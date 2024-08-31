from langchain import PromptTemplate, LLMChain
from langchain.llms import OpenAI

class CodeEnhancer:
    def __init__(self) -> None:
        self.llm = OpenAI(temperature=0.7)

    def enhance_code(self, existing_code: str, instructions: str) -> str:
        """
        Enhances existing code based on the given instructions.
        
        Args:
            existing_code (str): The existing code to be enhanced.
            instructions (str): Detailed instructions for code enhancement.
        
        Returns:
            str: The enhanced code.
        """
        prompt = PromptTemplate(
            template="Enhance the following code based on these instructions:\n\nInstructions: {instructions}\n\nExisting code:\n{existing_code}\n\nEnhanced code:",
            input_variables=["instructions", "existing_code"]
        )
        llm_chain = LLMChain(prompt=prompt, llm=self.llm)
        return llm_chain.run(instructions=instructions, existing_code=existing_code)