require "formula"

class Cuba < Formula
  homepage "http://www.feynarts.de/cuba"
  url "http://www.feynarts.de/cuba/Cuba-4.0.tar.gz"
  sha1 "2e98480da9d4a9a222fa6085738e46cfbe217e68"

  option "without-check", "Skip build-time tests (not recommended)"

  def install
    ENV.deparallelize

    system "./configure", "--prefix=#{prefix}", "--datadir=#{share}/cuba/doc"
    system "make"
    system "make", "check" if build.with? "check"
    system "make", "install"

    (share / "cuba").install "demo"
  end

  test do
    system ENV.cc, "-o", "demo-c", "#{lib}/libcuba.a", "#{share}/cuba/demo/demo-c.c"
    system "./demo-c"
  end
end
