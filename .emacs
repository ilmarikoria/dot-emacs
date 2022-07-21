;-----------------------------------------------------------------------;
; PACKAGES                                                              ;
;-----------------------------------------------------------------------;
(require 'package)
(add-to-list 'package-archives
  	     '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;-----------------------------------------------------------------------;
; GENERAL SETTINGS                                                      ;
;-----------------------------------------------------------------------;
;; -- emacs misc settings
(setq initial-buffer-choice "~/my-files/org/org-roam/todo/todo.org"
      inhibit-startup-screen t
      system-time-locale "C"
      tramp-verbose 1
      auth-sources '("~/.authinfo.gpg" "~/.authinfo" "~/.netrc")
      ring-bell-function 'ignore
      server-client-instructions nil
      native-comp-async-report-warnings-errors nil
      scroll-conservatively 101
      scroll-margin 20)

;; -- deleting stuff
(setq undo-limit 800000
      undo-strong-limit 12000000
      undo-outer-limit 120000000
      kill-ring-max 9999
      delete-by-moving-to-trash t)

;; -- writing general
(setq synosaurus-choose-method 'popup
       wc-modeline-format "WC[%W%w/%tw%gw]"
       ispell-dictionary "en_US"
       abbrev-file-name "~/my-files/org/abbrev_defs/abbrev_defs"
       next-line-add-newlines t
       save-abbrevs 'silently
       word-wrap-by-category t
       electric-pair-preserve-balance nil
       synosaurus-backend 'synosaurus-backend-wordnet
       ispell-personal-dictionary "~/my-files/emacs/ispell-personal-dictionary"
       ispell-silently-savep t)

;; -- writegood-mode
(setq writegood-weasel-words
      '("many" "various" "very" "fairly"
	"several" "extremely" "exceedingly" "quite"
	"remarkably" "few" "surprisingly" "mostly"
	"largely" "huge" "tiny" "are a number"
	"is a number" "excellent" "interestingly" "significantly"
	"substantially" "clearly" "vast" "relatively"
	"completely" "literally" "not rocket science" "pretty"
	"outside the box" "In this regard" "With this in mind"
	"With the above in mind" "In this sense" "variety"))

;; -- olivetti
(setq olivetti-body-width 0.50
      olivetti-minimum-body-width 72
      olivetti-recall-visual-line-mode-entry-state t)

;; -- auto capitalization
;; -- fix for org mode "https://emacs.stackexchange.com/questions/3949/fixing-auto-capitalize-to-work-with-org-mode-headings-and-lists"
(add-to-list 'load-path "~/my-files/emacs/.emacs.d/my-packages/auto-capitalize-el/")
(require 'auto-capitalize)
(setq auto-capitalize-words `("I" "English" "Chinese" "China" "Taiwan"))

;; -- misc modes
(electric-pair-mode 1)
(menu-bar-mode -1)
(show-paren-mode 1)
(delete-selection-mode t)
(xclip-mode 1)
(tool-bar-mode -1)
(set-default 'truncate-lines t)
(global-auto-revert-mode)
(scroll-bar-mode -1)
(wrap-region-mode t)
(global-hl-line-mode 1)

;; -- hooks for programming
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'prog-mode-hook 'electric-indent-mode)
(add-hook 'prog-mode-hook 'hl-line-mode)

;; -- hooks for text
(add-hook 'text-mode-hook 'writegood-mode)
(add-hook 'text-mode-hook 'wc-mode)
(add-hook 'text-mode-hook 'synosaurus-mode)
(add-hook 'text-mode-hook 'olivetti-mode)
(add-hook 'text-mode-hook 'palimpsest-mode)
(add-hook 'text-mode-hook 'auto-capitalize-mode)
(add-hook 'text-mode-hook 'wrap-region-mode)
(add-hook 'text-mode-hook #'flyspell-mode)
(add-hook 'text-mode-hook #'abbrev-mode)

;; -- xml hooks
(add-hook 'nxml-mode-hook 'display-line-numbers-mode)
(add-hook 'nxml-mode-hook 'electric-indent-mode)
(add-hook 'nxml-mode-hook 'hl-line-mode)
(add-hook 'nxml-mode-hook (lambda () (olivetti-mode -1)))
(add-to-list 'auto-mode-alist '("\\.dita\\'" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\.ditamap\\'" . nxml-mode))

;; -- html
(add-hook 'html-mode-hook 'display-line-numbers-mode)
(add-hook 'html-mode-hook 'electric-indent-mode)
(add-hook 'html-mode-hook 'hl-line-mode)
(add-hook 'html-mode-hook (lambda () (olivetti-mode -1)))

;; -- dired 
(put 'dired-find-alternate-file 'disabled nil)
;; (add-hook 'dired-mode-hook 'dired-hide-details-mode)

;; -- no popup for async shell command
(add-to-list 'display-buffer-alist
	     (cons "\\*Async Shell Command\\*.*" (cons #'display-buffer-no-window nil)))

;; -- line wrapping rules
;; -- M-x describe-categories
(modify-category-entry ?- ?|)
;; -- TODO check if these are needed
(modify-category-entry ?\) ?|)
(modify-category-entry ?_ ?|)
(modify-category-entry ?/ ?|)

;; -- backups
(setq auto-save-interval 20
      backup-each-save-mirror-location "~/.emacs-backup/"
      backup-each-save-remote-files t)
(add-hook 'after-save-hook 'backup-each-save)

;-----------------------------------------------------------------------;
; GLOBAL KEYBINDINGS                                                    ;
;-----------------------------------------------------------------------;
;; -- general
(global-set-key (kbd "C-c s") #'flyspell-buffer)
(global-set-key (kbd "C-c w") 'count-words-region)
(global-set-key (kbd "<f5>" ) 'async-shell-command)
(global-set-key (kbd "C-c v") 'visual-line-mode)
(global-set-key (kbd "C-c y") 'helm-show-kill-ring)
(global-set-key (kbd "C-c c") 'comment-region)
(global-set-key (kbd "C-c u") 'uncomment-region)
(global-set-key (kbd "C-c k") 'clone-indirect-buffer)
(global-set-key (kbd "C-c h") 'helm-descbinds)
(global-set-key (kbd "C-c 1") 'elfeed)
(global-set-key (kbd "C-c l") #'flyspell-popup-correct)
(global-set-key (kbd "C-c z") 'olivetti-mode)
(global-set-key (kbd "C-c t") 'dired-toggle-read-only)
(global-set-key (kbd "C-c r") 'ispell-word)
(global-set-key (kbd "C-c i") 'org-store-link)

;; -- multiple cursors (based on "https://www.youtube.com/watch?v=mDDeSKRc3Zo")
;; -- if issue with org-mode delete "~/.emacs.d/.mc-lists.el" and follow prompt
(global-set-key (kbd "C-M-j") 'mc/mark-all-dwim)
(global-set-key (kbd "C-M-c") 'mc/edit-lines)
(global-set-key (kbd "C-M-l") 'er/expand-region)
(global-set-key (kbd "C-M-/") 'mc/mark-all-like-this)
(global-set-key (kbd "C-M-,") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-M-.") 'mc/mark-next-like-this)
(global-set-key (kbd "C-M->") 'mc/skip-to-previous-like-this)
(global-set-key (kbd "C-M-<") 'mc/skip-to-next-like-this)
(global-set-key (kbd "C-M-s") 'just-one-space)
(global-set-key (kbd "C-M-y") 'mc/insert-numbers) ;; (C-u-1-0) -- also (rectangle-number-lines)
(global-set-key (kbd "C-'") 'mc/hide-unmatched-lines-mode)
(global-set-key (kbd "C-j") 'electric-newline-and-maybe-indent)

;; -- org
(global-set-key (kbd "C-c b") #'org-capture-at-point)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c p") 'org-pomodoro)
(global-set-key (kbd "<f6>" ) 'org-capture)
(global-set-key (kbd "C-c o") 'org-wc-display)
(global-set-key (kbd "C-c 0") 'org-insert-structure-template)
(global-set-key (kbd "C-c g") 'org-schedule)
(global-set-key (kbd "C-c d") 'org-deadline)
(global-set-key (kbd "C-c m") 'org-id-get-create)
(global-set-key (kbd "C-c q") 'org-insert-heading-after-current)

;; -- org-roam
(global-set-key (kbd "C-c n l") 'org-roam-buffer-toggle)
(global-set-key (kbd "C-c n f") 'org-roam-node-find)
(global-set-key (kbd "C-c n g") 'org-roam-graph)
(global-set-key (kbd "C-c n i") 'org-roam-node-insert)
(global-set-key (kbd "C-c n c") 'org-roam-capture)
(global-set-key (kbd "C-c n d") 'org-roam-dailies-capture-today)
(global-set-key (kbd "C-c n j") 'org-journal-new-entry)
(global-set-key (kbd "C-c n r") 'org-journal-search-forever)
(global-set-key (kbd "C-c n p") 'completion-at-point)
(global-set-key (kbd "C-c n s") 'deft)

;; -- engine mode
(engine-mode t)
(defengine duckduckgo "https://duckduckgo.com/?q=%s"
  :keybinding "d")
(defengine google "http://www.google.com/search?ie=utf-8&oe=utf-8&q=%s"
  :keybinding "g")
(defengine wikipedia "http://www.wikipedia.org/search-redirect.php?language=en&go=Go&search=%s"
  :keybinding "w")
(defengine thesaurus "https://www.thesaurus.com/browse/%s"
  :keybinding "t")

;; -- zoom
(add-to-list 'load-path "~/my-files/emacs/.emacs.d/my-packages/zoom-frm/")
(require 'zoom-frm)
(define-key ctl-x-map [(control ?+)] 'zoom-in/out)
(define-key ctl-x-map [(control ?-)] 'zoom-in/out)
(define-key ctl-x-map [(control ?=)] 'zoom-in/out)
(define-key ctl-x-map [(control ?0)] 'zoom-in/out)
(global-set-key (vector (list 'control mouse-wheel-down-event)) 'zoom-in)
(global-set-key (vector (list 'control mouse-wheel-up-event))   'zoom-out)
(global-set-key [S-mouse-1]    'zoom-in)
(global-set-key [C-S-mouse-1]  'zoom-out)
;; Get rid of `mouse-set-font' or `mouse-appearance-menu':
(global-set-key [S-down-mouse-1] nil)

;-----------------------------------------------------------------------;
; ORG MODE                                                              ;
;-----------------------------------------------------------------------;
;; -- ox extras
(require 'ox-extra)
(require 'ox-latex)
(require 'ox-bibtex) ;; ox-bibtex has to be loaded before org-ref

;; -- ignore tag for export
(ox-extras-activate
 '(ignore-headlines))

;; -- org general
(setq org-directory "~/my-files/org"
      org-file-apps '((auto-mode . emacs)
		      ("\\.x?html?\\'" . "firefox %s")
		      ("\\.pdf\\'" . "evince \"%s\"")
		      ("\\.pdf::\\([0-9]+\\)\\'" . "evince \"%s\" -p %1"))
      org-startup-folded t
      org-startup-indented t
      org-indent-mode t
      org-log-into-drawer t
      org-hide-emphasis-markers nil
      org-startup-truncated t
      org-tags-column 0
      org-ellipsis " ⤾")

;; -- org wc
(setq org-wc-ignored-tags '("nowc" "ARCHIVE"))

;; -- org-ref
(require 'org-ref)
(setq org-ref-bibliography-notes "~/my-files/bibliography/bibliography-notes.org"
      org-ref-default-bibliography '("~/my-files/bibliography/bibliography.bib"))

;; -- org-pomodoro
(setq org-pomodoro-audio-player "/usr/bin/mpv"
      org-pomodoro-play-sounds t)

;; -- org latex export
(setq org-latex-toc-command "\\tableofcontents \\addtocontents{toc}{\\protect\\thispagestyle{empty}} \\newpage" ;; -- TODO fix this 
      org-latex-compiler "xelatex"
      org-latex-pdf-process '("xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
			      "bibtex %b" "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
			      "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

;; -- latex classes
(add-to-list 'org-latex-classes
	     '("letter" "\\documentclass{letter}"
	       ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))

(add-to-list 'org-latex-classes
	     '("hitec" "\\documentclass{hitec}"
	       ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))

;; -- org export general
(setq org-export-with-smart-quotes t
      org-latex-tables-centered nil
      org-export-preserve-breaks t
      org-export-with-toc nil
      org-export-with-section-numbers nil
      org-html-footnotes-section "<div id=\"footnotes\">
                                  <h2 class=\"footnotes\">%s </h2>
                                  <div id=\"text-footnotes\">%s</div>
                                  </div>")

;; -- org agenda
(setq org-agenda-start-on-weekday nil
      org-agenda-window-setup 'only-window)

;; -- org source blocks
(setq org-src-tab-acts-natively t
      org-confirm-babel-evaluate nil)

;; -- org capture
(setq org-capture-templates '(("n" "note-at-point" plain (file "") " - (%^{location}) Here it says that %^{Here it says that...}.")
                             ("w" "weekly-review-at-point" plain (file "~/my-files/org/notes.org") (file "~/my-files/org/org-templates/weekly-review.txt"))
            		     ("d" "diary-at-point" plain (file "~/my-files/org/notes.org") (file "~/my-files/org/org-templates/daily-diary.txt"))
			     ("b" "beamer-at-point" plain (file "") (file "~/my-files/org/org-templates/beamer"))
                             ("t" "scheduled-todo" entry (file+headline "~/my-files/org/org-roam/todo/todo.org" "TASK-INDEX") (file "~/my-files/org/org-templates/scheduled-todo.txt"))
           		     ("r" "rss todo" entry (file+olp "~/my-files/org/org-roam/todo/todo.org" "TASK-INDEX") "* TODO %^{Description} %^g:RSS:\nSCHEDULED: %^t\n\n %a\n\n %i")))

;; -- capture at point, for notes and stuff
(defun org-capture-at-point () (interactive)
       (org-capture 0))

;; -- babel
(org-babel-do-load-languages
 'org-babel-load-languages '((emacs-lisp . t)
			     (python . t)
     			     (shell . t)
			     (lua . t)))

;; -- org bullets
(require 'org-bullets)
(add-hook 'org-mode-hook
	  (lambda () (org-bullets-mode 1)))

;; -- align tags thingy
(defun my-org-align-tags () (interactive) (org-align-tags 0))
(add-hook 'org-mode-hook
	  (lambda ()
	    (add-hook 'after-save-hook 'my-org-align-tags nil 'make-it-local)))

;; -- org to xml export
(add-to-list 'load-path "~/my-files/emacs/.emacs.d/my-packages/org-to-xml")
(require 'om-to-xml) ;; requires "org-ml" (from melpa)

;; -- org github toc
;; (add-hook 'org-mode-hook #'org-make-toc-mode)

;-----------------------------------------------------------------------;
; NOTIFICATION THINGY                                                   ;
;-----------------------------------------------------------------------;
(appt-activate t)

(setq appt-message-warning-time 10
      appt-display-interval appt-message-warning-time
      appt-display-mode-line nil)

(require 'appt)

(defun my-org-agenda-to-appt () (interactive)
       (setq appt-time-msg-list nil)(org-agenda-to-appt))

(my-org-agenda-to-appt)

(add-hook 'after-save-hook #'(lambda ()
			      (if (string= (buffer-file-name)
					   (concat (getenv "HOME") "/my-files/org/org-todo/todo.org"))
				  (my-org-agenda-to-appt))))

(setq appt-disp-window-function 'my-appt-display
      appt-delete-window-function (lambda () t)
      my-appt-notification-app (concat (getenv "HOME") "/bin/appt-notification"))

(defun my-appt-display (min-to-app new-time msg)
  (if (atom min-to-app)
      (start-process "my-appt-notification-app" nil my-appt-notification-app min-to-app msg)
    (dolist (i (number-sequence 0 (1- (length min-to-app))))
      (start-process "my-appt-notification-app" nil my-appt-notification-app (nth i min-to-app) (nth i msg)))))

;-----------------------------------------------------------------------;
; WEBSITE                                                               ;
;-----------------------------------------------------------------------;
(setq org-static-blog-publish-title "Ilmari Koria"
      org-static-blog-publish-url "https://ilmarikoria.com"
      org-static-blog-publish-directory "~/my-files/org/org-blog/html"
      org-static-blog-posts-directory "~/my-files/org/org-roam/blog"
      org-static-blog-drafts-directory "~/my-files/org/org-blog/blog-drafts"
      org-static-blog-enable-tags nil
      org-static-blog-preview-ellipsis ""
      org-static-blog-use-preview t
      org-static-blog-preview-start ""
      org-static-blog-preview-end "")

(setq org-static-blog-index-front-matter "<div id=\"recent-posts\">
                                          <h2>recent posts</h2>
                                          </div>")      

(setq org-static-blog-page-header "<meta name=\"author\" content=\"Ilmari Koria\">
                                   <meta name=\"referrer\" content=\"no-referrer\">
                                   <meta name=\"viewport\" content=\"initial-scale=1.0,maximum-scale=1.0,user-scalable=no\" />
                                   <link href= \"static/style.css\" rel=\"stylesheet\" type=\"text/css\" />
                                   <link rel=\"icon\" href=\"data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 100 100%22><text y=%22.9em%22 font-size=%2290%22>🏞</text></svg>\">")
 
(setq org-static-blog-page-preamble "<div id=\"banner\">
                                     <div id=\"top-nav\">
                                     <p style=\"text-align:left;\">ilmari koria blog
                                     <span style=\"float:right;\">
                                     <a href=\"https://ilmarikoria.com\">home</a> | <a href=\"https://ilmarikoria.com/archive.html\">posts</a> | <a href=\"https://ilmarikoria.com/contact.html\">contact</a>
                                     </span>
                                     </p>
                                     </div>
                                     </div>")      

(setq org-static-blog-page-postamble "<hr>
                                      <div id=\"bottom-nav\">
                                      <a href=\"https://ilmarikoria.com/rss.xml\">rss</a> | <a href=\"https://creativecommons.org/licenses/by-nc/4.0/\">license</a>
                                      </div>")

;-----------------------------------------------------------------------;
; ORG ROAM                                                              ;
;-----------------------------------------------------------------------;
;; -- org-roam automatically uses whatever completion engine is on
(add-hook 'after-init-hook 'helm-mode)
(helm-mode t)
(setq helm-truncate-lines t)

;; -- roam basic
(setq org-roam-directory (file-truename "~/my-files/org/org-roam")
      org-roam-v2-ack t
      org-roam-completion-everywhere t)

(org-roam-db-autosync-mode)

;; -- roam ui visualiser 
(setq org-roam-ui-sync-theme t
      org-roam-ui-follow t
      org-roam-ui-update-on-save t
      org-roam-ui-open-on-start t)

;; -- roam templates
(setq org-roam-capture-templates
      '(("p" "permanent" plain "%?" :target (file+head "permanent-notes/%<%Y-%m-%d>-permanent-${slug}.org" "#+title: ${title}\n#+filetags: %^{TAGS}\n # ~ REMEMBER: max 200 words") :unnarrowed t)
        ("b" "blog" plain "%?" :target (file+head "blog-drafts/%<%Y-%m-%d>-blog-${slug}.org" "#+title: ${title}\n#+filetags: %^{TAGS}\n#+DESCRIPTION: %^{short description}\n#+date: <%<%Y-%m-%d %H:%M>>\n# ~ REMEMBER: max 5-6 citations\n* Introduction\n* par2\n* par3\n* par4\n* par5\n* par6\n* par7\n* Conclusion\n* References :ignore:\n#+BIBLIOGRAPHY: bibliography.bib plain option:-a option:-noabstract option:-heveaurl limit:t\n* Footnotes :ignore:\n* Text-dump :noexport:") :unnarrowed t)
        ("r" "reference" plain "%?" :target (file+head "reference-notes/%<%Y-%m-%d>-reference-${citekey}.org" "#+title: ${citekey} - ${title}\n#+filetags: %^{TAGS}\n\n--\n *") :unnarrowed t)
        ("m" "misc" plain "%?" :target (file+head "misc/%<%Y-%m-%d>-misc-${slug}.org" "#+title: ${title}\n#+filetags: %^{TAGS}") :unnarrowed t) ;; everything else
        ("w" "wiki" plain "%?" :target (file+head "wiki/%<%Y-%m-%d>-wiki-${slug}.org" "#+title: ${title}\n#+filetags: %^{TAGS}") :unnarrowed t)
        ("l" "application" plain "%?" :target (file+head "application-notes/%<%Y-%m-%d>-application-${slug}.org" "#+title: ${title}\n#+filetags: %^{TAGS}") :unnarrowed t)
        ("t" "tech-note" plain "%?" :target (file+head "tech-notes/%<%Y-%m-%d>-tech-note-${slug}.org" "#+title: ${title}\n#+filetags: %^{TAGS}") :unnarrowed t)
        ("e" "presentation" plain "%?" :target (file+head "presentation/%<%Y-%m-%d>-presentation-${slug}.org" "#+title: ${title}\n#+filetags: %^{TAGS}\n#+setupfile: ~/my-files/org/org-setup/beamer") :unnarrowed t)
        ("a" "academic-note" plain "%?" :target (file+head "academic-notes/%<%Y-%m-%d>-academic-note-${slug}.org" "#+title: ${title}\n#+filetags: %^{TAGS}") :unnarrowed t))) ;; my general note category for academic studies and professional stuff, use tags to specifiy

;; -- dailies
(setq org-roam-dailies-directory "~/my-files/org/org-roam/fleeting-notes"
      org-roam-dailies-capture-templates '(("f" "fleeting-notes" entry "\n* %<%Y-%m-%d %H:%M> - %?" :target (file "fleeting-notes.org"))))

;; -- deft
(setq deft-recursive t
      deft-use-filter-string-for-filename t
      deft-default-extension "org"
      deft-directory org-roam-directory)

;; -- journal
(require 'org-journal)
(setq org-journal-dir "~/my-files/org/org-roam/org-journal"
      org-journal-date-format "%Y-%m-%d"
      org-journal-file-format "%Y-%m-journal.org"
      org-journal-enable-agenda-integration t
      org-journal-file-type 'monthly
      org-journal-file-header "#+title: Journal %Y-%m\n#+filetags: diary")

;; -- org roam bibtex
;; (require 'org-roam-bibtex)
(add-hook 'after-init-hook 'org-roam-bibtex-mode)
(setq orb-insert-follow-link t)

;; -- add "type" node
(cl-defmethod org-roam-node-type ((node org-roam-node))
  "Return the TYPE of NODE."
  (condition-case nil
      (file-name-nondirectory (directory-file-name
			       (file-name-directory
				(file-relative-name (org-roam-node-file node) org-roam-directory))))
    (error "")))
(setq org-roam-node-display-template "${type:20} ${tags:50} ${title:*}")

;; -- dont cache headings with :ATTACH: tag
(setq org-roam-db-node-include-function
      (lambda ()
        (not (member "ATTACH" (org-get-tags)))))

;; -- org roam buffer settings
;; (setq org-roam-mode-sections
;;       (list #'org-roam-backlinks-section
;;             #'org-roam-reflinks-section
;;             ;; #'org-roam-unlinked-references-section
;;             ))

(add-to-list 'display-buffer-alist
             '("\\*org-roam\\*"
               (display-buffer-in-direction)
               (direction . right)
               (window-width . 0.33)
               (window-height . fit-window-to-buffer)))

;; -- TODO fix this hack
(add-hook 'org-roam-buffer-postrender-functions 'visual-line-mode)
(add-hook 'org-roam-buffer-postrender-functions 'org-indent-mode)
(add-hook 'org-roam-buffer-postrender-functions 'wrap-region-mode)

;-----------------------------------------------------------------------;
; ELFEED RSS                                                            ; 
;-----------------------------------------------------------------------;
;; -- basic setup
(setq elfeed-search-filter "@3-days-ago +unread"
      elfeed-search-title-max-width 100
      elfeed-search-title-min-width 100
      url-queue-timeout 30
      elfeed-use-curl t)

;; -- styling hooks
(add-hook 'elfeed-show-mode-hook 'olivetti-mode)
(add-hook 'elfeed-show-mode-hook 'visual-line-mode)

;; -- elfeed-org
(require 'elfeed-org)
(elfeed-org)
(setq rmh-elfeed-org-files (list "~/my-files/org/org-roam/misc/2022-07-10-misc-rss-feed.org"))

;; -- fix for use with olivetti
(defun elfeed-olivetti (buff)
  (switch-to-buffer buff)
  (olivetti-mode)
  (elfeed-show-refresh))

(setq elfeed-show-entry-switch 'elfeed-olivetti)

;-----------------------------------------------------------------------;
; LATEX                                                                 ;
;-----------------------------------------------------------------------;
(setq TeX-auto-save t
      TeX-parse-self t
      TeX-PDF-mode t
      reftex-plug-into-AUCTeX t
      TeX-engine 'xetex
      pdf-latex-command "xelatex") ; needed from latex preview pane

(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'display-line-numbers-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(add-hook 'LaTeX-mode-hook 'hl-line-mode)
(add-hook 'LaTeX-mode-hook (lambda () (olivetti-mode -1)))

(latex-preview-pane-enable)

;; ;-----------------------------------------------------------------------;
;; ; STYLING/THEMES                                                        ; 
;; ;-----------------------------------------------------------------------;
;; ;; -- org styling
;(set-face-underline 'org-ellipsis nil)

;----------------------------------------------------------------------;
; ADDED BY EMACS                                                       ; 
;----------------------------------------------------------------------;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(modus-vivendi))
 '(custom-safe-themes
   '("5a611788d47c1deec31494eb2bb864fde402b32b139fe461312589a9f28835db" "4a288765be220b99defaaeb4c915ed783a9916e3e08f33278bf5ff56e49cbc73" default))
 '(org-agenda-files
   '("/home/ilmari/my-files/org/org-roam/todo/todo.org" "/home/ilmari/my-files/org/org-roam/academic-notes/2022-06-06-academic-note-nccu_mandarin_notes.org" "/home/ilmari/my-files/org/org-roam/org-journal/2022-07-journal.org"))
 '(org-ellipsis " ⤾")
 '(org-hide-leading-stars t)
 '(package-selected-packages
   '(backup-each-save zoutline xclip writegood-mode wrap-region wc-mode synosaurus swiper srefactor pkg-info palimpsest org-wc org-static-blog org-roam-ui org-roam-bibtex org-ref org-pomodoro org-msg org-ml org-make-toc org-journal org-contrib org-bullets olivetti multiple-cursors mu4e-alert modus-themes magit lua-mode lsp-mode latex-preview-pane iedit helm-descbinds grammarly gnu-elpa-keyring-update flyspell-popup expand-region engine-mode elfeed-org deft citeproc bongo auctex aggressive-indent adaptive-wrap ace-window))
 '(tool-bar-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Noto Sans Mono" :foundry "GOOG" :slant normal :weight normal :height 120 :width normal))))
 '(flyspell-duplicate ((t nil)))
 '(flyspell-incorrect ((t (:inherit modus-themes-lang-error))))
 '(minibuffer-prompt ((t (:inherit modus-themes-prompt))))
 '(writegood-duplicates-face ((t (:underline (:color "deep sky blue" :style wave)))))
 '(writegood-passive-voice-face ((t (:underline (:color "magenta" :style wave)))))
 '(writegood-weasels-face ((t (:underline (:color "green yellow" :style wave))))))
