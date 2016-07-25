var gulp = require('gulp'),
    shell = require('gulp-shell');

gulp.task('build-tests', shell.task([
  'elm-make test/TestRunner.elm --output target/test.js --warn '
]))

gulp.task('run-tests', ['build-tests'], shell.task([
  'node target/test.js'
]))

gulp.task('default', function () {
  gulp.run('run-tests')

  gulp.watch(['src/**/*.elm', 'test/**/*.elm'], ['run-tests'])
})
