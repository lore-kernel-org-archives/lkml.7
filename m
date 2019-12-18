Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B79C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 11:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5A812072B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 11:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfLRL7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 06:59:39 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:40479 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726141AbfLRL7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 06:59:38 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TlHJONf_1576670373;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TlHJONf_1576670373)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 18 Dec 2019 19:59:33 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Harry Wei <harryxiyou@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] docs/zh_CN: add translator info and link to index
Date:   Wed, 18 Dec 2019 19:59:27 +0800
Message-Id: <1576670367-153661-2-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670367-153661-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1576670367-153661-1-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now people could find it via html docs.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Harry Wei <harryxiyou@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 Documentation/translations/zh_CN/process/index.rst                   | 1 +
 .../translations/zh_CN/process/kernel-enforcement-statement.rst      | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/translations/zh_CN/process/index.rst b/Documentation/translations/zh_CN/process/index.rst
index 47a2af54fb13..8051a7b322c5 100644
--- a/Documentation/translations/zh_CN/process/index.rst
+++ b/Documentation/translations/zh_CN/process/index.rst
@@ -31,6 +31,7 @@
    development-process
    email-clients
    license-rules
+   kernel-enforcement-statement
    kernel-driver-statement
 
 其它大多数开发人员感兴趣的社区指南：
diff --git a/Documentation/translations/zh_CN/process/kernel-enforcement-statement.rst b/Documentation/translations/zh_CN/process/kernel-enforcement-statement.rst
index 4c71229bf2d8..75f7b7b9137c 100644
--- a/Documentation/translations/zh_CN/process/kernel-enforcement-statement.rst
+++ b/Documentation/translations/zh_CN/process/kernel-enforcement-statement.rst
@@ -1,5 +1,10 @@
 ﻿.. _cn_process_statement_kernel:
 
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: :ref:`Documentation/process/kernel-enforcement-statement.rst <process_statement_kernel>`
+:Translator: Alex Shi <alex.shi@linux.alibaba.com>
+
 Linux 内核执行声明
 ------------------
 
-- 
1.8.3.1

