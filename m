Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F545C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3980820656
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfF1KkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 06:40:10 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:56605 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfF1KkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 06:40:09 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MEmMt-1hneqR1qUl-00GHwL; Fri, 28 Jun 2019 12:39:28 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Lyude Paul <lyude@redhat.com>,
        Uma Shankar <uma.shankar@intel.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Ramalingam C <ramalingam.c@intel.com>,
        Radhakrishna Sripada <radhakrishna.sripada@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: connector: remove bogus NULL check
Date:   Fri, 28 Jun 2019 12:39:05 +0200
Message-Id: <20190628103925.2686249-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:G+y7LV1vsF/Vm55AUncbp7hvJIftzjKCKc7IizEy2E4LX7bp3+s
 Zw7dhRDtUzvEZDId+yfWbpw7nAAKWql8TNlnL1aGyNF4xHXL7NKNptNoY9TGI+Imy9RymzU
 AdTEA6pt6PQT+Me+UmPcFCEuOmU1kr4EdP7bU4i4bQ+Da1W4IrqtrFTFJeF2EfQV+QQRbba
 vqpPkiNLkJs2Q2Mk+srmw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:afF7kKP7CwA=:2IzTp9enG36FNhGD7pD+vz
 CJiQeyTns2tWzHZdGzNZz1vmnjcVF0b1fPoyB5mJl6KhNYkW4LDlOrn/beaVC5aaAa0rmATxD
 x2M3BrQXcYdB08bAUsttlahDS5JlcF/jgJ82LiM+CDmP5Xr7UQRx/hBooV+ujCaDFoNWz0NEE
 lOdoEdAUIBTz0nudc1sk6mZgph3PHth+BBxb6Jv/2CTS6+00MJCJiVw9f6QemhP4ljCxc93+2
 R+P8pQlnD2R3pGXn8c6Ya5KobpGDvnMISmpYVSjiYetnp0bRvpsmyt8T/RS4NZ44NHN9ntCql
 ZbfFxIx0oqY1TUTjAO7BeDhU8+F8/oBQw1ey2ohjRE9LcFvJJYXw5O8KSOBrMs06+diJPkmQM
 1JXExkme8h7pXdYx6rEoNFO+rxSMSNYxNOXGG/yJ/Q99IDsfnHZf5bdiav+U3/QxeDeICGnaF
 xGYetucBIBr+v4iIJ1Kn3D+lHJFfkhIVW+KYzfR7YIfvr7ckBivb3DASpqqKcjkm9zw8NlL44
 18flev/L1SVObA+e+bo1ml5DOV0t+Hv5tuPIk+JOob1vycIiB+LxodkAWk2pFst6ud7ts4Ydm
 LX1l+XP2mMuLPzE+O3/nNy5OPMD5am0ofKA7+q1/eRoA81QTufhDEYYRtw73GL7rM8qm+XRVS
 F+FlqOS8jbESNjPFwY4v4f8vzvx1MQn+Vgs74UoLU4ANk16HRJ05LxgVuzXPCXFX4X+HBzyiU
 BMrDZVYuJlrcBZXG72L43FgzJA3Rxo0E0mzBbA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mode->name is a character array in a structure, checking it's
address is pointless and causes a warning with some compilers:

drivers/gpu/drm/drm_connector.c:144:15: error: address of array 'mode->name' will always evaluate to 'true'
      [-Werror,-Wpointer-bool-conversion]
                      mode->name ? mode->name : "",
                      ~~~~~~^~~~ ~
include/drm/drm_print.h:366:29: note: expanded from macro 'DRM_DEBUG_KMS'
        drm_dbg(DRM_UT_KMS, fmt, ##__VA_ARGS__)
                                   ^~~~~~~~~~~

Remove the check here.

Fixes: 3aeeb13d8996 ("drm/modes: Support modes names on the command line")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/drm_connector.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 3afed5677946..b3f2cf7eae9c 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -141,7 +141,7 @@ static void drm_connector_get_cmdline_mode(struct drm_connector *connector)
 
 	DRM_DEBUG_KMS("cmdline mode for connector %s %s %dx%d@%dHz%s%s%s\n",
 		      connector->name,
-		      mode->name ? mode->name : "",
+		      mode->name,
 		      mode->xres, mode->yres,
 		      mode->refresh_specified ? mode->refresh : 60,
 		      mode->rb ? " reduced blanking" : "",
-- 
2.20.0

