(defun git-wip-wrapper () 
  (interactive)
  (eval '(shell-command (concat "git-wip save \"WIP from emacs: " (buffer-name) "\" --editor -- " (file-name-nondirectory (buffer-file-name))) " &"))
  ;; (message (concat "Wrote and git-wip'd " (buffer-file-name)))
  ) 

(defun eab/shell-command-sentinel (process signal)
  "Handle PROCESS signaling SIGNAL."
  (let ((sig (substring signal 0 -1))
        (command (car (cdr (cdr (process-command process))))))
    (cond ((string= sig "finished")
           nil)
          ((not (string= sig "finished"))
           (message "git-wip, Command failed.")
           ))))

;; TODO перестало работать на victory
;; (defun git-wip-wrapper () 
;;   (interactive)
;;   (setq proc (start-process "git-wip"
;;                                   nil
;;                                   shell-file-name
;;                                   shell-command-switch
;;                                   (concat "git-wip save \"WIP from emacs: " (buffer-file-name) "\" --editor -- " (buffer-file-name) " &")))
;;   (set-process-sentinel proc 'eab/shell-command-sentinel)
;;   )

(defun git-wip-if-git ()
  (interactive)
  (when (string= (vc-backend (buffer-file-name)) "Git")
    (git-wip-wrapper)))

(add-hook 'after-save-hook 'git-wip-if-git)

(provide 'git-wip)
