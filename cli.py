import click
from agents.coordinator_agent import CoordinatorAgent
import requests
import pkg_resources
import subprocess

@click.group()
def cli():
    """Project Genesis CLI"""
    pass

@cli.command()
@click.argument('project_name')
def create(project_name):
    """Create a new project"""
    coordinator = CoordinatorAgent()
    coordinator.create_project(project_name)

@cli.command()
@click.argument('project_name')
def enhance(project_name):
    """Enhance an existing project"""
    coordinator = CoordinatorAgent()
    coordinator.enhance_project(project_name)

@cli.command()
def update():
    """Check for updates and install the latest version"""
    current_version = pkg_resources.get_distribution("project-genesis").version
    try:
        response = requests.get("https://api.github.com/repos/your-username/project-genesis/releases/latest")
        latest_version = response.json()["tag_name"]
        if latest_version > current_version:
            click.echo(f"A new version {latest_version} is available. You have {current_version}.")
            if click.confirm("Do you want to update?"):
                subprocess.check_call([sys.executable, "-m", "pip", "install", "--upgrade", "project-genesis"])
                click.echo("Update completed. Please restart the terminal for changes to take effect.")
        else:
            click.echo("You have the latest version.")
    except Exception as e:
        click.echo(f"Failed to check for updates: {str(e)}")

if __name__ == '__main__':
    cli()