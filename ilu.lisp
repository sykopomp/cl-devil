;;;; cl-devil -- DevIL binding for CL.  See README for licensing information.
(defpackage #:ilu
  (:use #:cl #:cffi #:%il)
  (:shadow #:error)
  (:export
   :init
   :alienify
   :blur-avg
   :blur-gaussian
   :build-mipmaps
   :colours-used
   :colors-used
   :compare-image
   :contrast
   :crop
   :delete-image
   :edge-detect-p
   :edge-detect-s
   :emboss
   :enlarge-canvas
   :error-string
   :flip-image
   :gamma-correct-inter
   :gamma-correct-scale
   :gen-image
   :get-integer
   :invert-alpha
   :mirror
   :negative
   :noisify
   :pixelsize
   :rotate
   :saturate
   :scale
   :sharpen
   :swap-colours
   :swap-colors
   ;; :get-image-info
   ;; :get-string
   :image-parameter
   ))

(in-package :ilu)

(define-foreign-library ilu
  (:darwin (:or "libILU.dylib" "libILU.1.dylib"))
  (:unix (:or "libILU.so" "libILU.so.1"))
  (:windows "ILU.dll")
  (t (:default "libILU")))
(use-foreign-library ilu)

(defcenum mode
  (:file-overwrite #x0620)
  (:file-mode #x0621)
  (:conv-pal #x0630)
  (:use-key-color #x0635)
  (:png-alpha-index #x0724)
  (:version-num #x0DE2)
  (:image-width #x0DE4)
  (:image-height #x0DE5)
  (:image-depth #x0DE6)
  (:image-size-of-data #x0DE7)
  (:image-bpp #x0DE8)
  (:image-bytes-per-pixel #x0DE8)
  (:image-bits-per-pixel #x0DE9)
  (:image-format #x0DEA)
  (:image-type #x0DEB)
  (:palette-type #x0DEC)
  (:palette-size #x0DED)
  (:palette-bpp #x0DEE)
  (:palette-num-cols #x0DEF)
  (:palette-base-type #x0DF0)
  (:num-images #x0DF1)
  (:num-mipmaps #x0DF2)
  (:num-layers #x0DF3)
  (:active-image #x0DF4)
  (:active-mipmap #x0DF5)
  (:active-layer #x0DF6)
  (:cur-image #x0DF7)
  (:image-duration #x0DF8)
  (:image-planesize #x0DF9)
  (:image-bpc #x0DFA)
  (:image-offx #x0DFB)
  (:image-offy #x0DFC)
  (:image-cubeflags #x0DFD)
  (:image-origin #x0DFE)
  (:image-channels #x0DFF))

(defcenum img-param-name
  (:filter #x2600)
  (:placement #x700))

(defcenum img-param
  (:bilinear #x2603)
  (:linear #x2602)
  (:nearest #x2601)
  (:scale-bell #x2606)
  (:scale-box #x2604)
  (:scale-bspline #x2607)
  (:scale-lanczos3 #x2608)
  (:scale-mitchell #x2609)
  (:scale-triangle #x2605)
  (:center #x705)
  (:lower-left #x701)
  (:lower-right #x702)
  (:upper-left #x703)
  (:upper-right #x704))


(defcfun ("iluInit" init) :void)

(defcfun ("iluAlienify" %alienify) :boolean)
(deferrwrap alienify)
(defcfun ("iluBlurAvg" %blur-avg) :boolean (iter :uint))
(deferrwrap blur-avg (iter))
(defcfun ("iluBlurGaussian" %blur-gaussian) :boolean (iter :uint))
(deferrwrap blur-gaussian (iter))
(defcfun ("iluBuildMipmaps" %build-mipmaps) :boolean)
(deferrwrap build-mipmaps)
(defcfun ("iluColoursUsed" %colours-used) :boolean)
(deferrwrap colours-used)
(defun colors-used ()
  (colours-used))
(defcfun ("iluCompareImage" %compare-image) :boolean (comp :uint))
(deferrwrap compare-image (comp))
(defcfun ("iluContrast" %contrast) :boolean (contrast :float))
(deferrwrap contrast (contrast))
(defcfun ("iluCrop" %crop) :boolean
  (x-offset :uint) (y-offset :uint) (z-offset :uint)
  (width :uint) (height :uint) (depth :uint))
(deferrwrap crop (x y z width height depth))
(defcfun ("iluDeleteImage" delete-image) :void (id :uint))
(defcfun ("iluEdgeDetectP" %edge-detect-p) :boolean)
(deferrwrap edge-detect-p)
(defcfun ("iluEdgeDetectS" %edge-detect-s) :boolean)
(deferrwrap edge-detect-s)
(defcfun ("iluEmboss" %emboss) :boolean)
(deferrwrap emboss)
(defcfun ("iluEnlargeCanvas" %enlarge-canvas) :boolean
  (width :uint) (height :uint) (depth :uint))
(deferrwrap enlarge-canvas (width height depth))
(defcfun ("iluErrorString" error-string) :string
  (error il::error-enum))
(defcfun ("iluFlipImage" %flip-image) :boolean)
(deferrwrap flip-image)
(defcfun ("iluGammaCorrect" %gamma-correct) :boolean (gamma :float))
(deferrwrap gamma-correct (gamma))
(defcfun ("iluGenImage" gen-image) :uint)
;; (defcfun ("iluGetImageInfo" get-image-info) :void (info :pointer))
(defcfun ("iluGetInteger" get-integer) :int (mode mode))
;; (defcfun ("iluGetString" get-string) :string)
(defcfun ("iluImageParameter" image-parameter) :void
  (pname img-param-name) (param img-param))
(defcfun ("iluInvertAlpha" %invert-alpha) :boolean)
(deferrwrap invert-alpha)
(defcfun ("iluMirror" %mirror) :boolean)
(deferrwrap mirror)
(defcfun ("iluNegative" %negative) :boolean)
(deferrwrap negative)
(defcfun ("iluNoisify" %noisify) :boolean
  (x-dim :float) (y-dim :float) (z-dim :float))
(deferrwrap noisify (x y z))
(defcfun ("iluPixelize" %pixelize) :boolean (pixel-size :uint))
(deferrwrap pixelize (pixel-size))
(defcfun ("iluRotate" %rotate) :boolean (angle :float))
(deferrwrap rotate (angle))
(defcfun ("iluSaturate4f" saturate-4f) :boolean
  (r :float) (g :float) (b :float))
(defun saturate (&key (r 1.0) (g 1.0) (b 1.0))
  (maybe-error (saturate-4f r g b)))
(defcfun ("iluScale" %scale) :boolean
  (width :uint) (height :uint) (depth :uint))
(deferrwrap scale (width height depth))
(defcfun ("iluSharpen" %sharpen) :boolean
  (factor :float) (iter :uint))
(deferrwrap sharpen (factor iter))
(defcfun ("iluSwapColours" %swap-colours) :boolean)
(deferrwrap swap-colours)
(defun swap-colors ()
  (swap-colours))
