from flask import Flask, render_template, request, session, redirect
from flask_sqlalchemy import SQLAlchemy
from flask_mail import Mail
from werkzeug.utils import secure_filename
from datetime import datetime
import json
import os
import math

with open("config.json") as fp:
    parameters = json.load(fp)["params"]

local_server = "True"
app = Flask(__name__)
'''Provide upload file location'''
app.config['UPLOAD_FOLDER'] = parameters['upload_location']
'''Provide a secret key to work with session'''
app.secret_key = 'super-secret-key'
'''Install Flask-Mail
pip install Flask-Mail
'''
app.config.update(
    MAIL_SERVER='smtp.gmail.com',
    MAIL_PORT='465',
    MAIL_USE_SSL=True,
    MAIL_USERNAME=parameters['user_name'],
    MAIL_PASSWORD=parameters['password']
)
mail = Mail(app)
if local_server:
    app.config['SQLALCHEMY_DATABASE_URI'] = parameters['local_uri']
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = parameters['prod_uri']
db = SQLAlchemy(app)


class Contacts(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), unique=False, nullable=True)
    email = db.Column(db.String(100), nullable=True)
    phone_num = db.Column(db.String(12), nullable=True)
    msg = db.Column(db.String(100), nullable=True)
    date = db.Column(db.String(20), nullable=True)


class Posts(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(80), unique=False, nullable=True)
    slug = db.Column(db.String(100), nullable=True)
    content = db.Column(db.String(100), nullable=True)
    date = db.Column(db.String(20), nullable=True)
    img_file = db.Column(db.String(30), nullable=True)
    tagline = db.Column(db.String(100), nullable=True)


"""
1. Install XAMPP to connect to my sql db. Start the Apache and MySQL services from XAMPP control panel.
2. Open localhost/phpmyadmin after services are up and create a db and 2 tables: posts and contacts.
3. Install the flask-sqlalchemy and pymysql
pip install flask-sqlalchemy
pip install pymysql
4. Import SQLAlchemy and provide MySQL configuration URI to connect to the db.
This is the MySQL connection uri format:
'mysql+pymysql://username:password@localhost/db_name' (line no 5)
5. Classes Contacts and Posts created above should match the name of the tables. Only the classes should be camel case. The variables
inside the class should match the column name in the tables.
"""


@app.route("/")
def home():
    #posts = Posts.query.filter_by().all()[0:parameters['no_of_posts']]
    posts = Posts.query.filter_by().all()
    last = math.ceil(len(posts)/parameters['no_of_posts'])
    page = request.args.get('page')
    if not str(page).isnumeric():
        page = 1
    page = int(page)
    posts = posts[(page-1) * parameters['no_of_posts']: (page-1) * parameters['no_of_posts'] + parameters['no_of_posts']]
    if page == 1:
        prev = '#'
        next = "/?page=" + str(page+1)
    elif page == last:
        prev =  "/?page=" + str(page-1)
        next = '#'
    else:
        prev =  "/?page=" + str(page-1)
        next = "/?page=" + str(page+1)
    '''posts variable will have only first five posts. But try to keep atleast 3 records in the table.
    This is to restrict the no of posts being shown up on home page.'''
    return render_template("index.html", params=parameters, posts=posts, prev = prev, next = next)



'''post_slug is a variable used to attach the slug ex- url/first-post into the url and the same var needs to be 
passed in method as per flask framework. '''
@app.route("/post/<string:post_slug>", methods=['GET'])
def post_route(post_slug):
    """fetch the data from the table using query and filter it on the basis of post_slug variable and returns the
    first occurrence of it if slug values are repetitive..
     How to use the url?
     http://127.0.0.1:5000/post/first-post  here first-post is the slug
     """
    post = Posts.query.filter_by(slug=post_slug).first()
    return render_template('post.html', params=parameters, post=post)


@app.route("/about")
def about():
    return render_template('about.html', params=parameters)

# @app.route("/", methods=['GET', 'POST'])
# def welcome():
#     if session.get('user') is not None and session['user'] == parameters['admin_user']:
#         posts = Posts.query.all()
#         return render_template('dashboard.html', params=parameters, posts=posts)
#     else:
#         render_template('login.html', params=parameters)
#     if request.method == 'POST':
#         email = request.form.get('emailId')
#         pwd = request.form.get('pwd')
#         if email == parameters['admin_user'] and pwd == parameters['admin_pwd']:
#             '''set the session variable'''
#             session['user'] = email
#             posts = Posts.query.all()
#             return render_template('dashboard.html', params=parameters, posts=posts)
#     return render_template('login.html', params=parameters)


@app.route("/dashboard", methods=['GET', 'POST'])
def dashboard():
    if session.get('user') is not None and session['user'] == parameters['admin_user']:
        posts = Posts.query.all()
        return render_template('dashboard.html', params=parameters, posts=posts)
    if request.method == 'POST':
        email = request.form.get('emailId')
        pwd = request.form.get('pwd')
        if email == parameters['admin_user'] and pwd == parameters['admin_pwd']:
            '''set the session variable'''
            session['user'] = email
            posts = Posts.query.all()
            return render_template('dashboard.html', params=parameters, posts=posts)
    return render_template('login.html', params=parameters)


@app.route("/edit/<int:sno>", methods=['GET', 'POST'])
def edit(sno):
    if session.get('user') is not None and session['user'] == parameters['admin_user']:
        if request.method == 'POST':
            edit_title = request.form.get('title')
            edit_tagline = request.form.get('tagline')
            edit_content = request.form.get('content')
            edit_imgFile = request.form.get('img_file')
            edit_slug = request.form.get('slug')
            if sno == 0:
                post = Posts(title=edit_title, slug=edit_slug, content=edit_content, img_file=edit_imgFile,
                             tagline=edit_tagline, date=datetime.now())
                db.session.add(post)
                db.session.commit()
            else:
                post = Posts.query.filter_by(sno=sno).first()
                post.title = edit_title
                post.tagline = edit_tagline
                post.content = edit_content
                post.img_file = edit_imgFile
                post.slug = edit_slug
                db.session.commit()
                #strSno = str(sno)
                #return redirect('/edit/' + strSno)
        post = Posts.query.filter_by(sno=sno).first()
        return render_template('edit.html', params=parameters, post=post, sno=sno)

@app.route("/delete/<int:sno>",  methods=['GET', 'POST'])
def delete(sno):
    if session.get('user') is not None and session['user'] == parameters['admin_user']:
            post = Posts.query.filter_by(sno=sno).first()
            db.session.delete(post)
            db.session.commit()
    return redirect('/dashboard')

@app.route("/uploader", methods=['GET', 'POST'])
def uploader():
    if session.get('user') is not None and session['user'] == parameters['admin_user']:
        if request.method == 'POST':
            f = request.files['myfile']
            f.save(os.path.join(app.config['UPLOAD_FOLDER'], secure_filename(f.filename)))
            return "Uploaded successfully"


@app.route("/logout")
def logout():
    session.pop('user')
    return redirect('/dashboard')


@app.route("/contact", methods=['GET', 'POST'])
def contact():
    if request.method == 'POST':
        '''Add entry to the db'''
        name = request.form.get(
            'name')  # name is the value of name attribute for the input type given in contact.html form
        email = request.form.get('email')
        phone_num = request.form.get('phone')
        message = request.form.get('msg')
        '''Inserting data in the db. Use your class name and assign the above values to Contacts class variables defined'''
        entry = Contacts(name=name, email=email, phone_num=phone_num, msg=message, date=datetime.now())
        db.session.add(entry)
        db.session.commit()
        mail.send_message('New message from Chitra Blog', sender=email,
                          recipients=[parameters['user_name']],
                          body="Message from " + name + "\n" + message + "\n" + phone_num)
    return render_template('contact.html', params=parameters)


# @app.route("/post")
# def post():
#     return render_template('post.html', params=parameters)


app.run(debug=True)
