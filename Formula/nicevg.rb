class Nicevg < Formula
  desc "Deterministic checks and repairs for SVG diagrams"
  homepage "https://github.com/takagiy/nicevg"
  url "https://github.com/takagiy/nicevg/archive/refs/tags/v0.7.0.tar.gz"
  sha256 "0e9fc9749e42c61943edbacb9f3c91ca92044da11d5cdb14085039c341ccf751"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
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
