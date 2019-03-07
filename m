Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1939EC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E631120652
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfCGPxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:53:40 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:41615 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfCGPxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:53:39 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MekKJ-1gTgZs3yVh-00akPg; Thu, 07 Mar 2019 16:53:26 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, dri-devel@lists.freedesktop.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/stm: fix CONFIG_FB dependency
Date:   Thu,  7 Mar 2019 16:53:14 +0100
Message-Id: <20190307155323.2949975-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:cGeAUO8B0pPL+6GrxfyVPhHZVXyUhkXKXDHcs0djJ5BWC1J0m8Y
 zzEXLJ0gNERhK32hsBSZ17r0gi3mwakR2qTn+I5P0BaJzoy8PbGKj5maWOswrN/8FFlFFsd
 W0VBNDs2x/2YhTOumQa9Fzi+me/8rzQy0H7VFUaIP5bUtGHg4RRYZB56vuPRrEoJ+tgHu8K
 94Tw4LGhjq8S46zSlH6Ag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nfHIGyaxpPs=:c0QVHjAYx2QoCGFoeSYo5E
 hZEAXIbHIg5BF9hgiu/p/T/MD1Ud5oyk06CJ80KNyhPkGM9vfNpstmsXSmq9plCD0czcxpH8M
 c9mSnZDIuE0sCzXu77YzRTnudhWc+PfyBNNOF5xntWdHhfL6Y91yq89TF5ClLsHmWmpjF3zpA
 EDp7Qw+huMuKyTGhN6eqgOi96LC+HYkZB7/F9ZVHbmpRew+IIUdWyWafXpXecFA2kk2pxEmbI
 9lXwyETbusHgENQVn+T1Sme6hGlNmPO+L2jVWGGBGqXeELBv/T6gwNyTYTOZvdI4zQQ72V3EM
 VEAjlCryqJ2W+ehV6yEpSL22o2F/m3pMVfB8tDot2OuLY8IzItlugZiAj+ZhD5T8o1pRKHb7h
 NruKiKp1lHGQlVZpIOY8MHuE9mgAZDC9hD4lD7V5lREtahqWSHCk8rBvnOKy72V2cjgkhQIYO
 Kfyv2kMhFIm3uaaqPEgQToFZ6Y9NfryFl+hlYqQJszUTGTaJudZD1t6+XHC3aYO8qDDK7a0Gf
 qMesTfRll6NqirCKuMTs3l5ibCKRctM0hSByDcEhZYToJJ4HsFR7Z4UHt1kVNvWzp3/4x2dwp
 zJdd64O9x08s67W78TtsMi4L/8PSuXqswzrfWQNmvRQhLILG+IGLC79qHfYUsOwfIg0rCNQR7
 ioOED6bAS0Wbc7+RR0AqyUl+z0Vg4EzQn8kogka7m29uXt7JlDhJx3RCSThcva0ZCiOm+Bg37
 Xdi9GeocSsp0zmG+qonz0GmT6tQyyEpUOOpihQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DRM_STM driver can be built independently of the framebuffer
layer, but it causes a Kconfig warning:

WARNING: unmet direct dependencies detected for FB_PROVIDE_GET_FB_UNMAPPED_AREA
  Depends on [n]: HAS_IOMEM [=y] && FB [=n]
  Selected by [y]:
  - DRM_STM [=y] && HAS_IOMEM [=y] && DRM [=y] && (ARCH_STM32 [=n] || ARCH_MULTIPLATFORM [=y])

Selecting FB_PROVIDE_GET_FB_UNMAPPED_AREA actually has no effect
if CONFIG_FB is disabled, so we can make it a conditional 'select'
instead.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/stm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/stm/Kconfig b/drivers/gpu/drm/stm/Kconfig
index 35367ada3bc1..d15b10de1da6 100644
--- a/drivers/gpu/drm/stm/Kconfig
+++ b/drivers/gpu/drm/stm/Kconfig
@@ -6,7 +6,7 @@ config DRM_STM
 	select DRM_KMS_CMA_HELPER
 	select DRM_PANEL_BRIDGE
 	select VIDEOMODE_HELPERS
-	select FB_PROVIDE_GET_FB_UNMAPPED_AREA
+	select FB_PROVIDE_GET_FB_UNMAPPED_AREA if FB
 
 	help
 	  Enable support for the on-chip display controller on
-- 
2.20.0

