class Genesis < Formula
  include Language::Python::Virtualenv
  
  desc "Project Genesis: The Dawn of Autonomous Code Evolution"
  homepage "https://github.com/manurueda/Genesis"
  url "https://github.com/manurueda/Genesis/archive/refs/tags/v0.1.23.tar.gz"
  sha256 "6747884fb65ca66412cf7b413f1ad2cf33680c84232791d8e2e7e779642207de"
  license "MIT"

  depends_on "python@3.12"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "Project Genesis CLI", shell_output("#{bin}/genesis --help")
  end
end