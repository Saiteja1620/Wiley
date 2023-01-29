from queue import Full
from flask import *
from datetime import datetime
app=Flask(__name__)

import mysql.connector

mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  password="reddy@1620",
  database="project"
)

app.secret_key='sessionCreated'

@app.route("/")
def home():
    return render_template("home.html")


@app.route("/login")
def login():
    return render_template("login.html")

@app.route("/about")
def aboutus():
    print("about")
    return render_template("aboutus.html")

@app.route("/register")
def register():
    return render_template("register.html") 

@app.route("/contact")
def contact():
    return render_template("contact.html")

@app.route("/registerUser",methods=["POST"])
def registerUser():
    data=dict(request.form)
    Profile=data['profile']
    FullName=data['fullName']
    Email=data['email']
    Mobile=data['mobile']
    Password=data['password']
    CPassword=data['confirmPassword']
    print(Profile)
    try:
        if(Password==CPassword and Profile=='organiser'):
            stmt='INSERT Organizer(org_name,email_id,org_password,phone_number) VALUES(%s,%s,%s,%s)'
            val=(FullName,Email,Password,Mobile,)
            cursor=mydb.cursor()
            cursor.execute(stmt,val)
            mydb.commit()
            cursor.close()
            return render_template('login.html')

        elif(Password==CPassword and Profile=='participant'):
            stmt='INSERT participant(p_name,p_email_id,p_password,p_phone_number) VALUES(%s,%s,%s,%s)'
            val=(FullName,Email,Password,Mobile,)
            cursor=mydb.cursor()
            cursor.execute(stmt,val)
            mydb.commit()
            cursor.close()
            return render_template('login.html')

        elif(Password==CPassword and Profile=='sponsor'):
            stmt='INSERT Sponsors(sname,s_email,s_password,s_phonenumber) VALUES(%s,%s,%s,%s)'
            val=(FullName,Email,Password,Mobile,)
            cursor=mydb.cursor()
            cursor.execute(stmt,val)
            mydb.commit()
            cursor.close()
            return render_template('login.html')
        else:
            return "Registration Failed...Password Didn't Match"
    except mysql.connector.IntegrityError as err:
        return render_template('validation.html')


@app.route('/verifyLogin',methods=["POST"])
def verify():
    data=dict(request.form)
    email=data['email']
    password=data['password']
    stmt1='select email_id from Organizer'
    cursor=mydb.cursor()
    cursor.execute(stmt1)
    result1=cursor.fetchall()
    cursor.close()
    stmt2='select p_email_id from participant'
    cursor=mydb.cursor()
    cursor.execute(stmt2)
    result2=cursor.fetchall()
    cursor.close()
    stmt3='select s_email from sponsors'
    cursor=mydb.cursor()
    cursor.execute(stmt3)
    result3=cursor.fetchall()
    cursor.close()
    l1=[]
    l2=[]
    l3=[]
    for i in result1:
        l1.append(i[0]) 
    for i in result2:
        l2.append(i[0])
    for i in result3:
        l3.append(i[0])
    print(l1)
    print(l2)
    print(l3)
    #checking in organizer table for authentication
    if email in l1:
        stmt='select org_id,org_password from Organizer where email_id=%s'
        val=(email,)
        cursor=mydb.cursor()
        cursor.execute(stmt,val)
        pwd=cursor.fetchall()
        p=pwd[0][1]
        id=pwd[0][0]
        cursor.close()
        if password==p:
            session['organiser']=id
            # return render_template("orgdashboard.html")
            cursor=mydb.cursor()
            stmt="select org_name from organizer where org_id=%s"
            val=(id,)
            cursor.execute(stmt,val)
            name=cursor.fetchall()
            cursor.close()
            return eventsOfOrg()
            # return render_template("eventOfOrganiser.html",name=name)
    
    #checking in participant table for authentication
    elif email in l2:
        stmt='select p_id,p_password from participant where p_email_id=%s'
        val=(email,)
        cursor=mydb.cursor()
        cursor.execute(stmt,val)
        pwd=cursor.fetchall()
        p=pwd[0][1]
        id=pwd[0][0]
        cursor.close()
        if password==p:
            session['participant']=id
            # return events()
            # return yourEvents(id)
            return events()

    #checking in sponsors table for authentication
    elif email in l3:
        stmt='select s_id,s_password from sponsors where s_email=%s'
        val=(email,)
        cursor=mydb.cursor()
        cursor.execute(stmt,val)
        pwd=cursor.fetchall()
        p=pwd[0][1]
        id=pwd[0][0]
        cursor.close()
        if password==p:
            session['sponsor']=id
            # return render_template("sponsorDashboard.html")
            return sponsor()
    return 'wrong credentials'

@app.route("/createEvent",methods=["POST","GET"])
def createEvent():
    return render_template("createEvent.html")

    
@app.route('/eventform',methods=["POST","GET"])
def eventform():
    data1=dict(request.form)
    org_id=session['organiser']
    ename=data1['name']
    edesc=data1['desc']
    evenue=data1['venue']
    ecat=data1['category']
    elimit=data1['limit']
    edt=data1['datetime']
    eapp=data1['eveapp']
    if eapp=='yes':
        eapp=int(1)
    else:
        eapp=int(0)
    stmt="insert Events(org_id,event_name,event_desc,event_venue,event_date_time,participant_limit,event_category,approval_needed)  values(%s,%s,%s,%s,%s,%s,%s,%s)"
    val=(org_id,ename,edesc,evenue,edt,elimit,ecat,eapp)
    cursor=mydb.cursor()
    cursor.execute(stmt,val)
    mydb.commit()
    cursor.close()
    return eventsOfOrg()

@app.route('/eventsOfOrg',methods=["POST","GET"])
def eventsOfOrg():
    org_id=session['organiser']
    cursor=mydb.cursor()
    stmt='select * from events where org_id=%s'
    val=(org_id,)
    cursor.execute(stmt,val)
    result=cursor.fetchall()
    cursor.close()
    cursor=mydb.cursor()
    stmt="select org_name from organizer where org_id=%s"
    val=(org_id,)
    cursor.execute(stmt,val)
    name=cursor.fetchall()
    cursor.close()
    print(result)
    return render_template('organizer.html',result=result,name=name)

@app.route('/events',methods=["POST","GET"])
def events():
    p_id=session['participant']
    cursor=mydb.cursor()
    stmt='select * from events where event_status=0 and event_id not in (select event_id from event_participant where p_id=(%s));'
    val=(p_id,)
    cursor.execute(stmt,val)
    approval_not_needed=cursor.fetchall()
    print(approval_not_needed)
    cursor.close()
    cursor=mydb.cursor()
    #stmt='select * from events where event_status=0 and approval_needed=0 and event_id not in (select event_id from event_participant where p_id=(%s));'
    #val=(p_id,)
    #cursor.execute(stmt,val)
    #approval_needed=cursor.fetchall()
    # print(approval_not_needed)
    #cursor.close()
    cursor=mydb.cursor()
    stmt='select * from events where event_status=1;'
    cursor.execute(stmt)
    result1=cursor.fetchall()
    # print(result)
    cursor.close()
    print("I am from events")
    return render_template('particpants.html',result=approval_not_needed,result2=result1)



@app.route("/sponsor",methods=["POST","GET"])
def sponsor():
    s_id=session['sponsor']
    print("I am form sponsor method")
    cursor=mydb.cursor()
    stmt='select * from events where event_status=0 and event_id not in (select eventid from event_sponsorship where sid=(%s));'
    val=(s_id,)
    cursor.execute(stmt,val)
    approval_not_needed=cursor.fetchall()
    cursor.close()
    cursor=mydb.cursor()
   # stmt='select * from events where event_status=0 and approval_needed=0 and event_id not in (select eventid from event_sponsorship where sid=(%s));'
   # val=(s_id,)
   # cursor.execute(stmt,val)
   # approval_needed=cursor.fetchall()
   # cursor.close()
    cursor=mydb.cursor()
    stmt='select * from events where event_status=1;'
    cursor.execute(stmt)
    result1=cursor.fetchall()
    cursor.close()
    return render_template("sponsorDashboard.html",result=approval_not_needed,result2=result1)
    

@app.route('/register1/<id>',methods=["POST","GET"])
def registerForEvent(id):
    # id = request.form['reg']
    print("i am from register function")
    print(id,'->>>>> is my id')
    p_id=session['participant']
    print(id)
    cursor=mydb.cursor()
    stmt="insert event_participant(p_id,event_id) values(%s,%s)"
    val=(p_id,id,)
    cursor.execute(stmt,val)
    mydb.commit()
    cursor.close()
    # return yourEvents()
    return events()

@app.route('/yourEvents',methods=["POST","GET"])
def yourEvents():
    print("i am from yourEvents function")
    id=session['participant']
    cursor=mydb.cursor()
    stmt='select * from events where event_id in (select event_id from event_participant where p_id=%s) and approval_needed=0;'
    val=(id,)
    cursor.execute(stmt,val)
    result=cursor.fetchall()
    # print(result)
    cursor.close()
    cursor=mydb.cursor()
    stmt='select * from events where event_id in (select event_id from event_participant where p_id=%s and approval=1)  and approval_needed=1;'
    val=(id,)
    cursor.execute(stmt,val)
    approved=cursor.fetchall()
    cursor.close()
    cursor=mydb.cursor()
    stmt='select * from events where event_id in (select event_id from event_participant where p_id=%s and approval=0)  and approval_needed=1;'
    val=(id,)
    cursor.execute(stmt,val)
    result1=cursor.fetchall()
    # print(result)
    cursor.close()
    cursor=mydb.cursor()
    stmt="select p_name from participant where p_id=%s;"
    val=(id,)
    cursor.execute(stmt,val)
    name=cursor.fetchall()
    return render_template('yourEvents.html',result=result,name=name,result1=result1,approved=approved)

@app.route('/sponsoreve/<id>',methods=["POST","GET"])
def sponsorForEvent(id):
    print("i am from register function")
    print(id,'->>>>> is my id')
    s_id=session['sponsor']
    cursor=mydb.cursor()
    stmt="insert event_sponsorship(sid,eventid) values(%s,%s)"
    val=(s_id,id,)
    cursor.execute(stmt,val)
    mydb.commit()
    cursor.close()
    # return sponsorevents()
    return sponsor()

@app.route('/sponsorevents',methods=["POST","GET"])
def sponsorevents():
    print("i am from sponsorEvents function")
    id=session['sponsor']
    cursor=mydb.cursor()
    stmt='select * from events where event_id in (select eventid from event_sponsorship where sid=%s) and approval_needed=0;'
    val=(id,)
    cursor.execute(stmt,val)
    result=cursor.fetchall()
    # print(result)
    cursor.close()
    cursor=mydb.cursor()
    stmt='select * from events where event_id in (select eventid from event_sponsorship where sid=%s and approval=1) and approval_needed=1;'
    val=(id,)
    cursor.execute(stmt,val)
    approved=cursor.fetchall()
    cursor=mydb.cursor()
    stmt='select * from events where event_id in (select eventid from event_sponsorship where sid=%s and approval=0) and approval_needed=1;'
    val=(id,)
    cursor.execute(stmt,val)
    result1=cursor.fetchall()
    # print(result)
    cursor.close()
    cursor=mydb.cursor()
    stmt="select sname from sponsors where s_id=%s;"
    val=(id,)
    cursor.execute(stmt,val)
    name=cursor.fetchall()
    return render_template('sponsorevents.html',result=result,name=name,result1=result1,approved=approved)

@app.route("/viewParticipants",methods=["POST",'GET'])
def viewParticipants():
    org_id=session['organiser']
    cursor=mydb.cursor()
    stmt='''select e.event_name,p.p_id,p.p_name,p.p_email_id,p_phone_number,e.event_id from participant p join event_participant ep on 
    p.p_id=ep.p_id join events e on e.event_id=ep.event_id where e.org_id=(%s) and e.approval_needed=1 and ep.approval=0'''
    val=(org_id,)  #0 , 2, 3, 4   1,5
    cursor.execute(stmt,val)
    result=cursor.fetchall()
    cursor.close()
    return render_template('viewParticipants.html',result=result)

@app.route("/viewSponsors",methods=["POST",'GET'])
def viewSponsors():
    org_id=session['organiser']
    cursor=mydb.cursor()
    stmt='''select e.event_name,s.s_id,s.sname,s.s_email,s_phonenumber,e.event_id from sponsors s join event_sponsorship es on 
    s.s_id=es.sid join events e on e.event_id=es.eventid where e.org_id=(%s) and e.approval_needed=1 and es.approval=0'''
    val=(org_id,)
    cursor.execute(stmt,val)
    result=cursor.fetchall()
    cursor.close()
    return render_template('viewSponsors.html',result=result)

@app.route("/approveParticipant/<p_id>/<e_id>",methods=["POST","GET"])
def approveParticipant(p_id,e_id):
    cursor=mydb.cursor()
    stmt="update event_participant set approval=1 where event_id=(%s) and p_id=(%s);"
    val=(e_id,p_id,)
    cursor.execute(stmt,val)
    mydb.commit()
    cursor.close()
    return viewParticipants()

@app.route("/approveSponsor/<s_id>/<e_id>",methods=["POST","GET"])
def approveSponsor(s_id,e_id):
    cursor=mydb.cursor()
    stmt="update event_sponsorship set approval=1 where eventid=(%s) and sid=(%s);"
    val=(e_id,s_id,)
    cursor.execute(stmt,val)
    mydb.commit()
    cursor.close()
    return viewSponsors()
app.run()