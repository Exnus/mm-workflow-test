/**
 * Created by ilya on 08.02.16.
 */
/*var childProcess = require('child_process');
gulp.task('middleman', function(cb) {
    var child = childProcess.exec('middleman server', function(error, stdout, stderr) {
        cb(error);
    });
});*/


var gulp = require('gulp');
require('gulp-grunt')(gulp); // add all the gruntfile tasks to gulp

gulp.task('default', function() {
    gulp.run(
        // run complete grunt tasks
        //'grunt-minify',
        //'grunt-test',
        // or run specific targets
        //'grunt-sass:dist',
        //'grunt-browserify:dev'
    );
});

var vulcanize = require('gulp-vulcanize');

gulp.task('vulcanize', function () {
    return gulp.src('build/**.html')
        .pipe(vulcanize({
            abspath: '/',
            excludes: [],
            stripExcludes: false
        }))
        .pipe(gulp.dest('build'));
});
