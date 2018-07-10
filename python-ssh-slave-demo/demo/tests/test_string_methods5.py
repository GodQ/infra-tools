import unittest

class TestStringMethods5(unittest.TestCase):

    def test_upper5(self):
        self.assertEqual('foo'.upper(), 'FOO')

    def test_isupper5(self):
        self.assertTrue('FOO'.isupper())
        self.assertFalse('Foo'.isupper())

    def test_split5(self):
        s = 'hello world'
        self.assertEqual(s.split(), ['hello', 'world'])
        # check that s.split fails when the separator is not a string
        with self.assertRaises(TypeError):
            s.split(2)

if __name__ == '__main__':
    unittest.main()
