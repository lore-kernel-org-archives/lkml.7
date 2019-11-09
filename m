Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75EDC43331
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 19:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99511215EA
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 19:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfKITt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 14:49:29 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:39976 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfKITt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 14:49:29 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iTWjb-00082x-Pg; Sat, 09 Nov 2019 19:49:23 +0000
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
Subject: [PATCH][next] drm/amd/display: fix spelling mistake "exeuction" -> "execution"
Date:   Sat,  9 Nov 2019 19:49:23 +0000
Message-Id: <20191109194923.231655-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are spelling mistakes in a DC_ERROR message and a comment.
Fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c    | 2 +-
 drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 61cefe0a3790..b65b66025267 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -92,7 +92,7 @@ void dc_dmub_srv_cmd_execute(struct dc_dmub_srv *dc_dmub_srv)
 
 	status = dmub_srv_cmd_execute(dmub);
 	if (status != DMUB_STATUS_OK)
-		DC_ERROR("Error starting DMUB exeuction: status=%d\n", status);
+		DC_ERROR("Error starting DMUB execution: status=%d\n", status);
 }
 
 void dc_dmub_srv_wait_idle(struct dc_dmub_srv *dc_dmub_srv)
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h
index aa8f0396616d..45e427d1952e 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h
@@ -416,7 +416,7 @@ enum dmub_status dmub_srv_cmd_queue(struct dmub_srv *dmub,
  * dmub_srv_cmd_execute() - Executes a queued sequence to the dmub
  * @dmub: the dmub service
  *
- * Begins exeuction of queued commands on the dmub.
+ * Begins execution of queued commands on the dmub.
  *
  * Return:
  *   DMUB_STATUS_OK - success
-- 
2.20.1

