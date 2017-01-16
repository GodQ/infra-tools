from swiftclient import client
authurl = 'http://127.0.0.1:8080/auth/v1.0'
user = 'test:tester'
key = 'testing'
auth = client.Connection(authurl, user, key, tenant_name='admin', auth_version="1")
print auth.get_auth()
print auth.get_account()
print auth.get_container('test')
print auth.head_container('test')
print auth.put_container('test1')
print auth.put_object('test', 'test.py', 'testobject file content')
print auth.put_object('test', 'testfile', open('swift_test.py', 'rb'))
print auth.get_object('test', 'testfile')
print auth.head_object('test', 'testfile')
