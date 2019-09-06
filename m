Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF49C00307
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FCAE2070C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394787AbfIFPYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 11:24:55 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:47235 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbfIFPYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 11:24:54 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MgNtR-1ieCGu1yVr-00hxJq; Fri, 06 Sep 2019 17:24:39 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: meson: mark PM functions as __maybe_unused
Date:   Fri,  6 Sep 2019 17:24:29 +0200
Message-Id: <20190906152438.1533833-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:iAXw4+juZQ88e5MCxf8CxgonumKHmdb38haLq7aNwoHTl6DtoPC
 Z9GPHNRp0w/tJjiEzrdFIfQtJ5pxhtRdL+pDmwoKrwYL57eprTQvOXgSCFQPuyr29o4PnGW
 kZim5mMmM/k12IdaDCvf5Chnxe+5bimHjJ3PUFNF7AFhOfJDEx1L06QWv2Ub1xM/gCDNYFb
 FEXmyJk3f22Aen5NN8QMw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZlbboHLS25M=:nbSzMGw1TiiBYTW/Jn2ABL
 t6bsPlq1T8uhQiCGjZelLsQ8maUrd4/3e9VeJPNzuzACOgz38aM8zpjxcUnsTsOSABK1eubj6
 PwFWvFkSTZcFXV245vVSil93R9kfP9WnmMoGIZPNUT8PXlGp5AQw8v+YPYZ3v7WNCAld1AMD0
 ywH3pNCp54V5vLICDZPZNAM0kTguEV2kQ5EDE2beAPTQG7SXArH/9ZujIR2vhaC5LCY9pD0BL
 tmJSPxv/zYa/pdUE6i0rUABlEyngw4SyACVDHeTKd8/ZGmIJNm3rVy8aeRVf6ZKlcshiPN8Cf
 t2GAoZmq1P74mkbcgYaRAybt8RR79Irw9igE659MjsXorLaifnVinOauDka3WJJaKEyeEoZoc
 pc9n8fI2QS0S6VPpqKnnlYDM3+hezWY9NHiqUGrl4EQRtcn5AK0Fxl5ZvV/ZPJ8b6GPYntIp3
 /VDxk8Ss6T8AoZysMdHSF2rkFNJKiq/9fLYY+dGX5vFrerQBfvOl/AbA4pCnd15UYAqWFt3Le
 yH3C335gyPj6YQ3UQBIgwyyjJTn3o+aMOd53ssfQQ4w27aKbrR7QApt9OCP/g3Kv6dId6DF/l
 NPPQ5Cxfl8djMyNhzSMiFvL8TDxYnN7w3s2UHoFz8CFL86I4/pzBLTxy3YUz/+TIGy/e2/HOM
 PW1xNwI6q+Xb/Fn6ieQ/n/4Y3ww0GJ61hLyCrlEGlSOjMFWuTLHLrqmPleglq7TGov8OdyvX1
 G5vhUIbYZwMd0h487IPYU3jfG9z59wzVrap7c31npIvjd9hOPhWMtg9T22MUML2qoRmO/hA5P
 teP6FLOBRvCXWDX0xjfrMvf1dfA1wLAUpcFjxeeXHyk8yiYIsc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The meson_vrtc_set_wakeup_time() function is only used by
the PM functions and causes a warning when they are disabled:

drivers/rtc/rtc-meson-vrtc.c:32:13: error: unused function 'meson_vrtc_set_wakeup_time' [-Werror,-Wunused-function]

Remove the #ifdef around the callers and add a __maybe_unused
annotation as a more reliable way to avoid these warnings.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/rtc/rtc-meson-vrtc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-meson-vrtc.c b/drivers/rtc/rtc-meson-vrtc.c
index 4621a4715179..89e5ba0dae69 100644
--- a/drivers/rtc/rtc-meson-vrtc.c
+++ b/drivers/rtc/rtc-meson-vrtc.c
@@ -91,8 +91,7 @@ static int meson_vrtc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int meson_vrtc_suspend(struct device *dev)
+static int __maybe_unused meson_vrtc_suspend(struct device *dev)
 {
 	struct meson_vrtc_data *vrtc = dev_get_drvdata(dev);
 
@@ -121,7 +120,7 @@ static int meson_vrtc_suspend(struct device *dev)
 	return 0;
 }
 
-static int meson_vrtc_resume(struct device *dev)
+static int __maybe_unused meson_vrtc_resume(struct device *dev)
 {
 	struct meson_vrtc_data *vrtc = dev_get_drvdata(dev);
 
@@ -131,7 +130,7 @@ static int meson_vrtc_resume(struct device *dev)
 	meson_vrtc_set_wakeup_time(vrtc, 0);
 	return 0;
 }
-#endif
+
 static SIMPLE_DEV_PM_OPS(meson_vrtc_pm_ops,
 			 meson_vrtc_suspend, meson_vrtc_resume);
 
-- 
2.20.0

