var assert = require('assert');

describe('Game Page', function() {
    it('displays an array of 9 board spaces', function () {
        browser.url('http://localhost:8000/src/Main.elm');
        var board = browser.getText("#game-board");
        assert.equal(board, "[1,2,3,4,5,6,7,8,9]");
    });
});
