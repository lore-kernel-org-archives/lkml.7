Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69962C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 07:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 374622082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 07:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfCEHK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 02:10:29 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:41865 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725782AbfCEHK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 02:10:28 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04389;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TM.oBq1_1551769821;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TM.oBq1_1551769821)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 05 Mar 2019 15:10:21 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     Harry Wei <harryxiyou@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Cc:     linux-kernel@vger.kernel.org,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Zhang Wei <wezhang@outlook.com>, Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v2 28/28] docs/zh_CN: update Zhang Wei's email address
Date:   Tue,  5 Mar 2019 15:10:15 +0800
Message-Id: <20190305071015.164475-1-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.856.g8858448bb
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

to replace the obsolete email address with new one.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Zhang Wei <wezhang@outlook.com>
Cc: Li Yang <leoyang.li@nxp.com>
---
 Documentation/translations/zh_CN/process/submitting-drivers.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/zh_CN/process/submitting-drivers.rst b/Documentation/translations/zh_CN/process/submitting-drivers.rst
index d29032007112..3be51d998c80 100644
--- a/Documentation/translations/zh_CN/process/submitting-drivers.rst
+++ b/Documentation/translations/zh_CN/process/submitting-drivers.rst
@@ -13,7 +13,7 @@
         中文版翻译者： 李阳  Li Yang <leoyang.li@nxp.com>
         中文版校译者： 陈琦 Maggie Chen <chenqi@beyondsoft.com>
                        王聪 Wang Cong <xiyou.wangcong@gmail.com>
-                       张巍 Zhang Wei <Wei.Zhang@freescale.com>
+                       张巍 Zhang Wei <wezhang@outlook.com>
 
 如何向 Linux 内核提交驱动程序
 =============================
-- 
2.19.1.856.g8858448bb

