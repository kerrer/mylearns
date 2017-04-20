查看分支：
        $ git branch    该命令会类出当先项目中的所有分支信息，其中以*开头的表示当前所在的分支。参数-r列出远程仓库中的分支，而-a则远程与本地仓库的全部分支。
创建新分支：
        $ git branch testing    创建一个名为testing的分支

切换分支：
        $ git checkout teting   切换到testing分支上。通过向该命令传递一个-b参数，可以实现创建并切换分支的功能。

合并分支：
        $ git merge hotfix      将hotfix分支合并到当前分支当中去

删除分支：
        $ git branch -d hotfix  删除分支hotfix,-d选项只能删除已经被当前分支所合并过的分支，而要强制删除没有被合并过的分支，可以使用-D。

重命名分支：
        $ git branch -m oldbranch newbranch     -M用来强制重命名，如newbranch已经存在的时候。

查看分支之间的不同：
        $ git diff branchName   查看当前分支与branchName分支之间的差异，也可以使用：$ git diff branch1 branch2 来比较这1和2分支之间的差异，当使用第一种方式比较时，如果当前工作目录中存在与branchName同名的文件，系统则会提示错误，要是指明要比较的是文件还是分支，如果比较分支，可以进入.git中进行比较或切换分支，如果是>比较文件，则使用$ git diff -- fileName命令。
        $ git diff <branchA>:<fileA> <branchB>:<fileB>
        $ git ls-tree -r branch 列出所有的树对象

合并冲突：
    如果在不同的分支中都修改了同一个文件的同一部分，Git 就无法干净地把两者合到一起（译注：逻辑上说，这种问题只能由人来裁决。）
    任何包含未解决冲突的文件都会以未合并（unmerged）的状态列出。Git 会在有冲突的文件里加入标准的冲突解决标记，可以通过它们来手工定位并解决这些冲突。
    在解决了所有文件里的所有冲突后，运行 git add 将把它们标记为已解决状态（译注：实际上就是来一次快照保存到暂存区域。）。因为一旦暂存，就表示冲突已经解决。如
果你想用一个有图形界面的工具来解决这些问题，不妨运行 git mergetool，它会调用一个可视化的合并工具并引导你解决所有冲突。
    要从该清单中筛选出你已经（或尚未）与当前分支合并的分支，可以用 --merge 和 --no-merged 选项（Git 1.5.6 以上版本）。比如用 git branch --merge 查看哪些分支>已被并入当前分支（译注：也就是说哪些分支是当前分支的直接上游。）

远程分支：
    远程分支是对远程仓库分支的索引。它们是一些无法移动的本地分支，只有在Git进行网络交互时才会更新。我们用(远程仓库名)/(分支名)来表示远程分支。比如想查看上次>同origin仓库通讯时master的样子，就应该查看origin/master分支。

推送本地分支：
    $ git push (远程仓库名字) (分支名)  如：$ git push orgin serverfix 该命令会将本地serverfix分支推送到origin远程仓库的serverfix分支中去，也可以使用命令 $ git push origin serverfix:serferfix实现同样的效果，可以将第二个serverfix更改为其它名字来指定要将该本地分支推送到远程仓库中的的指定分支中去，如果不存在，则会在
远程仓库中新建分支。

获取远程分支：
    在使用git clone命令从远程服务器克隆Git仓库时，只是将远程仓库当前分支的内容克隆到本地，要是克隆其他分支的内容，需要使用下面命令：可通过git branch -r命令来
查看想要获取的远程仓库中的分支。
    $ git fetch origin  值得注意的是，在 fetch 操作下载好新的远程分支之后，你仍然无法在本地编辑该远程仓库中的分支。
    如果要把该内容合并到当前分支，可以运行 git merge origin/serverfix。如果想要一份自己的 serverfix 来开发，可以在远程分支的基础上分化出一个新的分支来：
        $ git checkout -b serverfix origin/serverfix
    这会切换到新建的 serverfix 本地分支，其内容同远程分支 origin/serverfix 一致，这样你就可以在里面继续开发了。

Git pull:
    从服务器的仓库中获取代码，和本地代码合并。（与服务器交互，从服务器上下载最新代码，等同于： Git fetch + Git merge）。
    从其它的版本库（既可以是远程的也可以是本地的）将代码更新到本地，例如：“git pull origin master ”就是将origin这个版本库的代码更新到本地的master主分支。
       git pull可以从任意一个git库获取某个分支的内容。用法如下：
       git pull username@ipaddr: 远端repository名 远端分支名:本地分支名。这条命令将从远端git库的远端分支名获取到本地git库的一个本地分支中。其中，如果不写本地
分支名，则默认pull到本地当前分支。
       需要注意的是，git pull也可以用来合并分支。 和git merge的作用相同。 因此，如果你的本地分支已经有内容，则git pull会合并这些文件，如果有冲突会报警。

Git push
    将本地commit的代码更新到远程版本库中，例如 “git push origin”就会将本地的代码更新到名为orgin的远程版本库中。
       git push和git pull正好想反，是将本地某个分支的内容提交到远端某个分支上。用法： git pushusername@ipaddr: 远端repository名 本地分支名:远端分支名。这条命
令将本地git库的一个本地分支push到远端git库的远端分支名中。
       需要格外注意的是，git push好像不会自动合并文件。因此，如果git push时，发生了冲突，就会被后push的文件内容强行覆盖，而且没有什么提示。 这在合作开发时是>很危险的事情。

git-clone命令只要碰到类似下面格式的远程仓库地址，都会被认为地址是符合SSH协议的：        账户@IP：工作目录

git checkout -b [分支名] [远程名]/[分支名]
如果你有 1.6.2 以上版本的 Git，还可以用 --track 选项简化
        $ git checkout --track origin/serverfix

删除远程分支：
        git push [远程名] :[分支名]

git pull 远程仓库名 远程分支:本地分支
git push 远程仓库名 远程分支:本地分支
git checkout -b 分支名 远程仓库名/分支名
