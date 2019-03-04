Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA48C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF2E620823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfCDUgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:36:33 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:59103 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfCDUgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:36:33 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N94uf-1h4SrB47Oh-0169tH; Mon, 04 Mar 2019 21:36:07 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, Guenter Roeck <linux@roeck-us.net>,
        Pankaj Bansal <pankaj.bansal@nxp.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] phy: mdio-mux: fix Kconfig dependencies
Date:   Mon,  4 Mar 2019 21:35:10 +0100
Message-Id: <20190304203554.2017178-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:lMToDzxsVtImwok1DJRlSK0nCTEFOdnwRwOwW86IB/AInuyleKX
 Psg9SQAg9oJbsFlHmASmX1xlhCUw74aowClG4dxZ4yTEzxtZzdP5RhhkwZ8Hpy/EWF0RZTC
 B/aRBXHhxzfFlKHh8SrvV0ei4BYi53A56TgVeFgKOv2V99/XQnVtkTDrDWjMEuV6mzLj+Mw
 zZDYvsD/gbAvT1C4RLyVQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eUfh0Ry6Yoo=:yFOmhaLZLk1WLO8RPVH430
 5J6ebgelqeS/AMKV2XXQn8X4Dzc2XHnI1Jj8BZQ65TIhtdi2W47hUffpLwjqMU9OWQea5BkRa
 slirtb/LutgHkmzbqlHQJIiqqLx9ZUbF4IcKV/MdzI3TEIeAker30nXA5j5Ro5FWPV55nCom6
 t4PKn71NH/mvCfeuMQMEApIkX367V47BsNqwLNmOIHfdEDY8nQlcUhwiLlNqrIyD2hnNHl+o8
 VVvjsgn98e4Q8liSzr3ALESNBIJ92oaBMzI/7RqpvFBdQfI0bWblobIkEj67AxsaUEuHByRG+
 NSAlE8SgCNNtGbs/FqxTyd3rIQf8/6pDW69TKgqexZ7UJhrjXNDFgTdJXXy5bYBKfz4AbITVc
 I4jvu01kXIrfz1l2IsAM2AY16a2v2ZIl7oBIhfSrXnfRfp2RsfTaOiVu3oF5DpgKNbpVMiF5O
 slWZXP6ZEbdMawX/uvx2FJ6Dj2oisqdYPdQ+RLbWehWjm7P7/oqC+mEQMIxdybvrhXdheWd6O
 Wy/4BnK6E4mCKnWXG/n/ThdANJub7d3mqxrwzxfB0fksGejWWh54ZANQtCSWI5kTDMKsdtbaE
 yxIg21KNbDlGy+pI2SN3BhNm21e5eQNlBLcarojphFH2HVYJ+UeaCo5im1KfjHWuBJIp2MMvs
 7mz7dsY2cJgHcxbCpexyZIxrGYWJ4Dbiniy4dTDQv/O4nCdDSukMbWmUlKjldM4EglB0Dc4a6
 CqqnqGgVJHa1FxFNyy9ZdaRtrtz0PQaQDvhp/w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MDIO_BUS_MUX can only be selected if OF_MDIO is already turned on:

WARNING: unmet direct dependencies detected for MDIO_BUS_MUX
  Depends on [n]: NETDEVICES [=y] && MDIO_BUS [=m] && OF_MDIO [=n]
  Selected by [m]:
  - MDIO_BUS_MUX_MULTIPLEXER [=m] && NETDEVICES [=y] && MDIO_BUS [=m] && OF [=y]

Fixes: 7865ad6551c9 ("drivers: net: phy: mdio-mux: Add support for Generic Mux controls")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/phy/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 7f66af446ec7..071869db44cf 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -89,7 +89,7 @@ config MDIO_BUS_MUX_MMIOREG
 
 config MDIO_BUS_MUX_MULTIPLEXER
 	tristate "MDIO bus multiplexer using kernel multiplexer subsystem"
-	depends on OF
+	depends on OF_MDIO
 	select MULTIPLEXER
 	select MDIO_BUS_MUX
 	help
-- 
2.20.0

