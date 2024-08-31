# generate_website.py
def generate_website(output_path: str) -> None:
    """
    Generates a simple HTML website with a button.
    
    Args:
        output_path (str): The path where the generated website will be saved.
    """
    html_content = """
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Simple Website</title>
    </head>
    <body>
        <button onclick="alert('Button clicked!')">Click Me!</button>
    </body>
    </html>
    """
    with open(output_path, 'w') as file:
        file.write(html_content)
    print(f"Website generated at {output_path}")

if __name__ == "__main__":
    generate_website("output/index.html")