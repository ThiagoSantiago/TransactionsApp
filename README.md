# TransactionsApp

[![Build Status](https://app.bitrise.io/app/4128018729810556/status.svg?token=Fgo6hzJ1BiXgfRAB7OS3HA&branch=master)](https://app.bitrise.io/app/4128018729810556) [![codebeat badge](https://codebeat.co/badges/fadfb229-a7f1-4799-be76-58f88a5667e8)](https://codebeat.co/projects/github-com-thiagosantiago-transactionsapp-master)

![alt text](https://i.pinimg.com/originals/81/b3/2b/81b32bef7486f3edd0ec1f67bc924b68.png)

# Requirements

- Xcode 10.1

# Architecture

The architecture choosen for this project was the Clean Swift.

![alt text](https://cdn-images-1.medium.com/max/2000/1*QV4nxWPd_sbGhoWO-X7PfQ.png)

To know more about the architecture follow the link below.

https://hackernoon.com/introducing-clean-swift-architecture-vip-770a639ad7bf

# Features

* Transactions list:

    * This screen displays the list of transactions, the total balance relative to the period and the user image.
    * When arriving at the end of the list, in case there are more transactions the loading is done and the balance updated.
    * Clicking on the transaction you will be redirected to the Detail screen.
    * Clicking on the user image you have access to the Profile screen.
    
* Transaction details:

    * This page presents some details about the transaction, like the amount, date, effective date and the location on the map.
    
* User infos: 

    * Here you can see some user details like name, surname, birthdate, and nationality. 
    * Besides that, at the bottom of the screen, you can click on the button to change your user image.
    
    
# About the tests

Talking a little bit about the tests, I did test for the Worker class because is one of the most important classes in the app.

I wrote some test for some presenter's functions because they are responsible for treat data to pass to the view, so I thought that was important guarantee that's they are doing the job correctly.

And I wrote tests for the interactors too.
