# Heze Receipt Application

This __web / iOS application__ helps solve the problem of expenses sharing with room / apartment mates. It allows users to submit receipts to a local shared expense pool and customize just how much of each receipt they would like reimbursement for. Heze Receipts also has a built-in approval system, group management system, and user account system. To make Heze Reciepts as convenient as possible, the iOS app uses the camera and __Google Cloud Vision API__ to scan a receipt directly into the system.

## Getting Started
These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. 

### Prerequisites

1. Install RVM if you haven't already: visit [rvm website](https://rvm.io/rvm/install) to find instructions. 
2. Install proper Ruby version with dependencies: visit [instruction website](https://www.phusionpassenger.com/library/walkthroughs/deploy/ruby/ownserver/nginx/oss/install_language_runtime.html) 
3. Install MySQL server: great details about installation and using MySQL can be found [here](https://support.rackspace.com/how-to/installing-mysql-server-on-ubuntu/)

### Initializing the database:
1. Create the database using MySQL commandline: 

    `create database hackwpi;`

2. On another prompt, use migration to initialize database schema: 

    `rake db:migrate`

3. Ta-da! Your tables with all necessary schema is created!

### Starting the server
1. Simply run:

    `rails s`

2. Then open a web browser, type in:

    `http://localhost:3000`

3. You will be redirected to a home page with log-in / signup request. Sign up with your name, email, and password. 

4. You will then be redirected to your dashboard. 

### Seeding the database (optional for testing)
1. Simply run: 
    
    `rake db:seed`

2. To "empty" the database without clearing out user's information, run: 

    `rake db:empty`


## Application in action
1. After setting up the application on your iOS device, simply scan a receipt. 
2. The server will then behave as a "proxy": send the picture to the __Google Cloud API__. 
3. The server retrieves the response from the __Google Cloud API__.
4. The server parses the response, and send the processed information to the user on the application to verify. 
5. User verifies the information, and later on all receipts will be displayed on the website's dashboard.


## Built With
- Ruby on Rails - Web Application framework used
- MySQL - database server
- Vue.js, Bootstrap - front-end framework / library 
- Google Cloud Vision API - for scanning receipts (using machine learning)
- Swift, Objective-C, Cocoa Pods, X-code) - iOS development

## License

This project is licensed under the GNU Public License.

## Authors
- [Ryan Johnson](https://github.com/ryodine)
- [Dung (Kevin) Nguyen](http://github.com/tdn90)
- [Minh Pham](https://github.com/mnpham0417)

## Acknowledgements: 
- Google Cloud Platform
- Inspiration
- Hack@WPI 19
- Need & Want
- Fun!

