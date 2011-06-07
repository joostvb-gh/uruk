<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN" [
<!ENTITY docbook.dsl PUBLIC "-//Norman Walsh//DOCUMENT DocBook HTML Stylesheet//EN" CDATA DSSSL>
]>

<!-- This file is maintained at http://git.mdcc.cx/caspar -->

<style-sheet>
<style-specification use="docbook">
<style-specification-body>

;; See dbparam.dsl for definitions of refentries
(define %section-autolabel% #t)           ;; Sections are enumerated
(define %chapter-autolabel% #t)           ;; Chapters are enumerated

(define nochunks #t)                    ;; Dont make multiple pages
(define rootchunk #t)                   ;; Do make a 'root' page
(define %use-id-as-filename% #t)        ;; Use book id as filename
(define %html-ext% ".html")             ;; give it a proper html extension

;; %generate-set-toc% and %generate-book-toc% are #t in dbparam.dsl
;; %generate-book-titlepage% and %generate-article-titlepage% are #t
;; %generate-part-toc-on-titlepage% is #t

;; it seems toc is generated, but not printed in nochunks mode

</style-specification-body>
</style-specification>
<external-specification id="docbook" document="docbook.dsl">
</style-sheet>
