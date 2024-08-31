from setuptools import setup, find_packages

setup(
    name='project-genesis',
    version='0.0.2',  # Ensure this line is correctly formatted
    packages=find_packages(),
    include_package_data=True,
    install_requires=[
        'Click',
        'langchain',
        'pytest',
        'requests',
    ],
    entry_points='''
        [console_scripts]
        genesis=cli:cli
    ''',
)