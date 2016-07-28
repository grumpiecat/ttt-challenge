var assert = require("assert");

describe("Game Board", function() {
  beforeEach(function() {
      browser.url("http://localhost:8000/src/Main.elm")
  });

  it("displays button if space is empty", function () {
    assert.deepEqual(browser.getTagName("#space-1"), "button");
  });

  describe("user clicks on open space", function() {
    it("changes the text of that space to 'X'", function () {
      browser.click("#space-3");

      assert.equal("X", browser.getText("#space-3"));
    });

    it("changes the element so it is no longer a button", function () {
      assert.equal("button", browser.getTagName("#space-6"));
      browser.click("#space-6");
      assert.notEqual("button", browser.getTagName("#space-6"));
    });
  });
});
