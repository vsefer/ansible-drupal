_drupalize_ - drupal installation with ansible
=========

### Install and configure drupal site(s) with ansible

include:

* firewall (iptables - ports 22,80,443 are opened)
* nginx
* php5-fpm
* mariadb (myslq)
* memcache
* drupal (with bootstrap theme and ckeditor enabled)
* drush
* ...

### Usage

Run playbook without inventory file

```
ansible-playbook -i '9.9.9.9,' drupalize.yml --extra-vars "domain= drupalver= dbrootpass= dbuser= dbpass= dbname="
```

Run playbook with inventory file

```
ansible-playbook --inventory-file=hosts.ini drupalize.yml --extra-vars "domain= drupalver= dbrootpass= dbuser= dbpass= dbname="
```

Variables

```
domain - enter your domain 
drupalver - enter drupal version number ( i.e. 7.41 )
dbrootpass - enter password for user called superuser (aka root)
dbuser - enter drupal user name
dbpass - enter drupal user password
dbname - enter drupal database name
```

Drupal is installed in /srv/www/yourdomain.com/htdocs

Go to http://yourdomain.com/

Log in with user *admin* and password *admin*.

### TO-DO

* download and enable memcache module
* add customized php5-fpm config
* fix nginx workers (pass CPU number)
