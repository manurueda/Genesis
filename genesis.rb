class Genesis < Formula
  include Language::Python::Virtualenv
  
  desc "Project Genesis: The Dawn of Autonomous Code Evolution"
  homepage "https://github.com/manurueda/Genesis"
  url "https://github.com/manurueda/Genesis/archive/refs/tags/v0.1.18.tar.gz"
  sha256 "c7f22c7940b457f490c429f08df6af94591dd908f30830b69708b654a41f6ea4"
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