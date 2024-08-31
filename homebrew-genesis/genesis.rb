class Genesis < Formula
  desc "Project Genesis: The Dawn of Autonomous Code Evolution"
  homepage "https://github.com/manurueda/Genesis"
  url "https://github.com/manurueda/genesis/archive/refs/tags/v0.0.3.tar.gz"
  sha256 "23444dd37e4bf69fa7ec5ef740806c29917a02ca9a34487ec6ea6f63e7cfd20a"
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