#!/bin/bash

sqlite3 "$1"/www/app.sqlite <<< "update items set url='https://$2/$3' where url = 'my-url' and title = '$3' COLLATE NOCASE"
