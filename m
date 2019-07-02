Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D176C06511
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 12:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3491620836
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 12:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfGBMbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 08:31:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50364 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbfGBMbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 08:31:01 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hiHw0-0000Fa-Jx; Tue, 02 Jul 2019 12:30:56 +0000
From:   Colin King <colin.king@canonical.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display/dce_mem_input: fix spelling mistake "eanble" -> "enable"
Date:   Tue,  2 Jul 2019 13:30:56 +0100
Message-Id: <20190702123056.8205-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a variable name, fix this by renaming
it to enable.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
index a24a2bda8656..07e0cc5a26d4 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
@@ -606,11 +606,11 @@ static void dce_mi_allocate_dmif(
 	}
 
 	if (dce_mi->wa.single_head_rdreq_dmif_limit) {
-		uint32_t eanble =  (total_stream_num > 1) ? 0 :
+		uint32_t enable =  (total_stream_num > 1) ? 0 :
 				dce_mi->wa.single_head_rdreq_dmif_limit;
 
 		REG_UPDATE(MC_HUB_RDREQ_DMIF_LIMIT,
-				ENABLE, eanble);
+				ENABLE, enable);
 	}
 }
 
@@ -636,11 +636,11 @@ static void dce_mi_free_dmif(
 			10, 3500);
 
 	if (dce_mi->wa.single_head_rdreq_dmif_limit) {
-		uint32_t eanble =  (total_stream_num > 1) ? 0 :
+		uint32_t enable =  (total_stream_num > 1) ? 0 :
 				dce_mi->wa.single_head_rdreq_dmif_limit;
 
 		REG_UPDATE(MC_HUB_RDREQ_DMIF_LIMIT,
-				ENABLE, eanble);
+				ENABLE, enable);
 	}
 }
 
-- 
2.20.1

