import unittest
from hello_world.main import main

class HelloWorldTest(unittest.TestCase) :
    def test_helloWorld(self):
        self.assertEqual(main(), "Hello World!")

if __name__ == "__main__":
    unittest.main()
