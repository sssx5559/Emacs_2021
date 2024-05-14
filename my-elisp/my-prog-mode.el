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
;; ;;(add-to-list 'exec-path (expand-file-name "~/.cargo/bin"))

;; (use-package rust-mode
;;   :ensure t
;;   :custom rust-format-on-save t)

;; (use-package cargo
;;   :ensure t
;;   :hook (rust-mode . cargo-minor-mode))


;;=========================================================
;; projectile
;;=========================================================
(use-package projectile
  :defer t

  :config ;; パッケージ読み込み後に実行
  (projectile-mode +1)
  (setq projectile-completion-system 'helm)
  ;; (helm-projectile-on)


  :bind	;; グローバルキー設定
    (("M-p" . projectile-command-map))
  ;; (("s-p" . projectile-command-map)) ; Mac
  ;; (("C-c p" . projectile-command-map)) ; Win
  )

;; projectile-ag用
(use-package ag)


;;=========================================================
;; dumb-jump
;;=========================================================
;; (use-package dumb-jump
;;   :ensure t
;;   ;; :bind(
;;   ;;       ("C-c g" . dumb-jump-go)         ;; クラスや関数、変数の定義されている場所へ飛ぶ
;;   ;;       ("C-c b" . dumb-jump-back)       ;; 飛んできたら、元の場所に戻る
;;   ;;       ("C-M-q" . dumb-jump-quick-look) ;; 飛ぶ前にジャンプ先の候補を表示
;;   ;;       )
;;   :init
;;   ;; dumb-jumpを起動
;;   (dumb-jump-mode)

;;   :config
;;   (add-hook 'xref-backend-functions #'dumb-jump-xref-activate) ;; xrefを使うらしいので起動させる
;;   (setq dumb-jump-force-searcher 'ag)          ;; デフォルトだとgit grepが使われてエラーが出たのでrgコマンドを強制利用する
;;   (setq dumb-jump-prefer-searcher 'ag)         ;; rgコマンドを優先的に利用する
;;   (setq dumb-jump-default-project "")          ;; ホームディレクトリ以下が検索対象になるのを回避
;;   ;; (setq dumb-jump-disable-obsolete-warnings t) ;; レガシーコマンドの警告を非表示
;;   )


;;=========================================================
;; smart-jump
;;=========================================================
;; (use-package smart-jump
;;  :ensure t
;;  :config
;;  (smart-jump-setup-default-registers))

;;=========================================================
;; Mermaid
;;=========================================================
(use-package mermaid-mode
  :custom
  (mermaid-output-format ".png")        ;".svg" or ".png" or ".pdf"

  ;; :bind
  ;; ;; デフォルト設定
  ;; ((("C-c C-c") 'mermaid-compile)
  ;;   (("C-c C-f") 'mermaid-compile-file)
  ;;   (("C-c C-b") 'mermaid-compile-buffer)
  ;;   (("C-c C-r") 'mermaid-compile-region)
  ;;   (("C-c C-o") 'mermaid-open-browser)
  ;;   (("C-c C-d") 'mermaid-open-doc))
  )
