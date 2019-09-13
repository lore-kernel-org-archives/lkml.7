Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07ECC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 08:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C15E9207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 08:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729156AbfIMICy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 04:02:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47983 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727997AbfIMICx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 04:02:53 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1i8gXY-0004uO-Ub; Fri, 13 Sep 2019 08:02:49 +0000
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
Subject: [PATCH] drm/amd/display: rename variable eanble -> enable
Date:   Fri, 13 Sep 2019 09:02:48 +0100
Message-Id: <20190913080248.28695-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in the variable name eanble,
rename it to enable.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
index 1488ffddf4e3..5944524faab9 100644
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

