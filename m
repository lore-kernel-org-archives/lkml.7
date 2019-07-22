Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2AAC76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 14:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1172921951
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 14:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfGVO4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 10:56:47 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:39631 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfGVO4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 10:56:46 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MK5BG-1i8jzE0TaY-00LSju; Mon, 22 Jul 2019 16:56:38 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     soc@kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Vivek Unune <npcomplete13@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [RESEND] ARM: bcm47094: add missing #cells for mdio-bus-mux
Date:   Mon, 22 Jul 2019 16:55:52 +0200
Message-Id: <20190722145618.1155492-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:58kYNxdp/4/OvhkcephOLG0lrEtZe2zmOjPbxM1QiGret2IP62K
 Do1CrdRVKb3+q8wqTdH7sLCUMztu0hZBtmcPCx2tU5t1bN6fqmAX5v7tFL5dTerwRm7NA78
 vBDVQPQJEQJr+H8tE7RL7zNIElfZINbjxoqrt3+SrLnqTjtOs72amePfZHcm3eh+Mva1jPh
 R6XjmO6j/3/U8K6YpL3fQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wKqZgt1dv0Q=:6PmNuljPMLdDh28rDeVivF
 OIkrLJ8ck2n9NBA9aF9puJX5cKE2GwHKs8yWZoMQhdvRJWx3YtzPYW93AezeahKzZ+FrdyGTY
 2d8EU5ssFXVht9gwbWC0rabvnKxcMSUg0SIsZtaQlHE2z2OTUrNKwgFuHxPV0ln3AZBkMtiy/
 MW86BXbXaFkrjFGxlNaFiezYwBNZj9XlDk581sTpfH/TLoeYQuaA8AwHdW28zdc6q6PFqo9l/
 qH+yzwdMi4hyfpzGR1vy/K6s7sYlh5iqr4R1ILEWgQ/IvWMnPCEnkiARJGQ4BYRdBOuQ7dUbR
 CoWJaQ50nf3kyQ7RWFHbx5usz/syTZyjKnoo1BL4DB0H1joXwbsQgvHRrhr88WvPfcKwimLP9
 YQmTk6/G7eT7YHZjtVt+x0NjO0TGKpOoCfg92EALVOtaYBR9BR2jnq9wwNXmyEqh2MTILgxpW
 15ivrfMNoJJYf4jU0aJ3BVgMPNMHPW1/XWT2gCJzcULM32KAQQFX1L1fv4qe4Z0wXRFJM/sEs
 qxu3D9H7fJTn/Xty1lgo01Tte8iaEp6rJ8rnRfBtYxk4ua3PaI+tHj6urOmpCukAIM93blLR/
 PfHzLFb8Sm0gn8xfJdKee7hp7BKpAMMDRZ7vQh95hSDKpR6DqaJY9ZGhHdGxnomSJwPV/5snS
 GBY/lJtCJZzp/LnetfqnTXyzS+Kohh+yF4IWXn4v8PM2nB2GJOdw+YhO9ZfHmaCKkimR5eHmt
 Wab3l4aEr9owkWzpYtmUxyF0l9N1ULaK3PNbyw==
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
As Florian is apparently on vacation at the moment, let's merge this
as a bugfix through arm-soc directly to get closer to clean allmodconfig
build.
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

