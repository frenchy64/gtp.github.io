#lang racket/base

;; Provides HTML templates and common variables for pages

(provide
  PROJECT-NAME
  AWARD-HREF
  AWARD-NUMBER
  body-id
  ;; constants

  header footer nav sponsors default-doctype
  ;; (-> Html)
  ;; Common templates

  (all-from-out "templates/datatypes.rkt")
  (all-from-out "templates/universities.rkt")
  (all-from-out "templates/principal-investigators.rkt")
  (all-from-out "templates/team-members.rkt")
  (all-from-out "templates/venues.rkt")
)

(require
  web-server/templates
  racket/string
  "templates/datatypes.rkt"
  "templates/principal-investigators.rkt"
  "templates/team-members.rkt"
  "templates/universities.rkt"
  "templates/venues.rkt"
)

;; =============================================================================

(define PROJECT-NAME "Gradual Typing Across the Spectrum")
(define AWARD-HREF "http://www.nsf.gov/awardsearch/showAward?AWD_ID=1518844")
(define AWARD-NUMBER "SHF 1518844")
(define body-id "MyPage")

(define PAGES '("Home" "About" "Research" "People" "Team"))

;; -----------------------------------------------------------------------------
;; --- Header/Footer

(define (sponsors [sponsors-text ""])
  (include-template "templates/sponsors.html"))

(define (header [title PROJECT-NAME])
  (include-template "templates/header.html"))

(define (footer)
  (include-template "templates/footer.html"))

(define (default-doctype)
  (include-template "templates/doctype.html"))

(define (nav current-page)
  (string-append
    "<div id=\"menu\" class=\"menu-fixed\">\n"
    "  <span id=\"menu-icon\"><span class=\"glyphicon glyphicon-menu-hamburger\"></span></span>\n"
    "  <ul>\n"
    (string-join (for/list ([p (in-list PAGES)] [i (in-naturals 1)])
      (string-append
        "<li " (if (string=? p current-page) "class=\"active\"" "")
          (format " data-src=\"./images/menu/item_~a.png\"" i)
        ">"
        (make-href (if (string=? p "Home")
                     "index.html"
                     (string-append (string-downcase p) ".html"))
                   p)
        "</li>")))
    "  </ul>\n"
    "</div>\n"))