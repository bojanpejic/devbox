# vagrant + precise64 + puppet box
* * *

A basic devbox with vagrant + puppet setup for PHP development (basic LAMP stack), includes:

* Apache
* MySql
* PHP 5.4
* Git
* composer
* phpmyadmin

TODO: more enhancements ..

# how to uset it
* * *
Clone this repo:

    git clone https://github.com/bojanpejic/vbox.git

Init and update all submodules used for provisioning with puppet

    git submodule update --init

### Run Vagrant ###

    vagrant up

Enter in your browser: http://192.168.10.11

Access PhpMyAdmin on: http://192.168.10.11/phpmyadmin/

user: root

passw: root
* * *
Inspired/Powered by: [http://www.erikaheidi.com/2013/07/02/a-begginers-guide-to-vagrant-getting-your-portable-development-environment/][http://www.erikaheidi.com/2013/07/02/a-begginers-guide-to-vagrant-getting-your-portable-development-environment/]