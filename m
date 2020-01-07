Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE2EC33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A3620692
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbgAGVh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:37:56 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:53343 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgAGVhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:37:54 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MD9jV-1ixz5J32PZ-0095eX; Tue, 07 Jan 2020 22:37:40 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: of: fix link error
Date:   Tue,  7 Jan 2020 22:37:32 +0100
Message-Id: <20200107213738.635906-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:kt5LvuirQVNweIAs+LOmABN57OTOIGByhcM0pxamuzNx7t9jGfj
 IuJeQ5d8yRjBH3cmRWomTgyvq83b74sEl/ZG5OFHfBjtYHi6ECVAhiW/szJyQgZs0PXsF8Y
 2bBfwV3qIXFpboG4tc9S3L6eSqjFRJ0ufeIjTIs7o4j+915emX7k5ceTf8G/BPTazTZGcD1
 Mu7Yqn5XSaLqcSEspvY2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ALbzvMY33/E=:vdrGZwPS2OYudX0MwcB3x+
 zdBm+YD9UN+FCkIxDRmYKwhp5EK24CbV3sk3ZI5+EDfjUTsNQnaBNddyVw3cQaBRDXq8szUXO
 1N9N7us30Xxa2Wbm2fYVhsmypwQRCMAJaphoFTNwTpZ/MnY4471u4y7kCflO5YMUJmpdeEghk
 T25qB1JSsSSAkhCqm9jY3YtETHm17lvzi7m8t0iIjtsUHsukKSlPB1n+6/ik3JoSmMJMO0QiR
 5nUvrMVN8YJvAVATHrSCv3Q/kYuEnvlehwonB2JT84n4SPXgRm2OUMQPnCiuRA7z8SRCmhe0T
 Feje9vXwQaBaER4Sh36n8Ti6ghIYCxe/StS2AgYHJXuJMPHsWnQY1w5xYEJ9G5Lc2oEdW83b7
 ZahQ6EsuZMwK9sAEy5aBAU01mQLq/7q+XQrO5daNgbikk69cpwpc3KLOFCGO3zPyTPvSqpJJy
 UEHL03okL7S7MqEvcEcKIQqz2IpivCL8kptQv5L38EZYiNj2uwdyE2rpaKdImPMFO3LrRLT3H
 wO0RIpYUtlawNu5lH8SX3hcTKkLMJf6gcrqVn0LawRQ4SdoSVIkmHmMnZecOxgy+3s1TenpZ8
 4vV9y/X6P8SyGiV+bLUr9dFkLBFGlyl5dNcbGyG4PwzmeAF/57GanXsuo0MwvWYOa/mgVm+vk
 8p/n5QDBrptghnd2BBkGloBbXaXJqinfDXx37lmOm7jZlnih7m/H1hRwy9n2eMBVa9V9zwOD1
 lkSL5Weu9/Izhp+HD6w43EE1K8hakM1V9xegBGsyzgsHAExJwpjzFEvt+qN9IIDh0qHkN6KcR
 6PxU2pvCgTaHUmFkiIn869EudWHe97f+2GmLFab3TFYDQTee9LBPPQdIrUMrwdoFkzwr/CzwI
 zsiDxNDGvGu+J69yFhzw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new dummy helper is non-static, so every driver gets
its own copy, leading to a link failure:

drivers/gpu/drm/imx/imx-ldb.o: In function `drm_of_lvds_get_dual_link_pixel_order':
imx-ldb.c:(.text+0x140): multiple definition of `drm_of_lvds_get_dual_link_pixel_order'
drivers/gpu/drm/imx/imx-drm-core.o:imx-drm-core.c:(.text+0x330): first defined here
drivers/gpu/drm/imx/dw_hdmi-imx.o: In function `drm_of_lvds_get_dual_link_pixel_order':
dw_hdmi-imx.c:(.text+0xd0): multiple definition of `drm_of_lvds_get_dual_link_pixel_order'
drivers/gpu/drm/imx/imx-drm-core.o:imx-drm-core.c:(.text+0x330): first defined here
drivers/gpu/drm/bridge/synopsys/dw-hdmi.o: In function `drm_of_lvds_get_dual_link_pixel_order':
dw-hdmi.c:(.text+0x3b90): multiple definition of `drm_of_lvds_get_dual_link_pixel_order'
drivers/gpu/drm/imx/imx-drm-core.o:imx-drm-core.c:(.text+0x330): first defined here
drivers/gpu/drm/etnaviv/etnaviv_drv.o: In function `drm_of_lvds_get_dual_link_pixel_order':
etnaviv_drv.c:(.text+0x9d0): multiple definition of `drm_of_lvds_get_dual_link_pixel_order'
drivers/gpu/drm/imx/imx-drm-core.o:imx-drm-core.c:(.text+0x330): first defined here

Add the missing 'static' keyword.

Fixes: 6529007522de ("drm: of: Add drm_of_lvds_get_dual_link_pixel_order")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/drm/drm_of.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_of.h b/include/drm/drm_of.h
index 8ec7ca6d2369..3398be966021 100644
--- a/include/drm/drm_of.h
+++ b/include/drm/drm_of.h
@@ -92,7 +92,7 @@ static inline int drm_of_find_panel_or_bridge(const struct device_node *np,
 	return -EINVAL;
 }
 
-int drm_of_lvds_get_dual_link_pixel_order(const struct device_node *port1,
+static inline int drm_of_lvds_get_dual_link_pixel_order(const struct device_node *port1,
 					  const struct device_node *port2)
 {
 	return -EINVAL;
-- 
2.20.0

