<p><strong>1. Найдите полный хеш и комментарий коммита, хеш которого начинается на aefea.&nbsp;</strong></p>

<p>git show aefea</p>

<p><em>commit aefead2207ef7e2aa5dc81a34aedf0cad4c32545<br />
Author: Alisdair McDiarmid &lt;alisdair@users.noreply.github.com&gt;<br />
Date: &nbsp; Thu Jun 18 10:29:58 2020 -0400</em></p>

<p><em>&nbsp; &nbsp; Update CHANGELOG.md</em><br />
&nbsp;</p>

<p><strong>2. Какому тегу соответствует коммит 85024d3?</strong></p>

<p>git show 85024d3</p>

<p><em>commit 85024d3100126de36331c6982bfaac02cdab9e76 (tag: v0.12.23)</em></p>

<p>&nbsp;</p>

<p><strong>3. Сколько родителей у коммита b8d720? Напишите их хеши.</strong></p>

<p><em>git show b8d720 --pretty=format:&quot;%P&quot;</em></p>

<p>56cd7859e05c36c06b56d013b55a252d0bb7e158<br />
9ea88f22fc6269854151c571162c5bcf958bee2b</p>

<p>&nbsp;</p>

<p><strong>4. Перечислите хеши и комментарии всех коммитов которые были сделаны между тегами v0.12.23 и v0.12.24.</strong></p>

<p>git log v0.12.23..v0.12.24 --oneline</p>

<p>33ff1c03b (tag: v0.12.24) v0.12.24<br />
b14b74c49 [Website] vmc provider links<br />
3f235065b Update CHANGELOG.md<br />
6ae64e247 registry: Fix panic when server is unreachable<br />
5c619ca1b website: Remove links to the getting started guide&#39;s old location<br />
06275647e Update CHANGELOG.md<br />
d5f9411f5 command: Fix bug when using terraform login on Windows<br />
4b6d06cc5 Update CHANGELOG.md<br />
dd01a3507 Update CHANGELOG.md<br />
225466bc3 Cleanup after v0.12.23 release</p>

<p>&nbsp;</p>

<p><strong>5. Найдите коммит в котором была создана функция func providerSource, ее определение в коде выглядит так func providerSource(...) (вместо троеточего перечислены аргументы).</strong></p>

<p>git log -S &quot;func providerSource(&quot; git show 8c928e8</p>

<p>commit 8c928e83589d90a031f811fae52a81be7153e82f</p>

<p>&nbsp;</p>

<p><strong>6. Найдите все коммиты в которых была изменена функция globalPluginDirs.</strong></p>

<p>git log -S &quot;func globalPluginDirs&quot;</p>

<p>35a058fb3 main: configure credentials from the CLI config file<br />
c0b176109 prevent log output during init<br />
8364383c3 Push plugin discovery down into command package</p>

<p>&nbsp;</p>

<p><strong>7. Кто автор функции synchronizedWriters?</strong></p>

<p>git log -S &quot;func synchronizedWriters(&quot; --pretty=format:&quot;%h, %an, %ad, %s&quot;</p>

<p>Author: Martin Atkins &lt;<a href="mailto:mart@degeneration.co.uk">mart@degeneration.co.uk</a>&gt;</p>
