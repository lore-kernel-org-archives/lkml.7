Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0C0C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E612220883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfDHJTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:19:02 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:59363 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725881AbfDHJTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 05:19:01 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TOo5DJX_1554715138;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TOo5DJX_1554715138)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 08 Apr 2019 17:18:58 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Harry Wei <harryxiyou@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs/zh_CN: correct a word in managment-style.
Date:   Mon,  8 Apr 2019 17:18:27 +0800
Message-Id: <20190408091827.124239-1-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.856.g8858448bb
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"made up" used here means 'fictional' instead of 'consist of'.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Harry Wei <harryxiyou@gmail.com> 
Cc: Jonathan Corbet <corbet@lwn.net> 
Cc: linux-doc@vger.kernel.org 
Cc: linux-kernel@vger.kernel.org 
---
 Documentation/translations/zh_CN/process/management-style.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/zh_CN/process/management-style.rst b/Documentation/translations/zh_CN/process/management-style.rst
index 63f9a73ff19c..a181fa56d19e 100644
--- a/Documentation/translations/zh_CN/process/management-style.rst
+++ b/Documentation/translations/zh_CN/process/management-style.rst
@@ -8,7 +8,7 @@
 Linux内核管理风格
 =================
 
-这是一个简短的文档，描述了Linux内核的首选（或组成，取决于您问谁）管理风格。
+这是一个简短的文档，描述了Linux内核首选的（或胡编的，取决于您问谁）管理风格。
 它的目的是在某种程度上参照 :ref:`process/coding-style.rst <codingstyle>`
 主要是为了避免反复回答 [#cnf1]_ 相同（或类似）的问题。
 
-- 
2.19.1.856.g8858448bb

