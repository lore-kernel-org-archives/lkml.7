Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3FBC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A18206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570469615;
	bh=89Dgdcnx+TZFIqd6fwq18cEG+oms2xjy64qSLbTDVXA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=wI/HIDtjDhobIRp32eegKjhDMxVFbG5E2sbsIKxh9ThgiEcE4F6HzjPhGRxBBrJcU
	 LUn5Z03U53BK1kMtlCJcpptYJ1nRxCMXuPYmlegWGXlu0K+tcYl+yhv9H0H5KPFgyz
	 3P85L/eUu7C0qFQzr+wr1sjkrlC86/6BVM0+9/u0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbfJGRdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 13:33:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:49272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728028AbfJGRdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 13:33:33 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 574DC206BB;
        Mon,  7 Oct 2019 17:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570469612;
        bh=89Dgdcnx+TZFIqd6fwq18cEG+oms2xjy64qSLbTDVXA=;
        h=From:To:Cc:Subject:Date:From;
        b=j/nSOY2CLSaY6ykV7MPW0ZITidtvOocSQkjkkdODAci1fsN3tiruPdaOAKITrI4Ml
         ncaMCUiUScL9Ybo60bA5L/7thaGYctYs0zCISt34bZq1WwG91JmX3W6hB4OTq7kZ4i
         SXGqbbPo3GWtooR229ICb41mvhcyQTAmcqgPrUzc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3] drm/amd: Fix Kconfig indentation
Date:   Mon,  7 Oct 2019 19:33:22 +0200
Message-Id: <20191007173322.9306-1-krzk@kernel.org>
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

Changes since v2:
1. Split AMD and i915 to separate patches.
---
 drivers/gpu/drm/Kconfig             |  4 ++--
 drivers/gpu/drm/amd/display/Kconfig | 32 ++++++++++++++---------------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 108e1b7f4564..7cb6e4eb99e8 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -226,9 +226,9 @@ config DRM_AMDGPU
 	tristate "AMD GPU"
 	depends on DRM && PCI && MMU
 	select FW_LOADER
-        select DRM_KMS_HELPER
+	select DRM_KMS_HELPER
 	select DRM_SCHED
-        select DRM_TTM
+	select DRM_TTM
 	select POWER_SUPPLY
 	select HWMON
 	select BACKLIGHT_CLASS_DEVICE
diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
index 1bbe762ee6ba..313183b80032 100644
--- a/drivers/gpu/drm/amd/display/Kconfig
+++ b/drivers/gpu/drm/amd/display/Kconfig
@@ -23,16 +23,16 @@ config DRM_AMD_DC_DCN2_0
 	depends on DRM_AMD_DC && X86
 	depends on DRM_AMD_DC_DCN1_0
 	help
-	    Choose this option if you want to have
-	    Navi support for display engine
+	  Choose this option if you want to have
+	  Navi support for display engine
 
 config DRM_AMD_DC_DCN2_1
-        bool "DCN 2.1 family"
-        depends on DRM_AMD_DC && X86
-        depends on DRM_AMD_DC_DCN2_0
-        help
-            Choose this option if you want to have
-            Renoir support for display engine
+	bool "DCN 2.1 family"
+	depends on DRM_AMD_DC && X86
+	depends on DRM_AMD_DC_DCN2_0
+	help
+	  Choose this option if you want to have
+	  Renoir support for display engine
 
 config DRM_AMD_DC_DSC_SUPPORT
 	bool "DSC support"
@@ -41,16 +41,16 @@ config DRM_AMD_DC_DSC_SUPPORT
 	depends on DRM_AMD_DC_DCN1_0
 	depends on DRM_AMD_DC_DCN2_0
 	help
-	    Choose this option if you want to have
-	    Dynamic Stream Compression support
+	  Choose this option if you want to have
+	  Dynamic Stream Compression support
 
 config DRM_AMD_DC_HDCP
-        bool "Enable HDCP support in DC"
-        depends on DRM_AMD_DC
-        help
-         Choose this option
-         if you want to support
-         HDCP authentication
+	bool "Enable HDCP support in DC"
+	depends on DRM_AMD_DC
+	help
+	 Choose this option
+	 if you want to support
+	 HDCP authentication
 
 config DEBUG_KERNEL_DC
 	bool "Enable kgdb break in DC"
-- 
2.17.1

