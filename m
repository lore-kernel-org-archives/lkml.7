Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEA3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21A49218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfCUBmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 21:42:18 -0400
Received: from goldenrod.birch.relay.mailchannels.net ([23.83.209.74]:10330
        "EHLO goldenrod.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726753AbfCUBmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 21:42:17 -0400
X-Sender-Id: techassets|x-authuser|alec@onelabs.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 0A30A5E0F8F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 01:35:14 +0000 (UTC)
Received: from cp11.deluxehosting.com (100-96-2-14.trex.outbound.svc.cluster.local [100.96.2.14])
        (Authenticated sender: techassets)
        by relay.mailchannels.net (Postfix) with ESMTPA id 9FF6F5E05A7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 01:35:13 +0000 (UTC)
X-Sender-Id: techassets|x-authuser|alec@onelabs.com
Received: from cp11.deluxehosting.com ([TEMPUNAVAIL]. [207.55.242.133])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.17.2);
        Thu, 21 Mar 2019 01:35:13 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: techassets|x-authuser|alec@onelabs.com
X-MailChannels-Auth-Id: techassets
X-Stop-Tangy: 40bd2b5a43167921_1553132113870_1464541724
X-MC-Loop-Signature: 1553132113870:849446948
X-MC-Ingress-Time: 1553132113869
Received: from [::1] (port=44060 helo=cp11.deluxehosting.com)
        by cp11.deluxehosting.com with esmtpa (Exim 4.91)
        (envelope-from <alec@onelabs.com>)
        id 1h6mbs-0005KU-9n
        for linux-kernel@vger.kernel.org; Wed, 20 Mar 2019 21:35:08 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 20 Mar 2019 20:35:08 -0500
From:   Alec Ari <alec@onelabs.com>
To:     linux-kernel@vger.kernel.org
Subject: drm/Kconfig: Remove selection of BACKLIGHT_* options for DRM_RADEON
Organization: ONE Labs
Message-ID: <7566f65c2972f6e4a03991650778277c@onelabs.com>
X-Sender: alec@onelabs.com
User-Agent: Roundcube Webmail/1.3.7
X-AuthUser: alec@onelabs.com
X-Originating-IP: ::1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 From e38df43127fd9a5db167f5873aee882b60f63f37 Mon Sep 17 00:00:00 2001
 From: Alec Ari <alec@onelabs.com>
Date: Wed, 20 Mar 2019 20:19:48 -0500
Subject: drm/Kconfig: Remove selection of BACKLIGHT_* options for 
DRM_RADEON

Backlight support is not required for base DRM_RADEON
functionality. Tested on Acer Aspire One w/ Radeon HD 6290.

Signed-off-by: Alec Ari <alec@onelabs.com>
---
  drivers/gpu/drm/Kconfig | 2 --
  1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index bd943a71756c..16dd978bd74e 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -193,8 +193,6 @@ config DRM_RADEON
          select DRM_TTM
  	select POWER_SUPPLY
  	select HWMON
-	select BACKLIGHT_CLASS_DEVICE
-	select BACKLIGHT_LCD_SUPPORT
  	select INTERVAL_TREE
  	help
  	  Choose this option if you have an ATI Radeon graphics card.  There
-- 
2.20.1
