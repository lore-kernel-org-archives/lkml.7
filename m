Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0251BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 13:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD9D82184C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 13:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfCMNvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 09:51:15 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:52935 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727018AbfCMNum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 09:50:42 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04389;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TMdXUw1_1552485036;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TMdXUw1_1552485036)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 13 Mar 2019 21:50:36 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     corbet@lwn.net, harryxiyou@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v5 29/31] mailmap: update my obsolete email address
Date:   Wed, 13 Mar 2019 21:49:59 +0800
Message-Id: <20190313135001.260905-30-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.856.g8858448bb
In-Reply-To: <20190313135001.260905-1-alex.shi@linux.alibaba.com>
References: <20190313135001.260905-1-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am not working for Intel or Linaro, so udpate the email address.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Li Yang <leoyang.li@nxp.com>
Signed-off-by: Weiwei Jia <harryxiyou@gmail.com>
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index e5979518c396..7dc884c03d13 100644
--- a/.mailmap
+++ b/.mailmap
@@ -16,6 +16,8 @@ Alan Cox <alan@lxorguk.ukuu.org.uk>
 Alan Cox <root@hraefn.swansea.linux.org.uk>
 Aleksey Gorelov <aleksey_gorelov@phoenix.com>
 Aleksandar Markovic <aleksandar.markovic@mips.com> <aleksandar.markovic@imgtec.com>
+Alex Shi <alex.shi@linux.alibaba.com> <alex.shi@intel.com>
+Alex Shi <alex.shi@linux.alibaba.com> <alex.shi@linaro.org>
 Al Viro <viro@ftp.linux.org.uk>
 Al Viro <viro@zenIV.linux.org.uk>
 Andi Shyti <andi@etezian.org> <andi.shyti@samsung.com>
-- 
2.19.1.856.g8858448bb

