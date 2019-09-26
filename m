Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEB9C47E48
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 10:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 938CF20872
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 10:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfIZKSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 06:18:01 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:27188 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726767AbfIZKSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 06:18:00 -0400
X-IronPort-AV: E=Sophos;i="5.64,551,1559487600"; 
   d="scan'208";a="27349760"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 26 Sep 2019 19:17:58 +0900
Received: from renesas-ubuntu18.ree.adwin.renesas.com (unknown [10.226.36.106])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 88CBC40083F1;
        Thu, 26 Sep 2019 19:17:57 +0900 (JST)
From:   Chris Paterson <chris.paterson2@renesas.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Ramesh Shanmugasundaram <rashanmu@gmail.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Chris Paterson <chris.paterson2@renesas.com>
Subject: [PATCH] [media] MAINTAINERS: Update MAX2175 & R-Car DRIF driver maintainer email
Date:   Thu, 26 Sep 2019 11:17:54 +0100
Message-Id: <20190926101754.23106-1-chris.paterson2@renesas.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ramesh is now using a new email address. Update the maintainer entry for
the MAX2175 SDR tuner and the Renesas R-Car DRIF drivers.

Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 37dca6d70d87..948612fcf60b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9873,7 +9873,7 @@ F:	Documentation/hwmon/max16065.rst
 F:	drivers/hwmon/max16065.c
 
 MAX2175 SDR TUNER DRIVER
-M:	Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
+M:	Ramesh Shanmugasundaram <rashanmu@gmail.com>
 L:	linux-media@vger.kernel.org
 T:	git git://linuxtv.org/media_tree.git
 S:	Maintained
@@ -10135,7 +10135,7 @@ F:	drivers/media/platform/renesas-ceu.c
 F:	include/media/drv-intf/renesas-ceu.h
 
 MEDIA DRIVERS FOR RENESAS - DRIF
-M:	Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
+M:	Ramesh Shanmugasundaram <rashanmu@gmail.com>
 L:	linux-media@vger.kernel.org
 L:	linux-renesas-soc@vger.kernel.org
 T:	git git://linuxtv.org/media_tree.git
-- 
2.17.1

