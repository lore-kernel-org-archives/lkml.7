Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DABDC10F12
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 02:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594112070D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 02:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfDPC0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 22:26:12 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:48807 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725308AbfDPC0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 22:26:12 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TPQZvMe_1555381569;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TPQZvMe_1555381569)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 16 Apr 2019 10:26:09 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     kernel-doc@vger.kernel.org
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Harry Wei <harryxiyou@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH 2/2] docs/zh_CN: fix typos in 1.Intro.rst file
Date:   Tue, 16 Apr 2019 10:25:49 +0800
Message-Id: <20190416022549.186820-2-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.856.g8858448bb
In-Reply-To: <20190416022549.186820-1-alex.shi@linux.alibaba.com>
References: <20190416022549.186820-1-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed uncapital issues, thanks for Jonathan Neuschäfer, I am insensitive
on captial custom as a non-captial native language reader. Sorry.

Also fix a typo. And replace more colloquial words in Chinese.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Harry Wei <harryxiyou@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 Documentation/translations/zh_CN/process/1.Intro.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/translations/zh_CN/process/1.Intro.rst b/Documentation/translations/zh_CN/process/1.Intro.rst
index 03bbafc00bd2..10a15f3dc282 100644
--- a/Documentation/translations/zh_CN/process/1.Intro.rst
+++ b/Documentation/translations/zh_CN/process/1.Intro.rst
@@ -79,13 +79,13 @@ Linux最引人注目的特性之一是这些开发人员可以访问它；任何
 致谢
 ----
 
-本文件由jonathan corbet撰写，corbet@lwn.net。以下人员的建议使之更为完善：
+本文件由Jonathan Corbet撰写，corbet@lwn.net。以下人员的建议使之更为完善：
 Johannes Berg, James Berry, Alex Chiang, Roland Dreier, Randy Dunlap,
 Jake Edge, Jiri Kosina, Matt Mackall, Arthur Marsh, Amanda McPherson,
 Andrew Morton, Andrew Price, Tsugikazu Shibata, 和 Jochen Voß.
 
-这项工作得到了Linux基金会的支持，特别感谢Amanda McPherson，他看到了这香工作
-的价值并使之发生。
+这项工作得到了Linux基金会的支持，特别感谢Amanda McPherson，他看到了这项工作
+的价值并把它变成现实。
 
 代码进入主线的重要性
 --------------------
-- 
2.19.1.856.g8858448bb

