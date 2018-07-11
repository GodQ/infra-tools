import unittest

class TestAdd1(unittest.TestCase):
    def setUp(self):
        print("Hello World")
        
    def test_add1(self):
        a = 1
        b = 2
        c = a + b
        self.assertEqual(c, 4)

    def tearDown(self):
        print("Bye Bye")
