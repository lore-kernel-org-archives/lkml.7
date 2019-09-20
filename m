Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05194C4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 07:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC6E6222CE
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 07:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437662AbfITHzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 03:55:08 -0400
Received: from mout.perfora.net ([74.208.4.197]:58371 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437650AbfITHzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 03:55:05 -0400
Received: from marcel-nb-toradex-int.cardiotech.int ([81.221.138.184]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0LvjHG-1i7uKf0Dqm-017VAu; Fri, 20 Sep 2019 09:54:29 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     dri-devel@lists.freedesktop.org
Cc:     devicetree@vger.kernel.org, info@logictechno.com,
        j.bauer@endrich.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v1 2/2] drm/panel: simple: add display timings for logic technologies displays
Date:   Fri, 20 Sep 2019 09:54:11 +0200
Message-Id: <20190920075411.15735-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190920075411.15735-1-marcel@ziswiler.com>
References: <20190920075411.15735-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:sLEHM5ID9bpkaIBR8unNP/vrUtJPExDKWaW13ABHK2a71XWqLsr
 9qVh9qGuJ6urbc4F+rb9guOpFZI2OTT/ZAACP/2LblYf8A5Rk50zBO7sqeoC8QOqsjYFpD6
 c3JAPZ/k39M5eZxNfowloFsS+vRMB/5bnAUB5rnta/VVlglsy2TQ/fy6X8LuzIcRM8tSn+Y
 Fecd3RLQm40vB+PcKaAyw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rM8OH6nkw0Q=:u7QyUop3rCQyx8mtBudJSK
 sLtrcTa50J82vAPT3ZHfV7s3KdJNwisv4bHEB97pIjmZWTdA85VAi7HpTDrWiHPHvAVsRVhhM
 la2JqoHOW1xPoJkhDkF1D8L/8OJSsC+q88k+apPVW7iDgj7uQKOStPUWwrdOnqDdku+H6Cz8M
 3ZR/6uDkjrnbL099c+FLZ/ISydfZmy8nKmTIWV7kJyd6rJFMDRwKneqsTXXjYWwYfDlsxDu9D
 04vQzA0rZkiro21l11XNtMarayek2+pj1seTBGKwthh1sqCEXboR5SyuWqNJnlKWKUnEkcXg1
 bvXKYT2hQidjQepOSDdp8dU5TJFFJXsj/4T+vyiewWg6KuXj2MP+qrIWEXV8iBEGS5TrlUH0F
 +tWx4H8kT8dyVowBAhBqMTxRy8cWGyni2sxqVgxedA1h2tTZWxp2Nek1r1M4ozFpofirFW8Hv
 PFlKYuvPlb/DFGfeOl4Lxd8+4gM+l+mOovj3PgbBrJII0mE7AEafzAFp7XWWyycMD627ae1v/
 9hb2gXk9Unr/OYgsvL61/WeI+A/nohPspp03pheosvy0rxGIaRs6e8+hzocFt1dapowf/XOOq
 8/P+vUMtH1PxTXUXbh6bTGfJQLbIW4YiugbyRuAHGX40q/gmEPaLbglpjksYv3szmDA2L/FhL
 ye/FpF/uRLrFyg94PW43L5qu4/4wGvK8U/MSdDN15GtIuMwacmMoW1CT16jxhUeT9mOWFURUI
 LyD5/fsSFdfgLFX+Y1GootShu+XClMwIYQyciMb49NqQF1gtwc88ehh9iPAMZ0+14D7Fi5/M9
 zlgA3atxSiRyxKAYWRdNIYal785/I4XDRQrOcqTiZsOBc7wcB7axjgB33n+Ct4rw87O9NVwrG
 w6DBSzdSXnXfDQgFPRhpt4IkN+/Hnn2lfCf4gweZc=
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

---

 drivers/gpu/drm/panel/panel-simple.c | 65 ++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 28fa6ba7b767..42bd0de25167 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2034,6 +2034,62 @@ static const struct panel_desc lg_lp129qe = {
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
@@ -3264,6 +3320,15 @@ static const struct of_device_id platform_of_match[] = {
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

