;;;; -*- coding: utf-8 -*-

;;-----------------------------------------------------------------------------
;; フォント設定ファイル
;;-----------------------------------------------------------------------------
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; NTEmacs, Ubuntu用
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun NTEmacs-font-set (myfont)
  ;; MSYS2用判定追加 2020/11/22
;  (unless (msys2p)
;	(set-default-font myfont))

  ;; 固定等幅フォント
  (set-face-attribute 'fixed-pitch    nil :family myfont)
  ;; 可変幅フォント
  (set-face-attribute 'variable-pitch nil :family myfont)
  (add-to-list 'default-frame-alist (cons 'font myfont))
  (set-face-font 'font-lock-comment-face       myfont)
  (set-face-font 'font-lock-string-face        myfont)
  (set-face-font 'font-lock-keyword-face       myfont)
  (set-face-font 'font-lock-builtin-face       myfont)
  (set-face-font 'font-lock-function-name-face myfont)
  (set-face-font 'font-lock-variable-name-face myfont)
  (set-face-font 'font-lock-type-face          myfont)
  (set-face-font 'font-lock-constant-face      myfont)
  (set-face-font 'font-lock-warning-face       myfont))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Font set
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(NTEmacs-font-set my-font)

