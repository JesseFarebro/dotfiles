;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Jesse Farebrother"
      user-mail-address "jessefarebro@gmail.com")

; vterm
(setq explicit-shell-file-name (executable-find "fish"))
(setq vterm-kill-buffer-on-exit t)

;; (setq +ligatures-in-modes t)
;; (setq +ligatures-extras-in-modes '(org-mode))

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-font (font-spec :family "MesloLGM Nerd Font" :size 13))
(setq doom-font (font-spec :family "MesloLGS Nerd Font" :size 14)
      doom-big-font (font-spec :family "MesloLGS Nerd Font" :size 19)
      doom-variable-pitch-font (font-spec :family "IBM Plex Sans" :size 16)
      doom-unicode-font (font-spec :family "MesloLGS Nerd Font")
      doom-serif-font (font-spec :family "IBM Plex Sans" :size 16 :weight 'medium))

(setq doom-theme 'doom-palenight)
(doom/set-frame-opacity 95)
(solaire-global-mode +1)

;; Smooth scroll
(when (fboundp 'pixel-scroll-precision-mode)
  (pixel-scroll-precision-mode 1))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

(after! org
  (map! :map org-mode-map
        :n "M-j" #'org-metadown
        :n "M-k" #'org-metaup))


(setq projectile-project-search-path '("~/Development/"))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

(setq org-latex-create-formula-image-program 'dvisvgm)

;; Default frame size
(when (window-system)
  (set-frame-height (selected-frame) 60)
  (set-frame-width (selected-frame) 150)
  (set-frame-position (selected-frame) 50 30))

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(use-package! tree-sitter
  :config
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

;; pylsp language server
(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp))))  ; or lsp-deferred

(use-package! firestarter
  :ensure t
  :init
  (firestarter-mode)
  :config
  (setq firestarter-default-type t))
