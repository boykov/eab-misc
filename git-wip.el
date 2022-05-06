;;; git-wip.el --- git-wip wrapper -*- lexical-binding: t -*-

(defun git-wip-wrapper () 
  (interactive)
  ;; (shell-command (concat "git-wip save \"WIP from emacs: " (buffer-name) "\" --editor -- " (file-name-nondirectory (buffer-file-name))) " &")
  (start-process "git-wip"
                 nil
                 shell-file-name
                 shell-command-switch
                 (concat "git-wip save \"WIP from emacs: " (buffer-file-name) "\" --editor -- " (buffer-file-name)))
  ;; (message (concat "Wrote and git-wip'd " (buffer-file-name)))
  ) 

(defun git-wip-if-git ()
  (interactive)
  (when (string= (vc-backend (buffer-file-name)) "Git")
    (git-wip-wrapper)))

(add-hook 'after-save-hook 'git-wip-if-git)

(provide 'git-wip)
