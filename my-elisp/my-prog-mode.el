;;;; -*- coding: utf-8 -*-

;;-----------------------------------------------------------------------------
;; -プログラム言語設定ファイル
;;-----------------------------------------------------------------------------

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

;;=========================================================
;; web-mode
;;=========================================================
;; (use-package web-mode
;;   :defer t

;;   (add-to-list 'auto-mode-alist '("\\.p?html?\\'" . web-mode))
;;   (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
;;   (add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
;;   (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
;;   (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
;;   (add-to-list 'auto-mode-alist '("\\.ts[x]?\\'" . web-mode))

;;   :config ;; パッケージ読み込み後に実行
;;   (setq web-mode-markup-indent-offset 2)
;;   (setq web-mode-css-indent-offset 2)
;;   (setq web-mode-code-indent-offset 2)
;;   )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; #lsp

;; (use-package lsp-mode
;;   :ensure t
;;   :init (yas-global-mode)
;;   :hook
;;   (rust-mode . lsp)
;;   (web-mode . lsp)

;; ;  :bind ("C-c h" . lsp-describe-thing-at-point)
;;   :custom (lsp-rust-server 'rust-analyzer))

;; (use-package lsp-ui
;;   :ensure t)

