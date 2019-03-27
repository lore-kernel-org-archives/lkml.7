Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF76C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86DFB206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732157AbfC0NEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:04:22 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:53253 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730393AbfC0NCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:02:36 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04428;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TNmZ5y5_1553691753;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TNmZ5y5_1553691753)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 27 Mar 2019 21:02:34 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     alex.shi@linux.alibaba.com, harryxiyou@gmail.com, corbet@lwn.net,
        leoyang.li@nxp.com, linux-doc@vger.kernel.org
Cc:     Tom Levy <tomlevy93@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 41/42] docs/zh_CN: redirect submit-checklist
Date:   Wed, 27 Mar 2019 21:01:47 +0800
Message-Id: <20190327130148.3258-42-alex.shi@linux.alibaba.com>
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

Now we has the Chinese version submit-checklist, so redirect it in
Chinese docs.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Harry Wei <harryxiyou@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Tom Levy <tomlevy93@gmail.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 Documentation/translations/zh_CN/process/5.Posting.rst          | 2 +-
 Documentation/translations/zh_CN/process/submitting-patches.rst | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/translations/zh_CN/process/5.Posting.rst b/Documentation/translations/zh_CN/process/5.Posting.rst
index 66b33fe58f3d..a8a6a7dacd7f 100644
--- a/Documentation/translations/zh_CN/process/5.Posting.rst
+++ b/Documentation/translations/zh_CN/process/5.Posting.rst
@@ -14,7 +14,7 @@
 也可在以下文件中找到
 :ref:`Documentation/translations/zh_CN/process/submitting-patches.rst <cn_submittingpatches>`,
 :ref:`Documentation/process/submitting-drivers.rst  <submittingdrivers>`
-和 :ref:`Documentation/process/submit-checklist.rst <submitchecklist>`.
+和 :ref:`Documentation/translations/zh_CN/process/submit-checklist.rst <cn_submitchecklist>`.
 
 何时邮寄
 --------
diff --git a/Documentation/translations/zh_CN/process/submitting-patches.rst b/Documentation/translations/zh_CN/process/submitting-patches.rst
index f6e609b242e7..93239649fb71 100644
--- a/Documentation/translations/zh_CN/process/submitting-patches.rst
+++ b/Documentation/translations/zh_CN/process/submitting-patches.rst
@@ -22,7 +22,7 @@
 
 以下文档含有大量简洁的建议， 具体请见：
 :ref:`Documentation/process <development_process_main>`
-同样，:ref:`Documentation/process/submit-checklist.rst <submitchecklist>`
+同样，:ref:`Documentation/translations/zh_CN/process/submit-checklist.rst <cn_submitchecklist>`
 给出在提交代码前需要检查的项目的列表。如果你在提交一个驱动程序，那么
 同时阅读一下:
 :ref:`Documentation/process/submitting-drivers.rst <submittingdrivers>`
-- 
2.19.1.856.g8858448bb

