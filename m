Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592DEC606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 13:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE2E20844
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 13:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731439AbfGHNrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 09:47:33 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:46091 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728461AbfGHNrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 09:47:33 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MsqIi-1idXVd2xaq-00tCtF; Mon, 08 Jul 2019 15:47:09 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/exynos: add CONFIG_MMU dependency
Date:   Mon,  8 Jul 2019 15:46:51 +0200
Message-Id: <20190708134707.538501-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Axu85VajvoAR0wMxnciqB+GEFg6pSh3s41QC4py5g9oaTINzJOU
 UZTGHhbajCJ3JGbZmqfhTRCufcbapkbWIlxE2O6YC/PYBuj6T1Xc+KMLQ61WIPq+oD2194n
 CwfP9Yz4bxTS7rQpc1m0RFG+9Hhz5UTlg9Rdj5gGR44o4kixJuGca+25o7R7dEIlRK13gXG
 gCAopP2RQqbNVKGh6VcHw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wnjssiFpvxA=:HTMu8pLHDd0+KCxZo8b6Wn
 e+rAuNkumRK+K4Z/GKOoxrneL/xy7278A61Y67M6KOB+P062stKVyfD7Az5cOJZHGOFBOaOEk
 Uvyx4CtA4I/aveHXSdF7iTh61rnO0iFDNbMOm1+8KjkHwoghph0jdfvwy2VbPDC0ZP/4BhJGA
 fqZMHC9n9KfwFup9F1gyw9Wnv3c87zWbYYIKPtGWh9Yb6CazHKg4hSuJJ2cjWlIqLP/ohRJQE
 4nsMQNB6aafVD8ZgDE5e5skHAfYuj41tTYzyB14BZiXY1dZ3uszoiZnQKx8Avsfc4UYNVdtvD
 A2SnOlW/1H+JnT/+zKLp+0PA0JoXKynorPVVTakM203L+fDzngNUGXsV6+rblk2MIpley2aeO
 1iz9R/V9ISTWRasK1Z0fxpvOTpA7U6W3SZJYeGmTXx2QGlQvOhs8K+mrO9fUKKpfYS8SfIi3U
 vf5SmG44kUojDZ0Czvkz0kZ4nLl+o3WBTcolcI7ypGwocJYaXZvhFCZ8rcdz0yAR/POTH9Fjb
 I4ZyYvwDJZ/y0geIgeJo0BQDd2wuaQbHrrXwggxYJn4+BV4EeBmL4q2vHh7aWq88lAMNkdyWG
 Q4RB1/9Uxzh9dyJ6IdJHuumfnzjIpMplgs9EGUtvr70w91XN7wzNyJadQYJ9Mdcn7pUowbLO2
 tNEy0886CoGThl7fHLYWDGAXaKdwRsGZIivVKOprgWBasmaF+dPV8/YMPRzTamDudypA4e6S8
 Z2OwKIM/3VIqy4OOo2Gjb837APKoRwQAd4CMBA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compile-testing this driver on a NOMMU configuration shows a link failure:

drivers/gpu/drm/exynos/exynos_drm_gem.o: In function `exynos_drm_gem_fault':
exynos_drm_gem.c:(.text+0x484): undefined reference to `vmf_insert_mixed'

Add a CONFIG_MMU dependency to ensure we only enable this in configurations
that build correctly.

Many other drm drivers have the same dependency. It would be nice to
make this work in MMU-less configurations, but evidently nobody has
ever needed this so far.

Fixes: 156bdac99061 ("drm/exynos: trigger build of all modules")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/exynos/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/exynos/Kconfig b/drivers/gpu/drm/exynos/Kconfig
index 60ce4a8ad9e1..6f7d3b3b3628 100644
--- a/drivers/gpu/drm/exynos/Kconfig
+++ b/drivers/gpu/drm/exynos/Kconfig
@@ -2,6 +2,7 @@
 config DRM_EXYNOS
 	tristate "DRM Support for Samsung SoC EXYNOS Series"
 	depends on OF && DRM && (ARCH_S3C64XX || ARCH_S5PV210 || ARCH_EXYNOS || ARCH_MULTIPLATFORM || COMPILE_TEST)
+	depends on MMU
 	select DRM_KMS_HELPER
 	select VIDEOMODE_HELPERS
 	select SND_SOC_HDMI_CODEC if SND_SOC
-- 
2.20.0

