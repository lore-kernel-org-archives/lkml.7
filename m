Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577C1CA9EAB
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 07:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ED4E222D1
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 07:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbfJSHej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 03:34:39 -0400
Received: from mta-08-4.privateemail.com ([198.54.122.58]:4647 "EHLO
        MTA-08-4.privateemail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfJSHeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 03:34:37 -0400
Received: from MTA-08.privateemail.com (localhost [127.0.0.1])
        by MTA-08.privateemail.com (Postfix) with ESMTP id 9E6DB60052;
        Sat, 19 Oct 2019 03:34:37 -0400 (EDT)
Received: from wambui.zuku.co.ke (unknown [10.20.151.244])
        by MTA-08.privateemail.com (Postfix) with ESMTPA id 0839C60051;
        Sat, 19 Oct 2019 07:34:33 +0000 (UTC)
From:   Wambui Karuga <wambui@karuga.xyz>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, alexander.deucher@amd.com,
        christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH] drm/amd/amdgpu: correct length misspelling
Date:   Sat, 19 Oct 2019 10:34:30 +0300
Message-Id: <20191019073430.22093-1-wambui@karuga.xyz>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct the "_LENTH" mispelling in the AMDGPU_MAX_TIMEOUT_PARAM_LENGTH
constant.

Signed-off-by: Wambui Karuga <wambui@karuga.xyz>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index c5b3c0c9193b..aaab37833659 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -86,7 +86,7 @@
 #define KMS_DRIVER_MINOR	34
 #define KMS_DRIVER_PATCHLEVEL	0
 
-#define AMDGPU_MAX_TIMEOUT_PARAM_LENTH	256
+#define AMDGPU_MAX_TIMEOUT_PARAM_LENGTH	256
 
 int amdgpu_vram_limit = 0;
 int amdgpu_vis_vram_limit = 0;
@@ -100,7 +100,7 @@ int amdgpu_disp_priority = 0;
 int amdgpu_hw_i2c = 0;
 int amdgpu_pcie_gen2 = -1;
 int amdgpu_msi = -1;
-static char amdgpu_lockup_timeout[AMDGPU_MAX_TIMEOUT_PARAM_LENTH];
+static char amdgpu_lockup_timeout[AMDGPU_MAX_TIMEOUT_PARAM_LENGTH];
 int amdgpu_dpm = -1;
 int amdgpu_fw_load_type = -1;
 int amdgpu_aspm = -1;
@@ -1327,9 +1327,9 @@ int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
 	adev->sdma_timeout = adev->video_timeout = adev->gfx_timeout;
 	adev->compute_timeout = MAX_SCHEDULE_TIMEOUT;
 
-	if (strnlen(input, AMDGPU_MAX_TIMEOUT_PARAM_LENTH)) {
+	if (strnlen(input, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH)) {
 		while ((timeout_setting = strsep(&input, ",")) &&
-				strnlen(timeout_setting, AMDGPU_MAX_TIMEOUT_PARAM_LENTH)) {
+				strnlen(timeout_setting, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH)) {
 			ret = kstrtol(timeout_setting, 0, &timeout);
 			if (ret)
 				return ret;
-- 
2.23.0

