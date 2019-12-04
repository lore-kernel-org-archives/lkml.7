Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC164C2BD09
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 06:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87CB02184B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 06:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfLDGC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 01:02:27 -0500
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:48164 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfLDGC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 01:02:26 -0500
Received: from localhost.localdomain ([90.126.97.183])
        by mwinf5d51 with ME
        id Zi2M2100G3xPcdm03i2NAd; Wed, 04 Dec 2019 07:02:24 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 04 Dec 2019 07:02:24 +0100
X-ME-IP: 90.126.97.183
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     robdclark@gmail.com, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, jcrouse@codeaurora.org, dianders@chromium.org,
        mamtashukla555@gmail.com
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] drm/msm/a6xx: Fix a typo in an error message
Date:   Wed,  4 Dec 2019 07:02:20 +0100
Message-Id: <20191204060220.12563-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'in' is duplicated in the error message. Axe one of them.
While at it, slighly improve indentation.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 85f14feafdec..d04e631ab3dc 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -1051,8 +1051,8 @@ static int a6xx_gmu_rpmh_arc_votes_init(struct device *dev, u32 *votes,
 
 		if (j == pri_count) {
 			DRM_DEV_ERROR(dev,
-				"Level %u not found in in the RPMh list\n",
-					level);
+				      "Level %u not found in the RPMh list\n",
+				      level);
 			DRM_DEV_ERROR(dev, "Available levels:\n");
 			for (j = 0; j < pri_count; j++)
 				DRM_DEV_ERROR(dev, "  %u\n", pri[j]);
-- 
2.20.1

