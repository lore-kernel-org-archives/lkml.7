Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0245FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 18:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83BFF21A4C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 18:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="t4Eg8lp1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436507AbfJPSFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 14:05:41 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56200 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390992AbfJPSFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 14:05:41 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9GI5bPc024288;
        Wed, 16 Oct 2019 13:05:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571249137;
        bh=O/Wbj2F5tkZWFNGIP7N39PcXh3SJywRvUwjgfektGIM=;
        h=From:To:CC:Subject:Date;
        b=t4Eg8lp1413Gd1DQJDp95MMv6Wl/NWxlohDJu1oEwIhMRpvLXeriZvTBz0OquXNDY
         q/y7zsWEXWiPglsH1gtBvjxbnCosPM1zmm6YSJFSjAracb4U3l4qw7k3gojKjH4wFw
         UesW4S6nCttBZmz84ywx6ha+03tFxZJkDAHyUo9w=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9GI5bwZ013949
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Oct 2019 13:05:37 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 16
 Oct 2019 13:05:30 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 16 Oct 2019 13:05:30 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9GI5bOF000515;
        Wed, 16 Oct 2019 13:05:37 -0500
Received: from localhost ([10.250.79.55])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x9GI5aZ22393;
        Wed, 16 Oct 2019 13:05:36 -0500 (CDT)
From:   "Andrew F. Davis" <afd@ti.com>
To:     Jiri Kosina <trivial@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
CC:     <linux-fbdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH] omapfb/dss: remove unneeded conversions to bool
Date:   Wed, 16 Oct 2019 14:04:24 -0400
Message-ID: <20191016180424.23907-1-afd@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Found with scripts/coccinelle/misc/boolconv.cocci.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/video/fbdev/omap2/omapfb/dss/dispc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dispc.c b/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
index 376ee5bc3ddc..ce37da85cc45 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
@@ -1635,7 +1635,7 @@ static void dispc_ovl_set_scaling_uv(enum omap_plane plane,
 {
 	int scale_x = out_width != orig_width;
 	int scale_y = out_height != orig_height;
-	bool chroma_upscale = plane != OMAP_DSS_WB ? true : false;
+	bool chroma_upscale = plane != OMAP_DSS_WB;
 
 	if (!dss_has_feature(FEAT_HANDLE_UV_SEPARATE))
 		return;
@@ -3100,9 +3100,9 @@ static bool _dispc_mgr_pclk_ok(enum omap_channel channel,
 		unsigned long pclk)
 {
 	if (dss_mgr_is_lcd(channel))
-		return pclk <= dispc.feat->max_lcd_pclk ? true : false;
+		return pclk <= dispc.feat->max_lcd_pclk;
 	else
-		return pclk <= dispc.feat->max_tv_pclk ? true : false;
+		return pclk <= dispc.feat->max_tv_pclk;
 }
 
 bool dispc_mgr_timings_ok(enum omap_channel channel,
-- 
2.17.1

