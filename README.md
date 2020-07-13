# Final_App
Original App Design Project - README Template
===

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
 This application is a personal finance application that would help users budget their income. I would also have a stcok market watchlist functionality where users interested in investing could use.

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:** Personal Finance
- **Mobile:** Uses location and camera
- **Story:** Allows user to plan how they want to use funds.
- **Market:** Anyone that has income and wishes to track spendings and make investments 
- **Habit:** Anytime users get paid at least he or she would like to plan their paycheck
- **Scope:** 

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* user can create a new account
* user can login/logout
* user can see stock marke data
* user can create a profile
* user can plan income
* user can se. stock details by company
* app recommends  a formula for how much you gt in return if invested(complex algorithm)
* user can take and upload a photo to store receipts



**Optional Nice-to-have Stories**
*Integrate with chase bank




### 2. Screen Archetypes

* Login/Registration Screen
   * User can log in 
   * User can create a new account
* Creation
   * User can create a new profile
* Stock Detail
    * User can see details of stocks
    

* Profile
    * User can see their profile 
    * user can edit their profile
    * User can log out

### 3. Navigation


## Wireframes
[Sketched wireframes]
<img src="https://www.figma.com/file/sRRw23XRhcVh7QQouRnrxJ/Untitled?node-id=0%3A1" width=600>


### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 

### Models

User
| Property | Type | Description |
| -------- | -------- | -------- |
| objectId| String| unique id for the user post (default field)|
|profileImage|File| user profile image|
|username|String|username|
|password|String|password|
|name|String|user name|
|number of trips|number|number of trips|
|createdAt|DateTime|date when trip is created (default field)|
|updatedAt|DateTime|date when post is last update (default field)|





### Networking
Register/Login
- Authenticate user
```objectivec=
[PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        
        if (error != nil) {
            NSLog(@"%@", error.localizedDescription);
            }];
        } else {
            NSLog(@"User logged in successfully");
            
            // display view controller that needs to shown after successful login
        }
    }];
}

```
- (POST) Create a new user
```objectivec=
 [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
            if (error != nil) {
                NSLog(@"%@", error.localizedDescription);
                }];
                
            } else {
                NSLog(@"User registered successfully");
                // display view controller that needs to shown after successful signup
            }
        }];
```

