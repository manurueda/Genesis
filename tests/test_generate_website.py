import os
from tools.generate_website import generate_website

def test_generate_website() -> None:
    output_path = "tests/output/index.html"
    generate_website(output_path)
    assert os.path.exists(output_path), "Website was not generated"
    with open(output_path, 'r') as file:
        content = file.read()
        assert "<button" in content, "Button not found in generated website"