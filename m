Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CB4C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 19:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC052077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 19:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfLJT7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 14:59:16 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:46739 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfLJT7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 14:59:16 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MxYT3-1hpfEc1HRJ-00xw8R; Tue, 10 Dec 2019 20:58:55 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: equilibrium: add CONFIG_OF dependency
Date:   Tue, 10 Dec 2019 20:58:29 +0100
Message-Id: <20191210195853.883483-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:tor64cZnKhFnxEaYoQEpGAP8ldGzW0XYqcz2ApV2GsAkNueUVHr
 opMFb096CXHadKuAynMYTzGTS1Z/U0psIZF2RkTHAg+bgv0tO8R3eVLn96wT0KG8bRZ3VrU
 31eABVntrr0zjoVBjFV4shZt1DHHFiFRvD8z9JSm2l2U7XDd3RaYr3SCONdZEMaIzRoAjss
 R/B2Nzh15TD0Qf4BxF9bA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qQgVTMFdYqY=:sw5rjP3PFD/RYb3as8Qxec
 6rMTwdAQon1V8mmRc1tzXiUmHOLGjXxK97pSPHFC979WgKrYNjIbz/MgAugU9hKiq4l1ur7LK
 E+3oyCjC3lfEyvhiSCgGIFCFTlcq8qjy1RrPbqTCFnqL7MszB7YEa0SKK1MfQkjHbMAjYN/BR
 UQoeTGZhzf6VF0EVifouYbme40TU3mqWQ/fABxMYvKVBSWR+GGDNmZEhoiHcogQ2kYzHRpOcR
 f46lHXYWyjKO2XeJW6rV6ydcdTFKlnSgzgRoa7hME3ic5naed8C0s80i8kHuiFZyGfMZ3rBqP
 YVlP3JB0AsX16iaFHv1yg2zr2Bc5UxI+c4SkqbA4d2pllWTddd8XE40NksWb9ha7DMSCLdW19
 Hh0Ue3rF85MRTxqeTupH70lVXf7+Qi7plL4vQ9hnKEfYMRVAWbuTr4mrV9i5OCjF7AOq101CN
 j/8HL0selF+tY3J3CBl0usODrSUTGKXrz/TyZ7EYZ+Fq0e9HsgPg03GY6MvuXEM43n/oUTXu/
 qfuLWqqCaDJ12EZE5US/a3LVm/L4JHiiH7cOKeWh80rZ9dRwrwh7NLQaT35lNT/dHZOM796AZ
 7wC3XPzVWvyc+wFVCh9XZBMuqJMm0vzL5j4mAEOX6/GR9wQrh/mCdt3WF1onnp+lXmwpzHgi1
 XSSp7fJx55WR196/B2p7mCS4LaDh7dhz0tV7U9eX35ShHvlTs5CQa2EE60Lv3Uu5x/kYb9K2V
 FjebnNr7d3ExCnDgiRBAN8TmWsoFX/ivBs1GTD02J61s/unpfen3NGeuXaVIckIOkTE9mtVpK
 Bji/Imh8NKTiaLxREhibOy4uBOwVD/2mIWnTCpnIQQMsLANy3SFNZgWRmL1OkZFcJ32a4O/9e
 ph5E/qL847FEC5ZeGt6w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this, randconfig builds get a link failure

drivers/pinctrl/pinctrl-equilibrium.o: In function `pinconf_generic_dt_node_to_map_all':
pinctrl-equilibrium.c:(.text+0x96d): undefined reference to `pinconf_generic_dt_node_to_map'

Fixes: 1948d5c51dba ("pinctrl: Add pinmux & GPIO controller driver for a new SoC")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pinctrl/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 3bfbf2ff6e2b..ba0cad4bd072 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -422,6 +422,7 @@ config PINCTRL_TB10X
 
 config PINCTRL_EQUILIBRIUM
 	tristate "Generic pinctrl and GPIO driver for Intel Lightning Mountain SoC"
+	depends on OF
 	select PINMUX
 	select PINCONF
 	select GPIOLIB
-- 
2.20.0

