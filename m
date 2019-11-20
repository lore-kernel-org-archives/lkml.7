Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871BEC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6031B22530
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574256981;
	bh=RUNB9hOTUZ4qmRoduYIQryJyG12dotmMLmkW3l5nh1Q=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=epyoMIW2/D4uvkVOpSxniJndKRrxGl1GOA2dTPF7pI6iWc61Vlq6uuCLAzsoe4fWr
	 eA7rNdxdL10krS+a1UVXegb6DawF+FFsi41enM4cL+xjwAcyk7DqPLNJiEqTvTmWbb
	 OLzQt20HGX5J/Bv2rLzgW+1WHIWfGGTUknSF/wOI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbfKTNgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:36:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:42620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728030AbfKTNgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:36:19 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8015421939;
        Wed, 20 Nov 2019 13:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574256979;
        bh=RUNB9hOTUZ4qmRoduYIQryJyG12dotmMLmkW3l5nh1Q=;
        h=From:To:Cc:Subject:Date:From;
        b=G077Hz9yCb4/C6pS9QFs0Zr0Vm/BpcgOE2TeFgrlAYK3BASuwj3uFk5xGTd1uIaUp
         zuXnhBY4Yv9oz0uAN+lX4TPPUuXgi11Xo2cd05PDv/+hxUXozGfvLteI1jEMyQI54o
         UmR7rOt9BUOaOLSFYKMz7ynRyki8yzp84+crlir4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/omap: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:36:14 +0800
Message-Id: <20191120133615.11329-1-krzk@kernel.org>
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
 drivers/gpu/drm/omapdrm/displays/Kconfig |  6 +++---
 drivers/gpu/drm/omapdrm/dss/Kconfig      | 12 ++++++------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/displays/Kconfig b/drivers/gpu/drm/omapdrm/displays/Kconfig
index 240dda102845..b562a8cd61bf 100644
--- a/drivers/gpu/drm/omapdrm/displays/Kconfig
+++ b/drivers/gpu/drm/omapdrm/displays/Kconfig
@@ -8,18 +8,18 @@ config DRM_OMAP_ENCODER_OPA362
 	  through a GPIO.
 
 config DRM_OMAP_ENCODER_TPD12S015
-        tristate "TPD12S015 HDMI ESD protection and level shifter"
+	tristate "TPD12S015 HDMI ESD protection and level shifter"
 	help
 	  Driver for TPD12S015, which offers HDMI ESD protection and level
 	  shifting.
 
 config DRM_OMAP_CONNECTOR_HDMI
-        tristate "HDMI Connector"
+	tristate "HDMI Connector"
 	help
 	  Driver for a generic HDMI connector.
 
 config DRM_OMAP_CONNECTOR_ANALOG_TV
-        tristate "Analog TV Connector"
+	tristate "Analog TV Connector"
 	help
 	  Driver for a generic analog TV connector.
 
diff --git a/drivers/gpu/drm/omapdrm/dss/Kconfig b/drivers/gpu/drm/omapdrm/dss/Kconfig
index 956f23e1452d..72ae79c0c9b4 100644
--- a/drivers/gpu/drm/omapdrm/dss/Kconfig
+++ b/drivers/gpu/drm/omapdrm/dss/Kconfig
@@ -6,12 +6,12 @@ config OMAP_DSS_BASE
 	tristate
 
 menuconfig OMAP2_DSS
-        tristate "OMAP2+ Display Subsystem support"
+	tristate "OMAP2+ Display Subsystem support"
 	select OMAP_DSS_BASE
 	select VIDEOMODE_HELPERS
 	select OMAP2_DSS_INIT
 	select HDMI
-        help
+	help
 	  OMAP2+ Display Subsystem support.
 
 if OMAP2_DSS
@@ -52,7 +52,7 @@ config OMAP2_DSS_DPI
 
 config OMAP2_DSS_VENC
 	bool "VENC support"
-        default y
+	default y
 	help
 	  OMAP Video Encoder support for S-Video and composite TV-out.
 
@@ -61,7 +61,7 @@ config OMAP2_DSS_HDMI_COMMON
 
 config OMAP4_DSS_HDMI
 	bool "HDMI support for OMAP4"
-        default y
+	default y
 	select OMAP2_DSS_HDMI_COMMON
 	help
 	  HDMI support for OMAP4 based SoCs.
@@ -85,7 +85,7 @@ config OMAP5_DSS_HDMI
 
 config OMAP2_DSS_SDI
 	bool "SDI support"
-        default n
+	default n
 	help
 	  SDI (Serial Display Interface) support.
 
@@ -94,7 +94,7 @@ config OMAP2_DSS_SDI
 
 config OMAP2_DSS_DSI
 	bool "DSI support"
-        default n
+	default n
 	help
 	  MIPI DSI (Display Serial Interface) support.
 
-- 
2.17.1

