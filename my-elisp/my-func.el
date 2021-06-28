;;;; -*- coding: utf-8 -*-

;;-----------------------------------------------------------------------------
;; 自作関数設定ファイル
;;-----------------------------------------------------------------------------
;; 2021/06/24 author miyazaki

;; フレームサイズ変更
(defun miya-resize-frame (size)
  "フレームサイズ変更

[key] : [action]
q : 終了
c : 元のサイズに戻す
f : 幅+
b : 幅-
n : 高さ+
p : 高さ-"
  (interactive "p")
  (catch 'exit
	(let ((init-height (frame-height))
		  (init-width (frame-width))
		  (key))
	(while t
	  (message "q:Quit c:Cancel [fbnp]:Resize  height = %d width = %d"
			   (frame-height) (frame-width))
	  (setq key (read-char))
	  (cond
	   ((eq key ?p) (set-frame-height nil (- (frame-height) size)))
	   ((eq key ?n) (set-frame-height nil (+ (frame-height) size)))
	   ((eq key ?b) (set-frame-width nil (- (frame-width) size)))
	   ((eq key ?f) (set-frame-width nil (+ (frame-width) size)))
	   ((eq key ?c)
		(set-frame-height nil init-height)
		(set-frame-width nil init-width))
	   ((eq key ?q) (throw 'exit t)))))))


;; フレーム位置変更
(defun miya-remove-frame (pos)
  "フレーム位置変更

[key] : [action]
q : 終了
c : 元の位置に戻す
f : 左端+
b : 左端-
n : 上端+
p : 上端-"  
  (interactive "p")
;  (if (< pos 10) (setq pos 20))
  (if (= pos 1) (setq pos 40))
  (catch 'exit
	(let* ((init-xpos (cdr (assq 'left (frame-parameters))))
		   (init-ypos (cdr (assq 'top (frame-parameters))))
		   (xpos init-xpos) 
		   (ypos init-ypos)
		   (key))
	  (while t
		(message "q:Quit c:Cancel [fbnp]:Remove  top = %d left = %d" ypos xpos)
		(setq key (read-char))
		(cond
		 ((eq key ?p) (setq ypos (- ypos pos)))
		 ((eq key ?n) (setq ypos (+ ypos pos)))
		 ((eq key ?b) (setq xpos (- xpos pos)))
		 ((eq key ?f) (setq xpos (+ xpos pos)))
		 ((eq key ?c) (setq ypos init-ypos
							xpos init-xpos))
		 ((eq key ?q) (throw 'exit t)))
		 (set-frame-position (selected-frame) xpos ypos)))))

;; フレーム初期化
(defun miya-init-frame ()
  (interactive)
  (progn
	(set-frame-height nil my-screen-height)
	(set-frame-width nil my-screen-width)
	(set-frame-position (selected-frame) my-screen-left my-screen-top)))


;; "リージョン内のコメント位置を調整する"(※作成中)
(defun miya-region-comment-orderline (start end)
  "リージョン内のコメント位置を調整する"
  (interactive "r")
  (let ((line-count (miya-region-count-lines start end))
		comment-text-alist
		pos
		(comment-max-column 0))
	(save-excursion
	  ;;=====================================================
	  ;; コメントのカラム位置とテキストを取得する初回ループ
	  ;;=====================================================
	  (goto-char start)
	  (do
		  ((i 1 (1+ i)))
		  ((> i line-count))
;		(setq pos (point))
;		(end-of-line)
;		(when (search-backward comment-start pos t)
		(when (search-forward comment-start (save-excursion
											  (end-of-line)
											  (point)) t)
		  (forward-char (- (length comment-start)))
		  (setq pos (point))
		  (when (< comment-max-column (current-column))
			(setq comment-max-column (current-column)))
		  (setq comment-text-alist
				(cons
				 (cons i
					   (buffer-substring (point) (progn
												   (end-of-line)
												   (point))))
				 comment-text-alist))
		  (goto-char pos)
		  (skip-chars-backward " \t　")
		  (delete-region (point) (progn (end-of-line) (point))))
		  (forward-line 1))
;	  (miya-debug-list comment-text-alist)
;	  (princ comment-max-column)
;	  (sit-for 3))
	  ;;=====================================================
	  ;; コメントを挿入する為の二回目のループ
	  ;;=====================================================
	  (goto-char start)
	  (do
		  ((i 1 (1+ i)))
		  ((> i line-count))
		(when (assq i comment-text-alist)
		  (move-to-column comment-max-column t)
		  (insert (cdr (assq i comment-text-alist))))
		(forward-line 1)))))


;; カーソルの位置の単語をリージョンで囲む(_-も単語に含める)
;; ついでに単語をコピーする
(defun miya-mark-word ()
  (interactive)
  (let ((word "[a-zA-Z0-9_-]")
		(non-word "[^a-zA-Z0-9_-]")
		(min (save-excursion
			   (progn (beginning-of-line) (point))))
		(max (save-excursion
			   (progn (end-of-line) (point))))
		start
		end)
	(if (string-match word (char-to-string (char-after)))
		(progn
		  (if (null (search-backward-regexp non-word min t))
			  (setq start min)
			(setq start (1+ (match-beginning 0))))
		  (forward-char 1)
		  (if (null (search-forward-regexp non-word max t))
			  (setq end max)
			(setq end (match-beginning 0)))
		  (kill-new (buffer-substring start end))
		  (goto-char start)
		  (push-mark
		   (save-excursion
			 (goto-char end)
			 (point))
		   nil t))
	  (message "No word"))))

;; カーソル上の単語位置を返す
;;
;; 引数：a-z, A-Z, 0-9以外に単語と認識する文字列
;;       例)'_'を単語に含める場合 (miya-word-search "_")
;;          '_', '-'を単語に含める場合 (miya-word-search '("_" "-"))
;;
;; 戻り値：(START END)のリスト
;;         単語が見つからない場合にはnil
;; (defun miya-word-search (&optional key)
;;   (let (word-regex-basic "a-zA-Z0-9"
;; 		word-regex-extend
;; 		non-word-regex-extend

;; (defun miya-word-search-make-regex (str list)
;;   (if (null list)
;; 	  (concat "[" str "]")
;; 	(let ((key (car list)))
;; 	  (cond
;; 	   ((string= "-" key)


;; 文字列挿入
(defun miya-insert-string (str index newstr)
  (when (< (length x) index)
	(setq index (length x)))
  (let ((split (miya-split-string str index)))
	(concat (first split) newstr (second split))))

;; 文字列分割
(defun miya-split-string (str index)
	(list
	 (substring str 0 index)
	 (substring str index)))

;; リージョン内の空白行を除去する
(defun miya-delete-blank-line (start end)
  (interactive "r")
  (let ((regex "[^ 　	]")
		(blank-line-count 0)
		(marker (make-marker)))			;; (kill-line)によってリージョン終端が変化してしまうのでmarkerを作成する
	  (save-excursion
		(goto-char start)
		(set-marker marker end)
		(while (< (point) marker)
		  (if (search-forward-regexp regex
									 (save-excursion
									   (end-of-line)
									   (point))
									 t)
			  (forward-line 1)
			(when (/= (point) (point-max))
			  (kill-line)
			  (incf blank-line-count)))))
	  (message "空白行数：%d" blank-line-count)))

;; 全角スペース→半角スペース変換
(defun miya-region-zenkaku-space-to-hankaku-space (start end)
  (interactive "r")
  (miya-common-region-convert-space start end ?　 ? ))

;; 半角スペース→全角スペース変換
(defun miya-region-hankaku-space-to-zenkaku-space (start end)
  (interactive "r")
  (miya-common-region-convert-space start end ?  ?　))

;; スペース変換共通関数
(defun miya-common-region-convert-space (start end old-char new-char)
    (let ((count 0)
		(marker (make-marker)))
	(save-excursion
	  (goto-char start)
	  (set-marker marker end)
	  (while (< (point) marker)
		(if (= (char-after) old-char)
			(progn
			  (delete-char 1)
			  (insert-char new-char 1)
			  (incf count))
		  (forward-char))))
	(message "Converted %d charcter." count)))

;;複利計算
(defun miya-calc-interest (capital rate term)
  (* capital (expt (1+ rate) term)))

;;複利計算2
(defun miya-calc-interest2 (capital rate year tsuika)
  (let ((count 0))
    (setq rate (/ rate 12.0))
    (setq year (* year 12))
    (while (< count year)
      (setq capital (miya-calc-interest (+ capital tsuika) rate 1))
      (incf count))
    capital))

;; 利回り計算
(defun miya-calc-rate (before after term)
  (- (expt (/ after before) (/ 1.0 term)) 1))

;; 16進数表示
(defmacro hex-print (param) (list 'format "#x%X" param))

;; カレントウィンドウの透明度設定
(when (>= emacs-major-version 22)
  (defun miya-set-frame-alpha (num)
	(interactive "n透明度(20 - 100):")
	(let (list)
	  (setq list (make-list 2 num))
	  (set-frame-parameter nil 'alpha list))))

;; 'global -u'コマンド実行
(defun miya-remake-gtags ()
  (interactive)
  (let* ((root-dir (if (require 'helm-gtags nil t)
					   (helm-gtags--tag-directory)
					 (gtags-get-rootpath)))
		 (cur-dir default-directory))
	(if root-dir
		(progn
		  (cd-absolute root-dir)
		  (call-process "global" nil nil nil "-u")
		  (cd-absolute cur-dir)
		  (message "GTAGS remade.")
		  )
	  (message "GTAGS not found."))))

;; ディレクトリ内の"*.el"ファイルをバイトコンパイル
(defun miya-byte-compile-folder (folder)
  (interactive "D")
  (let ((files (directory-files folder t "\.el$")))
	(while files
	  (when (not (byte-compile-file (car files)))
		(error (format "%sのコンパイルに失敗しました。" (car files))))
	  (setq files (cdr files)))))

;; ポイント位置の行数を返す
;; ※ current-columnは標準であるが、なぜか
;;    行数はないので"moccur.el"から拝借
;(defun current-line ()
;  "Return the vertical position of point..."
;  (1+ (count-lines 1 (point))))

;;=========================================================
;; バッファとウインドウを削除
;;=========================================================
(defun kill-buffer-and-window ()
  (interactive)
  (if (kill-buffer (current-buffer))
	  (delete-window)))
