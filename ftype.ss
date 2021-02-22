;;;; -*- mode: Scheme; -*-

(library (chez-sdl-image ftype)
  (export img-init
	  img-load
	  img-quit
	 ; IMG_Load_RW
	  IMG_INIT_JPG
	  IMG_INIT_PNG
	  IMG_INIT_TIF
	  IMG_INIT_EVERYTHING) 
	  
  (import (chezscheme)
	  (chez-sdl lib sdl ftype)
	  (chez-sdl lib sdl))

  (define *sdl-iamge*
    (case (machine-type)
      ((i3nt  ti3nt  a6nt  ta6nt)  (load-shared-object "SDL2_image.dll"))
      ((i3le  ti3le  a6le  ta6le)  (load-shared-object "SDL2_image.so"))
      ((i3osx ti3osx a6osx ta6osx) (load-shared-object "SDL2_image.dylib"))))

  (define-syntax sdl-image-procedure
    (syntax-rules ()
      ((sdl-image-procedure name params return)
       (if (foreign-entry? name)
	   (foreign-procedure name params return)
	   (lambda args
	     (error 'SDL "Function not exported in SDL2_image." name))))))
  ;; ftypes
  
  ;; flags
  (define IMG_INIT_JPG 1)
  (define IMG_INIT_PNG 2)
  (define IMG_INIT_TIF 4)
  (define IMG_INIT_EVERYTHING 7)	;通过前面三个或的关系得到
  (define IMG_MAJOR_VERSION 1)
  (define IMG_MINOR_VERSION 2)
  (define IMG_PATCHLEVEL 8)

  ;; SDL2_image proc
  (define img-init                (sdl-image-procedure "IMG_Init" (unsigned-32) int))
  (define img-quit                (sdl-image-procedure "IMG_Quit" () void))
					;(define IMG_Load_RW             (sdl-image-procedure "IMG_Load_RW" (SDL_RWops int) (* SDL_Surface))) ;SDL2ftype: SDL_RWops
					;(define IMG_Load                (lambda (path) (SDL_LoadBMP_RW (SDL_RWFromFile path "rb") 1)))
  (define img-load                (sdl-image-procedure "IMG_Load" (string) (* SDL_Surface)))
  )
