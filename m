Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95027C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 750B52072B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfLRJ4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 04:56:43 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:59431 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725799AbfLRJ4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 04:56:43 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TlGTrIG_1576662982;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TlGTrIG_1576662982)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 18 Dec 2019 17:56:22 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Harry Wei <harryxiyou@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] docs/zh_CN: add translator info and link to Chinese process index
Date:   Wed, 18 Dec 2019 17:56:20 +0800
Message-Id: <1576662980-103843-2-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576662980-103843-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1576662980-103843-1-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make it could be found in htmldocs.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Harry Wei <harryxiyou@gmail.com> 
Cc: Jonathan Corbet <corbet@lwn.net> 
Cc: linux-doc@vger.kernel.org 
Cc: linux-kernel@vger.kernel.org 
---
 Documentation/translations/zh_CN/process/index.rst                   | 1 +
 Documentation/translations/zh_CN/process/kernel-driver-statement.rst | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/translations/zh_CN/process/index.rst b/Documentation/translations/zh_CN/process/index.rst
index f7a84eff6e93..47a2af54fb13 100644
--- a/Documentation/translations/zh_CN/process/index.rst
+++ b/Documentation/translations/zh_CN/process/index.rst
@@ -31,6 +31,7 @@
    development-process
    email-clients
    license-rules
+   kernel-driver-statement
 
 其它大多数开发人员感兴趣的社区指南：
 
diff --git a/Documentation/translations/zh_CN/process/kernel-driver-statement.rst b/Documentation/translations/zh_CN/process/kernel-driver-statement.rst
index eb029ed79ef7..2b3375bcccfd 100644
--- a/Documentation/translations/zh_CN/process/kernel-driver-statement.rst
+++ b/Documentation/translations/zh_CN/process/kernel-driver-statement.rst
@@ -1,5 +1,10 @@
 .. _cn_process_statement_driver:
 
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: :ref:`Documentation/process/kernel-driver-statement.rst <process_statement_driver>`
+:Translator: Alex Shi <alex.shi@linux.alibaba.com>
+
 内核驱动声明
 ------------
 
-- 
1.8.3.1

