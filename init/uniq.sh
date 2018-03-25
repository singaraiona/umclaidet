#!/bin/bash

for f in `ls -l1 $1/*.csv`;
do
   sort $f | uniq -c | sort | awk '!/1 /'
done

exit 0


