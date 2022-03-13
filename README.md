# db-interface
---
This web interface, built in PHP, has the purpose of interacting with a locally hosted MySQL database related to management of an air traffic company, however it can also be extended to other MySQL databases. The interface allows for CRUD operations, along with viewing the results of certain SQL queries and views. The operations supported are the following:
- Insert entry
- View / update / delete entries
- View employee details and number of flights attended by employees who have attended more than 1 flight
- View details and average flight duration of flights with a duration longer than 2 hours
- Detailed view of employees, including airport and function details
- View number of employees working at each registered airport

CRUD operations are implemented in such a way that they can work on any MySQL database, not just the sample one given, including on SQL views (where these operations are allowed by MySQL); however, the other operations are specific to the sample database.
## Configuration
To use this interface:
- add the details of your MySQL schema in `config.php`
- host the project on a server (for this purpose I used MAMP)
- if you wish to use the sample database, run `install.php` and `installviews.php` (or run `init.sql` and `initviews.sql`, found in `data`), otherwise if you wish to use the interface for your own database, skip this step
- enter `public/index.php` and you're good to go!
## Notes
This database and interface was built as a project for my Databases course in college, which gave me the necessary insight into SQL to design and build the database itself, however PHP was not among the subjects of the course, so for the purpose of building the interface, I saw an opportunity to learn some of the basics of PHP on my own.
