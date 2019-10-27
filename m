Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F000CCA9EBD
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 14:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3EFA20873
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 14:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfJ0O1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 10:27:05 -0400
Received: from mout.perfora.net ([74.208.4.194]:34373 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbfJ0O1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 10:27:05 -0400
Received: from marcel-nb-toradex-int.toradex.int ([31.10.206.124]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0LfzPZ-1heeJU0fs3-00pfdc; Sun, 27 Oct 2019 15:26:27 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     dri-devel@lists.freedesktop.org
Cc:     devicetree@vger.kernel.org, info@logictechno.com,
        j.bauer@endrich.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v2 2/3] drm/panel: simple: add display timings for logic technologies displays
Date:   Sun, 27 Oct 2019 15:26:08 +0100
Message-Id: <20191027142609.12754-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191027142609.12754-1-marcel@ziswiler.com>
References: <20191027142609.12754-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3DquW+3hHT9LpViOmCrHnA2GnPQhQ1Qr+998CD0WzszqQ+evuJ6
 8N18jw92t9xhoo34PzGX0BmZoviWeITsGgQ+RXCqUtZtB1peCwX97YNdDLlzOrW/bNoIz/o
 YkLjROo1BdthaURJHNK1J4keiLBfOR5rl9ZZEuLdgN+SNHF4n8HnBivo4FWxMlDyAZAgm6c
 RimNBiJgr9Fw1olCTIA+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6vpPbtUJFrc=:XCDyEzNp5FoYZtJZG8B5Bq
 T5B9vJX4yEfQNCfXNECPQg79lspGRfbQ/XRdFQ46VUsUPneoJ9/6zyrZ7pzhkzgWGe8UvTlyn
 U9dLgX6ZrY+8W9k8tU7vlbQwpARC12jEFC/NA4vMnrksJxgcx6IvzXJgkQ3fKzkkXoOGnqQEA
 wx369B8ytI93dmkbC4uzIXjglOSJsBjYoLcOnHTvyKgNtSVc+KnKn1iwauoC1ftJTSSniTJpo
 77D/QWXqWEt9XkMF5BrRSFrp6C+IjOOR5AP+avWf9ddtzOCL2fFwdJ4bq3eBR2ujuzot4CUxE
 q/p2n2OQKA3TwVILXIY3QljtYvXUg6IEQW7riZJi1AusOplD9hgjQ6zQOFZJ9KIe9fB8h2FnL
 1jjL0IN7/ML3WKIrMxR8VS2cotG1gP8bUbtljkUY1ZV8SIbME4lC89oQuKJkd6gkZGN3IVE+T
 wsidPovGZbPkrXLoln1/OxP6K6gXvp+dERX8fPJA1R360gzr6AtKmh+MkAVR5QFrtWwF0MbPH
 hpGaS/6TDNdIobh0R87c4fMmGOuIvb/OE70YUvaDbkaj/ifkemcsGp4nu+bv45xDcYreMngPS
 Jba6uKjxQxvgv13DCzcDk6Xt+YcDy5omXl8xuY6m5m4zLeBdq6zeiarZEfSDPY0LnQnJPk/Ie
 S34I9tnmdJCclSuz9eKmQYbIbbi1a+yifTb88DP6BGZ+s61cwQHwMtfGRlMgwOh6rWS/fCalL
 J6/Gs9hjAj81t2SxuKSJwSZxYog9HLpns/k2z3cR+2x1DJvi0bU+tjvxGauEf8x9CjlgdyUAy
 1d2WzvZNo3jywpflHHg8EPCj99D2ncCJXVpVN0WkBtwSy72fQ985e8u/amVWOrHLr+2prNDQR
 Tmo5qgPmTDWHcuQR8dHcU1CbeNpMpncY/yxKptrOg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add display timings for the following 3 display panels manufactured by
Logic Technologies Limited:

- LT161010-2NHC e.g. as found in the Toradex Capacitive Touch Display
  7" Parallel [1]
- LT161010-2NHR e.g. as found in the Toradex Resistive Touch Display 7"
  Parallel [2]
- LT170410-2WHC e.g. as found in the Toradex Capacitive Touch Display
  10.1" LVDS [3]

Those panels may also be distributed by Endrich Bauelemente Vertriebs
GmbH [4].

[1] https://docs.toradex.com/104497-7-inch-parallel-capacitive-touch-display-800x480-datasheet.pdf
[2] https://docs.toradex.com/104498-7-inch-parallel-resistive-touch-display-800x480.pdf
[3] https://docs.toradex.com/105952-10-1-inch-lvds-capacitive-touch-display-1280x800-datasheet.pdf
[4] https://www.endrich.com/isi50_isi30_tft-displays/lt170410-1whc_isi30

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Reviewed-by: Philippe Schenker <philippe.schenker@toradex.com>

---

Changes in v2:
- Added Philippe's reviewed-by.

 drivers/gpu/drm/panel/panel-simple.c | 65 ++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 5d487686d25c..546770116096 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2047,6 +2047,62 @@ static const struct panel_desc lg_lp129qe = {
 	},
 };
 
+static const struct display_timing logictechno_lt161010_2nh_timing = {
+	.pixelclock = { 26400000, 33300000, 46800000 },
+	.hactive = { 800, 800, 800 },
+	.hfront_porch = { 16, 210, 354 },
+	.hback_porch = { 46, 46, 46 },
+	.hsync_len = { 1, 20, 40 },
+	.vactive = { 480, 480, 480 },
+	.vfront_porch = { 7, 22, 147 },
+	.vback_porch = { 23, 23, 23 },
+	.vsync_len = { 1, 10, 20 },
+	.flags = DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_LOW |
+		 DISPLAY_FLAGS_DE_HIGH | DISPLAY_FLAGS_PIXDATA_POSEDGE |
+		 DISPLAY_FLAGS_SYNC_POSEDGE,
+};
+
+static const struct panel_desc logictechno_lt161010_2nh = {
+	.timings = &logictechno_lt161010_2nh_timing,
+	.num_timings = 1,
+	.size = {
+		.width = 154,
+		.height = 86,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH |
+		     DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE |
+		     DRM_BUS_FLAG_SYNC_SAMPLE_NEGEDGE,
+};
+
+static const struct display_timing logictechno_lt170410_2whc_timing = {
+	.pixelclock = { 68900000, 71100000, 7340000 },
+	.hactive = { 1280, 1280, 1280 },
+	.hfront_porch = { 23, 60, 71 },
+	.hback_porch = { 23, 60, 71 },
+	.hsync_len = { 15, 40, 47 },
+	.vactive = { 800, 800, 800 },
+	.vfront_porch = { 5, 7, 10 },
+	.vback_porch = { 5, 7, 10 },
+	.vsync_len = { 6, 9, 12 },
+	.flags = DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_LOW |
+		 DISPLAY_FLAGS_DE_HIGH | DISPLAY_FLAGS_PIXDATA_POSEDGE |
+		 DISPLAY_FLAGS_SYNC_POSEDGE,
+};
+
+static const struct panel_desc logictechno_lt170410_2whc = {
+	.timings = &logictechno_lt170410_2whc_timing,
+	.num_timings = 1,
+	.size = {
+		.width = 217,
+		.height = 136,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH |
+		     DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE |
+		     DRM_BUS_FLAG_SYNC_SAMPLE_NEGEDGE,
+};
+
 static const struct drm_display_mode mitsubishi_aa070mc01_mode = {
 	.clock = 30400,
 	.hdisplay = 800,
@@ -3287,6 +3343,15 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "lg,lp129qe",
 		.data = &lg_lp129qe,
+	}, {
+		.compatible = "logictechno,lt161010-2nhc",
+		.data = &logictechno_lt161010_2nh,
+	}, {
+		.compatible = "logictechno,lt161010-2nhr",
+		.data = &logictechno_lt161010_2nh,
+	}, {
+		.compatible = "logictechno,lt170410-2whc",
+		.data = &logictechno_lt170410_2whc,
 	}, {
 		.compatible = "mitsubishi,aa070mc01-ca1",
 		.data = &mitsubishi_aa070mc01,
-- 
2.21.0

