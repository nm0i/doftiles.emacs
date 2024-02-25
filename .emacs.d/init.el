;;; Emacs Config
;; This configuration relies on outline mode for readability.
(setf user-full-name "nm0i"
      user-mail-address "nm0i@me0w.net")

;;; Core
(setq file-name-handler-alist nil
      site-run-file nil)
(setq custom-file "~/.emacs.d/custom.el")
;;Kill child procs, in repl and other modes
(setq confirm-kill-processes nil)
;;;; Garbage collection
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.3)
(setq create-lockfiles nil)
;;;; Atomatic saves
(setq auto-save-default nil)
(setq backup-by-copying t
      backup-by-copying-when-linked t)
(setq delete-old-versions t
      kept-new-versions 12
      kept-old-versions 4
      version-control t)
(setq backup-directory-alist (quote (("." . "~/.saves"))))
;;;; Encryption
(epa-file-enable)
; https://stackoverflow.com/questions/76388376/emacs-org-encrypt-entry-hangs-when-file-is-modified
(fset 'epg-wait-for-status 'ignore)

(setq auth-sources '("~/.authinfo.gpg"))
(defun nm0i-fetch-password (&rest params)
  (require 'auth-source)
  (let ((match (car (apply 'auth-source-search params))))
    (if match
        (let ((secret (plist-get match :secret)))
          (if (functionp secret)
              (funcall secret)
            secret))
      (error "Password not found for %S" params))))

;;; ELPA
(package-initialize)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/")
                         ("melpa" . "http://melpa.org/packages/")))
(setopt package-archive-priorities '(("melpa" . 10) ("gnu" . 9) ("nongnu" . 8)))

(add-to-list 'load-path "~/.emacs.d/scripts")
(add-to-list 'load-path "~/.emacs.d/elpa")
(add-to-list 'load-path "/usr/share/emacs/site-lisp/ledger-mode")

;;; Interface
;;;; Xorg specifics
(modify-frame-parameters nil '((wait-for-wm . nil)))
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(set-fringe-mode 10)
(setq frame-title-format "%b")
(set-face-attribute 'fringe nil :foreground "dim gray")
;;;;; Fonts
(setq inhibit-compacting-font-caches t)
(add-to-list 'default-frame-alist '(font . "FontAwesome 10"))
(add-to-list 'default-frame-alist '(font . "Fira Code 10"))
(add-to-list 'default-frame-alist '(font . "-*-terminus-medium-*-*-*-14-*-*-*-*-*-iso10646-*"))
(set-fontset-font t 'unicode "Fira Code" nil 'append)
(set-fontset-font t 'unicode "FontAwesome" nil 'append)
(set-fontset-font t 'unicode "Font Awesome 5 Brands" nil 'append)
(set-fontset-font t 'unicode "Font Awesome 6 Brands" nil 'append)
(set-fontset-font t 'unicode "Noto Color Emoji" nil 'append)
(set-fontset-font t 'unicode "Twitter Color Emoji" nil 'append)
(set-fontset-font t 'unicode "Quivira" nil 'append)
;;;;; i3wm tweaks
(setq frame-inhibit-implied-resize t)
(setq fit-window-to-buffer-horizontally t)
;;;; Modeline
(setq display-battery-mode nil)
(setq mode-line-compact t
      mode-line-position-column-line-format '(" %l.%c"))
(size-indication-mode t)

(setq inhibit-startup-echo-area-message t)
(setq inhibit-startup-message t)

;;;; Encoding
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)


;;;; New themes engine
(load-theme 'almost-mono-black t)
(enable-theme 'almost-mono-black)
;;;; Recentf
(setq recentf-auto-cleanup 'never)
(recentf-mode 1)
(setq recentf-max-menu-items 128)
(setq recentf-max-saved-items 128)
;;;; Column numbers
(column-number-mode 1)
;;;; Delete selection
(delete-selection-mode 1)
;;;; Highlight parentheses
(show-paren-mode 1)
(setq show-paren-highlight-openparen t
      show-paren-when-point-inside-paren t
      show-paren-when-point-in-periphery t)
;;;; Volatile highlights
(volatile-highlights-mode t)
;;;; Scrolling
(setq hscroll-margin 2
      hscroll-step 1
      scroll-conservatively 101
      scroll-margin 0
      scroll-preserve-screen-position t
      auto-window-vscroll nil)
;;;; Line numbering
(dolist (mode '(text-mode-hook
		prog-mode-hook
		conf-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 1))))
(dolist (mode '(org-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;;;; Line highlight
(dolist (mode '(text-mode-hook
		prog-mode-hook
		conf-mode-hook))
  (add-hook mode (lambda () (hl-line-mode 1))))

;;;; Minibuffer
(setq enable-recursive-minibuffers t)

;;;; Ghostscript
(setq preview-gs-options '("-q" "-dNOPAUSE" "-dSAFER" "-dDELAYSAFER" "-DNOPLATFONTS" "-dTextAlphaBits=1" "-dGraphicsAlphaBits=1"))
;;;; Identation
(setq-default indent-tabs-mode nil)
(setq tab-width 4)
;;;; Downcasing and upcasing
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
;;;; Window managing
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)
;;;; Smart switch window by numbers
(global-set-key (kbd "C-x o") 'switch-window)
;;;; Global keybindings
(global-set-key (kbd "C-c u") 'browse-url)
;;;; Keybindings on cyrillic layouts
(require 'reverse-im)
(reverse-im-activate "russian-computer")
;;;; Dialog style
(fset 'yes-or-no-p 'y-or-n-p)
;;;; Key hints
(which-key-mode 1)

;;; Autocompletion
;;;; Company
;;;; syntactic-close

(global-set-key (kbd "M-]") 'syntactic-close)

;;;; bbyac completion
(bbyac-global-mode t)
;;;; Electric pair
(add-hook 'prog-mode 'electric-pair-mode)
(add-hook 'conf-mode 'electric-pair-mode)
;;; Search
;;;; Helm
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x f") 'helm-find-files)
(global-set-key (kbd "C-s") 'helm-occur)
(global-set-key (kbd "C-c s b") 'helm-swoop-back-to-last-point)
(global-set-key (kbd "C-c s s") 'helm-swoop)
(global-set-key (kbd "C-c s m") 'helm-multi-swoop)
(global-set-key (kbd "C-c s a") 'helm-multi-swoop-all)
(global-set-key (kbd "C-c C-s") 'search-forward)
(define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-c M-x") 'execute-extended-command) ;; This is your old M-x.
(global-set-key (kbd "M-o i") 'helm-semantic-or-imenu)
(global-set-key (kbd "M-o u") 'helm-tree-sitter-or-imenu)
(global-set-key (kbd "M-o y") 'helm-show-kill-ring)
(global-set-key (kbd "M-o f") 'helm-for-files)
(global-set-key (kbd "M-o b") 'helm-bookmarks)
(global-set-key (kbd "M-o g") 'helm-git-grep)
;;;; Grep
(setq-default grep-save-buffers nil)
;;; Tools
;;;; Dired
(setq dired-dwim-target t)
(setq dired-recursive-deletes 'always)
(setq dired-listing-switches "-alN --group-directories-first")
(setq dired-use-ls-dired t)
(setq ls-lisp-dirs-first t)
(defun nm0i-open ()
  "Open file in external program."
  (interactive)
  (let* (($file-list
          (if (string-equal major-mode "dired-mode")
              (dired-get-marked-files)
            (list (buffer-file-name))))
         ($do-it-p (if (<= (length $file-list) 3)
                       t
                     (y-or-n-p "Open more than 3 files? "))))
    (when $do-it-p
      (mapc
       (lambda ($fpath) (let ((process-connection-type nil))
                          (start-process "" nil "xdg-open" $fpath)))
       $file-list))))
(eval-after-load "dired"
  '(progn
     (define-key dired-mode-map (kbd "M-o") 'nm0i-open)))

;;;; Doc-view
(setq doc-view-ghostscript-device "pnggray"
      doc-view-cache-directory "~/.cache/docview"
      doc-view-resolution 192
      doc-view-ghostscript-options '("-dSAFER" "-dNOPAUSE" "-dTextAlphaBits=2" "-dBATCH" "-dGraphicsAlphaBits=2" "-dQUIET"))
;;;; Vterm
(global-set-key [f2]  'vterm)
(setq vterm-max-scrollback 10000)
(setq vterm-tramp-shells '("docker" "/bin/zsh" "/bin/bash" "/bin/sh"))
;;; Text
;;;; Plain text
(add-hook 'text-mode-hook 'flyspell-mode)
;;;; Markdown markup mode
(add-hook 'markdown-mode-hook 'auto-fill-mode)
(add-hook 'markdown-mode-hook 'flyspell-mode)
(add-to-list 'auto-mode-alist '("\\.md" . markdown-mode))
;;;; Spellchecking
;;;;; Multiple languages spellcheck ring
(let ((langs '("ru" "fi" "american")))
  (setq lang-ring (make-ring (length langs)))
  (dolist (elem langs) (ring-insert lang-ring elem)))
;;function to cycle the ring
(defun cycle-ispell-languages ()
  (interactive)
  (let ((lang (ring-ref lang-ring -1)))
    (ring-insert lang-ring lang)
    (ispell-change-dictionary lang)))
(ispell-change-dictionary "american")
(global-set-key [f6]  'cycle-ispell-languages)

;;;;; Guess language
(setq guess-language-languages '(en ru fi))
(setq guess-language-min-paragraph-length 35)

;;;; ORG-mode
(setq org-mobile-directory "/ssh:me0w:.org/")
(setq org-directory "~/localdocs/Documents/org")
(setq org-agenda-files '("~/localdocs/Documents/org/tasks.org"))

(org-babel-do-load-languages
 'org-babel-load-languages '((C . t)
                             (R . t)
                             (shell . t)
                             (maxima . t)
                             (awk . t)
                             (python . t)))
(setq org-confirm-babel-evaluate nil)
(defun nm0i-org-retrieve-url-from-point ()
  "Copies the URL from an org link at the point"
  (interactive)
  (let ((plain-url (url-get-url-at-point)))
    (if plain-url
        (progn
          (kill-new plain-url)
          (message (concat "Copied: " plain-url)))
      (let* ((link-info (assoc :link (org-context)))
             (text (when link-info
                     (buffer-substring-no-properties
                      (or (cadr link-info) (point-min))
                      (or (caddr link-info) (point-max))))))
        (if (not text)
            (error "Oops! Point isn't in an org link")
          (string-match org-link-bracket-re text)
          (let ((url (substring text (match-beginning 1) (match-end 1))))
            (kill-new url)
            (message (concat "Copied: " url))))))))

;;;; CSV
(defun nm0i-lisp-table-to-org-table (table &optional function)
  (unless (functionp function)
    (setq function (lambda (x) (replace-regexp-in-string "\n" " " x))))
  (mapconcat (lambda (x)                ; x is a line.
               (concat "| " (mapconcat function x " | ") " |")) table "\n"))
(defun nm0i-csv-to-table (beg end)
  "Convert a csv file to an `org-mode' table."
  (interactive "r")
  (require 'pcsv)
  (insert (nm0i-lisp-table-to-org-table (pcsv-parse-region beg end)))
  (delete-region beg end)
  (org-table-align))
;;; Network
;;;; HTTP Proxy
(defun nm0i-toggle-env-http-proxy ()
  "set/unset the environment variable http_proxy which emacs uses"
  (interactive)
  (let ((proxy "http://127.0.0.1:8118")
        (sproxy "http://127.0.0.1:8118"))
    (if (string= (or (getenv "http_proxy")
                     (getenv "https_proxy")) proxy)
        ;; clear the proxy
        (progn
          (setenv "http_proxy" "")
          (setenv "https_proxy" "")
          (message "env http_proxy is empty now"))
      ;; set the proxy
      (setenv "http_proxy" proxy)
      (setenv "https_proxy" sproxy)
      (message "env http_proxy is %s now" proxy))))
(setenv "http_proxy" "http://127.0.0.1:8118")
(setenv "https_proxy" "http://127.0.0.1:8118")
(setq url-proxy-services '(("http" . "127.0.0.1:8118")
 			   ("https" . "127.0.0.1:8118")))
;;;; Mail-edit
(add-to-list 'auto-mode-alist '("\\.article" . message-mode))
(add-to-list 'auto-mode-alist '("\\.followup" . message-mode))
(setq mail-header-separator "")
(add-hook 'message-mode-hook 'flyspell-mode)
(add-hook 'message-mode-hook 'auto-fill-mode)
;;;; Transmission
;;(setq transmission-host "192.168.0.30")
;; (setq transmission-rpc-auth
;;       '(:username "user"))

;;;; Dokuwiki
(defun nm0i-dokuwiki-setup (doku-uri doku-user)
  (interactive)
  (setq dokuwiki-xml-rpc-url doku-uri)
  (setq dokuwiki-login-user-name doku-user))
(add-to-list 'auto-mode-alist '("\\.dokuwiki\\'" . dokuwiki-mode))
(add-to-list 'auto-mode-alist '("\\.dwiki\\'" . dokuwiki-mode))
;;;; Mastodon
(add-to-list 'browse-url-handlers '("https?://[^/]+/@[^/]+/.*" . 'nm0i-mastodon-open-at-point))
(defun nm0i-mastodon-open-at-point ()
  "Open the URL at point, or prompt if a URL is not found."
  (interactive)
  (mastodon-url-lookup (or (thing-at-point 'url) (read-string "URL: "))))

(eval-after-load "mastodon"
  '(progn
     (define-key mastodon-mode-map (kbd "g") 'mastodon-tl--update)
     ;; (load-file "~/.emacs.d/mastodon-tl-alternative.el")
     ;; (mastodon-alt-tl-activate)
     ))
(setq mastodon-instance-url "https://emacs.ch"
      mastodon-active-user "nm0i@me0w.net")
(setq mastodon-toot-timestamp-format "%Y-%m-%d %H:%M"
      mastodon-media--preview-max-height 196)
(setq mastodon-auth-source-file "~/.emacs.d/mastodon.cred")
;;;; Browse-url
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "xdg-open")
;;;; w3m
(setq
 w3m-show-graphic-icons-in-header-line nil
 w3m-use-favicon t
 w3m-use-cookies t
 w3m-confirm-leaving-secure-page nil
 w3m-cookie-accept-bad-cookies t
 w3m-enable-google-feeling-lucky nil
 w3m-search-default-engine "searx"
 w3m-search-engine-alist '(("searx" "https://me0w.net/s/search?q=%s" utf-8)
			   ("duckduck" "https://duckduckgo.com/lite/?q=%s" undecided)
			   ("openwrt" "https://wiki.openwrt.org/start?do=search&id=%s")
			   ("btdigg" "https://btdig.com/search?q=%s")
 			   ("wiki" "https://en.wikipedia.org/w/index.php?search=%s")
                           ("torduck" "https://duckduckgogg42xjoc72x3sjasowoarfbgcmvfimaftt6twagswzczad.onion/lite/?q=%s")
 			   ("fiwiki" "https://fi.wikipedia.org/w/index.php?search=%s")
 			   ("ruwiki" "https://ru.wikipedia.org/w/index.php?search=%s")
 			   ("enwiki" "https://en.wikipedia.org/w/index.php?search=%s")
 			   ("owm" "http://openweathermap.org/find?q=%s")
			   ("thesarus" "http://www.thesaurus.com/browse/%s?s=t")
 			   ("zugaina" "https://gpo.zugaina.org/Search?search=%s")
			   ("astalavista" "http://astalavista.box.sk/cgi-bin/robot?srch=%s")
			   ("emacswiki" "https://duckduckgo.com/?q=%s+site%3Aemacswiki.org")))

(defun nm0i-bookmarks () "Open bookmarks file"  (interactive)
       (find-file "~/localdocs/Documents/bookmarks.org"))
(eval-after-load "w3m"
  '(progn
     (define-key w3m-mode-map (kbd "S") 'w3m-search-new-session)
     (define-key w3m-mode-map (kbd "v") 'nm0i-bookmarks)))
;;(setq w3m-image-viewer "/usr/bin/sxiv")

;;;; Circe
(setq circe-use-cycle-completion t)
(setq helm-mode-no-completion-in-region-in-modes
      '(circe-channel-mode
        circe-query-mode
        circe-server-mode))
(setq circe-reduce-lurker-spam t)
(setq circe-prompt-string "> ")
(setq circe-format-self-say "{nick:12s} {body}")
(setq circe-format-say "{nick:12s} {body}")
(setq circe-format-server-topic "*** Topic by {userhost}: {topic-diff}")
(setq circe-server-max-reconnect-attempts nil)
(setq circe-default-part-message ".")
(setq circe-default-quit-message ".")
(setq circe-new-day-notifier-date-format "%Y-%m-%d")
(setq
 lui-fill-type nil
 lui-time-stamp-position 'right-margin
 lui-time-stamp-format "%H:%M" )

(defun nm0i-circe-lui-setup ()
  (setq
   fringes-outside-margins t
   right-margin-width 5
   word-wrap t
   wrap-prefix "    ")
  (setq right-margin-width 5))

(add-hook 'lui-mode-hook 'nm0i-circe-lui-setup)

(defun circe-command-DETACH (what)
  (circe-command-MSG "Bouncerserv" (concat "channel update  " what " -detached true")))

(defadvice tracking-shorten (around tracking-shorten-aggressively)
  (let ((shorten-join-function #'shorten-join-sans-tail))
    ad-do-it))
(ad-activate 'tracking-shorten)

(setq lui-flyspell-p t
      lui-flyspell-alist '(("#gentoo-fi" "fi")
                           ("#gentoo-ru" "ru")
                           ("#RCZNIT" "ru")
                           ("#russf2" "ru")
                           (".*" "american")))
(setq tracking-ignored-buffers '("&bitlbee"))

(eval-after-load 'circe
  '(progn
     '(defun lui-irc-propertize (&rest args))
     (enable-circe-new-day-notifier)
     ;; (enable-circe-color-nicks)
     '(circe-set-display-handler "NICK" (lambda (&rest ignored) nil))
     '(circe-set-display-handler "PART" (lambda (&rest ignored) nil))
     '(circe-set-display-handler "QUIT" (lambda (&rest ignored) nil))
     '(circe-set-display-handler "JOIN" (lambda (&rest ignored) nil))
     '(circe-set-display-handler "AWAY" (lambda (&rest ignored) nil))
     (global-set-key (kbd "C-x n") 'helm-circe-new-activity)
     (defadvice circe-command-SAY (after jjf-circe-unignore-target)
       (let ((ignored (tracking-ignored-p (current-buffer) nil)))
         (when ignored
           (setq tracking-ignored-buffers
                 (remove ignored tracking-ignored-buffers))
           (message "This buffer will now be tracked."))))
     (ad-activate 'circe-command-SAY)))

(autoload 'enable-circe-notifications "circe-notifications" nil t)
(add-hook 'circe-server-connected-hook 'enable-circe-notifications)
(eval-after-load "circe-notifications"
  '(setq circe-notifications-watch-strings
         '("nm0i")))

(defun nm0i-circe-pass ()
  (interactive)
  (nm0i-fetch-password :port 6767 :host "me0w.net" :user "nm0i"))
(defun nm0i-irc ()
  (interactive)
  (let ((passwd (nm0i-circe-pass)))
    (circe "bitlbee" :pass passwd)
    (circe "bitreich" :pass passwd)
    (circe "ergo" :pass passwd)
    (circe "freenode" :pass passwd)
    (circe "libera" :pass passwd)
    (circe "matrix" :pass passwd)
    (circe "oftc" :pass passwd)
    (circe "sdf" :pass passwd)
    (circe "tilde" :pass passwd)
    (circe "twitch" :pass passwd)))
(setq
 circe-network-options
 '(("bitlbee" :host "me0w.net" :port 6767 :user "nm0i/bitlbee":tls t)
   ("bitreich" :host "me0w.net" :port 6767 :user "nm0i/bitreich":tls t)
   ("ergo" :host "me0w.net" :port 6767 :user "nm0i/ergo":tls t)
   ("freenode" :host "me0w.net" :port 6767 :user "nm0i/freenode":tls t)
   ("libera" :host "me0w.net" :port 6767 :user "nm0i/libera":tls t)
   ("matrix" :host "me0w.net" :port 6767 :user "nm0i/matrix":tls t)
   ("oftc" :host "me0w.net" :port 6767 :user "nm0i/oftc":tls t)
   ("sdf" :host "me0w.net" :port 6767 :user "nm0i/sdf":tls t)
   ("tilde" :host "me0w.net" :port 6767 :user "nm0i/tilde":tls t)
   ("twitch" :host "me0w.net" :port 6767 :user "nm0i/twitch":tls t)))

;;;; Matrix
(eval-after-load "ement"
  '(progn
     (setq ement-notify-dbus-p nil
           ement-room-avatar-max-height 8
           ement-room-avatar-max-width 8
           ement-room-avatars t
           ement-room-event-separator-display-property " "
           ement-room-images t
           ement-room-left-margin-width 8
           ement-room-list-avatars nil
           ement-room-list-item-indent 2
           ement-room-message-format-spec "%S%L%B%r%R%t" nil (ement-room)
           ement-room-prism 'name
           ement-room-replace-edited-messages nil
           ement-room-send-typing nil
           ement-room-timestamp-format "%H:%M"
           ement-room-timestamp-header-delta 30000000
           ement-room-timestamp-header-format "%H-%S"
           ement-room-timestamp-header-with-date-format "%Y-%m-%d %H-%S"
           ement-room-username-display-property '(raise 0.0)
           ement-save-sessions t)))
;;;; Telegram

(setq telega-server-libs-prefix "~/.local")
(setq telega-proxies
      '((:server "127.0.0.1" :port 9050 :enable t :type "proxyTypeSocks5")))
(setq telega-database-dir "~/.telega/")
(setq telega-accounts (list
  (list "elmer" 'telega-database-dir
        (expand-file-name "elmer" telega-database-dir))
  (list "nm0i" 'telega-database-dir
        (expand-file-name "nm0i" telega-database-dir))))
(setq telega-chat-fill-column 116)
(setq telega-active-locations-show-avatars nil)
(setq telega-notifications-mode t)
(setq telega-chat-show-avatars nil)
(setq telega-use-tracking-for t)
(setq telega-root-show-avatars nil)
(eval-after-load "telega"
  '(progn
     (add-hook 'telega-chat-mode-hook 'flyspell-mode)))

;;; Code utilities
;;;; Outline mode
  (defvar outline-minor-mode-prefix "\M-#")
(add-hook 'outline-minor-mode-hook 'outshine-mode)
;;;; Tree sitter
(global-tree-sitter-mode)
;;;; Compile-mode
(global-set-key (kbd "C-c c") 'compile)
;;;; yasnippet
(require 'yasnippet)
(yas-reload-all)
(add-hook 'prog-mode-hook #'yas-minor-mode)
(define-key yas-minor-mode-map (kbd "M-z") 'yas-expand)
;;;; Multiple cursors
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;;;; Paredit hooks
(add-hook 'scheme-mode-hook 'enable-paredit-mode)
(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)

;;;; Electric pair
(electric-pair-mode)

;;;; LSP
(add-hook 'lsp-mode 'company-mode)
(setq lsp-keymap-prefix "M-p")
(setq lsp-ui-doc-border "dim gray")
(setq lsp-ui-doc-enable nil)
(setq lsp-ui-doc-show-with-cursor t)
(setq lsp-ui-doc-show-with-mouse nil)
(add-hook 'lsp-mode 'lsp-ui-mode)
;;;; Magit
(global-set-key (kbd "C-c g") 'magit-status)
;;;; Direnv
(direnv-mode)
;;;; flycheck
;; (global-flycheck-mode t)
(global-set-key (kbd "C-c n") 'flycheck-next-error)
(global-set-key (kbd "C-c p") 'flycheck-prev-error)
;;; Languages
;;;; TeX
(setq TeX-view-program-selection
      '((output-pdf "PDF Viewer")))
(setq TeX-view-program-list
      '(("PDF Viewer" "zathura %o")))
(setq TeX-PDF-mode t)
(setq TeX-engine 'xetex)
(setq TeX-auto-save t)
(setq TeX-parse-self t)

(add-hook 'LaTeX-mode-hook 'auto-fill-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
;;;; Sage
(setq sage-shell:sage-root "~/src/SageMath/"
      sage-shell:use-prompt-toolkit nil
      sage-shell:use-simple-prompt t)
;;;; GDL-IDL
(autoload 'idlwave-mode "idlwave" "IDLWAVE Mode" t)
(autoload 'idlwave-shell "idlw-shell" "IDLWAVE Shell" t)
(setq idlwave-init-rinfo-when-idle-after 2)
(setq idlwave-shell-debug-modifiers '(control shift))
;;;; Gnuplot
(add-to-list 'auto-mode-alist '("\\.plot" . gnuplot-mode))
;;;; Octave
(add-to-list 'auto-mode-alist '("\\.m$" . octave-mode))
;;;; Julia
;;;; Maxima
(add-to-list 'auto-mode-alist '("\\.mac\\'" . maxima-mode))
(autoload 'maxima-mode "maxima" "Maxima mode" t)
(autoload 'imath-mode "imath" "Imath mode for math formula input" t)
(autoload 'imaxima "imaxima" "Frontend for maxima with Image support" t)
(autoload 'maxima "maxima" "Maxima interaction" t)
(setq imaxima-use-maxima-mode-flag t)
(setq imaxima-fnt-size "Large")
(setq imaxima-print-tex-command "latex %s; dvipdf %s.dvi imax.pdf; zathura imax.pdf")
;;;; Elisp
(define-key emacs-lisp-mode-map (kbd "<C-tab>") 'company-complete-common)
(add-hook 'emacs-lisp-mode-hook 'company-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
(add-hook 'emacs-lisp-mode-hook 'outshine-mode)
;;;; C
(add-hook 'c-mode-hook 'flyspell-mode)
(add-hook 'c-mode-hook 'electric-pair-mode)
(add-hook 'c-mode-hook 'dtrt-indent-mode) ;;Ident type determination.
(add-hook 'c-mode-hook 'electric-operator-mode)
(setq-default c-basic-offset 4)
(add-hook 'c-mode-hook
          (lambda () (add-to-list 'write-file-functions 'delete-trailing-whitespace)))
(eval-after-load 'cc-mode
  '(progn
     (define-key c-mode-map (kbd "<backtab>") 'nm0i-call-indent)))
(defun nm0i-call-indent (&optional b e)
  "Call external indent."
  (interactive "r")
  (shell-command-on-region b e "uncrustify -c ~/.uncrustify/knr.cfg -l c --frag -q"  t t "*Shell Error Output*")
  (indent-region b e))
(setq c-default-style '((java-mode . "java")
                        (awk-mode . "awk")
                        (other . "k&r")))

;;;; Web-mode
(setq web-mode-enable-engine-detection t)
(add-to-list 'auto-mode-alist '("\\.html" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml" . web-mode))
(setq web-mode-engines-alist
      '(("django"    . "\\.html\\'")))
(defun my-web-mode-hook ()
  "Hooks for web-mode."
  (setq web-mode-markup-indent-offset 2))
(setq web-mode-engines-alist
      '(("django" . "\\.html\\'")))
(add-hook 'web-mode-hook 'my-web-mode-hook)

;;;; SH
(add-to-list 'auto-mode-alist '("\\.rc\\'" . shell-script-mode) )
(add-hook 'shell-script-mode 'company-mode)
(add-hook 'shell-script-mode 'hs-minor-mode)
(add-hook 'shell-script-mode 'outshine-mode)

;;;; Python
(add-hook 'python-mode-hook 'lsp-deferred)
(add-hook 'python-mode-hook 'company-mode)
(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook 'anaconda-eldoc-mode)
(add-hook 'python-mode-hook 'hs-minor-mode)
(add-hook 'python-mode-hook 'python-isort-on-save-mode)
;; (add-hook 'python-mode-hook 'importmagic-mode)
(setq lsp-pylsp-plugins-black-enabled t
      lsp-pylsp-plugins-flake8-exclude []
      lsp-pylsp-plugins-pycodestyle-enabled t
      lsp-pylsp-plugins-pyflakes-enabled t)
(add-hook 'python-mode-hook
          (lambda () (add-to-list 'write-file-functions 'delete-trailing-whitespace)))
(add-hook 'python-mode-hook 'flycheck-mode)
(setq flycheck-pycheckers-checkers '(mypy3 pyflakes))
(add-hook 'flycheck-mode-hook 'flycheck-pycheckers-setup)
(setq python-black-command "black"
      python-black-extra-args '("-l 79"))
(eval-after-load "python"
  '(progn
     (define-key python-mode-map (kbd "<C-tab>") 'company-complete-common)
     (define-key python-mode-map (kbd "<backtab>") 'python-black-region)
     (define-key python-mode-map (kbd "C-u <backtab>") 'python-black-buffer)
     (define-key python-mode-map (kbd "M-i d") 'helm-pydoc)
     (define-key python-mode-map (kbd "M-i s") 'anaconda-mode-show-doc)))

;; (setq python-shell-interpreter "ipython"
;;       python-shell-interpreter-args "-i --simple-prompt --InteractiveShell.display_page=True")

;;;; Lua
(add-hook 'lua-mode-hook 'lsp-deferred)

;;;; GLSL
;; (autoload 'glsl-mode "glsl-mode" nil t)
;; (add-to-list 'auto-mode-alist '("\\.glsl\\'" . glsl-mode))
;; (add-to-list 'auto-mode-alist '("\\.vert\\'" . glsl-mode))
;; (add-to-list 'auto-mode-alist '("\\.frag\\'" . glsl-mode))
;; (add-to-list 'auto-mode-alist '("\\.geom\\'" . glsl-mode))
(defun sort-words (reverse beg end)
  (interactive "*P\nr")
  (sort-regexp-fields reverse "\\w+" "\\&" beg end))
;;; Customize-settings
(load-file "~/.emacs.d/custom.el")
