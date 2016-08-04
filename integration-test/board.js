var assert = require("assert");

describe("Game Board", function() {
  var playerOne = "X";
  var playerTwo = "O";

  beforeEach(function() {
      browser.url("http://localhost:8080")
  });

  describe("Player vs Player Game", function() {
    beforeEach(function() {
      browser.click("#player-player");
    });

    it("game-over message is not visible", function() {
        assert.equal(false, browser.isVisible("#game-over-banner"));
    });

    it("displays button if space is empty", function () {
      assert.deepEqual(browser.getTagName("#space-1"), "button");
    });

    it("changes the text of that space to the active player marker", function () {
      browser.click("#space-3");
      assert.equal(playerOne, browser.getText("#space-3"));

      browser.click("#space-2");
      assert.equal(playerTwo, browser.getText("#space-2"));
    });

    it("changes the element so it is no longer a button", function () {
      assert.equal("button", browser.getTagName("#space-6"));
      browser.click("#space-6");
      browser.waitForExist("#space-6.filled-space")
      assert.notEqual("button", browser.getTagName("#space-6"));
    });
  });

  describe("Player vs AI chosen", function() {
    beforeEach(function() {
      browser.click("#player-ai");
    });

    it("game-over message is not visible", function() {
        assert.equal(false, browser.isVisible("#game-over-banner"));
    });

    it("changes the text of chosen space to the active player marker and places the AI marker on the board", function () {
      browser.click("#space-0");
      assert.equal(playerOne, browser.getText("#space-0"));

      browser.waitUntil(function () {
        return browser.getText("#space-4") ==  playerTwo;
      }, 20000, 'expected ai choice to be made after 20s');

      assert.equal(browser.getText("#space-4"), playerTwo);
    });
  });
});
