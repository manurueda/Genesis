import os

class FileManager:
    @staticmethod
    def save_code(project_name: str, file_name: str, file_extension: str, code: str) -> None:
        """
        Saves the code to a file.
        
        Args:
            project_name (str): The name of the project.
            file_name (str): The name of the file to be created.
            file_extension (str): The file extension to use.
            code (str): The code to be saved.
        """
        output_dir = f"{project_name}/src"
        os.makedirs(output_dir, exist_ok=True)
        output_path = f"{output_dir}/{file_name}{file_extension}"

        with open(output_path, 'w') as file:
            file.write(code)
        print(f"Code saved at {output_path}")

    @staticmethod
    def read_code(file_path: str) -> str:
        """
        Reads code from a file.
        
        Args:
            file_path (str): The path to the file to be read.
        
        Returns:
            str: The code read from the file.
        """
        with open(file_path, 'r') as file:
            return file.read()