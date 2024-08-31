class Genesis < Formula
  include Language::Python::Virtualenv
  
  desc "Project Genesis: The Dawn of Autonomous Code Evolution"
  homepage "https://github.com/manurueda/Genesis"
  url "https://github.com/manurueda/Genesis/archive/refs/tags/v..1.tar.gz"
  sha256 "d5558cd419c8d46bdc958064cb97f963d1ea793866414c025906ec15033512ed"
  license "MIT"

  depends_on "python@3.12"

  resource "click" do
    url "https://files.pythonhosted.org/packages/59/87/84326af34517fca8c58418d148f2403df25303e02736832403587318e9e8/click-8.1.3.tar.gz"
    sha256 "7682dc8afb30297001674575ea00d1814d808d6a36af415a82bd481d37ba7b8e"
  end

  resource "langchain" do
    url "https://files.pythonhosted.org/packages/..."
    sha256 "..."
  end

  resource "pytest" do
    url "https://files.pythonhosted.org/packages/..."
    sha256 "..."
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/..."
    sha256 "..."
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "Project Genesis CLI", shell_output("#{bin}/genesis --help")
  end
end