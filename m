Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1DFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD6E21734
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732222AbfC0NEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:04:50 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:60453 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730145AbfC0NCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:02:35 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04396;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TNmcUpz_1553691750;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TNmcUpz_1553691750)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 27 Mar 2019 21:02:30 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     alex.shi@linux.alibaba.com, harryxiyou@gmail.com, corbet@lwn.net,
        leoyang.li@nxp.com, linux-doc@vger.kernel.org
Cc:     Federico Vaga <federico.vaga@vaga.pv.it>,
        SeongJae Park <sj38.park@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 33/42] docs/zh_CN: fix link issue in howto.rst
Date:   Wed, 27 Mar 2019 21:01:39 +0800
Message-Id: <20190327130148.3258-34-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.856.g8858448bb
In-Reply-To: <20190327130148.3258-1-alex.shi@linux.alibaba.com>
References: <20190327130148.3258-1-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now we could follow links in created html files.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Harry Wei <harryxiyou@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Federico Vaga <federico.vaga@vaga.pv.it>
Cc: SeongJae Park <sj38.park@gmail.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 .../translations/zh_CN/process/howto.rst      | 48 ++++++++++---------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/Documentation/translations/zh_CN/process/howto.rst b/Documentation/translations/zh_CN/process/howto.rst
index 6ab167812325..246f76a97eaf 100644
--- a/Documentation/translations/zh_CN/process/howto.rst
+++ b/Documentation/translations/zh_CN/process/howto.rst
@@ -81,20 +81,21 @@ Linux内核代码中包含有大量的文档。这些文档对于学习如何与
 的维护者解释这些变化。
 
 以下是内核代码中需要阅读的文档：
-  README
+  :ref:`Documentation/admin-guide/README.rst <readme>`
     文件简要介绍了Linux内核的背景，并且描述了如何配置和编译内核。内核的
     新用户应该从这里开始。
 
-  Documentation/process/changes.rst
+
+  :ref:`Documentation/process/changes.rst <changes>`
     文件给出了用来编译和使用内核所需要的最小软件包列表。
 
-  Documentation/process/coding-style.rst
+  :ref:`Documentation/process/coding-style.rst <codingstyle>`
     描述Linux内核的代码风格和理由。所有新代码需要遵守这篇文档中定义的规
     范。大多数维护者只会接收符合规定的补丁，很多人也只会帮忙检查符合风格
     的代码。
 
-  Documentation/process/submitting-patches.rst
-  Documentation/process/submitting-drivers.rst
+  :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
+  :ref:`Documentation/process/submitting-drivers.rst <submittingdrivers>`
 
     这两份文档明确描述如何创建和发送补丁，其中包括（但不仅限于)：
        - 邮件内容
@@ -113,7 +114,7 @@ Linux内核代码中包含有大量的文档。这些文档对于学习如何与
 
         http://linux.yyz.us/patch-format.html
 
-  Documentation/process/stable-api-nonsense.rst
+  :ref:`Documentation/process/stable-api-nonsense.rst <stable_api_nonsense>`
     论证内核为什么特意不包括稳定的内核内部API，也就是说不包括像这样的特
     性：
 
@@ -124,29 +125,29 @@ Linux内核代码中包含有大量的文档。这些文档对于学习如何与
     这篇文档对于理解Linux的开发哲学至关重要。对于将开发平台从其他操作系
     统转移到Linux的人来说也很重要。
 
-  Documentation/admin-guide/security-bugs.rst
+  :ref:`Documentation/admin-guide/security-bugs.rst <securitybugs>`
     如果你认为自己发现了Linux内核的安全性问题，请根据这篇文档中的步骤来
     提醒其他内核开发者并帮助解决这个问题。
 
-  Documentation/process/management-style.rst
+  :ref:`Documentation/process/management-style.rst <managementstyle>`
     描述内核维护者的工作方法及其共有特点。这对于刚刚接触内核开发（或者对
     它感到好奇）的人来说很重要，因为它解释了很多对于内核维护者独特行为的
     普遍误解与迷惑。
 
-  Documentation/process/stable-kernel-rules.rst
+  :ref:`Documentation/process/stable-kernel-rules.rst <stable_kernel_rules>`
     解释了稳定版内核发布的规则，以及如何将改动放入这些版本的步骤。
 
-  Documentation/process/kernel-docs.rst
+  :ref:`Documentation/process/kernel-docs.rst <kernel_docs>`
     有助于内核开发的外部文档列表。如果你在内核自带的文档中没有找到你想找
     的内容，可以查看这些文档。
 
-  Documentation/process/applying-patches.rst
+  :ref:`Documentation/process/applying-patches.rst <applying_patches>`
     关于补丁是什么以及如何将它打在不同内核开发分支上的好介绍
 
 内核还拥有大量从代码自动生成的文档。它包含内核内部API的全面介绍以及如何
 妥善处理加锁的规则。生成的文档会放在 Documentation/DocBook/目录下。在内
 核源码的主目录中使用以下不同命令将会分别生成PDF、Postscript、HTML和手册
-页等不同格式的文档：
+页等不同格式的文档::
 
     make pdfdocs
     make htmldocs
@@ -212,8 +213,8 @@ kernel.org网站的pub/linux/kernel/v2.6/目录下找到它。它的开发遵循
   - 每当一个新版本的内核被发布，为期两周的集成窗口将被打开。在这段时间里
     维护者可以向Linus提交大段的修改，通常这些修改已经被放到-mm内核中几个
     星期了。提交大量修改的首选方式是使用git工具（内核的代码版本管理工具
-    ，更多的信息可以在http://git-scm.com/获取），不过使用普通补丁也是可以
-    的。
+    ，更多的信息可以在 http://git-scm.com/ 获取），不过使用普通补丁也是
+    可以的。
   - 两个星期以后-rc1版本内核发布。之后只有不包含可能影响整个内核稳定性的
     新功能的补丁才可能被接受。请注意一个全新的驱动程序（或者文件系统）有
     可能在-rc1后被接受是因为这样的修改完全独立，不会影响其他的代码，所以
@@ -243,8 +244,8 @@ kernel.org网站的pub/linux/kernel/v2.6/目录下找到它。它的开发遵循
 2.6.x.y版本由“稳定版”小组（邮件地址<stable@vger.kernel.org>）维护，一般隔周发
 布新版本。
 
-内核源码中的Documentation/process/stable-kernel-rules.rst文件具体描述了可被稳定
-版内核接受的修改类型以及发布的流程。
+内核源码中的 :ref:`Documentation/process/stable-kernel-rules.rst <stable_kernel_rules>`
+文件具体描述了可被稳定版内核接受的修改类型以及发布的流程。
 
 
 2.6.x -mm补丁集
@@ -316,7 +317,7 @@ linux-kernel邮件列表中提供反馈，告诉大家你遇到了问题还是
     - x86-64, 部分i386, Andi Kleen <ak@suse.de>
 	ftp.firstfloor.org:/pub/ak/x86_64/quilt/
 
-  其他内核源码树可以在http://git.kernel.org的列表中和MAINTAINERS文件里
+  其他内核源码树可以在 http://git.kernel.org 的列表中和MAINTAINERS文件里
   找到。
 
 报告bug
@@ -339,7 +340,7 @@ bugzilla.kernel.org是Linux内核开发者们用来跟踪内核Bug的网站。
 者感受到你的存在。修改bug是赢得其他开发者赞誉的最好办法，因为并不是很多
 人都喜欢浪费时间去修改别人报告的bug。
 
-要尝试修改已知的bug，请访问http://bugzilla.kernel.org网址。如果你想获得
+要尝试修改已知的bug，请访问 http://bugzilla.kernel.org 网址。如果你想获得
 最新bug的通知，可以订阅bugme-new邮件列表（只有新的bug报告会被寄到这里）
 或者订阅bugme-janitor邮件列表（所有bugzilla的变动都会被寄到这里）。
 
@@ -384,11 +385,12 @@ MAINTAINERS文件中可以找到不同话题对应的邮件列表。
 这几行。将你的评论加在被引用的段落之间而不要放在邮件的顶部。
 
 如果你在邮件中附带补丁，请确认它们是可以直接阅读的纯文本（如
-Documentation/process/submitting-patches.rst文档中所述）。内核开发者们不希望遇到附件
-或者被压缩了的补丁。只有这样才能保证他们可以直接评论你的每行代码。请确保
-你使用的邮件发送程序不会修改空格和制表符。一个防范性的测试方法是先将邮件
-发送给自己，然后自己尝试是否可以顺利地打上收到的补丁。如果测试不成功，请
-调整或者更换你的邮件发送程序直到它正确工作为止。
+:ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
+文档中所述）。内核开发者们不希望遇到附件或者被压缩了的补丁。只有这样才能
+保证他们可以直接评论你的每行代码。请确保你使用的邮件发送程序不会修改空格
+和制表符。一个防范性的测试方法是先将邮件发送给自己，然后自己尝试是否可以
+顺利地打上收到的补丁。如果测试不成功，请调整或者更换你的邮件发送程序直到
+它正确工作为止。
 
 总而言之，请尊重其他的邮件列表订阅者。
 
-- 
2.19.1.856.g8858448bb

