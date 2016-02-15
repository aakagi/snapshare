var gulp = require('gulp');
var browserify = require('browserify');
var babelify = require('babelify');
var source = require('vinyl-source-stream');

gulp.task('js', function() {
  browserify('client/js/src/app.jsx')
    .transform(babelify, {presets: ["es2015", "react"]})
    .bundle()
    .pipe(source('app.js'))
    .pipe(gulp.dest('client/js/build'));
});

gulp.task('watch', function() {
  gulp.watch('client/js/src/**/*.jsx', ['js']);
  gulp.watch('client/js/src/**/*.js', ['js']);
});

gulp.task('build', ['js']);
gulp.task('default', ['build', 'watch']);