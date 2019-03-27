Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF8AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6072A206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbfC0NCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:02:19 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:1830 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725829AbfC0NCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:02:19 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04452;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TNmcUmY_1553691736;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TNmcUmY_1553691736)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 27 Mar 2019 21:02:16 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     alex.shi@linux.alibaba.com, harryxiyou@gmail.com, corbet@lwn.net,
        leoyang.li@nxp.com, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 01/42] docs/zh_CN: translate development-process into Chinese
Date:   Wed, 27 Mar 2019 21:01:07 +0800
Message-Id: <20190327130148.3258-2-alex.shi@linux.alibaba.com>
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

Start development process translation.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Harry Wei <harryxiyou@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 .../zh_CN/process/development-process.rst     | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/process/development-process.rst

diff --git a/Documentation/translations/zh_CN/process/development-process.rst b/Documentation/translations/zh_CN/process/development-process.rst
new file mode 100644
index 000000000000..500ca5056f60
--- /dev/null
+++ b/Documentation/translations/zh_CN/process/development-process.rst
@@ -0,0 +1,21 @@
+.. _cn_development_process_main:
+
+内核开发过程指南
+================
+
+内容:
+
+.. toctree::
+   :numbered:
+   :maxdepth: 2
+
+   1.Intro
+   2.Process
+   3.Early-stage
+   4.Coding
+   5.Posting
+   6.Followthrough
+   7.AdvancedTopics
+   8.Conclusion
+
+本文档的目的是帮助开发人员（及其经理）以最小的挫折感与开发社区合作。它试图记录这个社区如何以一种不熟悉Linux内核开发（或者实际上是自由软件开发）的人可以访问的方式工作。虽然这里有一些技术资料，但这是一个面向过程的讨论，不需要深入了解内核编程就可以理解。
-- 
2.19.1.856.g8858448bb

