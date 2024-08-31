class Genesis < Formula
  include Language::Python::Virtualenv
  
  desc "Project Genesis: The Dawn of Autonomous Code Evolution"
  homepage "https://github.com/manurueda/Genesis"
  url "https://github.com/manurueda/Genesis/archive/refs/tags/v0.1.9.tar.gz"
  sha256 "4d6bcdd9827750da3fb9e87b1b258c2ab38b83c0780b3219af53ac923cbed8f4"
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