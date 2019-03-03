#!/usr/bin/env python

import boto
import boto.s3.connection

access_key = 'G378H0TYYV1JHWX9OD6U'
secret_key = '6EhiK0VAuMIkqDz3fciVzXJ2UJOY31nFolS9BFa7'
conn = boto.connect_s3(
        aws_access_key_id = access_key,
        aws_secret_access_key = secret_key,
        host = 'rgw.ceph', port = 80,
        is_secure=False, calling_format = boto.s3.connection.OrdinaryCallingFormat(),
        )

bucket = conn.create_bucket('my-new-bucket')
for bucket in conn.get_all_buckets():
        print "{name} {created}".format(name = bucket.name, created = bucket.creation_date)

key = bucket.new_key('hello.txt')
key.set_contents_from_string('Hello World!')
key = bucket.get_key('hello.txt')
print "downloaded data is:",key.get_contents_as_string()
bucket.delete_key('hello.txt')

