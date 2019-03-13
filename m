Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07547C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 13:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3CAE2177E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 13:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfCMNup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 09:50:45 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:51378 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726791AbfCMNug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 09:50:36 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TMdXUvO_1552485032;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TMdXUvO_1552485032)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 13 Mar 2019 21:50:32 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     corbet@lwn.net, harryxiyou@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Zhang Wei <wezhang@outlook.com>, Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v5 23/31] docs/zh_CN: update Zhang Wei's email address
Date:   Wed, 13 Mar 2019 21:49:53 +0800
Message-Id: <20190313135001.260905-24-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.856.g8858448bb
In-Reply-To: <20190313135001.260905-1-alex.shi@linux.alibaba.com>
References: <20190313135001.260905-1-alex.shi@linux.alibaba.com>
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
Signed-off-by: Weiwei Jia <harryxiyou@gmail.com>
---
 Documentation/translations/zh_CN/process/submitting-drivers.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/zh_CN/process/submitting-drivers.rst b/Documentation/translations/zh_CN/process/submitting-drivers.rst
index fade72515b04..43c0e4530362 100644
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

