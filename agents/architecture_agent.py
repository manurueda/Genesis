import os

class ArchitectureAgent:
    def create_project_structure(self, project_name: str) -> None:
        """
        Creates the basic project structure.
        
        Args:
            project_name (str): The name of the project.
        """
        os.makedirs(f"{project_name}/src", exist_ok=True)
        os.makedirs(f"{project_name}/tests", exist_ok=True)
        with open(f"{project_name}/README.md", 'w') as file:
            file.write(f"# {project_name}\n")
        print(f"Project structure for {project_name} created.")