from agents.coding.code_generator import CodeGenerator
from agents.coding.code_enhancer import CodeEnhancer
from agents.coding.file_manager import FileManager

class CodingAgent:
    def __init__(self) -> None:
        self.code_generator = CodeGenerator()
        self.code_enhancer = CodeEnhancer()
        self.file_manager = FileManager()

    def generate_code(self, project_name: str, instructions: str, file_name: str, file_extension: str = ".py") -> None:
        """
        Generates code based on the given instructions and saves it to a file.
        
        Args:
            project_name (str): The name of the project.
            instructions (str): Detailed instructions for code generation.
            file_name (str): The name of the file to be created.
            file_extension (str): The file extension to use. Defaults to ".py".
        """
        generated_code = self.code_generator.generate_code(instructions)
        self.file_manager.save_code(project_name, file_name, file_extension, generated_code)

    def enhance_code(self, project_name: str, file_path: str, instructions: str) -> None:
        """
        Enhances existing code based on the given instructions and saves the result.
        
        Args:
            project_name (str): The name of the project.
            file_path (str): The path to the file to be enhanced.
            instructions (str): Detailed instructions for code enhancement.
        """
        existing_code = self.file_manager.read_code(file_path)
        enhanced_code = self.code_enhancer.enhance_code(existing_code, instructions)
        self.file_manager.save_code(project_name, os.path.basename(file_path), "", enhanced_code)