Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB98DC73C7F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 08:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A972F20844
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 08:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfGJIJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 04:09:43 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:47013 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfGJIJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 04:09:43 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MvazO-1ibIbl3YHu-00sfRH; Wed, 10 Jul 2019 10:09:07 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Baruch Siach <baruch@tkos.co.il>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: digicolor_wdt: drop unused variable
Date:   Wed, 10 Jul 2019 10:08:57 +0200
Message-Id: <20190710080904.317599-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:mZ/4FmETA2N1iae5b2XmeS50rziApGWR+vb3D9a2WJ7k0ERculc
 ghh1DBVjPjlVFmFiUNa5WGCPIuQYF8zGQL06OabeHJT646KmHfuARB9U/YUq3soLwSLVPtg
 9VHbUI1gwlvlsDfDXGb3IZeiVPPBG5wRPphlG/ypn8e2103N1Cm84rMXw5kCpLby0IdT3Yp
 zEqBRLn0YPMkI6bTSJZfQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mLuOMZv1Qn4=:XbQMW6B70avtrAIu/4Zx94
 kMkzCWYXuEqlLAzEpoMJt8Su4mBtp3ADnOk1w3r1rMCFH1hZL+xhjYtaVcgyVDtIQCpDFHFBQ
 8xjIgGJuRTfFFD9EYq3ZLAR4m8+4Vx8CerfachcGURZHoKlPmNZ6pMlQpeVwZvEAndUr8WtQY
 tqDOzeRm5MWuyjsbpKaM72yfb3wHpQCtZc5W6xKAEnBfRR3zM1pQouIxOwwxmGzH/DD/cvW8g
 xk9tjcqFrKCT1l4kVPX4uPnU0XozJhgbtM3vGi92CnnsIwreZu7OiyNC39BuhpIRxCgCBlYIL
 FeNP5Vtx5qEjYdQepOT76T1x/2NprVJIZf4J+vIWJVE8AHSzYR/wI07GIqgSIMo6uWWAeOECj
 9ZvSFCG3zVOdkSf0LW1Iam/rAc7fBxz620T9oKduPZvsou2PSf1splv+U0f3qJTsWi4YHhio/
 VXLn47cikQ7oc4oYkQ+J9rNsdTwfi/IfqPRqgQ6Rpnwt0nJhQPgIJ3djJiYamtB711EuwCvk6
 P7NVDy+NE2MW8RH0015N65kNS7I34PgIzcTlPwkiiYroQmzKCmySaaj7+vVOnaETIGAKv9ezx
 Mq3E/SYMR5kq2Ap+/0dh8YaLI5sbeNTck/CMRq1om/Ay7VYuc+px6aenndWwuPo6oDcsm2hQX
 KxnwtDtsAS6KUDlUtw0glRF9Y6lv3Rn/jQF0pDUCs4Gv3wIw8eMzI5nLxFm4OScnZeoUHeoE7
 Hqnuc6nHCDOjM0qnUGountlPKdAx6WDxjg6AbQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last cleanup patch left behind an unused variable
that should have been removed as well:

drivers/watchdog/digicolor_wdt.c:121:6: error: unused variable 'ret' [-Werror,-Wunused-variable]

Fixes: cdad26977e3f ("watchdog: digicolor_wdt: drop warning after registering device")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/watchdog/digicolor_wdt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/watchdog/digicolor_wdt.c b/drivers/watchdog/digicolor_wdt.c
index 33cda95bd238..073d37867f47 100644
--- a/drivers/watchdog/digicolor_wdt.c
+++ b/drivers/watchdog/digicolor_wdt.c
@@ -118,7 +118,6 @@ static int dc_wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct dc_wdt *wdt;
-	int ret;
 
 	wdt = devm_kzalloc(dev, sizeof(struct dc_wdt), GFP_KERNEL);
 	if (!wdt)
-- 
2.20.0

