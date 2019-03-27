Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB8BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E6D1206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732529AbfC0NFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:05:22 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:40469 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729860AbfC0NC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:02:29 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04392;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TNmpMXf_1553691743;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TNmpMXf_1553691743)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 27 Mar 2019 21:02:24 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     alex.shi@linux.alibaba.com, harryxiyou@gmail.com, corbet@lwn.net,
        leoyang.li@nxp.com, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 18/42] docs/zh_CN: add 8.Conclusion.rst in development-process
Date:   Wed, 27 Mar 2019 21:01:24 +0800
Message-Id: <20190327130148.3258-19-alex.shi@linux.alibaba.com>
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

Now, the full developmen-process doc appears in 'make htmldocs' in
Chinese.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Harry Wei <harryxiyou@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 .../zh_CN/process/8.Conclusion.rst            | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/process/8.Conclusion.rst

diff --git a/Documentation/translations/zh_CN/process/8.Conclusion.rst b/Documentation/translations/zh_CN/process/8.Conclusion.rst
new file mode 100644
index 000000000000..9f8791c5784f
--- /dev/null
+++ b/Documentation/translations/zh_CN/process/8.Conclusion.rst
@@ -0,0 +1,58 @@
+.. _cn_development_conclusion:
+
+更多信息
+========
+
+关于Linux内核开发和相关主题的信息来源很多。首先是在内核源代码分发中找到的
+文档目录。顶级:ref:`process/howto.rst <process_howto>` 文件是一个重要的起点
+:ref:`process/submitting-patches.rst <submittingpatches>` 和
+:ref:`process/submitting-drivers.rst <submittingdrivers>` 也是所有内核开发
+人员都应该阅读的内容。许多内部内核API都是使用kerneldoc机制记录的；
+“make htmldocs”或“make pdfdocs”可用于以HTML或PDF格式生成这些文档（尽管某些
+发行版提供的tex版本会遇到内部限制，无法正确处理文档）。
+
+不同的网站在各个细节层次上讨论内核开发。您的作者想谦虚地建议用http://lwn.net/
+作为来源；有关许多特定内核主题的信息可以通过以下网址的lwn内核索引找到：
+
+        http://lwn.net/kernel/index/
+
+除此之外，内核开发人员的一个宝贵资源是：
+
+        http://kernelnewbies.org/
+
+当然，我们不应该忘记 http://kernel.org/ 这是内核发布信息的最终位置。
+
+关于内核开发有很多书：
+
+        Linux设备驱动程序，第三版（Jonathan Corbet、Alessandro Rubini和Greg Kroah Hartman）。
+        在线：http://lwn.net/kernel/ldd3/
+
+        Linux内核开发（Robert Love）。
+
+        了解Linux内核（Daniel Bovet和Marco Cesati）。
+
+然而，所有这些书都有一个共同的缺点：当它们上架时，它们往往有些过时，而且它们
+已经上架一段时间了。不过，在那里还可以找到相当多的好信息。
+
+有关git的文档，请访问：
+
+        http://www.kernel.org/pub/software/scm/git/docs/
+
+        http://www.kernel.org/pub/software/scm/git/docs/user-manual.html
+
+结论
+====
+
+祝贺所有通过这篇冗长的文件的人。希望它能够帮助您理解Linux内核是如何开发的，
+以及您如何参与这个过程。
+
+最后，重要的是参与。任何开源软件项目都不超过其贡献者投入其中的总和。Linux内核
+的发展速度和以前一样快，因为它得到了大量开发人员的帮助，他们都在努力使它变得
+更好。内核是一个主要的例子，说明当成千上万的人为了一个共同的目标一起工作时，
+可以做些什么。
+
+不过，内核总是可以从更大的开发人员基础中获益。总有更多的工作要做。但是，同样
+重要的是，Linux生态系统中的大多数其他参与者可以通过为内核做出贡献而受益。使
+代码进入主线是提高代码质量、降低维护和分发成本、提高对内核开发方向的影响程度
+等的关键。这是一种人人都赢的局面。踢开你的编辑，来加入我们吧，你会非常受
+欢迎的。
-- 
2.19.1.856.g8858448bb

