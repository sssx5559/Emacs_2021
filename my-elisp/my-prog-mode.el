;;;; -*- coding: utf-8 -*-

;;-----------------------------------------------------------------------------
;; -プログラム言語設定ファイル
;;-----------------------------------------------------------------------------

;;=========================================================
;; magit
;;=========================================================
(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)
         ("C-x M-g" . magit-dispatch-popup))
  :config
  (defun mu-magit-kill-buffers ()
    "Restore window configuration and kill all Magit buffers."
    (interactive)
    (let ((buffers (magit-mode-get-buffers)))
      (magit-restore-window-configuration)
      (mapc #'kill-buffer buffers)))
  (bind-key "q" #'mu-magit-kill-buffers magit-status-mode-map))


;;=========================================================
;; web-mode
;;=========================================================
(use-package add-node-modules-path
  :custom
  (add-node-modules-path-command '("npm bin")))

(use-package web-mode
  :init ;; パッケージ読み込み前に実行
  (add-hook 'web-mode-hook 'lsp)

  :mode ;; auto-mode-alist設定
  (("\\.\\([mc]?ts[x]\\|ts\\.erb\\)\\'" . web-mode) ; typescript
   ("\\.\\([mc]?js\\|js\\.erb\\)\\'"   . web-mode)  ; javascript
   ;; ("\\.\\(api\\|json\\|jsonld\\)\\'"   . web-mode) ; json
   ("\\.[jt]sx\\'"   . web-mode))                   ; jsx

  :custom
  (web-mode-markup-indent-offset 2)
  (web-mode-css-indent-offset 2)
  (web-mode-code-indent-offset 2)
  ;; (web-mode-part-padding 0)
  (tab-width 2)
	(indent-tabs-mode nil) ;; オートインデントでスペースを使う
  (web-mode-enable-current-element-highlight t)
  (let ((case-fold-search nil))
    (highlight-regexp "\\_<number\\|string\\|boolean\\|enum\\|unknown\\|any\\|void\\|null\\|undefined\\|never\\|object\\|symbol\\_>" 'font-lock-type-face))

  :config ;; パッケージ読み込み後に実行
  (eval-after-load 'web-mode
    '(add-hook 'web-mode-hook #'add-node-modules-path))
  )

(use-package flymake-eslint
  :config
  (add-hook 'web-mode-hook
            (lambda ()
              (flymake-eslint-enable))))

(use-package prettier
  :config
  (add-hook 'web-mode-hook
            (lambda ()
              (prettier-mode))))


;;=========================================================
;; js-mode
;;=========================================================
;; (add-hook 'js-mode-hook
;;           (lambda ()
;;             (make-local-variable 'js-indent-level)
;;             (setq js-indent-level 2)))


;;=========================================================
;; #lsp
;;=========================================================
(use-package lsp-mode
  :ensure t
  :init (yas-global-mode)
  :hook (rust-mode . lsp)
;  :bind ("C-c h" . lsp-describe-thing-at-point)
  :custom (lsp-rust-server 'rust-analyzer))

(use-package lsp-ui
  :ensure t)


;;=========================================================
;; Rust-mode
;;=========================================================
;;(add-to-list 'exec-path (expand-file-name "~/.cargo/bin"))

(use-package rust-mode
  :ensure t
  :custom rust-format-on-save t)

(use-package cargo
  :ensure t
  :hook (rust-mode . cargo-minor-mode))

