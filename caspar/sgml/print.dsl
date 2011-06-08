<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN" [
<!ENTITY docbook.dsl PUBLIC "-//Norman Walsh//DOCUMENT DocBook Print Stylesheet//EN" CDATA DSSSL>
]>

<!-- This file is maintained at http://git.mdcc.cx/caspar -->

<style-sheet>
  <style-specification use="docbook">
    <style-specification-body>

;; See dbparam.dsl for definitions of refentries
(define %section-autolabel% #t)           ;; Sections are enumerated
(define %chapter-autolabel% #t)           ;; Chapters are enumerated

(define %generate-article-toc% #t)        ;; A Table of Contents should
                                          ;;  be produced for Articles

(define %generate-article-titlepage-on-separate-page% #f)
(define %generate-article-titlepage% #t)
(define %generate-article-toc-on-titlepage% #t)


;; (define %visual-acuity% "normal")      ;; General measure of document text
                                          ;; size. See dbparam.dsl. bf-size maps
                                          ;; visual-acuity to normal-param text
                                          ;; size. normal is 10pt, presbyopic is
                                          ;; 12pt.



;; we want it to look like default LaTeX.  One could also choose
;; "Times New Roman" here.
(define %title-font-family% "Computer Modern")
                                          ;; The font family used in titles
(define %body-font-family% "Computer Modern")
                                          ;; The font family used in body text

(define %default-quadding% 'justify)      ;; The default quadding ('start',
                                          ;; 'center', 'justify', or 'end').

(define %body-start-indent% 0em)          ;; The default indent of body text.
                                          ;; Some elements may have more or
                                          ;; less indentation.  4pi is default
                                          ;; value 

;; we have vertical whitespace between paragraphs
;; (define %para-indent%     2em)         ;; First line start-indent for
                                          ;; paragraphs (other than the first)

(define article-titlepage-recto-style
  (style
     font-family-name: %title-font-family%
     font-size: (HSIZE 1)))               ;; overrule font of title on
                                          ;; titlepage, see dbttlpg.dsl. tnx
;;;  setting to HSIZE 2 or 5 has no effect...
                                          ;; flacoste

(define (article-titlepage-recto-elements)
  (list (normalize "title") 
        (normalize "subtitle") 
        (normalize "corpauthor") 
        (normalize "authorgroup") 
        (normalize "author") 
        (normalize "abstract")))

;;        (normalize "revhistory")))        ;; revhistory added

;; article-titlepage-recto-elements in dbttlpg.dsl

(define (toc-depth nd) 2)                 ;; see dbautoc.dsl, default 1 for
                                          ;; article, 7 for book

(define (first-page-inner-footer gi)
  (cond
   ((equal? (normalize gi) (normalize "dedication")) (empty-sosofo))
   ((equal? (normalize gi) (normalize "lot")) (empty-sosofo))
   ((equal? (normalize gi) (normalize "part")) (empty-sosofo))
   ((equal? (normalize gi) (normalize "toc")) (empty-sosofo))
   (else
    (with-mode footer-copyright-mode
      (process-node-list (select-elements (children (current-node))
					  (normalize "articleinfo")))))))

(define (page-inner-footer gi)
  (cond
   ((equal? (normalize gi) (normalize "dedication")) (empty-sosofo))
   ((equal? (normalize gi) (normalize "lot")) (empty-sosofo))
   ((equal? (normalize gi) (normalize "part")) (empty-sosofo))
   ((equal? (normalize gi) (normalize "toc")) (empty-sosofo))
   (else
    (with-mode footer-id-mode
      (process-node-list (select-elements (children (current-node))
					  (normalize "articleinfo")))))))


(mode footer-id-mode
  ;; Prevent elements with PCDATA content 
  ;; from being processed
  (element title
    (empty-sosofo))
  (element subtitle
    (empty-sosofo))
  (element copyright
    (empty-sosofo))
  (element author
    (empty-sosofo))
  (element revnumber
    (empty-sosofo))
  (element date
    (empty-sosofo))

  (element revremark 
    (process-children-trim))

  (default
    (process-children-trim)))

(define (make-footer-rule)
  (make rule
    orientation: 'escapement
    position-point-shift: 0.75cm
    length: 5cm
    layer: 1
    line-thickness: 0.4pt))

;; make sure systemitem gets typesetted in typewriter font
(element systemitem ($mono-seq$))

(mode footer-copyright-mode
  ;; Prevent elements with PCDATA content 
  ;; from being processed
  (element title
    (empty-sosofo))
  (element subtitle
    (empty-sosofo))
  (element author
    (empty-sosofo))
  (element revnumber
    (empty-sosofo))
  (element date
    (empty-sosofo))
  (element revhistory
    (empty-sosofo))

  (element copyright 
    (let ((year (select-elements (children (current-node))
				 (normalize "year")))
	  (holder (select-elements (children (current-node))
				 (normalize "holder"))))
      (make sequence
	(make-footer-rule)
	(literal "Copyright &#169; ")
	(process-node-list year)
	(literal " ")
	(process-node-list holder))))

  (default
    (process-children-trim)))

    </style-specification-body>
  </style-specification>
  <external-specification id="docbook" document="docbook.dsl">
</style-sheet>

