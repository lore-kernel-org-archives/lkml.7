Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E10DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C652206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730835AbfC0NCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:02:47 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:46750 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730516AbfC0NCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:02:45 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04428;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TNmt4c2_1553691754;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TNmt4c2_1553691754)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 27 Mar 2019 21:02:34 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     alex.shi@linux.alibaba.com, harryxiyou@gmail.com, corbet@lwn.net,
        leoyang.li@nxp.com, linux-doc@vger.kernel.org
Cc:     Tom Levy <tomlevy93@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 42/42] docs/zh_CN: update co-developed-by info after English version
Date:   Wed, 27 Mar 2019 21:01:48 +0800
Message-Id: <20190327130148.3258-43-alex.shi@linux.alibaba.com>
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

commit 24a2bb90741b ("docs: Clarify the usage and sign-off requirements for Co-developed-by")
give more info of co-developed-by tag usage. update Chinese docs to
follow it.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Harry Wei <harryxiyou@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Tom Levy <tomlevy93@gmail.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 .../translations/zh_CN/process/5.Posting.rst  |  7 ++--
 .../zh_CN/process/submitting-patches.rst      | 35 +++++++++++++++++--
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/Documentation/translations/zh_CN/process/5.Posting.rst b/Documentation/translations/zh_CN/process/5.Posting.rst
index a8a6a7dacd7f..b3a5a352d4d6 100644
--- a/Documentation/translations/zh_CN/process/5.Posting.rst
+++ b/Documentation/translations/zh_CN/process/5.Posting.rst
@@ -159,8 +159,11 @@ bug搜寻人员想知道补丁是否负责他们正在追查的问题，想知
    :ref:`Documentation/translations/zh_CN/process/submitting-patches.rst <cn_submittingpatches>`
    中找到，如果没有适当的签字，则不能合并到主线中。
 
- - Co-developed-by: 声明补丁也是由另一个开发人员和原始作者一起创建的。当多
-   个人在一个补丁上工作时，这很有用。注意，此人也需要在补丁中有一个签名行。
+ - Co-developed-by: 声明补丁是由多个开发人员共同创建的；当几个人在一个补丁上
+   工作时，它用于将属性赋予共同作者（除了 From: 所赋予的作者之外）。因为
+   Co-developed-by: 表示作者身份，所以每个共同开发人, 必须紧跟在相关合作作者
+   的签名之后。具体内容和示例可以在以下文件中找到
+   :ref:`Documentation/translations/zh_CN/process/submitting-patches.rst <cn_submittingpatches>`
 
  - Acked-by: 表示另一个开发人员（通常是相关代码的维护人员）同意补丁适合包含
    在内核中。
diff --git a/Documentation/translations/zh_CN/process/submitting-patches.rst b/Documentation/translations/zh_CN/process/submitting-patches.rst
index 93239649fb71..850c295a07a0 100644
--- a/Documentation/translations/zh_CN/process/submitting-patches.rst
+++ b/Documentation/translations/zh_CN/process/submitting-patches.rst
@@ -427,8 +427,37 @@ Acked-by：不一定表示对整个补丁的确认。例如，如果一个补丁
 这是唯一一个标签，它可以在没有被它命名的人显式操作的情况下添加，但它应该表明
 这个人是在补丁上抄送的。讨论中包含了潜在利益相关方。
 
-Co-developed-by: 声明补丁也是由另一个开发人员和原始作者一起创建的。当多个人
-在一个补丁上工作时，这很有用。注意，此人也需要在补丁中有一个 Signed-off-by:
+Co-developed-by: 声明补丁是由多个开发人员共同创建的；当几个人在一个补丁上工
+作时，它用于将属性赋予共同作者（除了 From: 所赋予的作者之外）。因为
+Co-developed-by: 表示作者身份，所以每个共同开发人：必须紧跟在相关合作作者的
+签名之后。标准的签核程序要求：标记的签核顺序应尽可能反映补丁的时间历史，而不
+管作者是通过 From ：还是由 Co-developed-by: 共同开发的。值得注意的是，最后一
+个签字人：必须始终是提交补丁的开发人员。
+
+注意，当作者也是电子邮件标题“发件人：”行中列出的人时，“From: ” 标记是可选的。
+
+作者提交的补丁程序示例::
+
+	<changelog>
+
+	Co-developed-by: First Co-Author <first@coauthor.example.org>
+	Signed-off-by: First Co-Author <first@coauthor.example.org>
+	Co-developed-by: Second Co-Author <second@coauthor.example.org>
+	Signed-off-by: Second Co-Author <second@coauthor.example.org>
+	Signed-off-by: From Author <from@author.example.org>
+
+合作开发者提交的补丁示例::
+
+	From: From Author <from@author.example.org>
+
+	<changelog>
+
+	Co-developed-by: Random Co-Author <random@coauthor.example.org>
+	Signed-off-by: Random Co-Author <random@coauthor.example.org>
+	Signed-off-by: From Author <from@author.example.org>
+	Co-developed-by: Submitting Co-Author <sub@coauthor.example.org>
+	Signed-off-by: Submitting Co-Author <sub@coauthor.example.org>
+
 
 13）使用报告人：、测试人：、审核人：、建议人：、修复人：
 --------------------------------------------------------
@@ -538,7 +567,7 @@ e-mail 标题中的“一句话概述”扼要的描述 e-mail 中的补丁。
     Subject: [PATCHv2 001/207] x86: fix eflags tracking
 
 "From" 行是信体里的最上面一行，具有如下格式：
-        From: Original Author <author@example.com>
+        From: Patch Author <author@example.com>
 
 "From" 行指明在永久改动日志里，谁会被确认为作者。如果没有 "From" 行，那
 么邮件头里的 "From: " 行会被用来决定改动日志中的作者。
-- 
2.19.1.856.g8858448bb

