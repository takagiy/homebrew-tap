class Nicevg < Formula
  desc "Deterministic checks and repairs for SVG diagrams"
  homepage "https://github.com/takagiy/nicevg"
  url "https://registry.npmjs.org/nicevg/-/nicevg-0.18.0.tgz"
  sha256 "59e9fe1aa61d79e0fd7739678f0de636a7b25feb8967d91e8d0b9718d67dd342"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  test do
    clipped = <<~SVG
      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 120">
        <g data-node="checkout">
          <rect x="20" y="20" width="100" height="56"/>
          <text x="70" y="53" text-anchor="middle" font-size="14">Checkout</text>
        </g>
      </svg>
    SVG
    assert_match 'viewBox="0 0 140 120"', pipe_output(bin/"nicevg", clipped, 0)
    assert_match "Invalid SVG", shell_output("echo '<svg><g></svg>' | #{bin}/nicevg 2>&1", 2)
  end
end
