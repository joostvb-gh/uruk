<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN" [
<!ENTITY docbook.dsl PUBLIC "-//Norman Walsh//DOCUMENT DocBook HTML Stylesheet//EN" CDATA DSSSL>
]>

<!-- $Id: html.dsl,v 1.1 2002-03-13 12:09:56 joostvb Exp $ -->

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

</style-specification-body>
</style-specification>
<external-specification id="docbook" document="docbook.dsl">
</style-sheet>
