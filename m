Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C306C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B54208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfCDUJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:09:28 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:52719 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfCDUJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:09:28 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MTiHd-1gX28j0HTZ-00U4kl; Mon, 04 Mar 2019 21:09:20 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] x86: apuv2: remove unused variable
Date:   Mon,  4 Mar 2019 21:09:07 +0100
Message-Id: <20190304200918.1444050-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:1ph8MhilKDjqsuDHxM5THpEkakWPf0W8D0IBCkP26audtK5Gg7p
 qsG1AMBA0KHL46VmKXyJOU/Oaay7MqtnTvpNBUey+nVKcD8EcEx1AUymEKF5gsZpwB88TRS
 QGw3WJX8vceMtZ3E6S+FOt/kCGLsY0fNQAuN/gnzgWVVJc29DV2QQcHjtoB8MrPRTW9KRJr
 lw4bqKu0P60lkLX3aVTrw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0uMKnTmho+0=:B4ucVYl0l1uDxXqq/UVxtj
 jJhaQNC81NbF9Oi8vWeGzIDOv6RvGwUI2eDVte59RmBq3Mw/8ZYgj6ehcnKObRP7xkflpApHu
 ftJpaTc6mpJCDR3VyGlfiSPKKm2IgFJPK8thdYumHMnCdXhfPUxHM+YBxDCgDcAfMvCNIDO+o
 /Jk8LqY1Qm+/WvdU39iJfoehzpX7Yu8fGLodkZwnrBxCD7TprSK27Lyv35NJvWXVjzupa+w86
 DQZRiXk2/O+bJQss7Y79Qk+RGWGudsjQVjHlZnR2AMl3982D+nA9vKA+mH27PocUNuS5MTnia
 B9nN4GbSHQdtBxRho81FddirCiDsxARK+RxQcZBoBtvx6nYYGGrEfKgdCf/6S/3fDCM5lv9fU
 yxVsVvsjU9O62GOKh2hXwNF+B7+OKswsgf6pkjRFDXalakv0zFz8cixdYqcKscuZyrEVkfnyb
 XCmD9l9TSfu48JvwOkvHhesFU435GN+QDl8ypg2ILhIVPioSXSDWqe49ZIhwFq7M86E9Vi4TJ
 h6rCw8PiJRGWukl1rZ4IQNxSh1neHvjQcx96i/dQ5iIKCIHInZ23ifiO70Z5Csa0UkuROO1nc
 sMUidLtIGqSc5F1ZcrfzW3z/+lqesufQI4px3uqY7nnYOBqIkEn36pWAX4D/iVj5Op6XtH6n7
 E8exHAvDYLbyiZ8kZsXzLG2dgaIgVV654UjwZvVEC/vZk1CdItkxjxMbxsDE78VqihOn6TyKu
 8ZAE3QZjSpRNCnPSnLuusFj/TUOiLus1sMOYgw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver was newly introduced but the version that got merged
produces a harmless compiler warning:

drivers/platform/x86/pcengines-apuv2.c: In function 'apu_board_init':
drivers/platform/x86/pcengines-apuv2.c:211:6: error: unused variable 'rc' [-Werror=unused-variable]

Remove the evidently useless variable.

Fixes: f8eb0235f659 ("x86: pcengines apuv2 gpio/leds/keys platform driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/platform/x86/pcengines-apuv2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/x86/pcengines-apuv2.c b/drivers/platform/x86/pcengines-apuv2.c
index dcb084f6b892..c1ca931e1fab 100644
--- a/drivers/platform/x86/pcengines-apuv2.c
+++ b/drivers/platform/x86/pcengines-apuv2.c
@@ -208,7 +208,6 @@ static struct platform_device * __init apu_create_pdev(
 
 static int __init apu_board_init(void)
 {
-	int rc;
 	const struct dmi_system_id *id;
 
 	id = dmi_first_match(apu_gpio_dmi_table);
-- 
2.20.0

