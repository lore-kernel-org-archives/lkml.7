Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A75C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E2C5206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfCDU0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:26:52 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:37765 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfCDU0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:26:51 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M42fG-1h0uAd0iga-0004G4; Mon, 04 Mar 2019 21:26:43 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Bai Ping <ping.bai@nxp.com>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: freescale: fix link errors
Date:   Mon,  4 Mar 2019 21:26:25 +0100
Message-Id: <20190304202640.1765847-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:zyMEgrcou+Iot8SUeeR8TBkWtFOqcT6qNhUlnnP4FxD5o7vf/ja
 r565rI16bNQiu3SPRRhL8UYsobsECcVPeUEjNNe4r/CpW31bqWKpAZzw5aqusuFrEqRoyN5
 ij+mdgRGWT1Uwv/VK06Covlc4DuZn+JepTNw51MgSO1O+UuDY3EtrYdUL2ZBI4dAFINuQTc
 h40b0e5v0QWKUmzZKzr6Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZN/xFHvcVGc=:EcRh16FvLgBh1sZvl8C7XE
 NAupQFIHbBc4/4cKs+m8YxYNb1krhqYq83/xsWphI2aTB/JdW+Q1C+lca5ChGBzlfLW+fnMxo
 QTZ+IHP2FNCJUwMVZbZEVmXolHrRzCU84xN4Sa5nlZyJrZBkNczDScCpzsbqZ9jkvNRs3tlGD
 C4FwSfYZURhcU3N/7am5eRDiHhudnCIK/saUp2dTsGKUP4dJrJo/jVGZyPWMgTyS/GrrE1uLO
 fIHjMaZf3YEfGjq0h9FrAGzd8ZJYxeQGzlXH73dNmswxJ4+BRkVMzWKztLleko3OORU8iwCB1
 I4kbQHimrHckMevgreWO2XGS55eG/t4T9HulZBUuzba1TsgYSzDrne6OKFBdaL6icrjohVCj1
 T1qqeUPOnQvAYfHQlYK+pOpdmLz5LUAcHOxFL/Mjps4n7f82nN9v3F5dO7hsDSr8ELYJB6OGM
 TN68I8xfmhbyL4+Kse7qVW5XY6KmINF0Xea79Zaig+PVGDOjz0hyQgpa4xeykQzSb7XUwFwBh
 KZkU8nAHTcspXZrgrNRI01XTEGF52puRncQHvT7JXde//0jkcIRjjQztwyX8iltakbXxB8l7N
 GY7wqmRnucuTjXDR1+UwSZidaUPWelVehek6DN4v+00Jwm6jGhTLFdZL5Ey9e2AkqvyKToMuH
 UasZ4naDWNWzTe272ppw7l3rNOhvofkapPkkuNPrUnIWv91la8ufmynXQKgB7gzuT5V8lH6nw
 u0uSOV2YBSwrP+rduMlDozvGATj3mMKWi+6Mng==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Submitted by Anders Roxell already

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pinctrl/freescale/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/freescale/Kconfig b/drivers/pinctrl/freescale/Kconfig
index e6dff3167a67..e447b996e79f 100644
--- a/drivers/pinctrl/freescale/Kconfig
+++ b/drivers/pinctrl/freescale/Kconfig
@@ -138,14 +138,14 @@ config PINCTRL_IMX8MQ
 
 config PINCTRL_IMX8QM
 	bool "IMX8QM pinctrl driver"
-	depends on ARCH_MXC && ARM64
+	depends on ARCH_MXC && ARM64 && IMX_SCU
 	select PINCTRL_IMX_SCU
 	help
 	  Say Y here to enable the imx8qm pinctrl driver
 
 config PINCTRL_IMX8QXP
 	bool "IMX8QXP pinctrl driver"
-	depends on ARCH_MXC && ARM64
+	depends on ARCH_MXC && ARM64 && IMX_SCU
 	select PINCTRL_IMX_SCU
 	help
 	  Say Y here to enable the imx8qxp pinctrl driver
-- 
2.20.0

