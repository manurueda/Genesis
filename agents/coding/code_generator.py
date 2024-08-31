from langchain import PromptTemplate, LLMChain
from langchain.llms import OpenAI

class CodeGenerator:
    def __init__(self) -> None:
        self.llm = OpenAI(temperature=0.7)

    def generate_code(self, instructions: str) -> str:
        """
        Generates code based on the given instructions.
        
        Args:
            instructions (str): Detailed instructions for code generation.
        
        Returns:
            str: The generated code.
        """
        prompt = PromptTemplate(
            template="Generate code based on the following instructions:\n\n{instructions}\n\nCode:",
            input_variables=["instructions"]
        )
        llm_chain = LLMChain(prompt=prompt, llm=self.llm)
        return llm_chain.run(instructions=instructions)