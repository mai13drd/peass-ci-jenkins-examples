If you add a new script, you first have to approve it manually:
https://www.jenkins.io/doc/book/managing/script-approval/

After that, new script is added to approved scripts in scriptApproval.xml in jenkins workspace. Save that file and copy it back to the workspace on jenkins startup. So jenkins will consider the new script as already approved.
