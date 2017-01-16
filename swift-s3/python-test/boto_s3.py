from boto.s3.connection import S3Connection
from boto.s3.key import Key
import sys
from boto.s3.connection import OrdinaryCallingFormat
from boto.s3.prefix import Prefix

def S3Connect(host, port, accesskey, secret):
    conn = S3Connection(
        aws_access_key_id = accesskey, #'test:tester',
        aws_secret_access_key = secret, #'testing',
        host='127.0.0.1',
        port=8080,
        is_secure=False,
        calling_format=OrdinaryCallingFormat())

    # List all buckets
    rs = conn.get_all_buckets()
    for b in rs:
        print b.name
    return conn

def test(conn, bucket):
    exists = conn.lookup(bucket)
    # Get a listing of test bucket
    bucket = conn.get_bucket('test')
    rs = bucket.list()
    for key in rs:
         print key.name
    return exists

conn = S3Connect('127.0.0.1', 8080, 'test:tester', 'testing')
print test(conn, 'test')
