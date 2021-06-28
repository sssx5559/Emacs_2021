;;;; -*- coding: utf-8 -*-

;;-----------------------------------------------------------------------------
;; キーバインド設定ファイル
;;-----------------------------------------------------------------------------

;;---------------------------------------------------------
;; Alt(A-x), Meta(M-x), Super(s-x), Hyper(H-x)キー設定
;;---------------------------------------------------------
(cond
 ((windowsp)
  ;;(setq w32-pass-rwindow-to-system nil)
  ;;(setq w32-rwindow-modifier 'super)		; 右win

  ;;(setq w32-pass-lwindow-to-system nil)
  ;;(setq w32-lwindow-modifier 'super)		; 左win

  ;; (setq w32-pass-apps-to-system nil)
  ;; (setq w32-apps-modifier 'hyper)			; App
  )
 ((macp)
  (setq mac-command-modifier 'meta)			; 左command
  (setq mac-right-command-modifier 'hyper)	; 右command
  ;;(setq mac-alternate-modifier 'super)		; ?
  ;;(setq mac-right-alternate-modifier 'alt)	; ?
  ;;(setq mac-option-modifier 'alt)			; 左option
  ;;(setq mac-right-option-modifier 'alt)		; 右option
  ;;(setq mac-control-modifier 'super)		; 左control
  ;;(setq mac-right-control-modifier 'super)	; 右control
  (setq mac-function-modifier 'alt)			; function
  )
 ((linuxp)
  )
 (t
  ;; Nothing
  ))

;;---------------------------------------------------------
;; global設定
;;---------------------------------------------------------
;;; C-h を backspace として使う。
; (keyboard-translate ?\C-h ?\C-?)
; (global-set-key "\C-h" nil)
(global-set-key "\C-h" 'backward-delete-char)

;; C-chをヘルプとして使う
(global-set-key "\C-ch" 'help-command)

;; 改行キーでオートインデント
(global-set-key "\C-m" 'newline-and-indent)

;; 改行キーの割り当て
(global-set-key "\C-j" 'newline)

;; リージョンコメントアウト
(global-set-key "\C-c\C-c" 'comment-region)

;; リージョンコメント削除
(global-set-key "\C-c\C-u" 'uncomment-region)

;; レジスタリスト
(global-set-key "\C-c\C-r" 'view-register)

;;行ジャンプ
(global-set-key "\C-cj" 'goto-line)

;; 1行コメント削除
;(global-set-key (kbd "C-c C-k") 'kill-comment)

;; URLからブラウザを表示
;(global-set-key "\C-cl" ;(if (fboundp 'w3m)
;;;;			    'w3m-browse-url
;			  'browse-url-at-point)


;; ファイル再読み込み
;(global-set-key (kbd "C-c r") '(lambda ()
;								 (interactive)
;								 (revert-buffer nil t)))

;; 最後のマークに移動
(defun move-to-mark ()
  (interactive)
  (let ((pos (point)))
	(goto-char (mark))
	(push-mark pos)))
(global-set-key "\M-p" 'move-to-mark)

;; ウィンドウ内のカーソル移動
;; (global-set-key (kbd "C-M-h") (lambda () (interactive) (move-to-window-line 0)))
;; (global-set-key (kbd "C-M-m") (lambda () (interactive) (move-to-window-line nil)))
;; (global-set-key (kbd "C-M-l") (lambda () (interactive) (move-to-window-line -1)))

(global-set-key (kbd "C-<up>") 'scroll-other-window-down)
(global-set-key (kbd "C-<down>") 'scroll-other-window)

(global-set-key (kbd "M-/") 'hippie-expand)		;; 動的略語展開の拡張
(global-set-key (kbd "C-x t") 'transpose-chars)	;; "C-t"はsmartrepに割り当てた為

;; 日本語入力(default-input-method)
(global-set-key (kbd "<henkan>") 'toggle-input-method)
(global-set-key (kbd "<muhenkan>") 'toggle-input-method)
;;(global-set-key (kbd "\C-\\") nil)

;; フレーム移動 (Windowsでは使えないかも)
(global-set-key (kbd "H-<left>") 'ns-prev-frame)
(global-set-key (kbd "H-<right>") 'ns-next-frame)

;; 日付挿入
(global-set-key (kbd "C-c d")
				'(lambda ()
				   (interactive)
				   (insert (format-time-string "%Y/%m/%d"))))

;;=========================================================
;; 自作関数呼び出し
;;=========================================================
;; カーソル上の単語選択
(global-set-key (kbd "C-c @") 'miya-mark-word)

;; フレーム最大化トグル切り替え
(global-set-key (kbd "C-c m") 'miya-toggle-frame-size)

;; フレーム位置変更
(global-set-key (kbd "C-c C-m") 'miya-remove-frame)
