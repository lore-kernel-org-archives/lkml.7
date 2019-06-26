Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC32BC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA2362147A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfFZNYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 09:24:33 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49060 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfFZNYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 09:24:33 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hg7uW-0008DR-43; Wed, 26 Jun 2019 13:24:28 +0000
From:   Colin King <colin.king@canonical.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nikola Cornij <nikola.cornij@amd.com>,
        Wenjing Liu <Wenjing.Liu@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next[ drm/amd/display: fix a couple of spelling mistakes
Date:   Wed, 26 Jun 2019 14:24:27 +0100
Message-Id: <20190626132427.12615-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are a couple of spelling mistakes in dm_error messages and
a comment. Fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c      | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
index be49fc7f4abe..ffd0014ec3b5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
@@ -126,7 +126,7 @@ static void dsc2_get_enc_caps(struct dsc_enc_caps *dsc_enc_caps, int pixel_clock
 
 	/* Maximum total throughput with all the slices combined. This is different from how DP spec specifies it.
 	 * Our decoder's total throughput in Pix/s is equal to DISPCLK. This is then shared between slices.
-	 * The value below is the absolute maximum value. The actual througput may be lower, but it'll always
+	 * The value below is the absolute maximum value. The actual throughput may be lower, but it'll always
 	 * be sufficient to process the input pixel rate fed into a single DSC engine.
 	 */
 	dsc_enc_caps->max_total_throughput_mps = DCN20_MAX_DISPLAY_CLOCK_Mhz;
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
index 77e7a0f8a527..ef5f84a144c3 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -47,7 +47,7 @@ static bool dsc_buff_block_size_from_dpcd(int dpcd_buff_block_size, int *buff_bl
 		*buff_block_size = 64 * 1024;
 		break;
 	default: {
-			dm_error("%s: DPCD DSC buffer size not recoginzed.\n", __func__);
+			dm_error("%s: DPCD DSC buffer size not recognized.\n", __func__);
 			return false;
 		}
 	}
@@ -63,7 +63,7 @@ static bool dsc_line_buff_depth_from_dpcd(int dpcd_line_buff_bit_depth, int *lin
 	else if (dpcd_line_buff_bit_depth == 8)
 		*line_buff_bit_depth = 8;
 	else {
-		dm_error("%s: DPCD DSC buffer depth not recoginzed.\n", __func__);
+		dm_error("%s: DPCD DSC buffer depth not recognized.\n", __func__);
 		return false;
 	}
 
@@ -123,7 +123,7 @@ static bool dsc_throughput_from_dpcd(int dpcd_throughput, int *throughput)
 		*throughput = 1000;
 		break;
 	default: {
-			dm_error("%s: DPCD DSC througput mode not recoginzed.\n", __func__);
+			dm_error("%s: DPCD DSC throughput mode not recognized.\n", __func__);
 			return false;
 		}
 	}
@@ -152,7 +152,7 @@ static bool dsc_bpp_increment_div_from_dpcd(int bpp_increment_dpcd, uint32_t *bp
 		*bpp_increment_div = 1;
 		break;
 	default: {
-		dm_error("%s: DPCD DSC bits-per-pixel increment not recoginzed.\n", __func__);
+		dm_error("%s: DPCD DSC bits-per-pixel increment not recognized.\n", __func__);
 		return false;
 	}
 	}
-- 
2.20.1

