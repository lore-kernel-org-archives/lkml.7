Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55CCC352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 12:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90FF421929
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 12:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbfJBMC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 08:02:58 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:53363 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfJBMC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 08:02:58 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N6srH-1i4Jx02kQB-018Nqd; Wed, 02 Oct 2019 14:02:49 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     clang-built-linux@googlegroups.com, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Arnd Bergmann <arnd@arndb.de>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Subject: [PATCH 3/6] drm/amdgpu: display_mode_vba_21: remove uint typedef
Date:   Wed,  2 Oct 2019 14:01:24 +0200
Message-Id: <20191002120136.1777161-4-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191002120136.1777161-1-arnd@arndb.de>
References: <20191002120136.1777161-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:oBjKGQ3jYf0A2J2ocemwNHrJLF3mvVMEn6zOLTNAGubueuLRYyk
 BpOHFj8UwLoAn+bAxDpM0Us8z6MwyTwhFaeTAJtXgpd1gN2qJVEkpNfIB76daOLbh6I9g1g
 ahi1mLhjBji4qSGK5wctAS/ZXegSzGKfel5KNAxFR+4Ew0SuQO7JYnxKngDUC1t/3w0hgkw
 0QdnYpJY4kkYs3R/f4iCg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eSQ5Yr5a9oE=:9FRtoMlN7bwSrOG9f5YY1I
 bpZ3Qlyhsku0LcpbDJu5j1GigQk6vUWd/VoWhAWdlLLxtXK+BCdOiQtpfBiQFZdP8FLJ26cuR
 kV5qGa3w8U+kaC94DSFBi0lHTB2sNsHBjsd2p8WvqTLIZwirBsTcidrQkvC2sa1DPz0RHHLd8
 U9Vnvws8HuDgF+P7zwa3qcikMwSX3nStW4yO3wtkWdKwr6Uglr1x0i8/QF3LCtLtK4FEzrZVg
 bM4cQCIHQZpPin18GxcI5pwvpk2Qgoml/0vjZaUvLxFLn2V4iCWTtG43DqQmNKwH+Uu5EPbFE
 XKXWZUhX8b8lTqAqeEI30b2ahQc932Gp2k9HLD4BRhgWp8Ig9EQRTUgQKWSsTHSTnQtU1cNv+
 4wMcWJOh0Doxtl6hUiJzmGCWOFc2YYIcQ9ELhsb9uoUBPdrVP4Cjrk1ffgCIZs6HhA7bvk7NE
 EZVguXf2MjBwrvsRdR3dXp5q2dELksAz89Tywytd8DQjNspuSufMllFGCsbJxVOgVSEnevN5g
 fKYidaTAnk8c1QQo9w9YM1DRwbCfHfDbJUTn+5ROSNw8cDuvGt7AjNVZUyBKhRUS3S6hrk7I5
 34ybrIVzQiMV1ahqKIPXzQ0zPNdkHLSJNEc5Zt0ixZByldmxHwcytbpqPiVd3k++zjnk1lmAh
 Cmv0SEdjvSfss1GwwRbvWZi8aTQH32JG2l9zkRPg7Dnv9F3dDWn4s9meRO7HnvAqZHffcxad3
 vMQ1fsnJ20Ma1FOm07EGM6aLkWoypGrNlbx+lKhhjGOg0kBUxqdy1pVidgfcwS403HhTEwiuL
 BlKxnY8Yx/kkAUL/1tXVJvhmg2XNXfg78iWD6M/9MmC8aZWKvP915zIr6FNADpRBtcjNi4JOp
 8nnSZfI7XGVLOMcy5tjQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The type definition for 'uint' clashes with the generic kernel
headers:

drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn21/display_mode_vba_21.c:43:22: error: redefinition of typedef 'uint' is a C11 feature [-Werror,-Wtypedef-redefinition]
include/linux/types.h:92:23: note: previous definition is here

Just remove this type and use plain 'unsigned int' consistently,
as it is already use almost everywhere in this file.

Fixes: b04641a3f4c5 ("drm/amd/display: Add Renoir DML")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 .../amd/display/dc/dml/dcn21/display_mode_vba_21.c  | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
index 46cda85d3d63..998970e2f84c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
@@ -39,9 +39,6 @@
  * ways. Unless there is something clearly wrong with it the code should
  * remain as-is as it provides us with a guarantee from HW that it is correct.
  */
-
-typedef unsigned int uint;
-
 typedef struct {
 	amdgpu_dc_double DPPCLK;
 	amdgpu_dc_double DISPCLK;
@@ -4774,7 +4771,7 @@ void dml21_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 				mode_lib->vba.MaximumReadBandwidthWithoutPrefetch = 0.0;
 				mode_lib->vba.MaximumReadBandwidthWithPrefetch = 0.0;
 				for (k = 0; k <= mode_lib->vba.NumberOfActivePlanes - 1; k++) {
-					uint m;
+					unsigned int m;
 
 					locals->cursor_bw[k] = 0;
 					locals->cursor_bw_pre[k] = 0;
@@ -5285,7 +5282,7 @@ static void CalculateWatermarksAndDRAMSpeedChangeSupport(
 	amdgpu_dc_double SecondMinActiveDRAMClockChangeMarginOneDisplayInVBLank;
 	amdgpu_dc_double FullDETBufferingTimeYStutterCriticalPlane = 0;
 	amdgpu_dc_double TimeToFinishSwathTransferStutterCriticalPlane = 0;
-	uint k, j;
+	unsigned int k, j;
 
 	mode_lib->vba.TotalActiveDPP = 0;
 	mode_lib->vba.TotalDCCActiveDPP = 0;
@@ -5507,7 +5504,7 @@ static void CalculateDCFCLKDeepSleep(
 		amdgpu_dc_double DPPCLK[],
 		amdgpu_dc_double *DCFCLKDeepSleep)
 {
-	uint k;
+	unsigned int k;
 	amdgpu_dc_double DisplayPipeLineDeliveryTimeLuma;
 	amdgpu_dc_double DisplayPipeLineDeliveryTimeChroma;
 	//amdgpu_dc_double   DCFCLKDeepSleepPerPlane[DC__NUM_DPP__MAX];
@@ -5727,7 +5724,7 @@ static void CalculatePixelDeliveryTimes(
 		amdgpu_dc_double DisplayPipeRequestDeliveryTimeChromaPrefetch[])
 {
 	amdgpu_dc_double req_per_swath_ub;
-	uint k;
+	unsigned int k;
 
 	for (k = 0; k < NumberOfActivePlanes; ++k) {
 		if (VRatio[k] <= 1) {
@@ -5869,7 +5866,7 @@ static void CalculateMetaAndPTETimes(
 	unsigned int dpte_groups_per_row_chroma_ub;
 	unsigned int num_group_per_lower_vm_stage;
 	unsigned int num_req_per_lower_vm_stage;
-	uint k;
+	unsigned int k;
 
 	for (k = 0; k < NumberOfActivePlanes; ++k) {
 		if (GPUVMEnable == true) {
-- 
2.20.0

