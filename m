Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFBAC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 20:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 102F320B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 20:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfHIUNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 16:13:18 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:28055 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfHIUNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 16:13:17 -0400
Received: from localhost.localdomain ([92.140.207.10])
        by mwinf5d28 with ME
        id n8DA2000G0Dzhgk038DAPq; Fri, 09 Aug 2019 22:13:14 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 09 Aug 2019 22:13:14 +0200
X-ME-IP: 92.140.207.10
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] drm/amd/display: Fix a typo - dce_aduio_mask --> dce_audio_mask
Date:   Fri,  9 Aug 2019 22:12:19 +0200
Message-Id: <20190809201219.629-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This should be 'dce_audio_mask', not 'dce_aduio_mask'.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_audio.c          | 2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_audio.h          | 6 +++---
 drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c   | 2 +-
 8 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
index 549704998f84..1e88c5f46be7 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
@@ -937,7 +937,7 @@ struct audio *dce_audio_create(
 		unsigned int inst,
 		const struct dce_audio_registers *reg,
 		const struct dce_audio_shift *shifts,
-		const struct dce_aduio_mask *masks
+		const struct dce_audio_mask *masks
 		)
 {
 	struct dce_audio *audio = kzalloc(sizeof(*audio), GFP_KERNEL);
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.h b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.h
index a0d5724aab31..1392fab0860b 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.h
@@ -101,7 +101,7 @@ struct dce_audio_shift {
 	uint32_t DCCG_AUDIO_DTO1_USE_512FBR_DTO;
 };
 
-struct dce_aduio_mask {
+struct dce_audio_mask {
 	uint32_t AZALIA_ENDPOINT_REG_INDEX;
 	uint32_t AZALIA_ENDPOINT_REG_DATA;
 
@@ -125,7 +125,7 @@ struct dce_audio {
 	struct audio base;
 	const struct dce_audio_registers *regs;
 	const struct dce_audio_shift *shifts;
-	const struct dce_aduio_mask *masks;
+	const struct dce_audio_mask *masks;
 };
 
 struct audio *dce_audio_create(
@@ -133,7 +133,7 @@ struct audio *dce_audio_create(
 		unsigned int inst,
 		const struct dce_audio_registers *reg,
 		const struct dce_audio_shift *shifts,
-		const struct dce_aduio_mask *masks);
+		const struct dce_audio_mask *masks);
 
 void dce_aud_destroy(struct audio **audio);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
index 6248c8455314..81116286b15b 100644
--- a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
@@ -304,7 +304,7 @@ static const struct dce_audio_shift audio_shift = {
 		AUD_COMMON_MASK_SH_LIST(__SHIFT)
 };
 
-static const struct dce_aduio_mask audio_mask = {
+static const struct dce_audio_mask audio_mask = {
 		AUD_COMMON_MASK_SH_LIST(_MASK)
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
index 764329264c3b..765e26454a18 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
@@ -331,7 +331,7 @@ static const struct dce_audio_shift audio_shift = {
 		AUD_COMMON_MASK_SH_LIST(__SHIFT)
 };
 
-static const struct dce_aduio_mask audio_mask = {
+static const struct dce_audio_mask audio_mask = {
 		AUD_COMMON_MASK_SH_LIST(_MASK)
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
index c6136e0ed1a4..3ac4c7e73050 100644
--- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
@@ -337,7 +337,7 @@ static const struct dce_audio_shift audio_shift = {
 		AUD_COMMON_MASK_SH_LIST(__SHIFT)
 };
 
-static const struct dce_aduio_mask audio_mask = {
+static const struct dce_audio_mask audio_mask = {
 		AUD_COMMON_MASK_SH_LIST(_MASK)
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
index 54be7ab370df..9a922cd39cf2 100644
--- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
@@ -352,7 +352,7 @@ static const struct dce_audio_shift audio_shift = {
 		DCE120_AUD_COMMON_MASK_SH_LIST(__SHIFT)
 };
 
-static const struct dce_aduio_mask audio_mask = {
+static const struct dce_audio_mask audio_mask = {
 		DCE120_AUD_COMMON_MASK_SH_LIST(_MASK)
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
index 860a524ebcfa..2a1ce9ecc66e 100644
--- a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
@@ -322,7 +322,7 @@ static const struct dce_audio_shift audio_shift = {
 		AUD_COMMON_MASK_SH_LIST(__SHIFT)
 };
 
-static const struct dce_aduio_mask audio_mask = {
+static const struct dce_audio_mask audio_mask = {
 		AUD_COMMON_MASK_SH_LIST(_MASK)
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
index 1a20461c2937..1c5835975935 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
@@ -270,7 +270,7 @@ static const struct dce_audio_shift audio_shift = {
 		DCE120_AUD_COMMON_MASK_SH_LIST(__SHIFT)
 };
 
-static const struct dce_aduio_mask audio_mask = {
+static const struct dce_audio_mask audio_mask = {
 		DCE120_AUD_COMMON_MASK_SH_LIST(_MASK)
 };
 
-- 
2.20.1

