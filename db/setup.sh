#!/bin/bash
scriptname=`basename $0 .sh`

#mysql -uroot < drop_db.sql
#mysql -uroot < create_db.sql
mysql -uroot < create_table.sql
#mysql -uroot < insert.sql
#mysql -uroot < load_data.sql
