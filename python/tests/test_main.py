from unittest.mock import patch
from hello_world.main import main

@patch('builtins.print')
def test_helloWorld(mock_print):
    main()
    mock_print.assert_called_with("Hello World!")

