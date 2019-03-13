Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99753C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 13:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D45F2183F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 13:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfCMNvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 09:51:10 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:45604 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727002AbfCMNum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 09:50:42 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04428;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TMdXUvz_1552485035;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TMdXUvz_1552485035)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 13 Mar 2019 21:50:35 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     corbet@lwn.net, harryxiyou@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v5 28/31] docs/zh_CN: remove zh-kernel.org in MAINTAINERS
Date:   Wed, 13 Mar 2019 21:49:58 +0800
Message-Id: <20190313135001.260905-29-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.856.g8858448bb
In-Reply-To: <20190313135001.260905-1-alex.shi@linux.alibaba.com>
References: <20190313135001.260905-1-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This web site is on sale, and Li Yang said it won't be in service again.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Li Yang <leoyang.li@nxp.com>
Signed-off-by: Weiwei Jia <harryxiyou@gmail.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4f004dc0a0f2..4d9132d19567 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3727,7 +3727,6 @@ F:	scripts/checkpatch.pl
 CHINESE DOCUMENTATION
 M:	Harry Wei <harryxiyou@gmail.com>
 L:	xiyoulinuxkernelgroup@googlegroups.com (subscribers-only)
-L:	linux-kernel@zh-kernel.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/translations/zh_CN/
 
-- 
2.19.1.856.g8858448bb

