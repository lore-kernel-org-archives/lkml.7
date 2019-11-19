Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20252C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 13:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2C1122304
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 13:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="A5fpBQZV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbfKSNrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 08:47:22 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:28642 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726202AbfKSNrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 08:47:22 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAJDgtQ1018085;
        Tue, 19 Nov 2019 14:47:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=RPNVCR00/xespK2RS0OoI2obJTyZRF5MAmRVt//oPM0=;
 b=A5fpBQZVil4S76+C6T/z24V6/kGUU7LjPcuPV0/R01F2tDdX6OHz5nOSsXZjo7LpldvE
 dYnC9wc5u/Y7TEA0ZR1O+z7TH09ID2gbTMvrDMhOM/ZoJxoylto8god6Nfg+qXS+UzmQ
 Emt6w22XW91xVWZf9/NeujIJirlVmlMuIjPQBLLjz3VukUBKhdvtJquzYSz9CpcxgMqU
 K0zWSoBgA5gRamuZ8BpcIq3ZCP230ZPyxdCwGv95SPqLja15s4iTpBq565sOiJwOGeO9
 rC/GNEnXyQcafyOkewn/7n7mjMozXFZVR8HsFdw/bhEPuIGWVAcpfi9JzkbndAA+zvsJ 1Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2wa9us7m4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Nov 2019 14:47:09 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5B48110002A;
        Tue, 19 Nov 2019 14:47:08 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4AA872BC7BB;
        Tue, 19 Nov 2019 14:47:08 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 19 Nov 2019 14:47:07
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <sean@poorly.run>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH] drm/modes: remove unused variables
Date:   Tue, 19 Nov 2019 14:47:06 +0100
Message-ID: <20191119134706.10893-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-19_04:2019-11-15,2019-11-19 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling with W=1 few warnings about unused variables show up.
This patch removes all the involved variables.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/gpu/drm/drm_modes.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index 88232698d7a0..aca901aff042 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -233,7 +233,7 @@ struct drm_display_mode *drm_cvt_mode(struct drm_device *dev, int hdisplay,
 		/* 3) Nominal HSync width (% of line period) - default 8 */
 #define CVT_HSYNC_PERCENTAGE	8
 		unsigned int hblank_percentage;
-		int vsyncandback_porch, vback_porch, hblank;
+		int vsyncandback_porch, hblank;
 
 		/* estimated the horizontal period */
 		tmp1 = HV_FACTOR * 1000000  -
@@ -249,7 +249,6 @@ struct drm_display_mode *drm_cvt_mode(struct drm_device *dev, int hdisplay,
 		else
 			vsyncandback_porch = tmp1;
 		/* 10. Find number of lines in back porch */
-		vback_porch = vsyncandback_porch - vsync;
 		drm_mode->vtotal = vdisplay_rnd + 2 * vmargin +
 				vsyncandback_porch + CVT_MIN_V_PORCH;
 		/* 5) Definition of Horizontal blanking time limitation */
@@ -386,9 +385,8 @@ drm_gtf_mode_complex(struct drm_device *dev, int hdisplay, int vdisplay,
 	int top_margin, bottom_margin;
 	int interlace;
 	unsigned int hfreq_est;
-	int vsync_plus_bp, vback_porch;
-	unsigned int vtotal_lines, vfieldrate_est, hperiod;
-	unsigned int vfield_rate, vframe_rate;
+	int vsync_plus_bp;
+	unsigned int vtotal_lines;
 	int left_margin, right_margin;
 	unsigned int total_active_pixels, ideal_duty_cycle;
 	unsigned int hblank, total_pixels, pixel_freq;
@@ -451,23 +449,9 @@ drm_gtf_mode_complex(struct drm_device *dev, int hdisplay, int vdisplay,
 	/* [V SYNC+BP] = RINT(([MIN VSYNC+BP] * hfreq_est / 1000000)) */
 	vsync_plus_bp = MIN_VSYNC_PLUS_BP * hfreq_est / 1000;
 	vsync_plus_bp = (vsync_plus_bp + 500) / 1000;
-	/*  9. Find the number of lines in V back porch alone: */
-	vback_porch = vsync_plus_bp - V_SYNC_RQD;
 	/*  10. Find the total number of lines in Vertical field period: */
 	vtotal_lines = vdisplay_rnd + top_margin + bottom_margin +
 			vsync_plus_bp + GTF_MIN_V_PORCH;
-	/*  11. Estimate the Vertical field frequency: */
-	vfieldrate_est = hfreq_est / vtotal_lines;
-	/*  12. Find the actual horizontal period: */
-	hperiod = 1000000 / (vfieldrate_rqd * vtotal_lines);
-
-	/*  13. Find the actual Vertical field frequency: */
-	vfield_rate = hfreq_est / vtotal_lines;
-	/*  14. Find the Vertical frame frequency: */
-	if (interlaced)
-		vframe_rate = vfield_rate / 2;
-	else
-		vframe_rate = vfield_rate;
 	/*  15. Find number of pixels in left margin: */
 	if (margins)
 		left_margin = (hdisplay_rnd * GTF_MARGIN_PERCENTAGE + 500) /
-- 
2.15.0

