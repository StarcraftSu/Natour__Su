var gulp = require('gulp'),
    autoprefixer = require('gulp-autoprefixer'),
    sass = require('gulp-sass'),
    rename = require('gulp-rename');

    gulp.task('sass',function(){
        return gulp.src('./sass/main.scss')
                   .pipe(sass())
                   .pipe(autoprefixer(
                        {
                            browsers: ['last 3 versions']
                        }
                   ))
                   .pipe(rename('style.css'))
                   .pipe(gulp.dest('./css'))
    });