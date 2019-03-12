Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D585C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 03:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5629C2148D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 03:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfCLDCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 23:02:54 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:36888 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727191AbfCLDCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 23:02:51 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04392;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TMWN-gD_1552359735;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TMWN-gD_1552359735)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 12 Mar 2019 11:02:15 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     corbet@lwn.net, harryxiyou@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Li Yang <leoyang.li@nxp.com>, TripleX Chung <xxx.phy@gmail.com>
Subject: [PATCH v4 28/31] docs/zh_CN: fix indent issue in submitting-drivers
Date:   Tue, 12 Mar 2019 11:01:26 +0800
Message-Id: <20190312030129.47511-29-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.856.g8858448bb
In-Reply-To: <20190312030129.47511-1-alex.shi@linux.alibaba.com>
References: <20190312030129.47511-1-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tame 'make htmldocs' w/o indent complains.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Harry Wei <harryxiyou@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Li Yang <leoyang.li@nxp.com>
Cc: TripleX Chung <xxx.phy@gmail.com>
---
 .../translations/zh_CN/process/submitting-drivers.rst         | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/translations/zh_CN/process/submitting-drivers.rst b/Documentation/translations/zh_CN/process/submitting-drivers.rst
index 43c0e4530362..3be51d998c80 100644
--- a/Documentation/translations/zh_CN/process/submitting-drivers.rst
+++ b/Documentation/translations/zh_CN/process/submitting-drivers.rst
@@ -137,9 +137,13 @@ Linux 设备驱动程序，第三版（探讨 2.6.10 版内核）：
 
 LWN.net:
 	每周内核开发活动摘要 - http://lwn.net/
+
 	2.6 版中 API 的变更：
+
 		http://lwn.net/Articles/2.6-kernel-api/
+
 	将旧版内核的驱动程序移植到 2.6 版：
+
 		http://lwn.net/Articles/driver-porting/
 
 内核新手(KernelNewbies):
-- 
2.19.1.856.g8858448bb

