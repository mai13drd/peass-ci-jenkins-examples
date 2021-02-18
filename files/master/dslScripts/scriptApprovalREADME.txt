If you add a new script, you first have to approve it manually once:
https://www.jenkins.io/doc/book/managing/script-approval/

After that, new script is added to approved scripts in scriptApproval.xml in jenkins workspace. Save that file here so it can copied back to the workspace on jenkins startup. Jenkins will now consider the new script as already approved.
