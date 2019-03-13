Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDE7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 13:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA8F22171F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 13:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfCMNum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 09:50:42 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:50953 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726896AbfCMNuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 09:50:35 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04392;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TMdk0u1_1552485031;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TMdk0u1_1552485031)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 13 Mar 2019 21:50:31 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     corbet@lwn.net, harryxiyou@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v5 22/31] mailmap: update Li Yang's email address
Date:   Wed, 13 Mar 2019 21:49:52 +0800
Message-Id: <20190313135001.260905-23-alex.shi@linux.alibaba.com>
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

Update the obsolete email address leoli@freescale.com and
leo@zh-kernel.org with leoyang.li@nxp.com.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Li Yang <leoyang.li@nxp.com>
Signed-off-by: Weiwei Jia <harryxiyou@gmail.com>
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index 37e1847c7988..705c4f11f1a3 100644
--- a/.mailmap
+++ b/.mailmap
@@ -117,6 +117,8 @@ Leonid I Ananiev <leonid.i.ananiev@intel.com>
 Linas Vepstas <linas@austin.ibm.com>
 Linus Lüssing <linus.luessing@c0d3.blue> <linus.luessing@web.de>
 Linus Lüssing <linus.luessing@c0d3.blue> <linus.luessing@ascom.ch>
+Li Yang <leoyang.li@nxp.com> <leo@zh-kernel.org>
+Li Yang <leoyang.li@nxp.com> <leoli@freescale.com>
 Maciej W. Rozycki <macro@mips.com> <macro@imgtec.com>
 Marcin Nowakowski <marcin.nowakowski@mips.com> <marcin.nowakowski@imgtec.com>
 Mark Brown <broonie@sirena.org.uk>
-- 
2.19.1.856.g8858448bb

