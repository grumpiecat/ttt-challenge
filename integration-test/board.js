var assert = require("assert");

describe("Game Board", function() {
  var playerOne = "X";
  var playerTwo = "O";

  beforeEach(function() {
      browser.url("http://localhost:8000/src/Main.elm")
  });

  describe("game is active", function() {
    xit("game-over message is not visible", function() {
        assert.equal(false, browser.isVisible("#game-over-banner"));
    });

    it("displays button if space is empty", function () {
      assert.deepEqual(browser.getTagName("#space-1"), "button");
    });

    describe("user clicks on open space", function() {
      it("changes the text of that space to the active player marker", function () {
        browser.click("#space-3");
        assert.equal(playerOne, browser.getText("#space-3"));

        browser.click("#space-2");
        assert.equal(playerTwo, browser.getText("#space-2"));
      });

      it("changes the element so it is no longer a button", function () {
        assert.equal("button", browser.getTagName("#space-6"));
        browser.click("#space-6");
        assert.notEqual("button", browser.getTagName("#space-6"));
      });
    });
  });

  describe("game over", function() {
    xit("displays game over message", function() {
        assert(browser.isVisible("#game-over-banner"));
    });
  });
});
