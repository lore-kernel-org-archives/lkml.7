Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED98EC06513
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF93D218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfGCNXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 09:23:13 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:40593 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbfGCNXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 09:23:12 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M28O9-1hgjPt2sY5-002TnS; Wed, 03 Jul 2019 15:22:56 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Vivek Unune <npcomplete13@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: bcm47094: add missing #cells for mdio-bus-mux
Date:   Wed,  3 Jul 2019 15:22:45 +0200
Message-Id: <20190703132255.852025-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:lvCFNj9rbQR8RjOV+MdKMN2bThGvAL+qaIb0oH5aGJue3TtP6ln
 d06sVHt6EYjIPOROSrbU6OtWl5LwghmnPvShGgDdr3Yx4Y58LgyPOn61l1tQj64jSgrSV2V
 oHrxr3wIM2tTby06bedxGhM2+S+nwWbrAlQRvfny4jBGFGMXWaOpDANZEBrzusRolOE6GIs
 9n6vd3A5ulAq03Ib8PKNA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:l7jljqs9bFs=:KFglj0618tLWnyn1ATzAdo
 uIUjTjubRhoedfMbin5H/FoTO8PCiZnOMjlibAiNvYNuNQkqF6IpoB1/sukRqXavCjJN3ns6Q
 MjoA1M9xS+JQ1sG8JAvyo1lrfuhs2aHSWNSFAYx29AA0lmdl/+RBUP/NrDJ7+HXqY9RRPPNF9
 1LzieIzos+QwFS+NBtE6CtxLBBOlpvB5qjD3/c7WoQWxgEuIhUTWnNBSU4LS2+LecsGP62YZp
 aEFAktZAd3XCcf0mKPJSR7Ve7E8YuFmyZgXgW4ZORNtRtdeYG74+T1X0ZNNIyokWWUHgahgNk
 xPI54+54p7TsXAifdYSWElb1GBDOCAE60Mg9eTZYAs93zACU8y2rxWSxGtvCY0yIkZLOabu7h
 NDhsnZyokdN5PN8i8S82mU+OZBwvvwZNmYrDgFBw9UhvN7/7FywSmeLHzEjRR7D8PHYauM6lT
 mCX8fbSF4pUiJuZs8637L59AHoiwbZ9RZ9kQAqA7kl0N47Xp6DVp6FqYUTV5cVkQE1L/p10xq
 wd3ZKhtMaH0PJnclTiU584ON5yxmjoaNe88mmnTrFboypT1NZGa2bLjq/ucSFwe79a+sQx9t0
 A9XznHTmFTHmEnfa9Qa2b98+K2psiYq/Jw4uI+n36ELcC8kOoMEvGAo1ws4o/nJi5/MQ1KD0C
 53TlBlpT5EY/JYztPcttty21x9Hl/LKdWBie9hpYxBPQIL9iLqbr9eOjWgjpS66ak2T6B0LOX
 c8Ar9G7tUYlIiPW1X8VzC7v+t4xTACx1gtnZOA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mdio-bus-mux has no #address-cells/#size-cells property,
which causes a few dtc warnings:

arch/arm/boot/dts/bcm47094-linksys-panamera.dts:129.4-18: Warning (reg_format): /mdio-bus-mux/mdio@200:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
arch/arm/boot/dts/bcm47094-linksys-panamera.dts:128.22-132.5: Warning (avoid_default_addr_size): /mdio-bus-mux/mdio@200: Relying on default #address-cells value
arch/arm/boot/dts/bcm47094-linksys-panamera.dts:128.22-132.5: Warning (avoid_default_addr_size): /mdio-bus-mux/mdio@200: Relying on default #size-cells value

Add the normal cell numbers.

Fixes: 2bebdfcdcd0f ("ARM: dts: BCM5301X: Add support for Linksys EA9500")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/boot/dts/bcm47094-linksys-panamera.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/bcm47094-linksys-panamera.dts b/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
index 18d0ae46e76c..0faae8950375 100644
--- a/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
+++ b/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
@@ -124,6 +124,9 @@
 	};
 
 	mdio-bus-mux {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
 		/* BIT(9) = 1 => external mdio */
 		mdio_ext: mdio@200 {
 			reg = <0x200>;
-- 
2.20.0

