Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7911C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 12:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B74D20684
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 12:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbfLCMlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 07:41:24 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:34648 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725997AbfLCMlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 07:41:23 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 87ECA5F4C71101B31B1E;
        Tue,  3 Dec 2019 20:41:21 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Tue, 3 Dec 2019 20:41:15 +0800
From:   Hongbo Yao <yaohongbo@huawei.com>
To:     <linuxarm@huawei.com>, <robdclark@gmail.com>, <sean@poorly.run>,
        <airlied@linux.ie>, <daniel@ffwll.ch>,
        <linux-kernel@vger.kernel.org>
CC:     <yaohongbo@huawei.com>
Subject: [PATCH] drm/msm/dpu: Fix compile warnings
Date:   Tue, 3 Dec 2019 20:38:58 +0800
Message-ID: <20191203123858.17036-1-yaohongbo@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the following command will get compile warnings:
make W=1 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.o ARCH=arm64

drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c: In function
‘_dpu_crtc_program_lm_output_roi’:
drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c:91:19: warning: variable
‘dpu_crtc’ set but not used [-Wunused-but-set-variable]
  struct dpu_crtc *dpu_crtc;
                   ^~~~~~~~
drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c: In function
‘dpu_crtc_atomic_begin’:
drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c:428:35: warning: variable
‘smmu_state’ set but not used [-Wunused-but-set-variable]
  struct dpu_crtc_smmu_state_data *smmu_state;
                                   ^~~~~~~~~~
drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c: In function
‘dpu_crtc_atomic_flush’:
drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c:489:25: warning: variable
‘event_thread’ set but not used [-Wunused-but-set-variable]
  struct msm_drm_thread *event_thread;
                         ^~~~~~~~~~~~
drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c: In function
‘dpu_crtc_destroy_state’:
drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c:565:19: warning: variable
‘dpu_crtc’ set but not used [-Wunused-but-set-variable]
  struct dpu_crtc *dpu_crtc;
                   ^~~~~~~~
drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c: In function
‘dpu_crtc_duplicate_state’:
drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c:664:19: warning: variable
‘dpu_crtc’ set but not used [-Wunused-but-set-variable]
  struct dpu_crtc *dpu_crtc;
                   ^~~~~~~~
drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c: In function
‘dpu_crtc_disable’:
drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c:693:26: warning: variable
‘priv’ set but not used [-Wunused-but-set-variable]
  struct msm_drm_private *priv;
                          ^~~~
drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c:691:27: warning: variable
‘mode’ set but not used [-Wunused-but-set-variable]
  struct drm_display_mode *mode;
                           ^~~~
drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c: In function ‘dpu_crtc_enable’:
drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c:766:26: warning: variable
‘priv’ set but not used [-Wunused-but-set-variable]
  struct msm_drm_private *priv;
                          ^~~~
drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c: In function ‘dpu_crtc_init’:
drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c:1292:18: warning: variable
‘kms’ set but not used [-Wunused-but-set-variable]
  struct dpu_kms *kms = NULL;
                  ^~~
drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c:663: warning: Excess function
parameter 'Returns' description in 'dpu_crtc_duplicate_state'

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Hongbo Yao <yaohongbo@huawei.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index ce59adff06aa..00bf35d2ef24 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -88,11 +88,9 @@ static void _dpu_crtc_setup_blend_cfg(struct dpu_crtc_mixer *mixer,
 
 static void _dpu_crtc_program_lm_output_roi(struct drm_crtc *crtc)
 {
-	struct dpu_crtc *dpu_crtc;
 	struct dpu_crtc_state *crtc_state;
 	int lm_idx, lm_horiz_position;
 
-	dpu_crtc = to_dpu_crtc(crtc);
 	crtc_state = to_dpu_crtc_state(crtc->state);
 
 	lm_horiz_position = 0;
@@ -425,7 +423,6 @@ static void dpu_crtc_atomic_begin(struct drm_crtc *crtc,
 	struct drm_encoder *encoder;
 	struct drm_device *dev;
 	unsigned long flags;
-	struct dpu_crtc_smmu_state_data *smmu_state;
 
 	if (!crtc) {
 		DPU_ERROR("invalid crtc\n");
@@ -443,7 +440,6 @@ static void dpu_crtc_atomic_begin(struct drm_crtc *crtc,
 	dpu_crtc = to_dpu_crtc(crtc);
 	cstate = to_dpu_crtc_state(crtc->state);
 	dev = crtc->dev;
-	smmu_state = &dpu_crtc->smmu_state;
 
 	_dpu_crtc_setup_lm_bounds(crtc, crtc->state);
 
@@ -486,7 +482,6 @@ static void dpu_crtc_atomic_flush(struct drm_crtc *crtc,
 	struct drm_device *dev;
 	struct drm_plane *plane;
 	struct msm_drm_private *priv;
-	struct msm_drm_thread *event_thread;
 	unsigned long flags;
 	struct dpu_crtc_state *cstate;
 
@@ -508,8 +503,6 @@ static void dpu_crtc_atomic_flush(struct drm_crtc *crtc,
 		return;
 	}
 
-	event_thread = &priv->event_thread[crtc->index];
-
 	if (dpu_crtc->event) {
 		DPU_DEBUG("already received dpu_crtc->event\n");
 	} else {
@@ -562,7 +555,6 @@ static void dpu_crtc_atomic_flush(struct drm_crtc *crtc,
 static void dpu_crtc_destroy_state(struct drm_crtc *crtc,
 		struct drm_crtc_state *state)
 {
-	struct dpu_crtc *dpu_crtc;
 	struct dpu_crtc_state *cstate;
 
 	if (!crtc || !state) {
@@ -570,7 +562,6 @@ static void dpu_crtc_destroy_state(struct drm_crtc *crtc,
 		return;
 	}
 
-	dpu_crtc = to_dpu_crtc(crtc);
 	cstate = to_dpu_crtc_state(state);
 
 	DPU_DEBUG("crtc%d\n", crtc->base.id);
@@ -657,11 +648,9 @@ static void dpu_crtc_reset(struct drm_crtc *crtc)
 /**
  * dpu_crtc_duplicate_state - state duplicate hook
  * @crtc: Pointer to drm crtc structure
- * @Returns: Pointer to new drm_crtc_state structure
  */
 static struct drm_crtc_state *dpu_crtc_duplicate_state(struct drm_crtc *crtc)
 {
-	struct dpu_crtc *dpu_crtc;
 	struct dpu_crtc_state *cstate, *old_cstate;
 
 	if (!crtc || !crtc->state) {
@@ -669,7 +658,6 @@ static struct drm_crtc_state *dpu_crtc_duplicate_state(struct drm_crtc *crtc)
 		return NULL;
 	}
 
-	dpu_crtc = to_dpu_crtc(crtc);
 	old_cstate = to_dpu_crtc_state(crtc->state);
 	cstate = kmemdup(old_cstate, sizeof(*old_cstate), GFP_KERNEL);
 	if (!cstate) {
@@ -688,9 +676,7 @@ static void dpu_crtc_disable(struct drm_crtc *crtc,
 {
 	struct dpu_crtc *dpu_crtc;
 	struct dpu_crtc_state *cstate;
-	struct drm_display_mode *mode;
 	struct drm_encoder *encoder;
-	struct msm_drm_private *priv;
 	unsigned long flags;
 	bool release_bandwidth = false;
 
@@ -700,8 +686,6 @@ static void dpu_crtc_disable(struct drm_crtc *crtc,
 	}
 	dpu_crtc = to_dpu_crtc(crtc);
 	cstate = to_dpu_crtc_state(crtc->state);
-	mode = &cstate->base.adjusted_mode;
-	priv = crtc->dev->dev_private;
 
 	DRM_DEBUG_KMS("crtc%d\n", crtc->base.id);
 
@@ -763,14 +747,12 @@ static void dpu_crtc_enable(struct drm_crtc *crtc,
 {
 	struct dpu_crtc *dpu_crtc;
 	struct drm_encoder *encoder;
-	struct msm_drm_private *priv;
 	bool request_bandwidth;
 
 	if (!crtc || !crtc->dev || !crtc->dev->dev_private) {
 		DPU_ERROR("invalid crtc\n");
 		return;
 	}
-	priv = crtc->dev->dev_private;
 
 	pm_runtime_get_sync(crtc->dev->dev);
 
@@ -1288,13 +1270,8 @@ struct drm_crtc *dpu_crtc_init(struct drm_device *dev, struct drm_plane *plane,
 {
 	struct drm_crtc *crtc = NULL;
 	struct dpu_crtc *dpu_crtc = NULL;
-	struct msm_drm_private *priv = NULL;
-	struct dpu_kms *kms = NULL;
 	int i;
 
-	priv = dev->dev_private;
-	kms = to_dpu_kms(priv->kms);
-
 	dpu_crtc = kzalloc(sizeof(*dpu_crtc), GFP_KERNEL);
 	if (!dpu_crtc)
 		return ERR_PTR(-ENOMEM);
-- 
2.20.1

