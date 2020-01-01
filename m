Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02F7C2D0DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 08:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A4C206E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 08:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbgAAIVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 03:21:17 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:56955 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725916AbgAAIUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 03:20:14 -0500
X-IronPort-AV: E=Sophos;i="5.69,382,1571695200"; 
   d="scan'208";a="429578756"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES128-SHA256; 01 Jan 2020 09:20:08 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     kernel-janitors@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/16] media: mt9v111: constify copied structure
Date:   Wed,  1 Jan 2020 08:43:24 +0100
Message-Id: <1577864614-5543-7-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1577864614-5543-1-git-send-email-Julia.Lawall@inria.fr>
References: <1577864614-5543-1-git-send-email-Julia.Lawall@inria.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mt9v111_def_fmt structure is only copied into another structure,
so make it const.

The opportunity for this change was found using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/media/i2c/mt9v111.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/mt9v111.c b/drivers/media/i2c/mt9v111.c
index bb41bea950ac..61ae6a0d5679 100644
--- a/drivers/media/i2c/mt9v111.c
+++ b/drivers/media/i2c/mt9v111.c
@@ -103,7 +103,7 @@
 #define MT9V111_MAX_CLKIN				27000000
 
 /* The default sensor configuration at startup time. */
-static struct v4l2_mbus_framefmt mt9v111_def_fmt = {
+static const struct v4l2_mbus_framefmt mt9v111_def_fmt = {
 	.width		= 640,
 	.height		= 480,
 	.code		= MEDIA_BUS_FMT_UYVY8_2X8,

