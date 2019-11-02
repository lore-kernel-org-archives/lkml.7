Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFE8CA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 22:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 888E420862
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 22:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfKBWda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 18:33:30 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59058 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfKBWda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 18:33:30 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iR1xU-0005bB-2Y; Sat, 02 Nov 2019 22:33:24 +0000
From:   Colin King <colin.king@canonical.com>
To:     Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/powerplay: fix spelling mistake "Attemp" -> "Attempt"
Date:   Sat,  2 Nov 2019 22:33:23 +0000
Message-Id: <20191102223323.8453-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are spelling mistakes in assert messages, fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c | 12 ++++++------
 drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c | 12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c
index 90c782c132d2..43190fa2bb33 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/vega12_smumgr.c
@@ -125,20 +125,20 @@ int vega12_enable_smc_features(struct pp_hwmgr *hwmgr,
 	if (enable) {
 		PP_ASSERT_WITH_CODE(smu9_send_msg_to_smc_with_parameter(hwmgr,
 				PPSMC_MSG_EnableSmuFeaturesLow, smu_features_low) == 0,
-				"[EnableDisableSMCFeatures] Attemp to enable SMU features Low failed!",
+				"[EnableDisableSMCFeatures] Attempt to enable SMU features Low failed!",
 				return -EINVAL);
 		PP_ASSERT_WITH_CODE(smu9_send_msg_to_smc_with_parameter(hwmgr,
 				PPSMC_MSG_EnableSmuFeaturesHigh, smu_features_high) == 0,
-				"[EnableDisableSMCFeatures] Attemp to enable SMU features High failed!",
+				"[EnableDisableSMCFeatures] Attempt to enable SMU features High failed!",
 				return -EINVAL);
 	} else {
 		PP_ASSERT_WITH_CODE(smu9_send_msg_to_smc_with_parameter(hwmgr,
 				PPSMC_MSG_DisableSmuFeaturesLow, smu_features_low) == 0,
-				"[EnableDisableSMCFeatures] Attemp to disable SMU features Low failed!",
+				"[EnableDisableSMCFeatures] Attempt to disable SMU features Low failed!",
 				return -EINVAL);
 		PP_ASSERT_WITH_CODE(smu9_send_msg_to_smc_with_parameter(hwmgr,
 				PPSMC_MSG_DisableSmuFeaturesHigh, smu_features_high) == 0,
-				"[EnableDisableSMCFeatures] Attemp to disable SMU features High failed!",
+				"[EnableDisableSMCFeatures] Attempt to disable SMU features High failed!",
 				return -EINVAL);
 	}
 
@@ -155,13 +155,13 @@ int vega12_get_enabled_smc_features(struct pp_hwmgr *hwmgr,
 
 	PP_ASSERT_WITH_CODE(smu9_send_msg_to_smc(hwmgr,
 			PPSMC_MSG_GetEnabledSmuFeaturesLow) == 0,
-			"[GetEnabledSMCFeatures] Attemp to get SMU features Low failed!",
+			"[GetEnabledSMCFeatures] Attempt to get SMU features Low failed!",
 			return -EINVAL);
 	smc_features_low = smu9_get_argument(hwmgr);
 
 	PP_ASSERT_WITH_CODE(smu9_send_msg_to_smc(hwmgr,
 			PPSMC_MSG_GetEnabledSmuFeaturesHigh) == 0,
-			"[GetEnabledSMCFeatures] Attemp to get SMU features High failed!",
+			"[GetEnabledSMCFeatures] Attempt to get SMU features High failed!",
 			return -EINVAL);
 	smc_features_high = smu9_get_argument(hwmgr);
 
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c
index f604612f411f..562cb221f186 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c
@@ -310,20 +310,20 @@ int vega20_enable_smc_features(struct pp_hwmgr *hwmgr,
 	if (enable) {
 		PP_ASSERT_WITH_CODE((ret = vega20_send_msg_to_smc_with_parameter(hwmgr,
 				PPSMC_MSG_EnableSmuFeaturesLow, smu_features_low)) == 0,
-				"[EnableDisableSMCFeatures] Attemp to enable SMU features Low failed!",
+				"[EnableDisableSMCFeatures] Attempt to enable SMU features Low failed!",
 				return ret);
 		PP_ASSERT_WITH_CODE((ret = vega20_send_msg_to_smc_with_parameter(hwmgr,
 				PPSMC_MSG_EnableSmuFeaturesHigh, smu_features_high)) == 0,
-				"[EnableDisableSMCFeatures] Attemp to enable SMU features High failed!",
+				"[EnableDisableSMCFeatures] Attempt to enable SMU features High failed!",
 				return ret);
 	} else {
 		PP_ASSERT_WITH_CODE((ret = vega20_send_msg_to_smc_with_parameter(hwmgr,
 				PPSMC_MSG_DisableSmuFeaturesLow, smu_features_low)) == 0,
-				"[EnableDisableSMCFeatures] Attemp to disable SMU features Low failed!",
+				"[EnableDisableSMCFeatures] Attempt to disable SMU features Low failed!",
 				return ret);
 		PP_ASSERT_WITH_CODE((ret = vega20_send_msg_to_smc_with_parameter(hwmgr,
 				PPSMC_MSG_DisableSmuFeaturesHigh, smu_features_high)) == 0,
-				"[EnableDisableSMCFeatures] Attemp to disable SMU features High failed!",
+				"[EnableDisableSMCFeatures] Attempt to disable SMU features High failed!",
 				return ret);
 	}
 
@@ -341,12 +341,12 @@ int vega20_get_enabled_smc_features(struct pp_hwmgr *hwmgr,
 
 	PP_ASSERT_WITH_CODE((ret = vega20_send_msg_to_smc(hwmgr,
 			PPSMC_MSG_GetEnabledSmuFeaturesLow)) == 0,
-			"[GetEnabledSMCFeatures] Attemp to get SMU features Low failed!",
+			"[GetEnabledSMCFeatures] Attempt to get SMU features Low failed!",
 			return ret);
 	smc_features_low = vega20_get_argument(hwmgr);
 	PP_ASSERT_WITH_CODE((ret = vega20_send_msg_to_smc(hwmgr,
 			PPSMC_MSG_GetEnabledSmuFeaturesHigh)) == 0,
-			"[GetEnabledSMCFeatures] Attemp to get SMU features High failed!",
+			"[GetEnabledSMCFeatures] Attempt to get SMU features High failed!",
 			return ret);
 	smc_features_high = vega20_get_argument(hwmgr);
 
-- 
2.20.1

