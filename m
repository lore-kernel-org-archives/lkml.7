Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEC6C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D976420823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfCDUgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:36:54 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:45251 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbfCDUgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:36:54 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MaIrN-1gUqqs3zVN-00WFCV; Mon, 04 Mar 2019 21:36:44 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: dsa: mv88e6xxx: fix unused function warning
Date:   Mon,  4 Mar 2019 21:36:27 +0100
Message-Id: <20190304203641.2052975-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8odyF2fgOP3y0vgr8dfi9ElArl05AUjmEv/a6068UKeYYnVIBOd
 dHlz7RwPGIdOmjW+FV+bUF9VfA0tYFae8jT2e5AHukfFrUZBkFnNl0NCM53C5MEkKf+c3hZ
 ejdQwJxc3x66lQ24X0o4+8TOkyQveZJIfRo7sh3sC1cDwu0GSdVWs5vHz8PMgLD8sPXukWR
 TqjtDu4/zDuiyDf91hdLg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jXOqjUKwjrI=:py/9fkYLOmHVBrW377YO3n
 8PexGYhocS9r/eGabBWp8BqdTFgZN22Nf7/hxXHgC1IRo9Qrk9qBV2zzZS7fM4RArTmspaXIH
 qFk5aaVuxXnwKCV7deNFA+nB6alEn171jPY5X3RNJQ+e0e2hVLzSvj5bSTCpCiRK9xMcC2rJ/
 MPgBmTmn8Wj1hE0FoFjlGkpFgr4kC2fKXI/GJk7c7d6esAUTB+7men2CsDjB23gvJxW4sc528
 qEK3g5EZPWgxjMFg/OQOCYquWhn7kY9ZCk8FPzAqsF65/w7+bJ5vaJxP3FWEDdB2IMOf51YsZ
 lWMpBsvu+Au3mCl+AOyFryaH99E8S0nd+xk6nPhTlE2muCsrb7MoFU+sYmLF313g7wu1bft3L
 egGBC/LABddbVafUACPXumZ4i0HDp+NLT6BmBVXvMamkQR9ePCo0jW6oLBTNyoWoU7lD7N9aE
 JqFR7RF+4pz5c07yiiQHYk6Ix+Yygswg7YcmDjcvvU3lJt45O0oUNQXGmrDqFQyIiRG43ODgs
 XS+evgeyvyUIM6bqXFTTnA1ZSu2zGN5HCL8rBgj6nKRGseFvBPy9nuv3TLoFcjPfsuw3SmzIX
 z+LRJM5VZa8iQISj7MWUR3mFu8+BbMNlLe7WJPutelbdiGRuM+SlAXuW0P0U4iNc5Xo4b09Co
 8Mjv9OuX3ZHxui4EzXgtiDfH4jB+eLcP5hfd1ewxeq8biPzwJwLxcTbFm9pYzFHvEtWHeY/t6
 62G+N7pNbiYF/qznJVgN94xN5BfR0q8nOXGlAw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newly introduced function is only used inside of an #ifdef
and causes a warning when that is disabled:

drivers/net/dsa/mv88e6xxx/chip.c:4623:13: error: unused function 'mv88e6xxx_ports_cmode_init' [-Werror,-Wunused-function]

Move it into the same #ifdef block to shut up the warning.

Fixes: ed8fe20205ac ("net: dsa: mv88e6xxx: prevent interrupt storm caused by mv88e6390x_port_set_cmode")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index e4ad16b2dc38..168d4898c36f 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -4620,14 +4620,6 @@ static int mv88e6xxx_smi_init(struct mv88e6xxx_chip *chip,
 	return 0;
 }
 
-static void mv88e6xxx_ports_cmode_init(struct mv88e6xxx_chip *chip)
-{
-	int i;
-
-	for (i = 0; i < mv88e6xxx_num_ports(chip); i++)
-		chip->ports[i].cmode = MV88E6XXX_PORT_STS_CMODE_INVALID;
-}
-
 static enum dsa_tag_protocol mv88e6xxx_get_tag_protocol(struct dsa_switch *ds,
 							int port)
 {
@@ -4637,6 +4629,14 @@ static enum dsa_tag_protocol mv88e6xxx_get_tag_protocol(struct dsa_switch *ds,
 }
 
 #if IS_ENABLED(CONFIG_NET_DSA_LEGACY)
+static void mv88e6xxx_ports_cmode_init(struct mv88e6xxx_chip *chip)
+{
+	int i;
+
+	for (i = 0; i < mv88e6xxx_num_ports(chip); i++)
+		chip->ports[i].cmode = MV88E6XXX_PORT_STS_CMODE_INVALID;
+}
+
 static const char *mv88e6xxx_drv_probe(struct device *dsa_dev,
 				       struct device *host_dev, int sw_addr,
 				       void **priv)
-- 
2.20.0

