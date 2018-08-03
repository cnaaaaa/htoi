(global-linum-mode t)
;; (setq linum-format (lambda (line) (propertize (format (let ((w (length (number-to-string (count-lines (point-min) (point-max)))))) (concat "%" (number-to-string w) "d \u2502 ")) line) 'face 'linum)))
; (setq linum-format "%d  ")

(defun make-backup-file-name (filename)
  (expand-file-name
   (concat "." (file-name-nondirectory filename) "~")
   (file-name-directory filename)))

(global-set-key (kbd "C-c <up>") 'windmove-up)
(global-set-key (kbd "C-c <down>") 'windmove-down)
(global-set-key (kbd "C-c <left>") 'windmove-left)
(global-set-key (kbd "C-c <right>") 'windmove-right)

(delete-selection-mode 1)
(add-hook 'emacs-startup-hook 'toggle-frame-maximized)

(add-to-list 'load-path "~/.emacs.d/3rd")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

(require 'package) ;; You might already have this line
(add-to-list 'package-archives
	     '("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")))
(package-initialize) ;; You might already have this line

; (require 'auto-complete)
(global-auto-complete-mode)

; theme
(load-theme 'jbeans t)

; helm
(require 'helm-config)
(helm-mode 1)
(require 'setup-helm)
; (global-set-key (kbd "C-s") 'helm-occur)

; Go ;
(add-to-list 'exec-path "~/go/bin")
(add-to-list 'exec-path "~/go_projects/bin")

; (add-to-list 'load-path "~/.emacs.d/elpa/archives/go-mode.el")
; (require 'go-mode-autoloads)

(with-eval-after-load 'go-mode
  (require 'go-autocomplete))

(with-eval-after-load 'go-mode
     (require 'go-guru))

; (add-hook 'before-save-hook 'gofmt-before-save)

(defun my-go-mode-hook ()
  ; Use goimports instead of go-fmt
  (setq gofmt-command "goimports")

  (go-guru-hl-identifier-mode)
  
  ; Call Gofmt before saving
  (add-hook 'before-save-hook 'gofmt-before-save)
  
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
	              "go build -v && go test -v && go vet"))
  ; Godef jump key binding
  (local-set-key (kbd "M-.") 'godef-jump)
  (local-set-key (kbd "M-*") 'pop-tag-mark)
  )
(add-hook 'go-mode-hook 'my-go-mode-hook)

(defun auto-complete-for-go ()
  (auto-complete-mode 1))
(add-hook 'go-mode-hook 'auto-complete-for-go)

(defun go-code-format ()
    (local-set-key (kbd "C-c M-f") 'gofmt-before-save))
(add-hook 'go-mode-hook 'go-code-format)


;; Go ;;
