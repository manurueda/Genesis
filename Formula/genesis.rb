class Genesis < Formula
  include Language::Python::Virtualenv
  
  desc "Project Genesis: The Dawn of Autonomous Code Evolution"
  homepage "https://github.com/manurueda/Genesis"
  url "https://github.com/manurueda/Genesis/archive/refs/tags/v0.1.21.tar.gz"
  sha256 "adb0dc0981fb23a6e10237e8ee1d4232cb0b4b3ef508a0d8dfc803a8a8b3d9ff"
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