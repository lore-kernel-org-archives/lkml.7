Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC45C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 08:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF73214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 08:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730699AbfHAIjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 04:39:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40262 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfHAIjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 04:39:46 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1ht6cg-0004e0-3p; Thu, 01 Aug 2019 08:39:42 +0000
From:   Colin King <colin.king@canonical.com>
To:     Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][drm-next] drm/amd/powerplay: fix a few spelling mistakes
Date:   Thu,  1 Aug 2019 09:39:41 +0100
Message-Id: <20190801083941.4230-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are a few spelling mistakes "unknow" -> "unknown" and
"enabeld" -> "enabled". Fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 13b2c8a60232..d029a99e600e 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -39,7 +39,7 @@ static const char* __smu_message_names[] = {
 const char *smu_get_message_name(struct smu_context *smu, enum smu_message_type type)
 {
 	if (type < 0 || type > SMU_MSG_MAX_COUNT)
-		return "unknow smu message";
+		return "unknown smu message";
 	return __smu_message_names[type];
 }
 
@@ -52,7 +52,7 @@ static const char* __smu_feature_names[] = {
 const char *smu_get_feature_name(struct smu_context *smu, enum smu_feature_mask feature)
 {
 	if (feature < 0 || feature > SMU_FEATURE_COUNT)
-		return "unknow smu feature";
+		return "unknown smu feature";
 	return __smu_feature_names[feature];
 }
 
@@ -79,7 +79,7 @@ size_t smu_sys_get_pp_feature_mask(struct smu_context *smu, char *buf)
 			       count++,
 			       smu_get_feature_name(smu, i),
 			       feature_index,
-			       !!smu_feature_is_enabled(smu, i) ? "enabeld" : "disabled");
+			       !!smu_feature_is_enabled(smu, i) ? "enabled" : "disabled");
 	}
 
 failed:
-- 
2.20.1

