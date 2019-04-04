Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCC0C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C6F22064A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbfDDPGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:06:19 -0400
Received: from smtprelay0205.hostedemail.com ([216.40.44.205]:33949 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727212AbfDDPGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 11:06:19 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 6D6B4182CED34;
        Thu,  4 Apr 2019 15:06:17 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: angle99_3602eec8fc958
X-Filterd-Recvd-Size: 5086
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Thu,  4 Apr 2019 15:06:11 +0000 (UTC)
Message-ID: <da6f2344396555034cf2476c8338b0ce1c56e0a7.camel@perches.com>
Subject: [PATCH] drm/panel: Rocktech jh057n00900: Add terminating newlines
 to logging
From:   Joe Perches <joe@perches.com>
To:     Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Johan Hovold <johan@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Date:   Thu, 04 Apr 2019 08:06:09 -0700
In-Reply-To: <20190404105359.GA8255@bogon.m.sigxcpu.org>
References: <cover.1554114302.git.agx@sigxcpu.org>
         <20190403161735.GN5238@ulmo>
         <1ed5eb3af4df6b2dd1544c7b696e034ed5c94f06.camel@perches.com>
         <20190404105359.GA8255@bogon.m.sigxcpu.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These were missing '\n' terminations, add them.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c b/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
index 158a6d548068..d88ea8da2ec2 100644
--- a/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
+++ b/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
@@ -123,7 +123,7 @@ static int jh057n_init_sequence(struct jh057n *ctx)
 
 	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
 	if (ret < 0) {
-		DRM_DEV_ERROR(dev, "Failed to exit sleep mode");
+		DRM_DEV_ERROR(dev, "Failed to exit sleep mode\n");
 		return ret;
 	}
 	/* Panel is operational 120 msec after reset */
@@ -132,7 +132,7 @@ static int jh057n_init_sequence(struct jh057n *ctx)
 	if (ret)
 		return ret;
 
-	DRM_DEV_DEBUG_DRIVER(dev, "Panel init sequence done");
+	DRM_DEV_DEBUG_DRIVER(dev, "Panel init sequence done\n");
 	return 0;
 }
 
@@ -172,7 +172,7 @@ static int jh057n_prepare(struct drm_panel *panel)
 	if (ctx->prepared)
 		return 0;
 
-	DRM_DEV_DEBUG_DRIVER(ctx->dev, "Resetting the panel.");
+	DRM_DEV_DEBUG_DRIVER(ctx->dev, "Resetting the panel\n");
 	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
 	usleep_range(20, 40);
 	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
@@ -180,7 +180,8 @@ static int jh057n_prepare(struct drm_panel *panel)
 
 	ret = jh057n_init_sequence(ctx);
 	if (ret < 0) {
-		DRM_DEV_ERROR(ctx->dev, "Panel init sequence failed: %d", ret);
+		DRM_DEV_ERROR(ctx->dev, "Panel init sequence failed: %d\n",
+			      ret);
 		return ret;
 	}
 
@@ -212,7 +213,7 @@ static int jh057n_get_modes(struct drm_panel *panel)
 
 	mode = drm_mode_duplicate(panel->drm, &default_mode);
 	if (!mode) {
-		DRM_DEV_ERROR(ctx->dev, "Failed to add mode %ux%u@%u",
+		DRM_DEV_ERROR(ctx->dev, "Failed to add mode %ux%u@%u\n",
 			      default_mode.hdisplay, default_mode.vdisplay,
 			      default_mode.vrefresh);
 		return -ENOMEM;
@@ -241,7 +242,7 @@ static int allpixelson_set(void *data, u64 val)
 	struct jh057n *ctx = data;
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
 
-	DRM_DEV_DEBUG_DRIVER(ctx->dev, "Setting all pixels on");
+	DRM_DEV_DEBUG_DRIVER(ctx->dev, "Setting all pixels on\n");
 	dsi_generic_write_seq(dsi, ST7703_CMD_ALL_PIXEL_ON);
 	msleep(val * 1000);
 	/* Reset the panel to get video back */
@@ -290,7 +291,7 @@ static int jh057n_probe(struct mipi_dsi_device *dsi)
 
 	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(ctx->reset_gpio)) {
-		DRM_DEV_ERROR(dev, "cannot get reset gpio");
+		DRM_DEV_ERROR(dev, "cannot get reset gpio\n");
 		return PTR_ERR(ctx->reset_gpio);
 	}
 
@@ -315,12 +316,12 @@ static int jh057n_probe(struct mipi_dsi_device *dsi)
 
 	ret = mipi_dsi_attach(dsi);
 	if (ret < 0) {
-		DRM_DEV_ERROR(dev, "mipi_dsi_attach failed. Is host ready?");
+		DRM_DEV_ERROR(dev, "mipi_dsi_attach failed. Is host ready?\n");
 		drm_panel_remove(&ctx->panel);
 		return ret;
 	}
 
-	DRM_DEV_INFO(dev, "%ux%u@%u %ubpp dsi %udl - ready",
+	DRM_DEV_INFO(dev, "%ux%u@%u %ubpp dsi %udl - ready\n",
 		     default_mode.hdisplay, default_mode.vdisplay,
 		     default_mode.vrefresh,
 		     mipi_dsi_pixel_format_to_bpp(dsi->format), dsi->lanes);


