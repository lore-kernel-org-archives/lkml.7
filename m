Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961DBC43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70BE922526
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574257007;
	bh=3HKCIB7YMRDHJrkZ/3F75UmwARzPFjHhq0piLV9ZpMs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=eSPu8Xv7QDETvUCbQDRhl2N4YOOARgJkBr6jluJyk+LYG8raQOtZrvbyF68rYLvvz
	 vG3tyc/ZV05safVEgr7DSeFNwEEVV/aU+3oAIJPsuj0wZdJ/rfSwm9EDEqqvynv/SK
	 8h3GCDZd2FMpUMaHf9GJ7IM5TZJqkxnJqkZbNgRU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730828AbfKTNgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:36:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:43296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729766AbfKTNgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:36:45 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A041F21939;
        Wed, 20 Nov 2019 13:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257004;
        bh=3HKCIB7YMRDHJrkZ/3F75UmwARzPFjHhq0piLV9ZpMs=;
        h=From:To:Cc:Subject:Date:From;
        b=1w50fEh8eOSMvUdbaWMAfpUvpGBnzIKA3XQ1mcR42pvTu25jyIo48QZktSflRIiPG
         B4R8EZlWJuG7OwKGnOOI89r01bxKVQnoZFiFPaB/GK/Fb6UdQysZ4fDkAPToIZMId3
         JIgsPHWUjusRhrtl2v7HMZm3BcQwITt4SJeZV9sc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:36:40 +0800
Message-Id: <20191120133640.11659-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/gpu/drm/Kconfig | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 1168351267fd..ad1b6ecd2e08 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -94,18 +94,18 @@ config DRM_KMS_FB_HELPER
 	  FBDEV helpers for KMS drivers.
 
 config DRM_DEBUG_DP_MST_TOPOLOGY_REFS
-        bool "Enable refcount backtrace history in the DP MST helpers"
-        select STACKDEPOT
-        depends on DRM_KMS_HELPER
-        depends on DEBUG_KERNEL
-        depends on EXPERT
-        help
-          Enables debug tracing for topology refs in DRM's DP MST helpers. A
-          history of each topology reference/dereference will be printed to the
-          kernel log once a port or branch device's topology refcount reaches 0.
-
-          This has the potential to use a lot of memory and print some very
-          large kernel messages. If in doubt, say "N".
+	bool "Enable refcount backtrace history in the DP MST helpers"
+	select STACKDEPOT
+	depends on DRM_KMS_HELPER
+	depends on DEBUG_KERNEL
+	depends on EXPERT
+	help
+	  Enables debug tracing for topology refs in DRM's DP MST helpers. A
+	  history of each topology reference/dereference will be printed to the
+	  kernel log once a port or branch device's topology refcount reaches 0.
+
+	  This has the potential to use a lot of memory and print some very
+	  large kernel messages. If in doubt, say "N".
 
 config DRM_FBDEV_EMULATION
 	bool "Enable legacy fbdev support for your modesetting driver"
@@ -234,8 +234,8 @@ config DRM_RADEON
 	tristate "ATI Radeon"
 	depends on DRM && PCI && MMU
 	select FW_LOADER
-        select DRM_KMS_HELPER
-        select DRM_TTM
+	select DRM_KMS_HELPER
+	select DRM_TTM
 	select POWER_SUPPLY
 	select HWMON
 	select BACKLIGHT_CLASS_DEVICE
@@ -294,7 +294,7 @@ config DRM_VKMS
 	  If M is selected the module will be called vkms.
 
 config DRM_ATI_PCIGART
-        bool
+	bool
 
 source "drivers/gpu/drm/exynos/Kconfig"
 
-- 
2.17.1

