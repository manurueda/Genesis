class Genesis < Formula
  desc "Project Genesis: The Dawn of Autonomous Code Evolution"
  homepage "https://github.com/manurueda/Genesis"
  url "https://github.com/manurueda/Genesis/archive/refs/tags/v0.2.tar.gz"
  sha256 "replace_with_actual_sha256_of_your_tarball_for_v0.2"
  license "MIT"

  depends_on "python@3.12"

  def install
    system "python3.12", "-m", "venv", "genesis_env"
    system "source genesis_env/bin/activate && pip3 install -r requirements.txt && pip3 install -e ."
    bin.install Dir["genesis_env/bin/*"]
  end

  test do
    assert_match "Project Genesis CLI", shell_output("#{bin}/genesis --help")
  end
end