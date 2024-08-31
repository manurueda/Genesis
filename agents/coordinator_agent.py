import click
from agents.architecture_agent import ArchitectureAgent
from agents.mitosis_agent import MitosisAgent
from agents.parser_agent import ParserAgent
from agents.integration_agent import IntegrationAgent
from agents.testing_agent import TestingAgent
from agents.deployment_agent import DeploymentAgent
from agents.documentation_agent import DocumentationAgent
from agents.versioning_agent import VersioningAgent
from agents.interface_agent import InterfaceAgent
from agents.brain_agent import BrainAgent
from agents.coding_agent import CodingAgent

class CoordinatorAgent:
    def __init__(self) -> None:
        # Initialize other agents
        self.architecture_agent = ArchitectureAgent()
        self.mitosis_agent = MitosisAgent()
        self.parser_agent = ParserAgent()
        self.integration_agent = IntegrationAgent()
        self.testing_agent = TestingAgent()
        self.deployment_agent = DeploymentAgent()
        self.documentation_agent = DocumentationAgent()
        self.versioning_agent = VersioningAgent()
        self.interface_agent = InterfaceAgent()
        self.brain_agent = BrainAgent()
        self.coding_agent = CodingAgent()

    def create_project(self, project_name: str) -> None:
        """Create a new project"""
        click.echo(f"Creating project: {project_name}")
        
        # Ask questions
        project_type = click.prompt("What type of project is this?", type=click.Choice(['web', 'cli', 'library']))
        language = click.prompt("What programming language would you like to use?", type=click.Choice(['python', 'javascript', 'typescript']))
        
        # Run agents
        self.architecture_agent.create_project_structure(project_name)
        
        instructions = f"Create a {project_type} project using {language}."
        self.coding_agent.generate_code(project_name, instructions, "main", self._get_file_extension(language))
        
        self.mitosis_agent.apply_srp(project_name)
        self.parser_agent.analyze_code(project_name)
        self.integration_agent.manage_dependencies(project_name)
        self.testing_agent.generate_tests(project_name)
        self.deployment_agent.setup_ci_cd(project_name)
        self.documentation_agent.generate_docs(project_name)
        self.versioning_agent.setup_version_control(project_name)
        self.interface_agent.integrate_with_ide(project_name)
        self.brain_agent.enhance_code_intelligence(project_name)

    def enhance_project(self, project_name: str) -> None:
        """Enhance an existing project"""
        click.echo(f"Enhancing project: {project_name}")
        
        # Ask questions
        enhancement_type = click.prompt("What type of enhancement would you like?", 
                                        type=click.Choice(['performance', 'security', 'features']))
        
        # Run agents
        instructions = f"Enhance the project for better {enhancement_type}."
        self.coding_agent.enhance_code(project_name, f"{project_name}/src/main.py", instructions)
        
        self.mitosis_agent.apply_srp(project_name)
        self.parser_agent.analyze_code(project_name)
        self.testing_agent.generate_tests(project_name)
        self.documentation_agent.generate_docs(project_name)

    def _get_file_extension(self, language: str) -> str:
        """Get the file extension for a given language"""
        extensions = {
            'python': '.py',
            'javascript': '.js',
            'typescript': '.ts'
        }
        return extensions.get(language, '.txt')