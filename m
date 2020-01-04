Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFABC2D0C2
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 15:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 681A32465B
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 15:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578151372;
	bh=cwVHC9cbVgplkseh61brdp4+7/gA+lKOKfHqQ/RsvbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wXOMKGVBPDzoKHP+1dquc9Ekf0UTovO5yntTN+iKRklIgkqfbCBLwxgNi7J6l8GAi
	 6jus8S1sX8D4uxtuoHmQI3iD7/qIOiKyxYsjz8gol43R5v7IVhfleQO9mT3eFkPr7J
	 rTOnL4eRGqZmPQ3LoFjD+TFUWaxkS6pl9Zy/ZHY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbgADPWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 10:22:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:60880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgADPWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 10:22:48 -0500
Received: from localhost.localdomain (unknown [194.230.155.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF10A24653;
        Sat,  4 Jan 2020 15:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578151368;
        bh=cwVHC9cbVgplkseh61brdp4+7/gA+lKOKfHqQ/RsvbM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=caye/OqaaDbiqYYjnZRpkvWLsTWq60WBd3unY9XD3X/MG16biqx1arMBswYacHcDd
         Ze3xrzZXuWydaqiTEU86TPfZ+8OkloaCFghayiDk6Ehh4zJcJZC9S/bTKQuYsjamRg
         iJFADtXDpkZS+jYV1jKIgfrNAnRl8cEKrdAnCuys=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Kukjin Kim <kgene@kernel.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 14/20] drm/exynos: Rename Exynos to lowercase
Date:   Sat,  4 Jan 2020 16:21:01 +0100
Message-Id: <20200104152107.11407-15-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200104152107.11407-1-krzk@kernel.org>
References: <20200104152107.11407-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up inconsistent usage of upper and lowercase letters in "Exynos"
name.

"EXYNOS" is not an abbreviation but a regular trademarked name.
Therefore it should be written with lowercase letters starting with
capital letter.

The lowercase "Exynos" name is promoted by its manufacturer Samsung
Electronics Co., Ltd., in advertisement materials and on website.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/gpu/drm/exynos/Kconfig | 6 +++---
 include/uapi/drm/exynos_drm.h  | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/exynos/Kconfig b/drivers/gpu/drm/exynos/Kconfig
index 6f7d3b3b3628..6417f374b923 100644
--- a/drivers/gpu/drm/exynos/Kconfig
+++ b/drivers/gpu/drm/exynos/Kconfig
@@ -1,13 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config DRM_EXYNOS
-	tristate "DRM Support for Samsung SoC EXYNOS Series"
+	tristate "DRM Support for Samsung SoC Exynos Series"
 	depends on OF && DRM && (ARCH_S3C64XX || ARCH_S5PV210 || ARCH_EXYNOS || ARCH_MULTIPLATFORM || COMPILE_TEST)
 	depends on MMU
 	select DRM_KMS_HELPER
 	select VIDEOMODE_HELPERS
 	select SND_SOC_HDMI_CODEC if SND_SOC
 	help
-	  Choose this option if you have a Samsung SoC EXYNOS chipset.
+	  Choose this option if you have a Samsung SoC Exynos chipset.
 	  If M is selected the module will be called exynosdrm.
 
 if DRM_EXYNOS
@@ -62,7 +62,7 @@ config DRM_EXYNOS_DSI
 	  This enables support for Exynos MIPI-DSI device.
 
 config DRM_EXYNOS_DP
-	bool "EXYNOS specific extensions for Analogix DP driver"
+	bool "Exynos specific extensions for Analogix DP driver"
 	depends on DRM_EXYNOS_FIMD || DRM_EXYNOS7_DECON
 	select DRM_ANALOGIX_DP
 	default DRM_EXYNOS
diff --git a/include/uapi/drm/exynos_drm.h b/include/uapi/drm/exynos_drm.h
index 45c6582b3df3..a51aa1c618c1 100644
--- a/include/uapi/drm/exynos_drm.h
+++ b/include/uapi/drm/exynos_drm.h
@@ -394,7 +394,7 @@ struct drm_exynos_ioctl_ipp_commit {
 #define DRM_IOCTL_EXYNOS_IPP_COMMIT		DRM_IOWR(DRM_COMMAND_BASE + \
 		DRM_EXYNOS_IPP_COMMIT, struct drm_exynos_ioctl_ipp_commit)
 
-/* EXYNOS specific events */
+/* Exynos specific events */
 #define DRM_EXYNOS_G2D_EVENT		0x80000000
 #define DRM_EXYNOS_IPP_EVENT		0x80000002
 
-- 
2.17.1

