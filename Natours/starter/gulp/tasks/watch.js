var gulp = require('gulp'),
    watch = require('gulp-watch'),
    browserSync = require('browser-sync').create();

    gulp.task('watch',function(){
        watch('./sass/**/*.scss',function(){
            gulp.start('refreshCSS');
        })
    })

    gulp.task('default',['watch','sass'],function(){
        browserSync.init({
            server:{
                baseDir:"./"
            }
        });  
    })

    gulp.task('refreshCSS',['sass'],function(){
        browserSync.reload();
    })