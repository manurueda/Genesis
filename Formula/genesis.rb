class Genesis < Formula
  include Language::Python::Virtualenv
  
  desc "Project Genesis: The Dawn of Autonomous Code Evolution"
  homepage "https://github.com/manurueda/Genesis"
  url "https://github.com/manurueda/Genesis/archive/refs/tags/v0.1.20.tar.gz"
  sha256 "c83bddc90706cf503e89850fdee26f83ca0aa5c10c9b0b4f087a7f160cda486c"
  license "MIT"

  depends_on "python@3.12"

  def install
    virtualenv_install_with_resources
    system "poetry", "export", "-f", "requirements.txt", "--output", "requirements.txt", "--without-hashes"
    virtualenv.pip_install "requirements.txt"
  end

  test do
    assert_match "Project Genesis CLI", shell_output("#{bin}/genesis --help")
  end
end