class Genesis < Formula
  include Language::Python::Virtualenv
  
  desc "Project Genesis: The Dawn of Autonomous Code Evolution"
  homepage "https://github.com/manurueda/Genesis"
  url "https://github.com/manurueda/Genesis/archive/refs/tags/v0.1.26.tar.gz"
  sha256 "35b428419327dbdc38232451772bdbcd7fb86422cc5f5b79bd2013823be8b34b"
  license "MIT"

  depends_on "python@3.12"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "Project Genesis CLI", shell_output("#{bin}/genesis --help")
  end
end