var assert = require("assert");

describe("Game Board", function() {
  beforeEach(function() {
      browser.url("http://localhost:8000/src/Main.elm")
  });

  it("displays button if space is empty", function () {
    assert.deepEqual(browser.getTagName(".open-space"), Array(9).fill("button"));
  });

  describe("user clicks on open space", function() {
    it("changes the text of that space to 'X'", function () {
      browser.click(".open-space");

      assert.equal("X", browser.getText(".open-space")[0]);
    });

    xit("changes the element so it is no longer a button", function () {
      assert.equal("button", browser.getTagName(".open-space")[0]);
      browser.click(".open-space");
      assert.notEqual("button", browser.getTagName(".open-space")[0]);
    });
  });
});
