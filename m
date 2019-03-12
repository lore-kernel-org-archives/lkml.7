Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C6FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 03:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96990214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 03:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfCLDZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 23:25:57 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:53784 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726998AbfCLDZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 23:25:49 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04452;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TMWN2uw_1552361145;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TMWN2uw_1552361145)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 12 Mar 2019 11:25:45 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     corbet@lwn.net, harryxiyou@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Li Yang <leoyang.li@nxp.com>, TripleX Chung <xxx.phy@gmail.com>
Subject: [PATCH v4 26/31] docs/zh_CN: fix rst format errors in howto.rst
Date:   Tue, 12 Mar 2019 11:24:55 +0800
Message-Id: <20190312032501.62056-27-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.856.g8858448bb
In-Reply-To: <20190312032501.62056-1-alex.shi@linux.alibaba.com>
References: <20190312032501.62056-1-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tame howto.rst file to avoid "ERROR: Unexpected indentation." etc
compiler errors.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Harry Wei <harryxiyou@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Li Yang <leoyang.li@nxp.com>
Cc: TripleX Chung <xxx.phy@gmail.com>
Signed-off-by: Weiwei Jia <harryxiyou@gmail.com>
---
 .../translations/zh_CN/process/howto.rst      | 32 +++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/Documentation/translations/zh_CN/process/howto.rst b/Documentation/translations/zh_CN/process/howto.rst
index 22708f9f6078..184dcd42f378 100644
--- a/Documentation/translations/zh_CN/process/howto.rst
+++ b/Documentation/translations/zh_CN/process/howto.rst
@@ -38,6 +38,7 @@ Linux内核大部分是由C语言写成的，一些体系结构相关的代码
 参与内核开发，你必须精通C语言。除非你想为某个架构开发底层代码，否则你并
 不需要了解（任何体系结构的）汇编语言。下面列举的书籍虽然不能替代扎实的C
 语言教育和多年的开发经验，但如果需要的话，做为参考还是不错的：
+
  - "The C Programming Language" by Kernighan and Ritchie [Prentice Hall]
    《C程序设计语言（第2版·新版）》（徐宝文 李志 译）[机械工业出版社]
  - "Practical C Programming" by Steve Oualline [O'Reilly]
@@ -94,16 +95,20 @@ Linux内核代码中包含有大量的文档。这些文档对于学习如何与
 
   Documentation/process/submitting-patches.rst
   Documentation/process/submitting-drivers.rst
+
     这两份文档明确描述如何创建和发送补丁，其中包括（但不仅限于)：
        - 邮件内容
        - 邮件格式
        - 选择收件人
+
     遵守这些规定并不能保证提交成功（因为所有补丁需要通过严格的内容和风格
     审查），但是忽视他们几乎就意味着失败。
 
     其他关于如何正确地生成补丁的优秀文档包括：
     "The Perfect Patch"
+
         http://www.ozlabs.org/~akpm/stuff/tpp.txt
+
     "Linux kernel patch submission format"
 
         http://linux.yyz.us/patch-format.html
@@ -111,9 +116,11 @@ Linux内核代码中包含有大量的文档。这些文档对于学习如何与
   Documentation/process/stable-api-nonsense.rst
     论证内核为什么特意不包括稳定的内核内部API，也就是说不包括像这样的特
     性：
+
        - 子系统中间层（为了兼容性？）
        - 在不同操作系统间易于移植的驱动程序
        - 减缓（甚至阻止）内核代码的快速变化
+
     这篇文档对于理解Linux的开发哲学至关重要。对于将开发平台从其他操作系
     统转移到Linux的人来说也很重要。
 
@@ -140,6 +147,7 @@ Linux内核代码中包含有大量的文档。这些文档对于学习如何与
 妥善处理加锁的规则。生成的文档会放在 Documentation/DocBook/目录下。在内
 核源码的主目录中使用以下不同命令将会分别生成PDF、Postscript、HTML和手册
 页等不同格式的文档：
+
     make pdfdocs
     make htmldocs
 
@@ -147,7 +155,9 @@ Linux内核代码中包含有大量的文档。这些文档对于学习如何与
 如何成为内核开发者
 ------------------
 如果你对Linux内核开发一无所知，你应该访问“Linux内核新手”计划：
+
 	http://kernelnewbies.org
+
 它拥有一个可以问各种最基本的内核开发问题的邮件列表（在提问之前一定要记得
 查找已往的邮件，确认是否有人已经回答过相同的问题）。它还拥有一个可以获得
 实时反馈的IRC聊天频道，以及大量对于学习Linux内核开发相当有帮助的文档。
@@ -158,7 +168,9 @@ Linux内核代码中包含有大量的文档。这些文档对于学习如何与
 
 如果你想加入内核开发社区并协助完成一些任务，却找不到从哪里开始，可以访问
 “Linux内核房管员”计划：
+
 	http://kernelnewbies.org/KernelJanitors
+
 这是极佳的起点。它提供一个相对简单的任务列表，列出内核代码中需要被重新
 整理或者改正的地方。通过和负责这个计划的开发者们一同工作，你会学到将补丁
 集成进内核的基本原理。如果还没有决定下一步要做什么的话，你还可能会得到方
@@ -167,6 +179,7 @@ Linux内核代码中包含有大量的文档。这些文档对于学习如何与
 如果你已经有一些现成的代码想要放到内核中，但是需要一些帮助来使它们拥有正
 确的格式。请访问“内核导师”计划。这个计划就是用来帮助你完成这个目标的。它
 是一个邮件列表，地址如下：
+
 	http://selenic.com/mailman/listinfo/kernel-mentors
 
 在真正动手修改内核代码之前，理解要修改的代码如何运作是必需的。要达到这个
@@ -174,6 +187,7 @@ Linux内核代码中包含有大量的文档。这些文档对于学习如何与
 一些特制的工具还可以提供帮助。例如，“Linux代码交叉引用”项目就是一个值得
 特别推荐的帮助工具，它将源代码显示在有编目和索引的网页上。其中一个更新及
 时的内核源码库，可以通过以下地址访问：
+
 	http://sosdg.org/~coywolf/lxr/
 
 
@@ -182,6 +196,7 @@ Linux内核代码中包含有大量的文档。这些文档对于学习如何与
 
 目前Linux内核开发流程包括几个“主内核分支”和很多子系统相关的内核分支。这
 些分支包括：
+
   - 2.6.x主内核源码树
   - 2.6.x.y -stable内核源码树
   - 2.6.x -git内核补丁集
@@ -194,6 +209,7 @@ Linux内核代码中包含有大量的文档。这些文档对于学习如何与
 2.6.x内核是由Linus Torvalds（Linux的创造者）亲自维护的。你可以在
 kernel.org网站的pub/linux/kernel/v2.6/目录下找到它。它的开发遵循以下步
 骤：
+
   - 每当一个新版本的内核被发布，为期两周的集成窗口将被打开。在这段时间里
     维护者可以向Linus提交大段的修改，通常这些修改已经被放到-mm内核中几个
     星期了。提交大量修改的首选方式是使用git工具（内核的代码版本管理工具
@@ -317,6 +333,7 @@ linux-kernel邮件列表中提供反馈，告诉大家你遇到了问题还是
 
 bugzilla.kernel.org是Linux内核开发者们用来跟踪内核Bug的网站。我们鼓励用
 户在这个工具中报告找到的所有bug。如何使用内核bugzilla的细节请访问：
+
 	http://test.kernel.org/bugzilla/faq.html
 
 内核源码主目录中的admin-guide/reporting-bugs.rst文件里有一个很好的模板。它指导用户如何报
@@ -344,10 +361,14 @@ bugzilla.kernel.org是Linux内核开发者们用来跟踪内核Bug的网站。
 
 正如上面的文档所描述，大多数的骨干内核开发者都加入了Linux Kernel邮件列
 表。如何订阅和退订列表的细节可以在这里找到：
+
 	http://vger.kernel.org/vger-lists.html#linux-kernel
+
 网上很多地方都有这个邮件列表的存档(archive)。可以使用搜索引擎来找到这些
 存档。比如：
+
 	http://dir.gmane.org/gmane.linux.kernel
+
 在发信之前，我们强烈建议你先在存档中搜索你想要讨论的问题。很多已经被详细
 讨论过的问题只在邮件列表的存档中可以找到。
 
@@ -355,10 +376,12 @@ bugzilla.kernel.org是Linux内核开发者们用来跟踪内核Bug的网站。
 MAINTAINERS文件中可以找到不同话题对应的邮件列表。
 
 很多邮件列表架设在kernel.org服务器上。这些列表的信息可以在这里找到：
+
 	http://vger.kernel.org/vger-lists.html
 
 在使用这些邮件列表时，请记住保持良好的行为习惯。下面的链接提供了与这些列
 表（或任何其它邮件列表）交流的一些简单规则，虽然内容有点滥竽充数。
+
 	http://www.albion.com/netiquette/
 
 当有很多人回复你的邮件时，邮件的抄送列表会变得很长。请不要将任何人从抄送
@@ -384,6 +407,7 @@ Documentation/process/submitting-patches.rst文档中所述）。内核开发者
 
 内核社区的目标就是提供尽善尽美的内核。所以当你提交补丁期望被接受进内核的
 时候，它的技术价值以及其他方面都将被评审。那么你可能会得到什么呢？
+
   - 批评
   - 评论
   - 要求修改
@@ -396,6 +420,7 @@ Documentation/process/submitting-patches.rst文档中所述）。内核开发者
 没在茫茫信海中。
 
 你不应该做的事情：
+
   - 期望自己的补丁不受任何质疑就直接被接受
   - 翻脸
   - 忽略别人的评论
@@ -415,7 +440,8 @@ Documentation/process/submitting-patches.rst文档中所述）。内核开发者
 
 内核社区的工作模式同大多数传统公司开发队伍的工作模式并不相同。下面这些例
 子，可以帮助你避免某些可能发生问题：
-  用这些话介绍你的修改提案会有好处：
+用这些话介绍你的修改提案会有好处：
+
     - 它同时解决了多个问题
     - 它删除了2000行代码
     - 这是补丁，它已经解释了我想要说明的
@@ -423,7 +449,8 @@ Documentation/process/submitting-patches.rst文档中所述）。内核开发者
     - 这是一系列小补丁用来……
     - 这个修改提高了普通机器的性能……
 
-  应该避免如下的说法：
+应该避免如下的说法：
+
     - 我们在AIX/ptx/Solaris就是这么做的，所以这么做肯定是好的……
     - 我做这行已经20年了，所以……
     - 为了我们公司赚钱考虑必须这么做
@@ -496,6 +523,7 @@ Linux内核社区并不喜欢一下接收大段的代码。修改需要被恰当
 当你发送补丁的时候，需要特别留意邮件正文的内容。因为这里的信息将会做为补
 丁的修改记录(ChangeLog)，会被一直保留以备大家查阅。它需要完全地描述补丁，
 包括：
+
   - 为什么需要这个修改
   - 补丁的总体设计
   - 实现细节
-- 
2.19.1.856.g8858448bb

