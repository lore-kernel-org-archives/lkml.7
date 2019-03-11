Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44BBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B7220657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbfCKNUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:20:31 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:56167 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727699AbfCKNUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:20:13 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MAORp-1hE2L73ZiF-00BqQy for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:43 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 114/114] arch: arm: boot: dts: pedantic formatting
Date:   Mon, 11 Mar 2019 14:19:06 +0100
Message-Id: <1552310346-7629-115-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:Zi7/s3qLvWVVczWy0O8SPFkEwlXwvM63B8k+wYGuHtcoyrdXnoj
 9tDJ1q3rm48/nfvZcOi5gqG6SSahDCxcmIbi7deN6rLXZZJtkyqU96fdUTFHp9j4gfv8/q4
 akO511DHPBFbHOHIRsiq9ZwEdtOdNnmUH9R1u/mu7cQdi9UqUU3WUfuEzK1SiGhaLveJmmf
 LX0poyCg3GXlDNUQsP9Jw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3lzkLoU4lZE=:K3b7ClEQP7K7hn+grmhq0z
 6wodpSQlSkOlQZKB+Y4DjFUcZ5Y3V+cQjadD0e2JiXjBvYCmpmT7RxCSLYzqKYGo8yiLYkoPK
 ZC4iXkQKZoRceMyp2CkLIGI0C21r2lre1CM+zWTehCB8SNdGIRSi9jJUdr7ax4PpDMT2hm3NA
 dDqW6uOkXJ+Kcj4tH2sb1tvyNFsh241fBoSFFpJd6TeeinBlCo8XWeN+Az454Snq08bCws7lh
 3BNjOyhfh7rzSPARQdHuXaP3Fh92KfGH6u+8kBcFd1iWWX2YS6g6zoFTN/PyoEUtB2Vk2f268
 JRBtXCKVrMnNbeo0aNF7g1TWAtSuw8kNhyhiTjpu8nWJf8yNW93ZY574nczmr1zt8y3h0K8fF
 fjHllANeFhBUh596zNYEKDRMIH8EAHPEx2f/E7N2qyksZwtQO1tlghO6jSLaJ8nG+EmjFlQiA
 bN2C5B/uUI4n6kX/jBCAAsRmJN0iQl6O3XKyyAyM3ch8ch8kjbDt3dA2qBazTJZzHmnES/xI6
 rVKonH4tSFDjUlRren+pj4bxNHC5NpQFMTe1qv+WaMeFxNVIIDNfB9nf3sMG0cyOusQvZy4v6
 o6wkHzzM2GNPZoQTUtzYFu83KjDgoFCRDpIwloc9zn8h7jg8r32h4k6wUi0hnJG7j3ha1BKv+
 aWSfO/hewV/fHYswYD7wozMIbuRjLOFSFKNo0lMIdq+Daean5hs3WVZc5X3CrLVVbuMNWSFnT
 /mTO5Z9wcw+j5Hjn
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of dts(i) files doesn't look so pretty, so just
take damp cloth and clean it up. Just indention changes.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 arch/arm/boot/dts/alpine-db.dts                    |   1 -
 arch/arm/boot/dts/am335x-baltos-ir2110.dts         |  16 +-
 arch/arm/boot/dts/am335x-baltos-ir3220.dts         |  38 +--
 arch/arm/boot/dts/am335x-baltos-ir5221.dts         |  42 +--
 arch/arm/boot/dts/am335x-baltos.dtsi               |  40 +--
 arch/arm/boot/dts/am335x-bone-common.dtsi          |  20 +-
 arch/arm/boot/dts/am335x-boneblack-common.dtsi     |  10 +-
 arch/arm/boot/dts/am335x-boneblack-wireless.dts    |  12 +-
 arch/arm/boot/dts/am335x-chiliboard.dts            |  22 +-
 arch/arm/boot/dts/am335x-evm.dts                   |  12 +-
 arch/arm/boot/dts/am335x-evmsk.dts                 |  56 ++--
 arch/arm/boot/dts/am335x-icev2.dts                 |  44 +--
 arch/arm/boot/dts/am335x-igep0033.dtsi             |   1 -
 arch/arm/boot/dts/am335x-lxm.dts                   |  21 +-
 arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts     |  52 +--
 arch/arm/boot/dts/am335x-nano.dts                  |   2 +-
 arch/arm/boot/dts/am335x-osd3358-sm-red.dts        |  62 ++--
 arch/arm/boot/dts/am335x-pepper.dts                |  68 ++--
 arch/arm/boot/dts/am335x-phycore-rdk.dts           |   1 -
 arch/arm/boot/dts/am335x-sancloud-bbe.dts          |   6 +-
 arch/arm/boot/dts/am335x-shc.dts                   |   2 +-
 arch/arm/boot/dts/am335x-sl50.dts                  |  50 +--
 arch/arm/boot/dts/am335x-wega.dtsi                 |  18 +-
 arch/arm/boot/dts/am3517-craneboard.dts            |   2 +-
 arch/arm/boot/dts/am3517-evm.dts                   |  68 ++--
 arch/arm/boot/dts/am3517-som.dtsi                  |  26 +-
 arch/arm/boot/dts/am3874-iceboard.dts              |  82 ++---
 arch/arm/boot/dts/am437x-cm-t43.dts                |  32 +-
 arch/arm/boot/dts/am437x-gp-evm.dts                | 238 ++++++-------
 arch/arm/boot/dts/am437x-idk-evm.dts               |  24 +-
 arch/arm/boot/dts/am437x-l4.dtsi                   |   1 -
 arch/arm/boot/dts/am43xx-clocks.dtsi               |   1 -
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi    |   1 -
 arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts  |   1 -
 arch/arm/boot/dts/armada-370-xp.dtsi               |   2 +-
 arch/arm/boot/dts/armada-375.dtsi                  |   1 -
 arch/arm/boot/dts/armada-388-rd.dts                |   1 -
 arch/arm/boot/dts/armada-xp-98dx3236.dtsi          |   1 -
 arch/arm/boot/dts/armada-xp-db-dxbc2.dts           |   1 -
 arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts      |   1 -
 arch/arm/boot/dts/armada-xp-gp.dts                 |  14 +-
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts    |   8 +-
 arch/arm/boot/dts/armada-xp-mv78230.dtsi           |  30 +-
 arch/arm/boot/dts/armada-xp-mv78260.dtsi           |  54 +--
 arch/arm/boot/dts/armada-xp-mv78460.dtsi           |  60 ++--
 arch/arm/boot/dts/at91-ariag25.dts                 |   1 -
 arch/arm/boot/dts/at91-dvk_som60.dts               |   1 -
 arch/arm/boot/dts/at91-dvk_su60_somc.dtsi          |   1 -
 arch/arm/boot/dts/at91-linea.dtsi                  |   1 -
 arch/arm/boot/dts/at91-sama5d2_xplained.dts        |   1 -
 arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dts        |   2 -
 arch/arm/boot/dts/at91-vinco.dts                   |   2 -
 arch/arm/boot/dts/at91-wb45n.dtsi                  |   2 -
 arch/arm/boot/dts/at91-wb50n.dts                   |   1 -
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi        |   2 -
 arch/arm/boot/dts/at91sam9x5cm.dtsi                |   1 -
 arch/arm/boot/dts/atlas6-evb.dts                   |  32 +-
 arch/arm/boot/dts/atlas6.dtsi                      | 368 ++++++++++-----------
 arch/arm/boot/dts/atlas7-evb.dts                   |   2 -
 arch/arm/boot/dts/atlas7.dtsi                      |   4 +-
 arch/arm/boot/dts/axm55xx.dtsi                     |   7 -
 arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts  |   1 -
 arch/arm/boot/dts/bcm4708.dtsi                     |   1 -
 arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts |   1 -
 arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts  |   1 -
 arch/arm/boot/dts/dra7-l4.dtsi                     |   1 -
 arch/arm/boot/dts/dra7xx-clocks.dtsi               |   8 +-
 arch/arm/boot/dts/evk-pro3.dts                     |   1 -
 arch/arm/boot/dts/exynos4412-ppmu-common.dtsi      |  48 +--
 arch/arm/boot/dts/exynos5410-pinctrl.dtsi          |   1 -
 arch/arm/boot/dts/exynos5422-odroidhc1.dts         |   1 -
 arch/arm/boot/dts/highbank.dts                     |   2 -
 arch/arm/boot/dts/imx23-sansa.dts                  |   1 -
 arch/arm/boot/dts/imx28-eukrea-mbmx283lc.dts       |   1 -
 arch/arm/boot/dts/imx28-evk.dts                    |   1 -
 arch/arm/boot/dts/imx28-sps1.dts                   |   1 -
 arch/arm/boot/dts/imx28-ts4600.dts                 |   4 -
 arch/arm/boot/dts/imx6dl-gw52xx.dts                |  26 +-
 arch/arm/boot/dts/imx6dl-gw53xx.dts                |  26 +-
 arch/arm/boot/dts/imx6dl-gw54xx.dts                |  26 +-
 arch/arm/boot/dts/imx6dl-mamoj.dts                 | 100 +++---
 arch/arm/boot/dts/imx6q-ba16.dtsi                  | 178 +++++-----
 arch/arm/boot/dts/imx6q-bx50v3.dtsi                |   8 +-
 arch/arm/boot/dts/imx6q-cm-fx6.dts                 |  46 +--
 arch/arm/boot/dts/imx6q-display5.dtsi              |  44 +--
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts            |   8 +-
 arch/arm/boot/dts/imx6q-dms-ba16.dts               |  16 +-
 arch/arm/boot/dts/imx6q-evi.dts                    | 300 ++++++++---------
 arch/arm/boot/dts/imx6q-gw52xx.dts                 |  26 +-
 arch/arm/boot/dts/imx6q-gw53xx.dts                 |  26 +-
 arch/arm/boot/dts/imx6q-gw54xx.dts                 |  26 +-
 arch/arm/boot/dts/imx6q-kp.dtsi                    | 168 +++++-----
 arch/arm/boot/dts/imx6q-mccmon6.dts                |  24 +-
 arch/arm/boot/dts/imx6q-pistachio.dts              |  62 ++--
 arch/arm/boot/dts/imx6q-tbs2910.dts                | 128 +++----
 arch/arm/boot/dts/imx6q-utilite-pro.dts            | 116 +++----
 arch/arm/boot/dts/imx6qdl-apalis.dtsi              | 358 ++++++++++----------
 arch/arm/boot/dts/imx6qdl-apf6dev.dtsi             | 102 +++---
 arch/arm/boot/dts/imx6qdl-aristainetos.dtsi        | 180 +++++-----
 arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi       | 174 +++++-----
 arch/arm/boot/dts/imx6qdl-colibri.dtsi             | 118 +++----
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi             |  42 +--
 arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi       |  12 +-
 arch/arm/boot/dts/imx6qdl-emcon.dtsi               | 100 +++---
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi              | 140 ++++----
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi              |  10 +-
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi              |  10 +-
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi              |   8 +-
 arch/arm/boot/dts/imx6qdl-gw551x.dtsi              |   2 +-
 arch/arm/boot/dts/imx6qdl-gw553x.dtsi              | 158 ++++-----
 arch/arm/boot/dts/imx6qdl-gw5904.dtsi              |  16 +-
 arch/arm/boot/dts/imx6qdl-hummingboard.dtsi        |  54 +--
 arch/arm/boot/dts/imx6qdl-hummingboard2-emmc.dtsi  |  22 +-
 arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi       | 164 ++++-----
 arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi           | 184 +++++------
 arch/arm/boot/dts/imx6qdl-icore.dtsi               | 108 +++---
 arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi           |  18 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi       | 116 +++----
 arch/arm/boot/dts/wm8750.dtsi                      | 110 +++---
 arch/arm/boot/dts/wm8850.dtsi                      |  54 +--
 120 files changed, 2648 insertions(+), 2713 deletions(-)

diff --git a/arch/arm/boot/dts/alpine-db.dts b/arch/arm/boot/dts/alpine-db.dts
index dfb5a08..a6d7b23 100644
--- a/arch/arm/boot/dts/alpine-db.dts
+++ b/arch/arm/boot/dts/alpine-db.dts
@@ -32,4 +32,3 @@
 	model = "Annapurna Labs Alpine Dev Board";
 	/* no need for anything outside SOC */
 };
-
diff --git a/arch/arm/boot/dts/am335x-baltos-ir2110.dts b/arch/arm/boot/dts/am335x-baltos-ir2110.dts
index 50dcf12..182d825 100644
--- a/arch/arm/boot/dts/am335x-baltos-ir2110.dts
+++ b/arch/arm/boot/dts/am335x-baltos-ir2110.dts
@@ -23,14 +23,14 @@
 &am33xx_pinmux {
 	uart1_pins: pinmux_uart1_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x980, PIN_INPUT | MUX_MODE0)      /* uart1_rxd */
-			AM33XX_IOPAD(0x984, PIN_INPUT | MUX_MODE0)      /* uart1_txd */
-			AM33XX_IOPAD(0x978, PIN_INPUT_PULLDOWN | MUX_MODE0)      /* uart1_ctsn */
-			AM33XX_IOPAD(0x97c, PIN_OUTPUT_PULLDOWN | MUX_MODE0)      /* uart1_rtsn */
-			AM33XX_IOPAD(0x8e0, PIN_OUTPUT_PULLDOWN | MUX_MODE7)      /* lcd_vsync.gpio2[22] DTR */
-			AM33XX_IOPAD(0x8e4, PIN_INPUT_PULLDOWN | MUX_MODE7)      /* lcd_hsync.gpio2[23] DSR */
-			AM33XX_IOPAD(0x8e8, PIN_INPUT_PULLDOWN | MUX_MODE7)      /* lcd_pclk.gpio2[24] DCD */
-			AM33XX_IOPAD(0x8ec, PIN_INPUT_PULLDOWN | MUX_MODE7)      /* lcd_ac_bias_en.gpio2[25] RI */
+			AM33XX_IOPAD(0x980, PIN_INPUT | MUX_MODE0)		/* uart1_rxd */
+			AM33XX_IOPAD(0x984, PIN_INPUT | MUX_MODE0)		/* uart1_txd */
+			AM33XX_IOPAD(0x978, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* uart1_ctsn */
+			AM33XX_IOPAD(0x97c, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart1_rtsn */
+			AM33XX_IOPAD(0x8e0, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* lcd_vsync.gpio2[22] DTR */
+			AM33XX_IOPAD(0x8e4, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* lcd_hsync.gpio2[23] DSR */
+			AM33XX_IOPAD(0x8e8, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* lcd_pclk.gpio2[24] DCD */
+			AM33XX_IOPAD(0x8ec, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* lcd_ac_bias_en.gpio2[25] RI */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/am335x-baltos-ir3220.dts b/arch/arm/boot/dts/am335x-baltos-ir3220.dts
index f3f1abd..9e7cec5 100644
--- a/arch/arm/boot/dts/am335x-baltos-ir3220.dts
+++ b/arch/arm/boot/dts/am335x-baltos-ir3220.dts
@@ -23,35 +23,35 @@
 &am33xx_pinmux {
 	tca6416_pins: pinmux_tca6416_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x9b4, PIN_INPUT_PULLUP | MUX_MODE7)      /* xdma_event_intr1.gpio0[20] tca6416 stuff */
+			AM33XX_IOPAD(0x9b4, PIN_INPUT_PULLUP | MUX_MODE7)	/* xdma_event_intr1.gpio0[20] tca6416 stuff */
 		>;
 	};
 
 	uart1_pins: pinmux_uart1_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x980, PIN_INPUT | MUX_MODE0)      /* uart1_rxd */
-			AM33XX_IOPAD(0x984, PIN_INPUT | MUX_MODE0)      /* uart1_txd */
-			AM33XX_IOPAD(0x978, PIN_INPUT_PULLDOWN | MUX_MODE0)      /* uart1_ctsn */
-			AM33XX_IOPAD(0x97c, PIN_OUTPUT_PULLDOWN | MUX_MODE0)      /* uart1_rtsn */
-			AM33XX_IOPAD(0x8e0, PIN_OUTPUT_PULLDOWN | MUX_MODE7)      /* lcd_vsync.gpio2[22] DTR */
-			AM33XX_IOPAD(0x8e4, PIN_INPUT_PULLDOWN | MUX_MODE7)      /* lcd_hsync.gpio2[23] DSR */
-			AM33XX_IOPAD(0x8e8, PIN_INPUT_PULLDOWN | MUX_MODE7)      /* lcd_pclk.gpio2[24] DCD */
-			AM33XX_IOPAD(0x8ec, PIN_INPUT_PULLDOWN | MUX_MODE7)      /* lcd_ac_bias_en.gpio2[25] RI */
+			AM33XX_IOPAD(0x980, PIN_INPUT | MUX_MODE0)		/* uart1_rxd */
+			AM33XX_IOPAD(0x984, PIN_INPUT | MUX_MODE0)		/* uart1_txd */
+			AM33XX_IOPAD(0x978, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* uart1_ctsn */
+			AM33XX_IOPAD(0x97c, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart1_rtsn */
+			AM33XX_IOPAD(0x8e0, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* lcd_vsync.gpio2[22] DTR */
+			AM33XX_IOPAD(0x8e4, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* lcd_hsync.gpio2[23] DSR */
+			AM33XX_IOPAD(0x8e8, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* lcd_pclk.gpio2[24] DCD */
+			AM33XX_IOPAD(0x8ec, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* lcd_ac_bias_en.gpio2[25] RI */
 		>;
 	};
 
 	uart2_pins: pinmux_uart2_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x950, PIN_INPUT | MUX_MODE1)      /* spi0_sclk.uart2_rxd_mux3 */
-			AM33XX_IOPAD(0x954, PIN_OUTPUT | MUX_MODE1)      /* spi0_d0.uart2_txd_mux3 */
-			AM33XX_IOPAD(0x988, PIN_INPUT_PULLDOWN | MUX_MODE2)      /* i2c0_sda.uart2_ctsn_mux0 */
-			AM33XX_IOPAD(0x98c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)      /* i2c0_scl.uart2_rtsn_mux0 */
-			AM33XX_IOPAD(0x830, PIN_OUTPUT_PULLDOWN | MUX_MODE7)      /* gpmc_ad12.gpio1[12] DTR */
-			AM33XX_IOPAD(0x834, PIN_INPUT_PULLDOWN | MUX_MODE7)      /* gpmc_ad13.gpio1[13] DSR */
-			AM33XX_IOPAD(0x838, PIN_INPUT_PULLDOWN | MUX_MODE7)      /* gpmc_ad14.gpio1[14] DCD */
-			AM33XX_IOPAD(0x83c, PIN_INPUT_PULLDOWN | MUX_MODE7)     /* gpmc_ad15.gpio1[15] RI */
-
-			AM33XX_IOPAD(0x9a0, PIN_INPUT_PULLUP | MUX_MODE7)      /* mcasp0_aclkr.gpio3[18], INPUT_PULLDOWN | MODE7 */
+			AM33XX_IOPAD(0x950, PIN_INPUT | MUX_MODE1)		/* spi0_sclk.uart2_rxd_mux3 */
+			AM33XX_IOPAD(0x954, PIN_OUTPUT | MUX_MODE1)		/* spi0_d0.uart2_txd_mux3 */
+			AM33XX_IOPAD(0x988, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* i2c0_sda.uart2_ctsn_mux0 */
+			AM33XX_IOPAD(0x98c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* i2c0_scl.uart2_rtsn_mux0 */
+			AM33XX_IOPAD(0x830, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad12.gpio1[12] DTR */
+			AM33XX_IOPAD(0x834, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad13.gpio1[13] DSR */
+			AM33XX_IOPAD(0x838, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad14.gpio1[14] DCD */
+			AM33XX_IOPAD(0x83c, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad15.gpio1[15] RI */
+
+			AM33XX_IOPAD(0x9a0, PIN_INPUT_PULLUP | MUX_MODE7)	/* mcasp0_aclkr.gpio3[18], INPUT_PULLDOWN | MODE7 */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/am335x-baltos-ir5221.dts b/arch/arm/boot/dts/am335x-baltos-ir5221.dts
index 42f473f..58ee26d 100644
--- a/arch/arm/boot/dts/am335x-baltos-ir5221.dts
+++ b/arch/arm/boot/dts/am335x-baltos-ir5221.dts
@@ -23,43 +23,43 @@
 &am33xx_pinmux {
 	tca6416_pins: pinmux_tca6416_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x9b4, PIN_INPUT_PULLUP | MUX_MODE7)      /* xdma_event_intr1.gpio0[20] tca6416 stuff */
+			AM33XX_IOPAD(0x9b4, PIN_INPUT_PULLUP | MUX_MODE7)	/* xdma_event_intr1.gpio0[20] tca6416 stuff */
 		>;
 	};
 
 
 	dcan1_pins: pinmux_dcan1_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x968, PIN_OUTPUT | MUX_MODE2)      /* uart0_ctsn.dcan1_tx_mux0 */
-			AM33XX_IOPAD(0x96c, PIN_INPUT | MUX_MODE2)      /* uart0_rtsn.dcan1_rx_mux0 */
+			AM33XX_IOPAD(0x968, PIN_OUTPUT | MUX_MODE2)		/* uart0_ctsn.dcan1_tx_mux0 */
+			AM33XX_IOPAD(0x96c, PIN_INPUT | MUX_MODE2)		/* uart0_rtsn.dcan1_rx_mux0 */
 		>;
 	};
 
 	uart1_pins: pinmux_uart1_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x980, PIN_INPUT | MUX_MODE0)      /* uart1_rxd */
-			AM33XX_IOPAD(0x984, PIN_INPUT | MUX_MODE0)      /* uart1_txd */
-			AM33XX_IOPAD(0x978, PIN_INPUT_PULLDOWN | MUX_MODE0)      /* uart1_ctsn */
-			AM33XX_IOPAD(0x97c, PIN_OUTPUT_PULLDOWN | MUX_MODE0)      /* uart1_rtsn */
-			AM33XX_IOPAD(0x8e0, PIN_OUTPUT_PULLDOWN | MUX_MODE7)      /* lcd_vsync.gpio2[22] DTR */
-			AM33XX_IOPAD(0x8e4, PIN_INPUT_PULLDOWN | MUX_MODE7)      /* lcd_hsync.gpio2[23] DSR */
-			AM33XX_IOPAD(0x8e8, PIN_INPUT_PULLDOWN | MUX_MODE7)      /* lcd_pclk.gpio2[24] DCD */
-			AM33XX_IOPAD(0x8ec, PIN_INPUT_PULLDOWN | MUX_MODE7)      /* lcd_ac_bias_en.gpio2[25] RI */
+			AM33XX_IOPAD(0x980, PIN_INPUT | MUX_MODE0)		/* uart1_rxd */
+			AM33XX_IOPAD(0x984, PIN_INPUT | MUX_MODE0)		/* uart1_txd */
+			AM33XX_IOPAD(0x978, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* uart1_ctsn */
+			AM33XX_IOPAD(0x97c, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart1_rtsn */
+			AM33XX_IOPAD(0x8e0, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* lcd_vsync.gpio2[22] DTR */
+			AM33XX_IOPAD(0x8e4, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* lcd_hsync.gpio2[23] DSR */
+			AM33XX_IOPAD(0x8e8, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* lcd_pclk.gpio2[24] DCD */
+			AM33XX_IOPAD(0x8ec, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* lcd_ac_bias_en.gpio2[25] RI */
 		>;
 	};
 
 	uart2_pins: pinmux_uart2_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x950, PIN_INPUT | MUX_MODE1)      /* spi0_sclk.uart2_rxd_mux3 */
-			AM33XX_IOPAD(0x954, PIN_OUTPUT | MUX_MODE1)      /* spi0_d0.uart2_txd_mux3 */
-			AM33XX_IOPAD(0x988, PIN_INPUT_PULLDOWN | MUX_MODE2)      /* i2c0_sda.uart2_ctsn_mux0 */
-			AM33XX_IOPAD(0x98c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)      /* i2c0_scl.uart2_rtsn_mux0 */
-			AM33XX_IOPAD(0x830, PIN_OUTPUT_PULLDOWN | MUX_MODE7)      /* gpmc_ad12.gpio1[12] DTR */
-			AM33XX_IOPAD(0x834, PIN_INPUT_PULLDOWN | MUX_MODE7)      /* gpmc_ad13.gpio1[13] DSR */
-			AM33XX_IOPAD(0x838, PIN_INPUT_PULLDOWN | MUX_MODE7)      /* gpmc_ad14.gpio1[14] DCD */
-			AM33XX_IOPAD(0x83c, PIN_INPUT_PULLDOWN | MUX_MODE7)     /* gpmc_ad15.gpio1[15] RI */
-
-			AM33XX_IOPAD(0x9a0, PIN_INPUT_PULLUP | MUX_MODE7)      /* mcasp0_aclkr.gpio3[18], INPUT_PULLDOWN | MODE7 */
+			AM33XX_IOPAD(0x950, PIN_INPUT | MUX_MODE1)		/* spi0_sclk.uart2_rxd_mux3 */
+			AM33XX_IOPAD(0x954, PIN_OUTPUT | MUX_MODE1)		/* spi0_d0.uart2_txd_mux3 */
+			AM33XX_IOPAD(0x988, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* i2c0_sda.uart2_ctsn_mux0 */
+			AM33XX_IOPAD(0x98c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* i2c0_scl.uart2_rtsn_mux0 */
+			AM33XX_IOPAD(0x830, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad12.gpio1[12] DTR */
+			AM33XX_IOPAD(0x834, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad13.gpio1[13] DSR */
+			AM33XX_IOPAD(0x838, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad14.gpio1[14] DCD */
+			AM33XX_IOPAD(0x83c, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad15.gpio1[15] RI */
+
+			AM33XX_IOPAD(0x9a0, PIN_INPUT_PULLUP | MUX_MODE7)	/* mcasp0_aclkr.gpio3[18], INPUT_PULLDOWN | MODE7 */
 		>;
 	};
 
diff --git a/arch/arm/boot/dts/am335x-baltos.dtsi b/arch/arm/boot/dts/am335x-baltos.dtsi
index 8c6fc41..a624a2e 100644
--- a/arch/arm/boot/dts/am335x-baltos.dtsi
+++ b/arch/arm/boot/dts/am335x-baltos.dtsi
@@ -53,52 +53,52 @@
 &am33xx_pinmux {
 	mmc2_pins: pinmux_mmc2_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x820, PIN_INPUT_PULLUP | MUX_MODE2)      /* gpmc_ad8.mmc1_dat0_mux0 */
-			AM33XX_IOPAD(0x824, PIN_INPUT_PULLUP | MUX_MODE2)      /* gpmc_ad9.mmc1_dat1_mux0 */
-			AM33XX_IOPAD(0x828, PIN_INPUT_PULLUP | MUX_MODE2)      /* gpmc_ad10.mmc1_dat2_mux0 */
-			AM33XX_IOPAD(0x82c, PIN_INPUT_PULLUP | MUX_MODE2)      /* gpmc_ad11.mmc1_dat3_mux0 */
-			AM33XX_IOPAD(0x880, PIN_INPUT_PULLUP | MUX_MODE2)      /* gpmc_csn1.mmc1_clk_mux0 */
-			AM33XX_IOPAD(0x884, PIN_INPUT_PULLUP | MUX_MODE2)      /* gpmc_csn2.mmc1_cmd_mux0 */
-			AM33XX_IOPAD(0x9e4, PIN_INPUT_PULLUP | MUX_MODE7)      /* emu0.gpio3[7] */
+			AM33XX_IOPAD(0x820, PIN_INPUT_PULLUP | MUX_MODE2)	/* gpmc_ad8.mmc1_dat0_mux0 */
+			AM33XX_IOPAD(0x824, PIN_INPUT_PULLUP | MUX_MODE2)	/* gpmc_ad9.mmc1_dat1_mux0 */
+			AM33XX_IOPAD(0x828, PIN_INPUT_PULLUP | MUX_MODE2)	/* gpmc_ad10.mmc1_dat2_mux0 */
+			AM33XX_IOPAD(0x82c, PIN_INPUT_PULLUP | MUX_MODE2)	/* gpmc_ad11.mmc1_dat3_mux0 */
+			AM33XX_IOPAD(0x880, PIN_INPUT_PULLUP | MUX_MODE2)	/* gpmc_csn1.mmc1_clk_mux0 */
+			AM33XX_IOPAD(0x884, PIN_INPUT_PULLUP | MUX_MODE2)	/* gpmc_csn2.mmc1_cmd_mux0 */
+			AM33XX_IOPAD(0x9e4, PIN_INPUT_PULLUP | MUX_MODE7)	/* emu0.gpio3[7] */
 		>;
 	};
 
 	wl12xx_gpio: pinmux_wl12xx_gpio {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x9e8, PIN_OUTPUT_PULLUP | MUX_MODE7)      /* emu1.gpio3[8] */
+			AM33XX_IOPAD(0x9e8, PIN_OUTPUT_PULLUP | MUX_MODE7)	/* emu1.gpio3[8] */
 		>;
 	};
 
 	tps65910_pins: pinmux_tps65910_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x878, PIN_INPUT_PULLUP | MUX_MODE7)      /* gpmc_ben1.gpio1[28] */
+			AM33XX_IOPAD(0x878, PIN_INPUT_PULLUP | MUX_MODE7)	/* gpmc_ben1.gpio1[28] */
 		>;
 	};
 
 	i2c1_pins: pinmux_i2c1_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x958, PIN_INPUT | MUX_MODE2)      /* spi0_d1.i2c1_sda_mux3 */
-			AM33XX_IOPAD(0x95c, PIN_INPUT | MUX_MODE2)      /* spi0_cs0.i2c1_scl_mux3 */
+			AM33XX_IOPAD(0x958, PIN_INPUT | MUX_MODE2)		/* spi0_d1.i2c1_sda_mux3 */
+			AM33XX_IOPAD(0x95c, PIN_INPUT | MUX_MODE2)		/* spi0_cs0.i2c1_scl_mux3 */
 		>;
 	};
 
 	uart0_pins: pinmux_uart0_pins {
 		pinctrl-single,pins = <
 			AM33XX_IOPAD(0x970, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
-			AM33XX_IOPAD(0x974, PIN_OUTPUT_PULLDOWN | MUX_MODE0)		/* uart0_txd.uart0_txd */
+			AM33XX_IOPAD(0x974, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart0_txd.uart0_txd */
 		>;
 	};
 
 	cpsw_default: cpsw_default {
 		pinctrl-single,pins = <
 			/* Slave 1 */
-			AM33XX_IOPAD(0x90c, PIN_INPUT_PULLDOWN | MUX_MODE1)       /* mii1_crs.rmii1_crs_dv */
-			AM33XX_IOPAD(0x914, PIN_OUTPUT_PULLDOWN | MUX_MODE1)      /* mii1_tx_en.rmii1_txen */
-			AM33XX_IOPAD(0x924, PIN_OUTPUT_PULLDOWN | MUX_MODE1)      /* mii1_txd1.rmii1_txd1 */
-			AM33XX_IOPAD(0x928, PIN_OUTPUT_PULLDOWN | MUX_MODE1)      /* mii1_txd0.rmii1_txd0 */
-			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLDOWN | MUX_MODE1)      /* mii1_rxd1.rmii1_rxd1 */
-			AM33XX_IOPAD(0x940, PIN_INPUT_PULLDOWN | MUX_MODE1)      /* mii1_rxd0.rmii1_rxd0 */
-			AM33XX_IOPAD(0x944, PIN_INPUT_PULLDOWN | MUX_MODE0)      /* rmii1_ref_clk.rmii1_refclk */
+			AM33XX_IOPAD(0x90c, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* mii1_crs.rmii1_crs_dv */
+			AM33XX_IOPAD(0x914, PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* mii1_tx_en.rmii1_txen */
+			AM33XX_IOPAD(0x924, PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* mii1_txd1.rmii1_txd1 */
+			AM33XX_IOPAD(0x928, PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* mii1_txd0.rmii1_txd0 */
+			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* mii1_rxd1.rmii1_rxd1 */
+			AM33XX_IOPAD(0x940, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* mii1_rxd0.rmii1_rxd0 */
+			AM33XX_IOPAD(0x944, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* rmii1_ref_clk.rmii1_refclk */
 
 
 			/* Slave 2 */
@@ -196,7 +196,7 @@
 		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
 		interrupt-parent = <&gpmc>;
 		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
-			     <1 IRQ_TYPE_NONE>;	/* termcount */
+			     <1 IRQ_TYPE_NONE>; /* termcount */
 		rb-gpios = <&gpmc 0 GPIO_ACTIVE_HIGH>; /* gpmc_wait0 */
 		nand-bus-width = <8>;
 		ti,nand-ecc-opt = "bch8";
diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index 456eef5..7105144 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -173,16 +173,16 @@
 
 	emmc_pins: pinmux_emmc_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x880, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_csn1.mmc1_clk */
-			AM33XX_IOPAD(0x884, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_csn2.mmc1_cmd */
-			AM33XX_IOPAD(0x800, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad0.mmc1_dat0 */
-			AM33XX_IOPAD(0x804, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad1.mmc1_dat1 */
-			AM33XX_IOPAD(0x808, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad2.mmc1_dat2 */
-			AM33XX_IOPAD(0x80c, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad3.mmc1_dat3 */
-			AM33XX_IOPAD(0x810, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad4.mmc1_dat4 */
-			AM33XX_IOPAD(0x814, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad5.mmc1_dat5 */
-			AM33XX_IOPAD(0x818, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad6.mmc1_dat6 */
-			AM33XX_IOPAD(0x81c, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad7.mmc1_dat7 */
+			AM33XX_IOPAD(0x880, PIN_INPUT_PULLUP | MUX_MODE2)	/* gpmc_csn1.mmc1_clk */
+			AM33XX_IOPAD(0x884, PIN_INPUT_PULLUP | MUX_MODE2)	/* gpmc_csn2.mmc1_cmd */
+			AM33XX_IOPAD(0x800, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad0.mmc1_dat0 */
+			AM33XX_IOPAD(0x804, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad1.mmc1_dat1 */
+			AM33XX_IOPAD(0x808, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad2.mmc1_dat2 */
+			AM33XX_IOPAD(0x80c, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad3.mmc1_dat3 */
+			AM33XX_IOPAD(0x810, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad4.mmc1_dat4 */
+			AM33XX_IOPAD(0x814, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad5.mmc1_dat5 */
+			AM33XX_IOPAD(0x818, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad6.mmc1_dat6 */
+			AM33XX_IOPAD(0x81c, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad7.mmc1_dat7 */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/am335x-boneblack-common.dtsi b/arch/arm/boot/dts/am335x-boneblack-common.dtsi
index e543c2b..d4609bb 100644
--- a/arch/arm/boot/dts/am335x-boneblack-common.dtsi
+++ b/arch/arm/boot/dts/am335x-boneblack-common.dtsi
@@ -62,11 +62,11 @@
 
 	mcasp0_pins: mcasp0_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x9ac, PIN_INPUT_PULLUP | MUX_MODE0) /* mcasp0_ahcklx.mcasp0_ahclkx */
-			AM33XX_IOPAD(0x99c, PIN_OUTPUT_PULLDOWN | MUX_MODE2) /* mcasp0_ahclkr.mcasp0_axr2*/
-			AM33XX_IOPAD(0x994, PIN_OUTPUT_PULLUP | MUX_MODE0) /* mcasp0_fsx.mcasp0_fsx */
-			AM33XX_IOPAD(0x990, PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* mcasp0_aclkx.mcasp0_aclkx */
-			AM33XX_IOPAD(0x86c, PIN_OUTPUT_PULLDOWN | MUX_MODE7) /* gpmc_a11.GPIO1_27 */
+			AM33XX_IOPAD(0x9ac, PIN_INPUT_PULLUP | MUX_MODE0)	/* mcasp0_ahcklx.mcasp0_ahclkx */
+			AM33XX_IOPAD(0x99c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mcasp0_ahclkr.mcasp0_axr2*/
+			AM33XX_IOPAD(0x994, PIN_OUTPUT_PULLUP | MUX_MODE0)	/* mcasp0_fsx.mcasp0_fsx */
+			AM33XX_IOPAD(0x990, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* mcasp0_aclkx.mcasp0_aclkx */
+			AM33XX_IOPAD(0x86c, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a11.GPIO1_27 */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/am335x-boneblack-wireless.dts b/arch/arm/boot/dts/am335x-boneblack-wireless.dts
index 83f49f6..9162fb9 100644
--- a/arch/arm/boot/dts/am335x-boneblack-wireless.dts
+++ b/arch/arm/boot/dts/am335x-boneblack-wireless.dts
@@ -38,12 +38,12 @@
 
 	mmc3_pins: pinmux_mmc3_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLUP | MUX_MODE6 ) /* (L15) gmii1_rxd1.mmc2_clk */
-			AM33XX_IOPAD(0x914, PIN_INPUT_PULLUP | MUX_MODE6 ) /* (J16) gmii1_txen.mmc2_cmd */
-			AM33XX_IOPAD(0x918, PIN_INPUT_PULLUP | MUX_MODE5 ) /* (J17) gmii1_rxdv.mmc2_dat0 */
-			AM33XX_IOPAD(0x91c, PIN_INPUT_PULLUP | MUX_MODE5 ) /* (J18) gmii1_txd3.mmc2_dat1 */
-			AM33XX_IOPAD(0x920, PIN_INPUT_PULLUP | MUX_MODE5 ) /* (K15) gmii1_txd2.mmc2_dat2 */
-			AM33XX_IOPAD(0x908, PIN_INPUT_PULLUP | MUX_MODE5 ) /* (H16) gmii1_col.mmc2_dat3 */
+			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLUP | MUX_MODE6 )	/* (L15) gmii1_rxd1.mmc2_clk */
+			AM33XX_IOPAD(0x914, PIN_INPUT_PULLUP | MUX_MODE6 )	/* (J16) gmii1_txen.mmc2_cmd */
+			AM33XX_IOPAD(0x918, PIN_INPUT_PULLUP | MUX_MODE5 )	/* (J17) gmii1_rxdv.mmc2_dat0 */
+			AM33XX_IOPAD(0x91c, PIN_INPUT_PULLUP | MUX_MODE5 )	/* (J18) gmii1_txd3.mmc2_dat1 */
+			AM33XX_IOPAD(0x920, PIN_INPUT_PULLUP | MUX_MODE5 )	/* (K15) gmii1_txd2.mmc2_dat2 */
+			AM33XX_IOPAD(0x908, PIN_INPUT_PULLUP | MUX_MODE5 )	/* (H16) gmii1_col.mmc2_dat3 */
 		>;
 	};
 
diff --git a/arch/arm/boot/dts/am335x-chiliboard.dts b/arch/arm/boot/dts/am335x-chiliboard.dts
index bffa5dc..6838821 100644
--- a/arch/arm/boot/dts/am335x-chiliboard.dts
+++ b/arch/arm/boot/dts/am335x-chiliboard.dts
@@ -49,7 +49,7 @@
 	cpsw_default: cpsw_default {
 		pinctrl-single,pins = <
 			/* Slave 1 */
-			AM33XX_IOPAD(0x90c, PIN_INPUT_PULLDOWN | MUX_MODE1)  /* mii1_crs.rmii1_crs */
+			AM33XX_IOPAD(0x90c, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* mii1_crs.rmii1_crs */
 			AM33XX_IOPAD(0x910, PIN_INPUT_PULLUP | MUX_MODE1)	/* mii1_rxerr.rmii1_rxerr */
 			AM33XX_IOPAD(0x914, PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* mii1_txen.rmii1_txen */
 			AM33XX_IOPAD(0x924, PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* mii1_txd1.rmii1_txd1 */
@@ -94,26 +94,26 @@
 
 	usb1_drvvbus: usb1_drvvbus {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0xa34, PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* usb1_drvvbus.usb1_drvvbus */
+			AM33XX_IOPAD(0xa34, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* usb1_drvvbus.usb1_drvvbus */
 		>;
 	};
 
 	sd_pins: pinmux_sd_card {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x8f0, PIN_INPUT | MUX_MODE0) /* mmc0_dat0.mmc0_dat0 */
-			AM33XX_IOPAD(0x8f4, PIN_INPUT | MUX_MODE0) /* mmc0_dat1.mmc0_dat1 */
-			AM33XX_IOPAD(0x8f8, PIN_INPUT | MUX_MODE0) /* mmc0_dat2.mmc0_dat2 */
-			AM33XX_IOPAD(0x8fc, PIN_INPUT | MUX_MODE0) /* mmc0_dat3.mmc0_dat3 */
-			AM33XX_IOPAD(0x900, PIN_INPUT | MUX_MODE0) /* mmc0_clk.mmc0_clk */
-			AM33XX_IOPAD(0x904, PIN_INPUT | MUX_MODE0) /* mmc0_cmd.mmc0_cmd */
-			AM33XX_IOPAD(0x960, PIN_INPUT | MUX_MODE7) /* spi0_cs1.gpio0_6 */
+			AM33XX_IOPAD(0x8f0, PIN_INPUT | MUX_MODE0)		/* mmc0_dat0.mmc0_dat0 */
+			AM33XX_IOPAD(0x8f4, PIN_INPUT | MUX_MODE0)		/* mmc0_dat1.mmc0_dat1 */
+			AM33XX_IOPAD(0x8f8, PIN_INPUT | MUX_MODE0)		/* mmc0_dat2.mmc0_dat2 */
+			AM33XX_IOPAD(0x8fc, PIN_INPUT | MUX_MODE0)		/* mmc0_dat3.mmc0_dat3 */
+			AM33XX_IOPAD(0x900, PIN_INPUT | MUX_MODE0)		/* mmc0_clk.mmc0_clk */
+			AM33XX_IOPAD(0x904, PIN_INPUT | MUX_MODE0)		/* mmc0_cmd.mmc0_cmd */
+			AM33XX_IOPAD(0x960, PIN_INPUT | MUX_MODE7)		/* spi0_cs1.gpio0_6 */
 		>;
 	};
 
 	led_gpio_pins: led_gpio_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x9e4, PIN_OUTPUT | MUX_MODE7) /* emu0.gpio3_7 */
-			AM33XX_IOPAD(0x9e8, PIN_OUTPUT | MUX_MODE7) /* emu1.gpio3_8 */
+			AM33XX_IOPAD(0x9e4, PIN_OUTPUT | MUX_MODE7)		/* emu0.gpio3_7 */
+			AM33XX_IOPAD(0x9e8, PIN_OUTPUT | MUX_MODE7)		/* emu1.gpio3_8 */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index dce5be5..167b3a9 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -368,10 +368,10 @@
 
 	mcasp1_pins: mcasp1_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x90c, PIN_INPUT_PULLDOWN | MUX_MODE4) /* mii1_crs.mcasp1_aclkx */
-			AM33XX_IOPAD(0x910, PIN_INPUT_PULLDOWN | MUX_MODE4) /* mii1_rxerr.mcasp1_fsx */
-			AM33XX_IOPAD(0x908, PIN_OUTPUT_PULLDOWN | MUX_MODE4) /* mii1_col.mcasp1_axr2 */
-			AM33XX_IOPAD(0x944, PIN_INPUT_PULLDOWN | MUX_MODE4) /* rmii1_ref_clk.mcasp1_axr3 */
+			AM33XX_IOPAD(0x90c, PIN_INPUT_PULLDOWN | MUX_MODE4)	/* mii1_crs.mcasp1_aclkx */
+			AM33XX_IOPAD(0x910, PIN_INPUT_PULLDOWN | MUX_MODE4)	/* mii1_rxerr.mcasp1_fsx */
+			AM33XX_IOPAD(0x908, PIN_OUTPUT_PULLDOWN | MUX_MODE4)	/* mii1_col.mcasp1_axr2 */
+			AM33XX_IOPAD(0x944, PIN_INPUT_PULLDOWN | MUX_MODE4)	/* rmii1_ref_clk.mcasp1_axr3 */
 		>;
 	};
 
@@ -386,8 +386,8 @@
 
 	dcan1_pins_default: dcan1_pins_default {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x968, PIN_OUTPUT | MUX_MODE2) /* uart0_ctsn.d_can1_tx */
-			AM33XX_IOPAD(0x96c, PIN_INPUT_PULLDOWN | MUX_MODE2) /* uart0_rtsn.d_can1_rx */
+			AM33XX_IOPAD(0x968, PIN_OUTPUT | MUX_MODE2)		/* uart0_ctsn.d_can1_tx */
+			AM33XX_IOPAD(0x96c, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* uart0_rtsn.d_can1_rx */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index b128998..df75098 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -250,22 +250,22 @@
 			AM33XX_IOPAD(0x834, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad13.lcd_data18 */
 			AM33XX_IOPAD(0x838, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad14.lcd_data17 */
 			AM33XX_IOPAD(0x83c, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad15.lcd_data16 */
-			AM33XX_IOPAD(0x8a0, PULL_DISABLE | MUX_MODE7)	/* lcd_data0.lcd_data0 */
-			AM33XX_IOPAD(0x8a4, PULL_DISABLE | MUX_MODE7)	/* lcd_data1.lcd_data1 */
-			AM33XX_IOPAD(0x8a8, PULL_DISABLE | MUX_MODE7)	/* lcd_data2.lcd_data2 */
-			AM33XX_IOPAD(0x8ac, PULL_DISABLE | MUX_MODE7)	/* lcd_data3.lcd_data3 */
-			AM33XX_IOPAD(0x8b0, PULL_DISABLE | MUX_MODE7)	/* lcd_data4.lcd_data4 */
-			AM33XX_IOPAD(0x8b4, PULL_DISABLE | MUX_MODE7)	/* lcd_data5.lcd_data5 */
-			AM33XX_IOPAD(0x8b8, PULL_DISABLE | MUX_MODE7)	/* lcd_data6.lcd_data6 */
-			AM33XX_IOPAD(0x8bc, PULL_DISABLE | MUX_MODE7)	/* lcd_data7.lcd_data7 */
-			AM33XX_IOPAD(0x8c0, PULL_DISABLE | MUX_MODE7)	/* lcd_data8.lcd_data8 */
-			AM33XX_IOPAD(0x8c4, PULL_DISABLE | MUX_MODE7)	/* lcd_data9.lcd_data9 */
-			AM33XX_IOPAD(0x8c8, PULL_DISABLE | MUX_MODE7)	/* lcd_data10.lcd_data10 */
-			AM33XX_IOPAD(0x8cc, PULL_DISABLE | MUX_MODE7)	/* lcd_data11.lcd_data11 */
-			AM33XX_IOPAD(0x8d0, PULL_DISABLE | MUX_MODE7)	/* lcd_data12.lcd_data12 */
-			AM33XX_IOPAD(0x8d4, PULL_DISABLE | MUX_MODE7)	/* lcd_data13.lcd_data13 */
-			AM33XX_IOPAD(0x8d8, PULL_DISABLE | MUX_MODE7)	/* lcd_data14.lcd_data14 */
-			AM33XX_IOPAD(0x8dc, PULL_DISABLE | MUX_MODE7)	/* lcd_data15.lcd_data15 */
+			AM33XX_IOPAD(0x8a0, PULL_DISABLE | MUX_MODE7)		/* lcd_data0.lcd_data0 */
+			AM33XX_IOPAD(0x8a4, PULL_DISABLE | MUX_MODE7)		/* lcd_data1.lcd_data1 */
+			AM33XX_IOPAD(0x8a8, PULL_DISABLE | MUX_MODE7)		/* lcd_data2.lcd_data2 */
+			AM33XX_IOPAD(0x8ac, PULL_DISABLE | MUX_MODE7)		/* lcd_data3.lcd_data3 */
+			AM33XX_IOPAD(0x8b0, PULL_DISABLE | MUX_MODE7)		/* lcd_data4.lcd_data4 */
+			AM33XX_IOPAD(0x8b4, PULL_DISABLE | MUX_MODE7)		/* lcd_data5.lcd_data5 */
+			AM33XX_IOPAD(0x8b8, PULL_DISABLE | MUX_MODE7)		/* lcd_data6.lcd_data6 */
+			AM33XX_IOPAD(0x8bc, PULL_DISABLE | MUX_MODE7)		/* lcd_data7.lcd_data7 */
+			AM33XX_IOPAD(0x8c0, PULL_DISABLE | MUX_MODE7)		/* lcd_data8.lcd_data8 */
+			AM33XX_IOPAD(0x8c4, PULL_DISABLE | MUX_MODE7)		/* lcd_data9.lcd_data9 */
+			AM33XX_IOPAD(0x8c8, PULL_DISABLE | MUX_MODE7)		/* lcd_data10.lcd_data10 */
+			AM33XX_IOPAD(0x8cc, PULL_DISABLE | MUX_MODE7)		/* lcd_data11.lcd_data11 */
+			AM33XX_IOPAD(0x8d0, PULL_DISABLE | MUX_MODE7)		/* lcd_data12.lcd_data12 */
+			AM33XX_IOPAD(0x8d4, PULL_DISABLE | MUX_MODE7)		/* lcd_data13.lcd_data13 */
+			AM33XX_IOPAD(0x8d8, PULL_DISABLE | MUX_MODE7)		/* lcd_data14.lcd_data14 */
+			AM33XX_IOPAD(0x8dc, PULL_DISABLE | MUX_MODE7)		/* lcd_data15.lcd_data15 */
 			AM33XX_IOPAD(0x8e0, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* lcd_vsync.lcd_vsync */
 			AM33XX_IOPAD(0x8e4, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* lcd_hsync.lcd_hsync */
 			AM33XX_IOPAD(0x8e8, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* lcd_pclk.lcd_pclk */
@@ -413,10 +413,10 @@
 
 	mcasp1_pins: mcasp1_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x90c, PIN_INPUT_PULLDOWN | MUX_MODE4) /* mii1_crs.mcasp1_aclkx */
-			AM33XX_IOPAD(0x910, PIN_INPUT_PULLDOWN | MUX_MODE4) /* mii1_rxerr.mcasp1_fsx */
-			AM33XX_IOPAD(0x908, PIN_OUTPUT_PULLDOWN | MUX_MODE4) /* mii1_col.mcasp1_axr2 */
-			AM33XX_IOPAD(0x944, PIN_INPUT_PULLDOWN | MUX_MODE4) /* rmii1_ref_clk.mcasp1_axr3 */
+			AM33XX_IOPAD(0x90c, PIN_INPUT_PULLDOWN | MUX_MODE4)	/* mii1_crs.mcasp1_aclkx */
+			AM33XX_IOPAD(0x910, PIN_INPUT_PULLDOWN | MUX_MODE4)	/* mii1_rxerr.mcasp1_fsx */
+			AM33XX_IOPAD(0x908, PIN_OUTPUT_PULLDOWN | MUX_MODE4)	/* mii1_col.mcasp1_axr2 */
+			AM33XX_IOPAD(0x944, PIN_INPUT_PULLDOWN | MUX_MODE4)	/* rmii1_ref_clk.mcasp1_axr3 */
 		>;
 	};
 
@@ -431,19 +431,19 @@
 
 	mmc2_pins: pinmux_mmc2_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x874, PIN_INPUT_PULLUP | MUX_MODE7) /* gpmc_wpn.gpio0_31 */
-			AM33XX_IOPAD(0x880, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_csn1.mmc1_clk */
-			AM33XX_IOPAD(0x884, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_csn2.mmc1_cmd */
-			AM33XX_IOPAD(0x800, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad0.mmc1_dat0 */
-			AM33XX_IOPAD(0x804, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad1.mmc1_dat1 */
-			AM33XX_IOPAD(0x808, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad2.mmc1_dat2 */
-			AM33XX_IOPAD(0x80c, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad3.mmc1_dat3 */
+			AM33XX_IOPAD(0x874, PIN_INPUT_PULLUP | MUX_MODE7)	/* gpmc_wpn.gpio0_31 */
+			AM33XX_IOPAD(0x880, PIN_INPUT_PULLUP | MUX_MODE2)	/* gpmc_csn1.mmc1_clk */
+			AM33XX_IOPAD(0x884, PIN_INPUT_PULLUP | MUX_MODE2)	/* gpmc_csn2.mmc1_cmd */
+			AM33XX_IOPAD(0x800, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad0.mmc1_dat0 */
+			AM33XX_IOPAD(0x804, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad1.mmc1_dat1 */
+			AM33XX_IOPAD(0x808, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad2.mmc1_dat2 */
+			AM33XX_IOPAD(0x80c, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad3.mmc1_dat3 */
 		>;
 	};
 
 	wl12xx_gpio: pinmux_wl12xx_gpio {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x87c, PIN_OUTPUT_PULLUP | MUX_MODE7) /* gpmc_csn0.gpio1_29 */
+			AM33XX_IOPAD(0x87c, PIN_OUTPUT_PULLUP | MUX_MODE7)	/* gpmc_csn0.gpio1_29 */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/am335x-icev2.dts b/arch/arm/boot/dts/am335x-icev2.dts
index 9ac775c..f37bc80 100644
--- a/arch/arm/boot/dts/am335x-icev2.dts
+++ b/arch/arm/boot/dts/am335x-icev2.dts
@@ -157,48 +157,48 @@
 &am33xx_pinmux {
 	user_leds: user_leds {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x91c, PIN_OUTPUT | MUX_MODE7) /* (J18) gmii1_txd3.gpio0[16] */
-			AM33XX_IOPAD(0x920, PIN_OUTPUT | MUX_MODE7) /* (K15) gmii1_txd2.gpio0[17] */
-			AM33XX_IOPAD(0x9b0, PIN_OUTPUT | MUX_MODE7) /* (A15) xdma_event_intr0.gpio0[19] */
-			AM33XX_IOPAD(0x9b4, PIN_OUTPUT | MUX_MODE7) /* (D14) xdma_event_intr1.gpio0[20] */
-			AM33XX_IOPAD(0x880, PIN_OUTPUT | MUX_MODE7) /* (U9) gpmc_csn1.gpio1[30] */
-			AM33XX_IOPAD(0x92c, PIN_OUTPUT | MUX_MODE7) /* (K18) gmii1_txclk.gpio3[9] */
+			AM33XX_IOPAD(0x91c, PIN_OUTPUT | MUX_MODE7)	/* (J18) gmii1_txd3.gpio0[16] */
+			AM33XX_IOPAD(0x920, PIN_OUTPUT | MUX_MODE7)	/* (K15) gmii1_txd2.gpio0[17] */
+			AM33XX_IOPAD(0x9b0, PIN_OUTPUT | MUX_MODE7)	/* (A15) xdma_event_intr0.gpio0[19] */
+			AM33XX_IOPAD(0x9b4, PIN_OUTPUT | MUX_MODE7)	/* (D14) xdma_event_intr1.gpio0[20] */
+			AM33XX_IOPAD(0x880, PIN_OUTPUT | MUX_MODE7)	/* (U9) gpmc_csn1.gpio1[30] */
+			AM33XX_IOPAD(0x92c, PIN_OUTPUT | MUX_MODE7)	/* (K18) gmii1_txclk.gpio3[9] */
 		>;
 	};
 
 	mmc0_pins_default: mmc0_pins_default {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x8f0, PIN_INPUT_PULLUP | MUX_MODE0) /* (F17) mmc0_dat3.mmc0_dat3 */
-			AM33XX_IOPAD(0x8f4, PIN_INPUT_PULLUP | MUX_MODE0) /* (F18) mmc0_dat2.mmc0_dat2 */
-			AM33XX_IOPAD(0x8f8, PIN_INPUT_PULLUP | MUX_MODE0) /* (G15) mmc0_dat1.mmc0_dat1 */
-			AM33XX_IOPAD(0x8fc, PIN_INPUT_PULLUP | MUX_MODE0) /* (G16) mmc0_dat0.mmc0_dat0 */
-			AM33XX_IOPAD(0x900, PIN_INPUT_PULLUP | MUX_MODE0) /* (G17) mmc0_clk.mmc0_clk */
-			AM33XX_IOPAD(0x904, PIN_INPUT_PULLUP | MUX_MODE0) /* (G18) mmc0_cmd.mmc0_cmd */
+			AM33XX_IOPAD(0x8f0, PIN_INPUT_PULLUP | MUX_MODE0)	/* (F17) mmc0_dat3.mmc0_dat3 */
+			AM33XX_IOPAD(0x8f4, PIN_INPUT_PULLUP | MUX_MODE0)	/* (F18) mmc0_dat2.mmc0_dat2 */
+			AM33XX_IOPAD(0x8f8, PIN_INPUT_PULLUP | MUX_MODE0)	/* (G15) mmc0_dat1.mmc0_dat1 */
+			AM33XX_IOPAD(0x8fc, PIN_INPUT_PULLUP | MUX_MODE0)	/* (G16) mmc0_dat0.mmc0_dat0 */
+			AM33XX_IOPAD(0x900, PIN_INPUT_PULLUP | MUX_MODE0)	/* (G17) mmc0_clk.mmc0_clk */
+			AM33XX_IOPAD(0x904, PIN_INPUT_PULLUP | MUX_MODE0)	/* (G18) mmc0_cmd.mmc0_cmd */
 		>;
 	};
 
 	i2c0_pins_default: i2c0_pins_default {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x988, PIN_INPUT | MUX_MODE0) /* (C17) I2C0_SDA.I2C0_SDA */
-			AM33XX_IOPAD(0x98c, PIN_INPUT | MUX_MODE0) /* (C16) I2C0_SCL.I2C0_SCL */
+			AM33XX_IOPAD(0x988, PIN_INPUT | MUX_MODE0)		/* (C17) I2C0_SDA.I2C0_SDA */
+			AM33XX_IOPAD(0x98c, PIN_INPUT | MUX_MODE0)		/* (C16) I2C0_SCL.I2C0_SCL */
 		>;
 	};
 
 	spi0_pins_default: spi0_pins_default {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x950, PIN_INPUT_PULLUP | MUX_MODE0) /* (A17) spi0_sclk.spi0_sclk */
-			AM33XX_IOPAD(0x954, PIN_INPUT_PULLUP | MUX_MODE0) /* (B17) spi0_d0.spi0_d0 */
-			AM33XX_IOPAD(0x958, PIN_INPUT_PULLUP | MUX_MODE0) /* (B16) spi0_d1.spi0_d1 */
-			AM33XX_IOPAD(0x95c, PIN_INPUT_PULLUP | MUX_MODE0) /* (A16) spi0_cs0.spi0_cs0 */
-			AM33XX_IOPAD(0x960, PIN_INPUT_PULLUP | MUX_MODE0) /* (C15) spi0_cs1.spi0_cs1 */
-			AM33XX_IOPAD(0x9a0, PIN_INPUT_PULLUP | MUX_MODE7) /* (B12) mcasp0_aclkr.gpio3[18] */
+			AM33XX_IOPAD(0x950, PIN_INPUT_PULLUP | MUX_MODE0)	/* (A17) spi0_sclk.spi0_sclk */
+			AM33XX_IOPAD(0x954, PIN_INPUT_PULLUP | MUX_MODE0)	/* (B17) spi0_d0.spi0_d0 */
+			AM33XX_IOPAD(0x958, PIN_INPUT_PULLUP | MUX_MODE0)	/* (B16) spi0_d1.spi0_d1 */
+			AM33XX_IOPAD(0x95c, PIN_INPUT_PULLUP | MUX_MODE0)	/* (A16) spi0_cs0.spi0_cs0 */
+			AM33XX_IOPAD(0x960, PIN_INPUT_PULLUP | MUX_MODE0)	/* (C15) spi0_cs1.spi0_cs1 */
+			AM33XX_IOPAD(0x9a0, PIN_INPUT_PULLUP | MUX_MODE7)	/* (B12) mcasp0_aclkr.gpio3[18] */
 		>;
 	};
 
 	uart3_pins_default: uart3_pins_default {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x934, PIN_INPUT_PULLUP | MUX_MODE1) /* (L17) gmii1_rxd3.uart3_rxd */
-			AM33XX_IOPAD(0x938, PIN_OUTPUT_PULLUP | MUX_MODE1) /* (L16) gmii1_rxd2.uart3_txd */
+			AM33XX_IOPAD(0x934, PIN_INPUT_PULLUP | MUX_MODE1)	/* (L17) gmii1_rxd3.uart3_rxd */
+			AM33XX_IOPAD(0x938, PIN_OUTPUT_PULLUP | MUX_MODE1)	/* (L16) gmii1_rxd2.uart3_txd */
 		>;
 	};
 
diff --git a/arch/arm/boot/dts/am335x-igep0033.dtsi b/arch/arm/boot/dts/am335x-igep0033.dtsi
index cbd22f2..af2b749 100644
--- a/arch/arm/boot/dts/am335x-igep0033.dtsi
+++ b/arch/arm/boot/dts/am335x-igep0033.dtsi
@@ -325,4 +325,3 @@
 		};
 	};
 };
-
diff --git a/arch/arm/boot/dts/am335x-lxm.dts b/arch/arm/boot/dts/am335x-lxm.dts
index d0e8e72..cd01d08 100644
--- a/arch/arm/boot/dts/am335x-lxm.dts
+++ b/arch/arm/boot/dts/am335x-lxm.dts
@@ -132,16 +132,16 @@
 
 	emmc_pins: pinmux_emmc_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x880, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_csn1.mmc1_clk */
-			AM33XX_IOPAD(0x884, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_csn2.mmc1_cmd */
-			AM33XX_IOPAD(0x800, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad0.mmc1_dat0 */
-			AM33XX_IOPAD(0x804, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad1.mmc1_dat1 */
-			AM33XX_IOPAD(0x808, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad2.mmc1_dat2 */
-			AM33XX_IOPAD(0x80c, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad3.mmc1_dat3 */
-			AM33XX_IOPAD(0x810, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad4.mmc1_dat4 */
-			AM33XX_IOPAD(0x814, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad5.mmc1_dat5 */
-			AM33XX_IOPAD(0x818, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad6.mmc1_dat6 */
-			AM33XX_IOPAD(0x81c, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad7.mmc1_dat7 */
+			AM33XX_IOPAD(0x880, PIN_INPUT_PULLUP | MUX_MODE2)	/* gpmc_csn1.mmc1_clk */
+			AM33XX_IOPAD(0x884, PIN_INPUT_PULLUP | MUX_MODE2)	/* gpmc_csn2.mmc1_cmd */
+			AM33XX_IOPAD(0x800, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad0.mmc1_dat0 */
+			AM33XX_IOPAD(0x804, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad1.mmc1_dat1 */
+			AM33XX_IOPAD(0x808, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad2.mmc1_dat2 */
+			AM33XX_IOPAD(0x80c, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad3.mmc1_dat3 */
+			AM33XX_IOPAD(0x810, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad4.mmc1_dat4 */
+			AM33XX_IOPAD(0x814, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad5.mmc1_dat5 */
+			AM33XX_IOPAD(0x818, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad6.mmc1_dat6 */
+			AM33XX_IOPAD(0x81c, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad7.mmc1_dat7 */
 		>;
 	};
 
@@ -367,4 +367,3 @@
 	ti,non-removable;
 	status = "okay";
 };
-
diff --git a/arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts b/arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts
index e562ce4..153a5a1 100644
--- a/arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts
+++ b/arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts
@@ -141,8 +141,8 @@
 	uart1_pins: pinmux_uart1_pins {
 		pinctrl-single,pins = <
 			AM33XX_IOPAD(0x978, PIN_INPUT | MUX_MODE0)		/* uart1_ctsn.uart1_ctsn */
-			AM33XX_IOPAD(0x97C, PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* uart1_rtsn.uart1_rtsn */
-			AM33XX_IOPAD(0x980, PIN_INPUT_PULLUP | MUX_MODE0)    /* uart1_rxd.uart1_rxd */
+			AM33XX_IOPAD(0x97C, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart1_rtsn.uart1_rtsn */
+			AM33XX_IOPAD(0x980, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart1_rxd.uart1_rxd */
 			AM33XX_IOPAD(0x984, PIN_OUTPUT | MUX_MODE0)		/* uart1_txd.uart1_txd */
 		>;
 	};
@@ -150,8 +150,8 @@
 	uart2_pins: pinmux_uart2_pins {
 		pinctrl-single,pins = <
 			AM33XX_IOPAD(0x8d8, PIN_INPUT | MUX_MODE6)		/* lcd_data14.uart5_ctsn */
-			AM33XX_IOPAD(0x8dc, PIN_OUTPUT_PULLDOWN | MUX_MODE6)  /* lcd_data15.uart5_rtsn */
-			AM33XX_IOPAD(0x8c4, PIN_INPUT_PULLUP | MUX_MODE4)     /* lcd_data9.uart5_rxd */
+			AM33XX_IOPAD(0x8dc, PIN_OUTPUT_PULLDOWN | MUX_MODE6)	/* lcd_data15.uart5_rtsn */
+			AM33XX_IOPAD(0x8c4, PIN_INPUT_PULLUP | MUX_MODE4)	/* lcd_data9.uart5_rxd */
 			AM33XX_IOPAD(0x8c0, PIN_OUTPUT | MUX_MODE4)		/* lcd_data8.uart5_txd */
 		>;
 	};
@@ -159,24 +159,24 @@
 	cpsw_default: cpsw_default {
 		pinctrl-single,pins = <
 			/* Slave 1 */
-			AM33XX_IOPAD(0x90c, PIN_INPUT_PULLDOWN | MUX_MODE1)  /* mii1_crs.rmii1_crs_dv */
-			AM33XX_IOPAD(0x910, PIN_INPUT_PULLUP | MUX_MODE1)    /* mii1_rxerr.rmii1_rxerr */
-			AM33XX_IOPAD(0x914, PIN_OUTPUT_PULLDOWN | MUX_MODE1) /* mii1_txen.rmii1_txen */
-			AM33XX_IOPAD(0x924, PIN_OUTPUT_PULLDOWN | MUX_MODE1) /* mii1_txd1.rmii1_txd1 */
-			AM33XX_IOPAD(0x928, PIN_OUTPUT_PULLDOWN | MUX_MODE1) /* mii1_txd0.rmii1_txd0 */
-			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLUP | MUX_MODE1)    /* mii1_rxd1.rmii1_rxd1 */
-			AM33XX_IOPAD(0x940, PIN_INPUT_PULLUP | MUX_MODE1)    /* mii1_rxd0.rmii1_rxd0 */
-			AM33XX_IOPAD(0x944, PIN_INPUT_PULLDOWN | MUX_MODE0)  /* mii1_refclk.rmii1_refclk */
+			AM33XX_IOPAD(0x90c, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* mii1_crs.rmii1_crs_dv */
+			AM33XX_IOPAD(0x910, PIN_INPUT_PULLUP | MUX_MODE1)	/* mii1_rxerr.rmii1_rxerr */
+			AM33XX_IOPAD(0x914, PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* mii1_txen.rmii1_txen */
+			AM33XX_IOPAD(0x924, PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* mii1_txd1.rmii1_txd1 */
+			AM33XX_IOPAD(0x928, PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* mii1_txd0.rmii1_txd0 */
+			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLUP | MUX_MODE1)	/* mii1_rxd1.rmii1_rxd1 */
+			AM33XX_IOPAD(0x940, PIN_INPUT_PULLUP | MUX_MODE1)	/* mii1_rxd0.rmii1_rxd0 */
+			AM33XX_IOPAD(0x944, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mii1_refclk.rmii1_refclk */
 
 			/* Slave 2 */
-			AM33XX_IOPAD(0x870, PIN_INPUT_PULLDOWN | MUX_MODE3)   /* rmii2_crs_dv */
-			AM33XX_IOPAD(0x874, PIN_INPUT_PULLDOWN | MUX_MODE3)   /* rmii2_rxer */
-			AM33XX_IOPAD(0x840, PIN_OUTPUT_PULLDOWN | MUX_MODE3)  /* rmii2_txen */
-			AM33XX_IOPAD(0x850, PIN_OUTPUT_PULLDOWN | MUX_MODE3)  /* rmii2_td1 */
-			AM33XX_IOPAD(0x854, PIN_OUTPUT_PULLDOWN | MUX_MODE3)  /* rmii2_td0 */
-			AM33XX_IOPAD(0x868, PIN_INPUT_PULLDOWN | MUX_MODE3)   /* rmii2_rd1 */
-			AM33XX_IOPAD(0x86c, PIN_INPUT_PULLDOWN | MUX_MODE3)   /* rmii2_rd0 */
-			AM33XX_IOPAD(0x908, PIN_INPUT_PULLDOWN | MUX_MODE1)  /* rmii2_refclk */
+			AM33XX_IOPAD(0x870, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* rmii2_crs_dv */
+			AM33XX_IOPAD(0x874, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* rmii2_rxer */
+			AM33XX_IOPAD(0x840, PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* rmii2_txen */
+			AM33XX_IOPAD(0x850, PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* rmii2_td1 */
+			AM33XX_IOPAD(0x854, PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* rmii2_td0 */
+			AM33XX_IOPAD(0x868, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* rmii2_rd1 */
+			AM33XX_IOPAD(0x86c, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* rmii2_rd0 */
+			AM33XX_IOPAD(0x908, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* rmii2_refclk */
 
 		>;
 	};
@@ -198,7 +198,7 @@
 			AM33XX_IOPAD(0x900, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_clk */
 			AM33XX_IOPAD(0x904, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_cmd */
 			AM33XX_IOPAD(0x990, PIN_INPUT_PULLUP | MUX_MODE7)	/* mcasp0_aclkx.gpio3_14 */
-			AM33XX_IOPAD(0x9a0, PIN_INPUT_PULLUP | MUX_MODE7)    /* mcasp0_aclkx.gpio3_18 */
+			AM33XX_IOPAD(0x9a0, PIN_INPUT_PULLUP | MUX_MODE7)	/* mcasp0_aclkx.gpio3_18 */
 		>;
 	};
 
@@ -213,17 +213,17 @@
 			AM33XX_IOPAD(0x824, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_ad9.mmc2_dat5 */
 			AM33XX_IOPAD(0x828, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_ad10.mmc2_dat6 */
 			AM33XX_IOPAD(0x82c, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_ad11.mmc2_dat7 */
-			AM33XX_IOPAD(0x888, PIN_INPUT_PULLUP | MUX_MODE3)     /* gpmc_csn3.mmc2_cmd */
+			AM33XX_IOPAD(0x888, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_csn3.mmc2_cmd */
 			AM33XX_IOPAD(0x88c, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_clk.mmc2_clk */
 		>;
 	};
 
 	spi0_pins: pinmux_spi0 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x950, PIN_INPUT_PULLUP | MUX_MODE0) /* spi0_sclk.spi0_sclk */
-			AM33XX_IOPAD(0x95C, PIN_INPUT_PULLUP | MUX_MODE0) /* spi0_cs0.spi0_cs0 */
-			AM33XX_IOPAD(0x954, PIN_INPUT_PULLUP | MUX_MODE0) /* spi0_d0.spi0_d0 */
-			AM33XX_IOPAD(0x958, PIN_INPUT_PULLUP | MUX_MODE0) /* spi0_d1.spi0_d1 */
+			AM33XX_IOPAD(0x950, PIN_INPUT_PULLUP | MUX_MODE0)	/* spi0_sclk.spi0_sclk */
+			AM33XX_IOPAD(0x95C, PIN_INPUT_PULLUP | MUX_MODE0)	/* spi0_cs0.spi0_cs0 */
+			AM33XX_IOPAD(0x954, PIN_INPUT_PULLUP | MUX_MODE0)	/* spi0_d0.spi0_d0 */
+			AM33XX_IOPAD(0x958, PIN_INPUT_PULLUP | MUX_MODE0)	/* spi0_d1.spi0_d1 */
 		>;
 	};
 
diff --git a/arch/arm/boot/dts/am335x-nano.dts b/arch/arm/boot/dts/am335x-nano.dts
index 9c9143e..0d129b6 100644
--- a/arch/arm/boot/dts/am335x-nano.dts
+++ b/arch/arm/boot/dts/am335x-nano.dts
@@ -41,7 +41,7 @@
 
 	misc_pins: misc_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x95c, PIN_OUTPUT | MUX_MODE7)	/* spi0_cs0.gpio0_5 */
+			AM33XX_IOPAD(0x95c, PIN_OUTPUT | MUX_MODE7)		/* spi0_cs0.gpio0_5 */
 		>;
 	};
 
diff --git a/arch/arm/boot/dts/am335x-osd3358-sm-red.dts b/arch/arm/boot/dts/am335x-osd3358-sm-red.dts
index 95d54cf..270b681 100644
--- a/arch/arm/boot/dts/am335x-osd3358-sm-red.dts
+++ b/arch/arm/boot/dts/am335x-osd3358-sm-red.dts
@@ -72,29 +72,29 @@
 
 	mcasp0_pins: mcasp0-pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x9ac, PIN_INPUT_PULLUP | MUX_MODE0) /* mcasp0_ahcklx.mcasp0_ahclkx */
-			AM33XX_IOPAD(0x99c, PIN_OUTPUT_PULLDOWN | MUX_MODE2) /* mcasp0_ahclkr.mcasp0_axr2*/
-			AM33XX_IOPAD(0x994, PIN_OUTPUT_PULLUP | MUX_MODE0) /* mcasp0_fsx.mcasp0_fsx */
-			AM33XX_IOPAD(0x990, PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* mcasp0_aclkx.mcasp0_aclkx */
-			AM33XX_IOPAD(0x86c, PIN_OUTPUT_PULLDOWN | MUX_MODE7) /* gpmc_a11.GPIO1_27 */
+			AM33XX_IOPAD(0x9ac, PIN_INPUT_PULLUP | MUX_MODE0)	/* mcasp0_ahcklx.mcasp0_ahclkx */
+			AM33XX_IOPAD(0x99c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mcasp0_ahclkr.mcasp0_axr2*/
+			AM33XX_IOPAD(0x994, PIN_OUTPUT_PULLUP | MUX_MODE0)	/* mcasp0_fsx.mcasp0_fsx */
+			AM33XX_IOPAD(0x990, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* mcasp0_aclkx.mcasp0_aclkx */
+			AM33XX_IOPAD(0x86c, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_a11.GPIO1_27 */
 		>;
 	};
 
 	flash_enable: flash-enable {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x944, PIN_OUTPUT_PULLDOWN | MUX_MODE7) 	/* rmii1_ref_clk.gpio0_29 */
+			AM33XX_IOPAD(0x944, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* rmii1_ref_clk.gpio0_29 */
 		>;
 	};
 
 	imu_interrupt: imu-interrupt {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x910, PIN_INPUT_PULLDOWN | MUX_MODE7) 		/* mii1_rx_er.gpio3_2 */
+			AM33XX_IOPAD(0x910, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* mii1_rx_er.gpio3_2 */
 		>;
 	};
 
 	ethernet_interrupt: ethernet-interrupt{
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x908, PIN_INPUT_PULLDOWN | MUX_MODE7) 		/* mii1_col.gpio3_0 */
+			AM33XX_IOPAD(0x908, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* mii1_col.gpio3_0 */
 		>;
 	};
 };
@@ -300,17 +300,17 @@
 		pinctrl-single,pins = <
 			/* Slave 1 */
 			AM33XX_IOPAD(0x914, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txen.rgmii1_tctl */
-			AM33XX_IOPAD(0x918, PIN_INPUT_PULLDOWN | MUX_MODE2)		/* mii1_rxdv.rgmii1_rctl */
+			AM33XX_IOPAD(0x918, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxdv.rgmii1_rctl */
 			AM33XX_IOPAD(0x91c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd3.rgmii1_txd3 */
 			AM33XX_IOPAD(0x920, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd2.rgmii1_txd2 */
 			AM33XX_IOPAD(0x924, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd1.rgmii1_txd1 */
 			AM33XX_IOPAD(0x928, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd0.rgmii1_txd0 */
 			AM33XX_IOPAD(0x92c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txclk.rgmii1_txclk */
-			AM33XX_IOPAD(0x930, PIN_INPUT_PULLDOWN | MUX_MODE2)		/* mii1_rxclk.rgmii1_rxclk */
-			AM33XX_IOPAD(0x934, PIN_INPUT_PULLDOWN | MUX_MODE2)		/* mii1_rxd3.rgmii1_rxd3 */
-			AM33XX_IOPAD(0x938, PIN_INPUT_PULLDOWN | MUX_MODE2)		/* mii1_rxd2.rgmii1_rxd2 */
-			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLDOWN | MUX_MODE2)		/* mii1_rxd1.rgmii1_rxd1 */
-			AM33XX_IOPAD(0x940, PIN_INPUT_PULLDOWN | MUX_MODE2)		/* mii1_rxd0.rgmii1_rxd0 */
+			AM33XX_IOPAD(0x930, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxclk.rgmii1_rxclk */
+			AM33XX_IOPAD(0x934, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd3.rgmii1_rxd3 */
+			AM33XX_IOPAD(0x938, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd2.rgmii1_rxd2 */
+			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd1.rgmii1_rxd1 */
+			AM33XX_IOPAD(0x940, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd0.rgmii1_rxd0 */
 		>;
 	};
 
@@ -350,28 +350,28 @@
 
 	mmc1_pins: pinmux-mmc1-pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x960, PIN_INPUT | MUX_MODE7) /* (C15) spi0_cs1.gpio0[6] */
-			AM33XX_IOPAD(0x8fc, PIN_INPUT_PULLUP | MUX_MODE0) /* (G16) mmc0_dat0.mmc0_dat0 */
-			AM33XX_IOPAD(0x8f8, PIN_INPUT_PULLUP | MUX_MODE0) /* (G15) mmc0_dat1.mmc0_dat1 */
-			AM33XX_IOPAD(0x8f4, PIN_INPUT_PULLUP | MUX_MODE0) /* (F18) mmc0_dat2.mmc0_dat2 */
-			AM33XX_IOPAD(0x8f0, PIN_INPUT_PULLUP | MUX_MODE0) /* (F17) mmc0_dat3.mmc0_dat3 */
-			AM33XX_IOPAD(0x904, PIN_INPUT_PULLUP | MUX_MODE0) /* (G18) mmc0_cmd.mmc0_cmd */
-			AM33XX_IOPAD(0x900, PIN_INPUT_PULLUP | MUX_MODE0) /* (G17) mmc0_clk.mmc0_clk */
+			AM33XX_IOPAD(0x960, PIN_INPUT | MUX_MODE7)		/* (C15) spi0_cs1.gpio0[6] */
+			AM33XX_IOPAD(0x8fc, PIN_INPUT_PULLUP | MUX_MODE0)	/* (G16) mmc0_dat0.mmc0_dat0 */
+			AM33XX_IOPAD(0x8f8, PIN_INPUT_PULLUP | MUX_MODE0)	/* (G15) mmc0_dat1.mmc0_dat1 */
+			AM33XX_IOPAD(0x8f4, PIN_INPUT_PULLUP | MUX_MODE0)	/* (F18) mmc0_dat2.mmc0_dat2 */
+			AM33XX_IOPAD(0x8f0, PIN_INPUT_PULLUP | MUX_MODE0)	/* (F17) mmc0_dat3.mmc0_dat3 */
+			AM33XX_IOPAD(0x904, PIN_INPUT_PULLUP | MUX_MODE0)	/* (G18) mmc0_cmd.mmc0_cmd */
+			AM33XX_IOPAD(0x900, PIN_INPUT_PULLUP | MUX_MODE0)	/* (G17) mmc0_clk.mmc0_clk */
 		>;
 	};
 
 	emmc_pins: pinmux-emmc-pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x880, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_csn1.mmc1_clk */
-			AM33XX_IOPAD(0x884, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_csn2.mmc1_cmd */
-			AM33XX_IOPAD(0x800, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad0.mmc1_dat0 */
-			AM33XX_IOPAD(0x804, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad1.mmc1_dat1 */
-			AM33XX_IOPAD(0x808, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad2.mmc1_dat2 */
-			AM33XX_IOPAD(0x80c, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad3.mmc1_dat3 */
-			AM33XX_IOPAD(0x810, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad4.mmc1_dat4 */
-			AM33XX_IOPAD(0x814, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad5.mmc1_dat5 */
-			AM33XX_IOPAD(0x818, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad6.mmc1_dat6 */
-			AM33XX_IOPAD(0x81c, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad7.mmc1_dat7 */
+			AM33XX_IOPAD(0x880, PIN_INPUT_PULLUP | MUX_MODE2)	/* gpmc_csn1.mmc1_clk */
+			AM33XX_IOPAD(0x884, PIN_INPUT_PULLUP | MUX_MODE2)	/* gpmc_csn2.mmc1_cmd */
+			AM33XX_IOPAD(0x800, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad0.mmc1_dat0 */
+			AM33XX_IOPAD(0x804, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad1.mmc1_dat1 */
+			AM33XX_IOPAD(0x808, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad2.mmc1_dat2 */
+			AM33XX_IOPAD(0x80c, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad3.mmc1_dat3 */
+			AM33XX_IOPAD(0x810, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad4.mmc1_dat4 */
+			AM33XX_IOPAD(0x814, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad5.mmc1_dat5 */
+			AM33XX_IOPAD(0x818, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad6.mmc1_dat6 */
+			AM33XX_IOPAD(0x81c, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad7.mmc1_dat7 */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/am335x-pepper.dts b/arch/arm/boot/dts/am335x-pepper.dts
index 6be79b8..99279fa0 100644
--- a/arch/arm/boot/dts/am335x-pepper.dts
+++ b/arch/arm/boot/dts/am335x-pepper.dts
@@ -130,7 +130,7 @@
 &am33xx_pinmux {
 	accel_pins: pinmux_accel {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x898, PIN_INPUT | MUX_MODE7)   /* gpmc_wen.gpio2_4 */
+			AM33XX_IOPAD(0x898, PIN_INPUT | MUX_MODE7)		/* gpmc_wen.gpio2_4 */
 		>;
 	};
 };
@@ -182,7 +182,7 @@
 			AM33XX_IOPAD(0x990, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mcasp0_aclkx.mcasp0_aclkx */
 			AM33XX_IOPAD(0x998, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mcasp0_axr0.mcasp0_axr0 */
 			AM33XX_IOPAD(0x9a8, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mcasp0_axr1.mcasp0_axr1 */
-			AM33XX_IOPAD(0x840, PIN_OUTPUT | MUX_MODE7)	/* gpmc_a0.gpio1_16 */
+			AM33XX_IOPAD(0x840, PIN_OUTPUT | MUX_MODE7)		/* gpmc_a0.gpio1_16 */
 		>;
 	};
 };
@@ -228,34 +228,34 @@
 &am33xx_pinmux {
 	lcd_pins: pinmux_lcd {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x8a0, PIN_OUTPUT | MUX_MODE0)	/* lcd_data0.lcd_data0 */
-			AM33XX_IOPAD(0x8a4, PIN_OUTPUT | MUX_MODE0)	/* lcd_data1.lcd_data1 */
-			AM33XX_IOPAD(0x8a8, PIN_OUTPUT | MUX_MODE0)	/* lcd_data2.lcd_data2 */
-			AM33XX_IOPAD(0x8ac, PIN_OUTPUT | MUX_MODE0)	/* lcd_data3.lcd_data3 */
-			AM33XX_IOPAD(0x8b0, PIN_OUTPUT | MUX_MODE0)	/* lcd_data4.lcd_data4 */
-			AM33XX_IOPAD(0x8b4, PIN_OUTPUT | MUX_MODE0)	/* lcd_data5.lcd_data5 */
-			AM33XX_IOPAD(0x8b8, PIN_OUTPUT | MUX_MODE0)	/* lcd_data6.lcd_data6 */
-			AM33XX_IOPAD(0x8bc, PIN_OUTPUT | MUX_MODE0)	/* lcd_data7.lcd_data7 */
-			AM33XX_IOPAD(0x8c0, PIN_OUTPUT | MUX_MODE0)	/* lcd_data8.lcd_data8 */
-			AM33XX_IOPAD(0x8c4, PIN_OUTPUT | MUX_MODE0)	/* lcd_data9.lcd_data9 */
-			AM33XX_IOPAD(0x8c8, PIN_OUTPUT | MUX_MODE0)	/* lcd_data10.lcd_data10 */
-			AM33XX_IOPAD(0x8cc, PIN_OUTPUT | MUX_MODE0)	/* lcd_data11.lcd_data11 */
-			AM33XX_IOPAD(0x8d0, PIN_OUTPUT | MUX_MODE0)	/* lcd_data12.lcd_data12 */
-			AM33XX_IOPAD(0x8d4, PIN_OUTPUT | MUX_MODE0)	/* lcd_data13.lcd_data13 */
-			AM33XX_IOPAD(0x8d8, PIN_OUTPUT | MUX_MODE0)	/* lcd_data14.lcd_data14 */
-			AM33XX_IOPAD(0x8dc, PIN_OUTPUT | MUX_MODE0)	/* lcd_data15.lcd_data15 */
-			AM33XX_IOPAD(0x820, PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad8.lcd_data16 */
-			AM33XX_IOPAD(0x824, PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad9.lcd_data17 */
-			AM33XX_IOPAD(0x828, PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad10.lcd_data18 */
-			AM33XX_IOPAD(0x82c, PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad11.lcd_data19 */
-			AM33XX_IOPAD(0x830, PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad12.lcd_data20 */
-			AM33XX_IOPAD(0x834, PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad13.lcd_data21 */
-			AM33XX_IOPAD(0x838, PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad14.lcd_data22 */
-			AM33XX_IOPAD(0x83c, PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad15.lcd_data23 */
-			AM33XX_IOPAD(0x8e0, PIN_OUTPUT | MUX_MODE0)	/* lcd_vsync.lcd_vsync */
-			AM33XX_IOPAD(0x8e4, PIN_OUTPUT | MUX_MODE0)	/* lcd_hsync.lcd_hsync */
-			AM33XX_IOPAD(0x8e8, PIN_OUTPUT | MUX_MODE0)	/* lcd_pclk.lcd_pclk */
-			AM33XX_IOPAD(0x8ec, PIN_OUTPUT | MUX_MODE0)	/* lcd_ac_bias_en.lcd_ac_bias_en */
+			AM33XX_IOPAD(0x8a0, PIN_OUTPUT | MUX_MODE0)		/* lcd_data0.lcd_data0 */
+			AM33XX_IOPAD(0x8a4, PIN_OUTPUT | MUX_MODE0)		/* lcd_data1.lcd_data1 */
+			AM33XX_IOPAD(0x8a8, PIN_OUTPUT | MUX_MODE0)		/* lcd_data2.lcd_data2 */
+			AM33XX_IOPAD(0x8ac, PIN_OUTPUT | MUX_MODE0)		/* lcd_data3.lcd_data3 */
+			AM33XX_IOPAD(0x8b0, PIN_OUTPUT | MUX_MODE0)		/* lcd_data4.lcd_data4 */
+			AM33XX_IOPAD(0x8b4, PIN_OUTPUT | MUX_MODE0)		/* lcd_data5.lcd_data5 */
+			AM33XX_IOPAD(0x8b8, PIN_OUTPUT | MUX_MODE0)		/* lcd_data6.lcd_data6 */
+			AM33XX_IOPAD(0x8bc, PIN_OUTPUT | MUX_MODE0)		/* lcd_data7.lcd_data7 */
+			AM33XX_IOPAD(0x8c0, PIN_OUTPUT | MUX_MODE0)		/* lcd_data8.lcd_data8 */
+			AM33XX_IOPAD(0x8c4, PIN_OUTPUT | MUX_MODE0)		/* lcd_data9.lcd_data9 */
+			AM33XX_IOPAD(0x8c8, PIN_OUTPUT | MUX_MODE0)		/* lcd_data10.lcd_data10 */
+			AM33XX_IOPAD(0x8cc, PIN_OUTPUT | MUX_MODE0)		/* lcd_data11.lcd_data11 */
+			AM33XX_IOPAD(0x8d0, PIN_OUTPUT | MUX_MODE0)		/* lcd_data12.lcd_data12 */
+			AM33XX_IOPAD(0x8d4, PIN_OUTPUT | MUX_MODE0)		/* lcd_data13.lcd_data13 */
+			AM33XX_IOPAD(0x8d8, PIN_OUTPUT | MUX_MODE0)		/* lcd_data14.lcd_data14 */
+			AM33XX_IOPAD(0x8dc, PIN_OUTPUT | MUX_MODE0)		/* lcd_data15.lcd_data15 */
+			AM33XX_IOPAD(0x820, PIN_OUTPUT | MUX_MODE1)		/* gpmc_ad8.lcd_data16 */
+			AM33XX_IOPAD(0x824, PIN_OUTPUT | MUX_MODE1)		/* gpmc_ad9.lcd_data17 */
+			AM33XX_IOPAD(0x828, PIN_OUTPUT | MUX_MODE1)		/* gpmc_ad10.lcd_data18 */
+			AM33XX_IOPAD(0x82c, PIN_OUTPUT | MUX_MODE1)		/* gpmc_ad11.lcd_data19 */
+			AM33XX_IOPAD(0x830, PIN_OUTPUT | MUX_MODE1)		/* gpmc_ad12.lcd_data20 */
+			AM33XX_IOPAD(0x834, PIN_OUTPUT | MUX_MODE1)		/* gpmc_ad13.lcd_data21 */
+			AM33XX_IOPAD(0x838, PIN_OUTPUT | MUX_MODE1)		/* gpmc_ad14.lcd_data22 */
+			AM33XX_IOPAD(0x83c, PIN_OUTPUT | MUX_MODE1)		/* gpmc_ad15.lcd_data23 */
+			AM33XX_IOPAD(0x8e0, PIN_OUTPUT | MUX_MODE0)		/* lcd_vsync.lcd_vsync */
+			AM33XX_IOPAD(0x8e4, PIN_OUTPUT | MUX_MODE0)		/* lcd_hsync.lcd_hsync */
+			AM33XX_IOPAD(0x8e8, PIN_OUTPUT | MUX_MODE0)		/* lcd_pclk.lcd_pclk */
+			AM33XX_IOPAD(0x8ec, PIN_OUTPUT | MUX_MODE0)		/* lcd_ac_bias_en.lcd_ac_bias_en */
 			/* Display Enable */
 			AM33XX_IOPAD(0x86c, PIN_OUTPUT_PULLUP | MUX_MODE7)	/* gpmc_a11.gpio1_27 */
 		>;
@@ -498,10 +498,10 @@
 &am33xx_pinmux {
 	spi0_pins: pinmux_spi0 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x950, PIN_INPUT_PULLUP | MUX_MODE0) /* spi0_sclk.spi0_sclk */
-			AM33XX_IOPAD(0x95C, PIN_INPUT_PULLUP | MUX_MODE0) /* spi0_cs0.spi0_cs0 */
-			AM33XX_IOPAD(0x954, PIN_INPUT_PULLUP | MUX_MODE0) /* spi0_d0.spi0_d0 */
-			AM33XX_IOPAD(0x958, PIN_INPUT_PULLUP | MUX_MODE0) /* spi0_d1.spi0_d1 */
+			AM33XX_IOPAD(0x950, PIN_INPUT_PULLUP | MUX_MODE0)	/* spi0_sclk.spi0_sclk */
+			AM33XX_IOPAD(0x95C, PIN_INPUT_PULLUP | MUX_MODE0)	/* spi0_cs0.spi0_cs0 */
+			AM33XX_IOPAD(0x954, PIN_INPUT_PULLUP | MUX_MODE0)	/* spi0_d0.spi0_d0 */
+			AM33XX_IOPAD(0x958, PIN_INPUT_PULLUP | MUX_MODE0)	/* spi0_d1.spi0_d1 */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/am335x-phycore-rdk.dts b/arch/arm/boot/dts/am335x-phycore-rdk.dts
index 305f0b3..2b2ada6 100644
--- a/arch/arm/boot/dts/am335x-phycore-rdk.dts
+++ b/arch/arm/boot/dts/am335x-phycore-rdk.dts
@@ -23,5 +23,4 @@
 
 &serial_flash {
 	status = "okay";
-
 };
diff --git a/arch/arm/boot/dts/am335x-sancloud-bbe.dts b/arch/arm/boot/dts/am335x-sancloud-bbe.dts
index 35527fd..e6d2ce6 100644
--- a/arch/arm/boot/dts/am335x-sancloud-bbe.dts
+++ b/arch/arm/boot/dts/am335x-sancloud-bbe.dts
@@ -74,19 +74,19 @@
 
 	usb_hub_ctrl: usb_hub_ctrl {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x944, PIN_OUTPUT_PULLUP | MUX_MODE7)     /* rmii1_refclk.gpio0_29 */
+			AM33XX_IOPAD(0x944, PIN_OUTPUT_PULLUP | MUX_MODE7)	/* rmii1_refclk.gpio0_29 */
 		>;
 	};
 
 	mpu6050_pins: pinmux_mpu6050_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x968, PIN_INPUT | MUX_MODE7)    /* uart0_ctsn.gpio1_8 */
+			AM33XX_IOPAD(0x968, PIN_INPUT | MUX_MODE7)		/* uart0_ctsn.gpio1_8 */
 		>;
 	};
 
 	lps3331ap_pins: pinmux_lps3331ap_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x868, PIN_INPUT | MUX_MODE7)     /* gpmc_a10.gpio1_26 */
+			AM33XX_IOPAD(0x868, PIN_INPUT | MUX_MODE7)		/* gpmc_a10.gpio1_26 */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/am335x-shc.dts b/arch/arm/boot/dts/am335x-shc.dts
index bfbe27a..58c060e 100644
--- a/arch/arm/boot/dts/am335x-shc.dts
+++ b/arch/arm/boot/dts/am335x-shc.dts
@@ -443,7 +443,7 @@
 
 	ehrpwm1_pins: pinmux_ehrpwm1 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x84c, PIN_OUTPUT | MUX_MODE6) /* gpmc_a3.gpio1_19 */
+			AM33XX_IOPAD(0x84c, PIN_OUTPUT | MUX_MODE6)		/* gpmc_a3.gpio1_19 */
 		>;
 	};
 
diff --git a/arch/arm/boot/dts/am335x-sl50.dts b/arch/arm/boot/dts/am335x-sl50.dts
index 38d57b8..b706df5 100644
--- a/arch/arm/boot/dts/am335x-sl50.dts
+++ b/arch/arm/boot/dts/am335x-sl50.dts
@@ -240,34 +240,34 @@
 
 	backlight0_pins: pinmux_backlight0_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x898, PIN_OUTPUT | MUX_MODE7)	/* gpmc_wen.gpio2_4 */
+			AM33XX_IOPAD(0x898, PIN_OUTPUT | MUX_MODE7)		/* gpmc_wen.gpio2_4 */
 		>;
 	};
 
 	backlight1_pins: pinmux_backlight1_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x828, PIN_OUTPUT | MUX_MODE7)     /* gpmc_ad10.gpio0_26 */
+			AM33XX_IOPAD(0x828, PIN_OUTPUT | MUX_MODE7)		/* gpmc_ad10.gpio0_26 */
 		>;
 	};
 
 	lcd_pins: pinmux_lcd_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x8a0, PIN_OUTPUT | MUX_MODE0)	/* lcd_data0.lcd_data0 */
-			AM33XX_IOPAD(0x8a4, PIN_OUTPUT | MUX_MODE0)	/* lcd_data1.lcd_data1 */
-			AM33XX_IOPAD(0x8a8, PIN_OUTPUT | MUX_MODE0)	/* lcd_data2.lcd_data2 */
-			AM33XX_IOPAD(0x8ac, PIN_OUTPUT | MUX_MODE0)	/* lcd_data3.lcd_data3 */
-			AM33XX_IOPAD(0x8b0, PIN_OUTPUT | MUX_MODE0)	/* lcd_data4.lcd_data4 */
-			AM33XX_IOPAD(0x8b4, PIN_OUTPUT | MUX_MODE0)	/* lcd_data5.lcd_data5 */
-			AM33XX_IOPAD(0x8b8, PIN_OUTPUT | MUX_MODE0)	/* lcd_data6.lcd_data6 */
-			AM33XX_IOPAD(0x8bc, PIN_OUTPUT | MUX_MODE0)	/* lcd_data7.lcd_data7 */
-			AM33XX_IOPAD(0x8c0, PIN_OUTPUT | MUX_MODE0)	/* lcd_data8.lcd_data8 */
-			AM33XX_IOPAD(0x8c4, PIN_OUTPUT | MUX_MODE0)	/* lcd_data9.lcd_data9 */
-			AM33XX_IOPAD(0x8c8, PIN_OUTPUT | MUX_MODE0)	/* lcd_data10.lcd_data10 */
-			AM33XX_IOPAD(0x8cc, PIN_OUTPUT | MUX_MODE0)	/* lcd_data11.lcd_data11 */
-			AM33XX_IOPAD(0x8d0, PIN_OUTPUT | MUX_MODE0)	/* lcd_data12.lcd_data12 */
-			AM33XX_IOPAD(0x8d4, PIN_OUTPUT | MUX_MODE0)	/* lcd_data13.lcd_data13 */
-			AM33XX_IOPAD(0x8d8, PIN_OUTPUT | MUX_MODE0)	/* lcd_data14.lcd_data14 */
-			AM33XX_IOPAD(0x8dc, PIN_OUTPUT | MUX_MODE0)	/* lcd_data15.lcd_data15 */
+			AM33XX_IOPAD(0x8a0, PIN_OUTPUT | MUX_MODE0)		/* lcd_data0.lcd_data0 */
+			AM33XX_IOPAD(0x8a4, PIN_OUTPUT | MUX_MODE0)		/* lcd_data1.lcd_data1 */
+			AM33XX_IOPAD(0x8a8, PIN_OUTPUT | MUX_MODE0)		/* lcd_data2.lcd_data2 */
+			AM33XX_IOPAD(0x8ac, PIN_OUTPUT | MUX_MODE0)		/* lcd_data3.lcd_data3 */
+			AM33XX_IOPAD(0x8b0, PIN_OUTPUT | MUX_MODE0)		/* lcd_data4.lcd_data4 */
+			AM33XX_IOPAD(0x8b4, PIN_OUTPUT | MUX_MODE0)		/* lcd_data5.lcd_data5 */
+			AM33XX_IOPAD(0x8b8, PIN_OUTPUT | MUX_MODE0)		/* lcd_data6.lcd_data6 */
+			AM33XX_IOPAD(0x8bc, PIN_OUTPUT | MUX_MODE0)		/* lcd_data7.lcd_data7 */
+			AM33XX_IOPAD(0x8c0, PIN_OUTPUT | MUX_MODE0)		/* lcd_data8.lcd_data8 */
+			AM33XX_IOPAD(0x8c4, PIN_OUTPUT | MUX_MODE0)		/* lcd_data9.lcd_data9 */
+			AM33XX_IOPAD(0x8c8, PIN_OUTPUT | MUX_MODE0)		/* lcd_data10.lcd_data10 */
+			AM33XX_IOPAD(0x8cc, PIN_OUTPUT | MUX_MODE0)		/* lcd_data11.lcd_data11 */
+			AM33XX_IOPAD(0x8d0, PIN_OUTPUT | MUX_MODE0)		/* lcd_data12.lcd_data12 */
+			AM33XX_IOPAD(0x8d4, PIN_OUTPUT | MUX_MODE0)		/* lcd_data13.lcd_data13 */
+			AM33XX_IOPAD(0x8d8, PIN_OUTPUT | MUX_MODE0)		/* lcd_data14.lcd_data14 */
+			AM33XX_IOPAD(0x8dc, PIN_OUTPUT | MUX_MODE0)		/* lcd_data15.lcd_data15 */
 			AM33XX_IOPAD(0x8e0, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_vsync.lcd_vsync */
 			AM33XX_IOPAD(0x8e4, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_hsync.lcd_hsync */
 			AM33XX_IOPAD(0x8e8, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* lcd_pclk.lcd_pclk */
@@ -277,10 +277,10 @@
 
 	led_pins: pinmux_led_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x854, PIN_OUTPUT | MUX_MODE7)	/* gpmc_a5.gpio1_21 */
-			AM33XX_IOPAD(0x858, PIN_OUTPUT | MUX_MODE7)	/* gpmc_a6.gpio1_22 */
-			AM33XX_IOPAD(0x85c, PIN_OUTPUT | MUX_MODE7)	/* gpmc_a7.gpio1_23 */
-			AM33XX_IOPAD(0x860, PIN_OUTPUT | MUX_MODE7)	/* gpmc_a8.gpio1_24 */
+			AM33XX_IOPAD(0x854, PIN_OUTPUT | MUX_MODE7)		/* gpmc_a5.gpio1_21 */
+			AM33XX_IOPAD(0x858, PIN_OUTPUT | MUX_MODE7)		/* gpmc_a6.gpio1_22 */
+			AM33XX_IOPAD(0x85c, PIN_OUTPUT | MUX_MODE7)		/* gpmc_a7.gpio1_23 */
+			AM33XX_IOPAD(0x860, PIN_OUTPUT | MUX_MODE7)		/* gpmc_a8.gpio1_24 */
 		>;
 	};
 
@@ -404,14 +404,14 @@
 
 	ehrpwm1_pins: pinmux_ehrpwm1a_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x848, PIN_OUTPUT | MUX_MODE6)	/* gpmc_a2.ehrpwm1a */
-			AM33XX_IOPAD(0x84c, PIN_OUTPUT | MUX_MODE6)	/* gpmc_a3.ehrpwm1b */
+			AM33XX_IOPAD(0x848, PIN_OUTPUT | MUX_MODE6)		/* gpmc_a2.ehrpwm1a */
+			AM33XX_IOPAD(0x84c, PIN_OUTPUT | MUX_MODE6)		/* gpmc_a3.ehrpwm1b */
 		>;
 	};
 
 	rtc0_irq_pins: pinmux_rtc0_irq_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x824, PIN_INPUT_PULLUP | MUX_MODE7)     /* gpmc_ad9.gpio0_23 */
+			AM33XX_IOPAD(0x824, PIN_INPUT_PULLUP | MUX_MODE7)	/* gpmc_ad9.gpio0_23 */
 		>;
 	};
 
diff --git a/arch/arm/boot/dts/am335x-wega.dtsi b/arch/arm/boot/dts/am335x-wega.dtsi
index 8ce5417..d497578 100644
--- a/arch/arm/boot/dts/am335x-wega.dtsi
+++ b/arch/arm/boot/dts/am335x-wega.dtsi
@@ -32,11 +32,11 @@
 &am33xx_pinmux {
 	mcasp0_pins: pinmux_mcasp0 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x9AC, PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* mcasp0_ahclkx.mcasp0_ahclkx */
-			AM33XX_IOPAD(0x990, PIN_INPUT_PULLDOWN | MUX_MODE0)  /* mcasp0_aclkx.mcasp0_aclkx */
-			AM33XX_IOPAD(0x994, PIN_INPUT_PULLDOWN | MUX_MODE0)  /* mcasp0_fsx.mcasp0_fsx */
-			AM33XX_IOPAD(0x998, PIN_INPUT_PULLDOWN | MUX_MODE0)  /* mcasp0_axr0.mcasp0_axr0 */
-			AM33XX_IOPAD(0x9A8, PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* mcasp0_axr1.mcasp0_axr1 */
+			AM33XX_IOPAD(0x9AC, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* mcasp0_ahclkx.mcasp0_ahclkx */
+			AM33XX_IOPAD(0x990, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mcasp0_aclkx.mcasp0_aclkx */
+			AM33XX_IOPAD(0x994, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mcasp0_fsx.mcasp0_fsx */
+			AM33XX_IOPAD(0x998, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mcasp0_axr0.mcasp0_axr0 */
+			AM33XX_IOPAD(0x9A8, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* mcasp0_axr1.mcasp0_axr1 */
 		>;
 	};
 };
@@ -84,8 +84,8 @@
 &am33xx_pinmux {
 	dcan1_pins: pinmux_dcan1 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x968, PIN_OUTPUT_PULLUP | MUX_MODE2) /* uart0_ctsn.d_can1_tx */
-			AM33XX_IOPAD(0x96c, PIN_INPUT_PULLUP | MUX_MODE2) /* uart0_rtsn.d_can1_rx */
+			AM33XX_IOPAD(0x968, PIN_OUTPUT_PULLUP | MUX_MODE2)	/* uart0_ctsn.d_can1_tx */
+			AM33XX_IOPAD(0x96c, PIN_INPUT_PULLUP | MUX_MODE2)	/* uart0_rtsn.d_can1_rx */
 		>;
 	};
 };
@@ -171,8 +171,8 @@
 &am33xx_pinmux {
 	uart0_pins: pinmux_uart0 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x970, PIN_INPUT_PULLUP | MUX_MODE0)    /* uart0_rxd.uart0_rxd */
-			AM33XX_IOPAD(0x974, PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* uart0_txd.uart0_txd */
+			AM33XX_IOPAD(0x970, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
+			AM33XX_IOPAD(0x974, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart0_txd.uart0_txd */
 		>;
 	};
 
diff --git a/arch/arm/boot/dts/am3517-craneboard.dts b/arch/arm/boot/dts/am3517-craneboard.dts
index 083ff50..8323ec5 100644
--- a/arch/arm/boot/dts/am3517-craneboard.dts
+++ b/arch/arm/boot/dts/am3517-craneboard.dts
@@ -77,7 +77,7 @@
 &omap3_pmx_core {
 	tps_pins: pinmux_tps_pins {
 		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x21e0, PIN_INPUT_PULLUP | MUX_MODE0) /* sys_nirq.sys_nirq */
+			OMAP3_CORE1_IOPAD(0x21e0, PIN_INPUT_PULLUP | MUX_MODE0)	/* sys_nirq.sys_nirq */
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/am3517-evm.dts b/arch/arm/boot/dts/am3517-evm.dts
index 3527c0f..ca39ff0 100644
--- a/arch/arm/boot/dts/am3517-evm.dts
+++ b/arch/arm/boot/dts/am3517-evm.dts
@@ -29,12 +29,12 @@
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
 
-        vmmc_fixed: vmmc {
-                compatible = "regulator-fixed";
-                regulator-name = "vmmc_fixed";
-                regulator-min-microvolt = <3300000>;
-                regulator-max-microvolt = <3300000>;
-        };
+	vmmc_fixed: vmmc {
+		compatible = "regulator-fixed";
+		regulator-name = "vmmc_fixed";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
 
 	gpio-keys {
 		compatible = "gpio-keys-polled";
@@ -185,11 +185,11 @@
 };
 
 &davinci_emac {
-	     status = "okay";
+	status = "okay";
 };
 
 &davinci_mdio {
-	     status = "okay";
+	status = "okay";
 };
 
 &dss {
@@ -236,7 +236,7 @@
 };
 
 &mmc3 {
-      status = "disabled";
+	status = "disabled";
 };
 
 &usbhshost {
@@ -266,46 +266,46 @@
 			OMAP3_CORE1_IOPAD(0x214a, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat1.sdmmc1_dat1 */
 			OMAP3_CORE1_IOPAD(0x214c, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat2.sdmmc1_dat2 */
 			OMAP3_CORE1_IOPAD(0x214e, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat3.sdmmc1_dat3 */
-			OMAP3_CORE1_IOPAD(0x2150, PIN_INPUT_PULLUP | MUX_MODE4) /* sdmmc1_dat4.gpio_126 */
-			OMAP3_CORE1_IOPAD(0x2152, PIN_INPUT_PULLUP | MUX_MODE4) /* sdmmc1_dat5.gpio_127 */
+			OMAP3_CORE1_IOPAD(0x2150, PIN_INPUT_PULLUP | MUX_MODE4)	/* sdmmc1_dat4.gpio_126 */
+			OMAP3_CORE1_IOPAD(0x2152, PIN_INPUT_PULLUP | MUX_MODE4)	/* sdmmc1_dat5.gpio_127 */
 		>;
 	};
 
 	pwm_pins: pinmux_pwm_pins {
 		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x21dc, PIN_OUTPUT | MUX_MODE1)       /* mcspi2_cs0.gpt11_pwm */
+			OMAP3_CORE1_IOPAD(0x21dc, PIN_OUTPUT | MUX_MODE1)	/* mcspi2_cs0.gpt11_pwm */
 		>;
 	};
 
 	backlight_pins: pinmux_backlight_pins {
 		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x21de, PIN_OUTPUT | MUX_MODE4)       /* mcspi2_cs1.gpio_182 */
+			OMAP3_CORE1_IOPAD(0x21de, PIN_OUTPUT | MUX_MODE4)	/* mcspi2_cs1.gpio_182 */
 		>;
 	};
 
 	dss_dpi_pins: pinmux_dss_dpi_pins {
 		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x21d2, PIN_OUTPUT | MUX_MODE4)       /* mcspi1_cs2.gpio_176 */
-			OMAP3_CORE1_IOPAD(0x20d4, PIN_OUTPUT | MUX_MODE0)       /* dss_pclk.dss_pclk */
-			OMAP3_CORE1_IOPAD(0x20d6, PIN_OUTPUT | MUX_MODE0)       /* dss_hsync.dss_hsync */
-			OMAP3_CORE1_IOPAD(0x20d8, PIN_OUTPUT | MUX_MODE0)       /* dss_vsync.dss_vsync */
-			OMAP3_CORE1_IOPAD(0x20da, PIN_OUTPUT | MUX_MODE0)       /* dss_acbias.dss_acbias */
-			OMAP3_CORE1_IOPAD(0x20dc, PIN_OUTPUT | MUX_MODE0)       /* dss_data0.dss_data0 */
-			OMAP3_CORE1_IOPAD(0x20de, PIN_OUTPUT | MUX_MODE0)       /* dss_data1.dss_data1 */
-			OMAP3_CORE1_IOPAD(0x20e0, PIN_OUTPUT | MUX_MODE0)       /* dss_data2.dss_data2 */
-			OMAP3_CORE1_IOPAD(0x20e2, PIN_OUTPUT | MUX_MODE0)       /* dss_data3.dss_data3 */
-			OMAP3_CORE1_IOPAD(0x20e4, PIN_OUTPUT | MUX_MODE0)       /* dss_data4.dss_data4 */
-			OMAP3_CORE1_IOPAD(0x20e6, PIN_OUTPUT | MUX_MODE0)       /* dss_data5.dss_data5 */
-			OMAP3_CORE1_IOPAD(0x20e8, PIN_OUTPUT | MUX_MODE0)       /* dss_data6.dss_data6 */
-			OMAP3_CORE1_IOPAD(0x20ea, PIN_OUTPUT | MUX_MODE0)       /* dss_data7.dss_data7 */
-			OMAP3_CORE1_IOPAD(0x20ec, PIN_OUTPUT | MUX_MODE0)       /* dss_data8.dss_data8 */
-			OMAP3_CORE1_IOPAD(0x20ee, PIN_OUTPUT | MUX_MODE0)       /* dss_data9.dss_data9 */
-			OMAP3_CORE1_IOPAD(0x20f0, PIN_OUTPUT | MUX_MODE0)       /* dss_data10.dss_data10 */
-			OMAP3_CORE1_IOPAD(0x20f2, PIN_OUTPUT | MUX_MODE0)       /* dss_data11.dss_data11 */
-			OMAP3_CORE1_IOPAD(0x20f4, PIN_OUTPUT | MUX_MODE0)       /* dss_data12.dss_data12 */
-			OMAP3_CORE1_IOPAD(0x20f6, PIN_OUTPUT | MUX_MODE0)       /* dss_data13.dss_data13 */
-			OMAP3_CORE1_IOPAD(0x20f8, PIN_OUTPUT | MUX_MODE0)       /* dss_data14.dss_data14 */
-			OMAP3_CORE1_IOPAD(0x20fa, PIN_OUTPUT | MUX_MODE0)       /* dss_data15.dss_data15 */
+			OMAP3_CORE1_IOPAD(0x21d2, PIN_OUTPUT | MUX_MODE4)	/* mcspi1_cs2.gpio_176 */
+			OMAP3_CORE1_IOPAD(0x20d4, PIN_OUTPUT | MUX_MODE0)	/* dss_pclk.dss_pclk */
+			OMAP3_CORE1_IOPAD(0x20d6, PIN_OUTPUT | MUX_MODE0)	/* dss_hsync.dss_hsync */
+			OMAP3_CORE1_IOPAD(0x20d8, PIN_OUTPUT | MUX_MODE0)	/* dss_vsync.dss_vsync */
+			OMAP3_CORE1_IOPAD(0x20da, PIN_OUTPUT | MUX_MODE0)	/* dss_acbias.dss_acbias */
+			OMAP3_CORE1_IOPAD(0x20dc, PIN_OUTPUT | MUX_MODE0)	/* dss_data0.dss_data0 */
+			OMAP3_CORE1_IOPAD(0x20de, PIN_OUTPUT | MUX_MODE0)	/* dss_data1.dss_data1 */
+			OMAP3_CORE1_IOPAD(0x20e0, PIN_OUTPUT | MUX_MODE0)	/* dss_data2.dss_data2 */
+			OMAP3_CORE1_IOPAD(0x20e2, PIN_OUTPUT | MUX_MODE0)	/* dss_data3.dss_data3 */
+			OMAP3_CORE1_IOPAD(0x20e4, PIN_OUTPUT | MUX_MODE0)	/* dss_data4.dss_data4 */
+			OMAP3_CORE1_IOPAD(0x20e6, PIN_OUTPUT | MUX_MODE0)	/* dss_data5.dss_data5 */
+			OMAP3_CORE1_IOPAD(0x20e8, PIN_OUTPUT | MUX_MODE0)	/* dss_data6.dss_data6 */
+			OMAP3_CORE1_IOPAD(0x20ea, PIN_OUTPUT | MUX_MODE0)	/* dss_data7.dss_data7 */
+			OMAP3_CORE1_IOPAD(0x20ec, PIN_OUTPUT | MUX_MODE0)	/* dss_data8.dss_data8 */
+			OMAP3_CORE1_IOPAD(0x20ee, PIN_OUTPUT | MUX_MODE0)	/* dss_data9.dss_data9 */
+			OMAP3_CORE1_IOPAD(0x20f0, PIN_OUTPUT | MUX_MODE0)	/* dss_data10.dss_data10 */
+			OMAP3_CORE1_IOPAD(0x20f2, PIN_OUTPUT | MUX_MODE0)	/* dss_data11.dss_data11 */
+			OMAP3_CORE1_IOPAD(0x20f4, PIN_OUTPUT | MUX_MODE0)	/* dss_data12.dss_data12 */
+			OMAP3_CORE1_IOPAD(0x20f6, PIN_OUTPUT | MUX_MODE0)	/* dss_data13.dss_data13 */
+			OMAP3_CORE1_IOPAD(0x20f8, PIN_OUTPUT | MUX_MODE0)	/* dss_data14.dss_data14 */
+			OMAP3_CORE1_IOPAD(0x20fa, PIN_OUTPUT | MUX_MODE0)	/* dss_data15.dss_data15 */
 		>;
 	};
 
diff --git a/arch/arm/boot/dts/am3517-som.dtsi b/arch/arm/boot/dts/am3517-som.dtsi
index b1c988e..53f09b3 100644
--- a/arch/arm/boot/dts/am3517-som.dtsi
+++ b/arch/arm/boot/dts/am3517-som.dtsi
@@ -184,35 +184,35 @@
 
 	wl12xx_buffer_pins: pinmux_wl12xx_buffer_pins {
 		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x2156, PIN_OUTPUT | MUX_MODE4)  /* mmc1_dat7.gpio_129 */
+			OMAP3_CORE1_IOPAD(0x2156, PIN_OUTPUT | MUX_MODE4)	/* mmc1_dat7.gpio_129 */
 		>;
 	};
 
 	mmc2_pins: pinmux_mmc2_pins {
 		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x2158, PIN_INPUT_PULLUP | MUX_MODE0)  /* mmc2_clk.mmc2_clk */
-			OMAP3_CORE1_IOPAD(0x215a, PIN_INPUT_PULLUP | MUX_MODE0)  /* mmc2_cmd.mmc2_cmd */
-			OMAP3_CORE1_IOPAD(0x215c, PIN_INPUT_PULLUP | MUX_MODE0)  /* mmc2_dat0.mmc2_dat0 */
-			OMAP3_CORE1_IOPAD(0x215e, PIN_INPUT_PULLUP | MUX_MODE0)  /* mmc2_dat1.mmc2_dat1 */
-			OMAP3_CORE1_IOPAD(0x2160, PIN_INPUT_PULLUP | MUX_MODE0)  /* mmc2_dat2.mmc2_dat2 */
-			OMAP3_CORE1_IOPAD(0x2162, PIN_INPUT_PULLUP | MUX_MODE0)  /* mmc2_dat3.mmc2_dat3 */
-			OMAP3_CORE1_IOPAD(0x2164, PIN_OUTPUT | MUX_MODE1) /* mmc2_dat4.mmc2_dir_dat0 */
-			OMAP3_CORE1_IOPAD(0x2166, PIN_OUTPUT | MUX_MODE1) /* mmc2_dat5.mmc2_dir_dat1 */
-			OMAP3_CORE1_IOPAD(0x2168, PIN_OUTPUT | MUX_MODE1) /* mmc2_dat6.mmc2_dir_cmd */
-			OMAP3_CORE1_IOPAD(0x216a, PIN_INPUT | MUX_MODE1) /* mmc2_dat7.mmc2_clkin */
+			OMAP3_CORE1_IOPAD(0x2158, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc2_clk.mmc2_clk */
+			OMAP3_CORE1_IOPAD(0x215a, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc2_cmd.mmc2_cmd */
+			OMAP3_CORE1_IOPAD(0x215c, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc2_dat0.mmc2_dat0 */
+			OMAP3_CORE1_IOPAD(0x215e, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc2_dat1.mmc2_dat1 */
+			OMAP3_CORE1_IOPAD(0x2160, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc2_dat2.mmc2_dat2 */
+			OMAP3_CORE1_IOPAD(0x2162, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc2_dat3.mmc2_dat3 */
+			OMAP3_CORE1_IOPAD(0x2164, PIN_OUTPUT | MUX_MODE1)	/* mmc2_dat4.mmc2_dir_dat0 */
+			OMAP3_CORE1_IOPAD(0x2166, PIN_OUTPUT | MUX_MODE1)	/* mmc2_dat5.mmc2_dir_dat1 */
+			OMAP3_CORE1_IOPAD(0x2168, PIN_OUTPUT | MUX_MODE1)	/* mmc2_dat6.mmc2_dir_cmd */
+			OMAP3_CORE1_IOPAD(0x216a, PIN_INPUT | MUX_MODE1)	/* mmc2_dat7.mmc2_clkin */
 			OMAP3_CORE1_IOPAD(0x21c6, PIN_INPUT_PULLUP | MUX_MODE4)	/* hdq_sio.gpio_170 */
 		>;
 	};
 
 	rtc_pins: pinmux_rtc_pins {
 		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x20b6, PIN_INPUT_PULLUP | MUX_MODE4) /* gpmc_ncs4.gpio_55 */
+			OMAP3_CORE1_IOPAD(0x20b6, PIN_INPUT_PULLUP | MUX_MODE4)	/* gpmc_ncs4.gpio_55 */
 		>;
 	};
 
 	tsc2004_pins: pinmux_tsc2004_pins {
 		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x20d2, PIN_INPUT | MUX_MODE4) /* gpmc_wait3.gpio_65 */
+			OMAP3_CORE1_IOPAD(0x20d2, PIN_INPUT | MUX_MODE4)	/* gpmc_wait3.gpio_65 */
 		>;
 	};
 
diff --git a/arch/arm/boot/dts/am3874-iceboard.dts b/arch/arm/boot/dts/am3874-iceboard.dts
index 883fb85..a1091f6 100644
--- a/arch/arm/boot/dts/am3874-iceboard.dts
+++ b/arch/arm/boot/dts/am3874-iceboard.dts
@@ -294,65 +294,65 @@
 &pincntl {
 	mmc2_pins: pinmux_mmc2_pins {
 		pinctrl-single,pins = <
-			DM814X_IOPAD(0x0800, PIN_INPUT | 0x1)	/* SD1_CLK */
+			DM814X_IOPAD(0x0800, PIN_INPUT | 0x1)		/* SD1_CLK */
 			DM814X_IOPAD(0x0804, PIN_INPUT_PULLUP | 0x1)	/* SD1_CMD */
 			DM814X_IOPAD(0x0808, PIN_INPUT_PULLUP | 0x1)	/* SD1_DAT[0] */
 			DM814X_IOPAD(0x080c, PIN_INPUT_PULLUP | 0x1)	/* SD1_DAT[1] */
 			DM814X_IOPAD(0x0810, PIN_INPUT_PULLUP | 0x1)	/* SD1_DAT[2] */
 			DM814X_IOPAD(0x0814, PIN_INPUT_PULLUP | 0x1)	/* SD1_DAT[3] */
 			DM814X_IOPAD(0x0924, PIN_INPUT_PULLUP | 0x40)	/* SD1_POW */
-			DM814X_IOPAD(0x0928, PIN_INPUT | 0x40)	/* SD1_SDWP */
-			DM814X_IOPAD(0x093C, PIN_INPUT | 0x2)	/* SD1_SDCD */
+			DM814X_IOPAD(0x0928, PIN_INPUT | 0x40)		/* SD1_SDWP */
+			DM814X_IOPAD(0x093C, PIN_INPUT | 0x2)		/* SD1_SDCD */
 			>;
 	};
 
 	usb0_pins: pinmux_usb0_pins {
 		pinctrl-single,pins = <
-			DM814X_IOPAD(0x0c34, PIN_OUTPUT | 0x1)	/* USB0_DRVVBUS */
+			DM814X_IOPAD(0x0c34, PIN_OUTPUT | 0x1)		/* USB0_DRVVBUS */
 			>;
 	};
 
 	usb1_pins: pinmux_usb1_pins {
 		pinctrl-single,pins = <
-			DM814X_IOPAD(0x0834, PIN_OUTPUT | 0x80)	/* USB1_DRVVBUS */
+			DM814X_IOPAD(0x0834, PIN_OUTPUT | 0x80)		/* USB1_DRVVBUS */
 			>;
 	};
 
 	gpio1_pins: pinmux_gpio1_pins {
 		pinctrl-single,pins = <
-			DM814X_IOPAD(0x081c, PIN_OUTPUT | 0x80)	/* PROGRAM_B */
-			DM814X_IOPAD(0x0820, PIN_INPUT | 0x80)	/* INIT_B */
-			DM814X_IOPAD(0x0824, PIN_INPUT | 0x80)	/* DONE */
-
-			DM814X_IOPAD(0x0838, PIN_INPUT_PULLUP | 0x80) /* FMCA_TMS */
-			DM814X_IOPAD(0x083c, PIN_INPUT_PULLUP | 0x80) /* FMCA_TCK */
-			DM814X_IOPAD(0x0898, PIN_INPUT_PULLUP | 0x80) /* FMCA_TDO */
-			DM814X_IOPAD(0x089c, PIN_INPUT_PULLUP | 0x80) /* FMCA_TDI */
-			DM814X_IOPAD(0x08ac, PIN_INPUT_PULLUP | 0x80) /* FMCA_TRST */
-
-			DM814X_IOPAD(0x08b0, PIN_INPUT_PULLUP | 0x80) /* FMCB_TMS */
-			DM814X_IOPAD(0x0a88, PIN_INPUT_PULLUP | 0x80) /* FMCB_TCK */
-			DM814X_IOPAD(0x0a8c, PIN_INPUT_PULLUP | 0x80) /* FMCB_TDO */
-			DM814X_IOPAD(0x08bc, PIN_INPUT_PULLUP | 0x80) /* FMCB_TDI */
-			DM814X_IOPAD(0x0a94, PIN_INPUT_PULLUP | 0x80) /* FMCB_TRST */
-
-			DM814X_IOPAD(0x08d4, PIN_INPUT_PULLUP | 0x80) /* FPGA_TMS */
-			DM814X_IOPAD(0x0aa8, PIN_INPUT_PULLUP | 0x80) /* FPGA_TCK */
-			DM814X_IOPAD(0x0adc, PIN_INPUT_PULLUP | 0x80) /* FPGA_TDO */
-			DM814X_IOPAD(0x0ab0, PIN_INPUT_PULLUP | 0x80) /* FPGA_TDI */
+			DM814X_IOPAD(0x081c, PIN_OUTPUT | 0x80)		/* PROGRAM_B */
+			DM814X_IOPAD(0x0820, PIN_INPUT | 0x80)		/* INIT_B */
+			DM814X_IOPAD(0x0824, PIN_INPUT | 0x80)		/* DONE */
+
+			DM814X_IOPAD(0x0838, PIN_INPUT_PULLUP | 0x80)	/* FMCA_TMS */
+			DM814X_IOPAD(0x083c, PIN_INPUT_PULLUP | 0x80)	/* FMCA_TCK */
+			DM814X_IOPAD(0x0898, PIN_INPUT_PULLUP | 0x80)	/* FMCA_TDO */
+			DM814X_IOPAD(0x089c, PIN_INPUT_PULLUP | 0x80)	/* FMCA_TDI */
+			DM814X_IOPAD(0x08ac, PIN_INPUT_PULLUP | 0x80)	/* FMCA_TRST */
+
+			DM814X_IOPAD(0x08b0, PIN_INPUT_PULLUP | 0x80)	/* FMCB_TMS */
+			DM814X_IOPAD(0x0a88, PIN_INPUT_PULLUP | 0x80)	/* FMCB_TCK */
+			DM814X_IOPAD(0x0a8c, PIN_INPUT_PULLUP | 0x80)	/* FMCB_TDO */
+			DM814X_IOPAD(0x08bc, PIN_INPUT_PULLUP | 0x80)	/* FMCB_TDI */
+			DM814X_IOPAD(0x0a94, PIN_INPUT_PULLUP | 0x80)	/* FMCB_TRST */
+
+			DM814X_IOPAD(0x08d4, PIN_INPUT_PULLUP | 0x80)	/* FPGA_TMS */
+			DM814X_IOPAD(0x0aa8, PIN_INPUT_PULLUP | 0x80)	/* FPGA_TCK */
+			DM814X_IOPAD(0x0adc, PIN_INPUT_PULLUP | 0x80)	/* FPGA_TDO */
+			DM814X_IOPAD(0x0ab0, PIN_INPUT_PULLUP | 0x80)	/* FPGA_TDI */
 			>;
 	};
 
 	gpio2_pins: pinmux_gpio2_pins {
 		pinctrl-single,pins = <
-			DM814X_IOPAD(0x090c, PIN_INPUT_PULLUP | 0x80) /* PHY A IRQ */
-			DM814X_IOPAD(0x0910, PIN_INPUT_PULLUP | 0x80) /* PHY A RESET */
-			DM814X_IOPAD(0x08f4, PIN_INPUT_PULLUP | 0x80) /* PHY B IRQ */
-			DM814X_IOPAD(0x08f8, PIN_INPUT_PULLUP | 0x80) /* PHY B RESET */
-
-			//DM814X_IOPAD(0x0a14, PIN_INPUT_PULLUP | 0x80) /* ARM IRQ */
-			//DM814X_IOPAD(0x0900, PIN_INPUT | 0x80) /* GPIO IRQ */
-			DM814X_IOPAD(0x0a2c, PIN_INPUT_PULLUP | 0x80) /* GPIO RESET */
+			DM814X_IOPAD(0x090c, PIN_INPUT_PULLUP | 0x80)	/* PHY A IRQ */
+			DM814X_IOPAD(0x0910, PIN_INPUT_PULLUP | 0x80)	/* PHY A RESET */
+			DM814X_IOPAD(0x08f4, PIN_INPUT_PULLUP | 0x80)	/* PHY B IRQ */
+			DM814X_IOPAD(0x08f8, PIN_INPUT_PULLUP | 0x80)	/* PHY B RESET */
+
+			//DM814X_IOPAD(0x0a14, PIN_INPUT_PULLUP | 0x80)	/* ARM IRQ */
+			//DM814X_IOPAD(0x0900, PIN_INPUT | 0x80)	/* GPIO IRQ */
+			DM814X_IOPAD(0x0a2c, PIN_INPUT_PULLUP | 0x80)	/* GPIO RESET */
 		>;
 	};
 
@@ -362,19 +362,19 @@
 			 * we force the CS lines to pull up as GPIOs until we're ready.
 			 * See https://e2e.ti.com/support/processors/f/791/t/276011?Linux-support-for-AM3874-DM8148-in-Arago-linux-omap3
 			 */
-			DM814X_IOPAD(0x0b3c, PIN_INPUT_PULLUP | 0x80) /* BP_ARM_GPIO0 */
-			DM814X_IOPAD(0x0b40, PIN_INPUT_PULLUP | 0x80) /* BP_ARM_GPIO1 */
-			DM814X_IOPAD(0x0b44, PIN_INPUT_PULLUP | 0x80) /* BP_ARM_GPIO2 */
-			DM814X_IOPAD(0x0b48, PIN_INPUT_PULLUP | 0x80) /* BP_ARM_GPIO3 */
-			DM814X_IOPAD(0x0b4c, PIN_INPUT_PULLUP | 0x80) /* BP_ARM_GPIO4 */
-			DM814X_IOPAD(0x0b50, PIN_INPUT_PULLUP | 0x80) /* BP_ARM_GPIO5 */
+			DM814X_IOPAD(0x0b3c, PIN_INPUT_PULLUP | 0x80)	/* BP_ARM_GPIO0 */
+			DM814X_IOPAD(0x0b40, PIN_INPUT_PULLUP | 0x80)	/* BP_ARM_GPIO1 */
+			DM814X_IOPAD(0x0b44, PIN_INPUT_PULLUP | 0x80)	/* BP_ARM_GPIO2 */
+			DM814X_IOPAD(0x0b48, PIN_INPUT_PULLUP | 0x80)	/* BP_ARM_GPIO3 */
+			DM814X_IOPAD(0x0b4c, PIN_INPUT_PULLUP | 0x80)	/* BP_ARM_GPIO4 */
+			DM814X_IOPAD(0x0b50, PIN_INPUT_PULLUP | 0x80)	/* BP_ARM_GPIO5 */
 		>;
 	};
 
 	spi2_pins: pinmux_spi2_pins {
 		pinctrl-single,pins = <
-			DM814X_IOPAD(0x0950, PIN_INPUT_PULLUP | 0x80) /* PLL SPI CS1 as GPIO */
-			DM814X_IOPAD(0x0818, PIN_INPUT_PULLUP | 0x80) /* PLL SPI CS2 as GPIO */
+			DM814X_IOPAD(0x0950, PIN_INPUT_PULLUP | 0x80)	/* PLL SPI CS1 as GPIO */
+			DM814X_IOPAD(0x0818, PIN_INPUT_PULLUP | 0x80)	/* PLL SPI CS2 as GPIO */
 		>;
 	};
 
diff --git a/arch/arm/boot/dts/am437x-cm-t43.dts b/arch/arm/boot/dts/am437x-cm-t43.dts
index 4fcf647..c609cba 100644
--- a/arch/arm/boot/dts/am437x-cm-t43.dts
+++ b/arch/arm/boot/dts/am437x-cm-t43.dts
@@ -49,32 +49,32 @@
 
 	i2c0_pins: i2c0_pins {
 		pinctrl-single,pins = <
-			AM4372_IOPAD(0x988, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)  /* i2c0_sda.i2c0_sda */
-			AM4372_IOPAD(0x98c, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)  /* i2c0_scl.i2c0_scl */
+			AM4372_IOPAD(0x988, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* i2c0_sda.i2c0_sda */
+			AM4372_IOPAD(0x98c, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
 		>;
 	};
 
 	emmc_pins: emmc_pins {
 		pinctrl-single,pins = <
-			AM4372_IOPAD(0x820, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_ad8.mmc1_dat0 */
-			AM4372_IOPAD(0x824, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_ad9.mmc1_dat1 */
-			AM4372_IOPAD(0x828, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_ad10.mmc1_dat2 */
-			AM4372_IOPAD(0x82c, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_ad11.mmc1_dat3 */
-			AM4372_IOPAD(0x830, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_ad12.mmc1_dat4 */
-			AM4372_IOPAD(0x834, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_ad13.mmc1_dat5 */
-			AM4372_IOPAD(0x838, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_ad14.mmc1_dat6 */
-			AM4372_IOPAD(0x83c, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_ad15.mmc1_dat7 */
-			AM4372_IOPAD(0x880, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_csn1.mmc1_clk */
-			AM4372_IOPAD(0x884, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_csn2.mmc1_cmd */
+			AM4372_IOPAD(0x820, PIN_INPUT_PULLUP | MUX_MODE2)			/* gpmc_ad8.mmc1_dat0 */
+			AM4372_IOPAD(0x824, PIN_INPUT_PULLUP | MUX_MODE2)			/* gpmc_ad9.mmc1_dat1 */
+			AM4372_IOPAD(0x828, PIN_INPUT_PULLUP | MUX_MODE2)			/* gpmc_ad10.mmc1_dat2 */
+			AM4372_IOPAD(0x82c, PIN_INPUT_PULLUP | MUX_MODE2)			/* gpmc_ad11.mmc1_dat3 */
+			AM4372_IOPAD(0x830, PIN_INPUT_PULLUP | MUX_MODE2)			/* gpmc_ad12.mmc1_dat4 */
+			AM4372_IOPAD(0x834, PIN_INPUT_PULLUP | MUX_MODE2)			/* gpmc_ad13.mmc1_dat5 */
+			AM4372_IOPAD(0x838, PIN_INPUT_PULLUP | MUX_MODE2)			/* gpmc_ad14.mmc1_dat6 */
+			AM4372_IOPAD(0x83c, PIN_INPUT_PULLUP | MUX_MODE2)			/* gpmc_ad15.mmc1_dat7 */
+			AM4372_IOPAD(0x880, PIN_INPUT_PULLUP | MUX_MODE2)			/* gpmc_csn1.mmc1_clk */
+			AM4372_IOPAD(0x884, PIN_INPUT_PULLUP | MUX_MODE2)			/* gpmc_csn2.mmc1_cmd */
 		>;
 	};
 
 	spi0_pins: pinmux_spi0_pins {
 		pinctrl-single,pins = <
-			AM4372_IOPAD(0x950, PIN_INPUT | MUX_MODE0) /* spi0_sclk.spi0_sclk */
-			AM4372_IOPAD(0x954, PIN_INPUT | MUX_MODE0) /* spi0_d0.spi0_d0 */
-			AM4372_IOPAD(0x958, PIN_OUTPUT | MUX_MODE0) /* spi0_d1.spi0_d1 */
-			AM4372_IOPAD(0x95C, PIN_OUTPUT | MUX_MODE0) /* spi0_cs0.spi0_cs0 */
+			AM4372_IOPAD(0x950, PIN_INPUT | MUX_MODE0)			/* spi0_sclk.spi0_sclk */
+			AM4372_IOPAD(0x954, PIN_INPUT | MUX_MODE0)			/* spi0_d0.spi0_d0 */
+			AM4372_IOPAD(0x958, PIN_OUTPUT | MUX_MODE0)			/* spi0_d1.spi0_d1 */
+			AM4372_IOPAD(0x95C, PIN_OUTPUT | MUX_MODE0)			/* spi0_cs0.spi0_cs0 */
 		>;
 	};
 
diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 4c6ee37e..3f38cfb 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -80,12 +80,12 @@
 		col-gpios = <&gpio3 19 GPIO_ACTIVE_HIGH /* Bank3, pin19 */
 				&gpio3 20 GPIO_ACTIVE_HIGH>; /* Bank3, pin20 */
 
-		linux,keymap = <0x00000201      /* P1 */
-				0x00010202      /* P2 */
-				0x01000067      /* UP */
-				0x0101006a      /* RIGHT */
-				0x02000069      /* LEFT */
-				0x0201006c>;      /* DOWN */
+		linux,keymap = <0x00000201	/* P1 */
+				0x00010202	/* P2 */
+				0x01000067	/* UP */
+				0x0101006a	/* RIGHT */
+				0x02000069	/* LEFT */
+				0x0201006c>;	/* DOWN */
 		};
 
 	lcd0: display {
@@ -180,33 +180,33 @@
 
 	i2c0_pins: i2c0_pins {
 		pinctrl-single,pins = <
-			AM4372_IOPAD(0x988, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)  /* i2c0_sda.i2c0_sda */
-			AM4372_IOPAD(0x98c, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)  /* i2c0_scl.i2c0_scl */
+			AM4372_IOPAD(0x988, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* i2c0_sda.i2c0_sda */
+			AM4372_IOPAD(0x98c, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
 		>;
 	};
 
 	i2c1_pins: i2c1_pins {
 		pinctrl-single,pins = <
-			AM4372_IOPAD(0x95c, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE2)  /* spi0_cs0.i2c1_scl */
-			AM4372_IOPAD(0x958, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE2)  /* spi0_d1.i2c1_sda  */
+			AM4372_IOPAD(0x95c, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE2)	/* spi0_cs0.i2c1_scl */
+			AM4372_IOPAD(0x958, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE2)	/* spi0_d1.i2c1_sda  */
 		>;
 	};
 
 	mmc1_pins: pinmux_mmc1_pins {
 		pinctrl-single,pins = <
-			AM4372_IOPAD(0x960, PIN_INPUT | MUX_MODE7) /* spi0_cs1.gpio0_6 */
+			AM4372_IOPAD(0x960, PIN_INPUT | MUX_MODE7)		/* spi0_cs1.gpio0_6 */
 		>;
 	};
 
 	ecap0_pins: backlight_pins {
 		pinctrl-single,pins = <
-			AM4372_IOPAD(0x964, MUX_MODE0)       /* eCAP0_in_PWM0_out.eCAP0_in_PWM0_out MODE0 */
+			AM4372_IOPAD(0x964, MUX_MODE0)				/* eCAP0_in_PWM0_out.eCAP0_in_PWM0_out MODE0 */
 		>;
 	};
 
 	pixcir_ts_pins: pixcir_ts_pins {
 		pinctrl-single,pins = <
-			AM4372_IOPAD(0xa64, PIN_INPUT_PULLUP | MUX_MODE7)  /* spi2_d0.gpio3_22 */
+			AM4372_IOPAD(0xa64, PIN_INPUT_PULLUP | MUX_MODE7)	/* spi2_d0.gpio3_22 */
 		>;
 	};
 
@@ -264,14 +264,14 @@
 
 	nand_flash_x8: nand_flash_x8 {
 		pinctrl-single,pins = <
-			AM4372_IOPAD(0x800, PIN_INPUT  | MUX_MODE0)	/* gpmc_ad0.gpmc_ad0 */
-			AM4372_IOPAD(0x804, PIN_INPUT  | MUX_MODE0)	/* gpmc_ad1.gpmc_ad1 */
-			AM4372_IOPAD(0x808, PIN_INPUT  | MUX_MODE0)	/* gpmc_ad2.gpmc_ad2 */
-			AM4372_IOPAD(0x80c, PIN_INPUT  | MUX_MODE0)	/* gpmc_ad3.gpmc_ad3 */
-			AM4372_IOPAD(0x810, PIN_INPUT  | MUX_MODE0)	/* gpmc_ad4.gpmc_ad4 */
-			AM4372_IOPAD(0x814, PIN_INPUT  | MUX_MODE0)	/* gpmc_ad5.gpmc_ad5 */
-			AM4372_IOPAD(0x818, PIN_INPUT  | MUX_MODE0)	/* gpmc_ad6.gpmc_ad6 */
-			AM4372_IOPAD(0x81c, PIN_INPUT  | MUX_MODE0)	/* gpmc_ad7.gpmc_ad7 */
+			AM4372_IOPAD(0x800, PIN_INPUT  | MUX_MODE0)		/* gpmc_ad0.gpmc_ad0 */
+			AM4372_IOPAD(0x804, PIN_INPUT  | MUX_MODE0)		/* gpmc_ad1.gpmc_ad1 */
+			AM4372_IOPAD(0x808, PIN_INPUT  | MUX_MODE0)		/* gpmc_ad2.gpmc_ad2 */
+			AM4372_IOPAD(0x80c, PIN_INPUT  | MUX_MODE0)		/* gpmc_ad3.gpmc_ad3 */
+			AM4372_IOPAD(0x810, PIN_INPUT  | MUX_MODE0)		/* gpmc_ad4.gpmc_ad4 */
+			AM4372_IOPAD(0x814, PIN_INPUT  | MUX_MODE0)		/* gpmc_ad5.gpmc_ad5 */
+			AM4372_IOPAD(0x818, PIN_INPUT  | MUX_MODE0)		/* gpmc_ad6.gpmc_ad6 */
+			AM4372_IOPAD(0x81c, PIN_INPUT  | MUX_MODE0)		/* gpmc_ad7.gpmc_ad7 */
 			AM4372_IOPAD(0x870, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_wait0.gpmc_wait0 */
 			AM4372_IOPAD(0x874, PIN_OUTPUT_PULLUP | MUX_MODE7)	/* gpmc_wpn.gpmc_wpn */
 			AM4372_IOPAD(0x87c, PIN_OUTPUT | MUX_MODE0)		/* gpmc_csn0.gpmc_csn0  */
@@ -284,15 +284,15 @@
 
 	dss_pins: dss_pins {
 		pinctrl-single,pins = <
-			AM4372_IOPAD(0x820, PIN_OUTPUT_PULLUP | MUX_MODE1) /*gpmc ad 8 -> DSS DATA 23 */
+			AM4372_IOPAD(0x820, PIN_OUTPUT_PULLUP | MUX_MODE1)	/* gpmc ad 8 -> DSS DATA 23 */
 			AM4372_IOPAD(0x824, PIN_OUTPUT_PULLUP | MUX_MODE1)
 			AM4372_IOPAD(0x828, PIN_OUTPUT_PULLUP | MUX_MODE1)
 			AM4372_IOPAD(0x82c, PIN_OUTPUT_PULLUP | MUX_MODE1)
 			AM4372_IOPAD(0x830, PIN_OUTPUT_PULLUP | MUX_MODE1)
 			AM4372_IOPAD(0x834, PIN_OUTPUT_PULLUP | MUX_MODE1)
 			AM4372_IOPAD(0x838, PIN_OUTPUT_PULLUP | MUX_MODE1)
-			AM4372_IOPAD(0x83c, PIN_OUTPUT_PULLUP | MUX_MODE1) /*gpmc ad 15 -> DSS DATA 16 */
-			AM4372_IOPAD(0x8a0, PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS DATA 0 */
+			AM4372_IOPAD(0x83c, PIN_OUTPUT_PULLUP | MUX_MODE1)	/* gpmc ad 15 -> DSS DATA 16 */
+			AM4372_IOPAD(0x8a0, PIN_OUTPUT_PULLUP | MUX_MODE0)	/* DSS DATA 0 */
 			AM4372_IOPAD(0x8a4, PIN_OUTPUT_PULLUP | MUX_MODE0)
 			AM4372_IOPAD(0x8a8, PIN_OUTPUT_PULLUP | MUX_MODE0)
 			AM4372_IOPAD(0x8ac, PIN_OUTPUT_PULLUP | MUX_MODE0)
@@ -307,11 +307,11 @@
 			AM4372_IOPAD(0x8d0, PIN_OUTPUT_PULLUP | MUX_MODE0)
 			AM4372_IOPAD(0x8d4, PIN_OUTPUT_PULLUP | MUX_MODE0)
 			AM4372_IOPAD(0x8d8, PIN_OUTPUT_PULLUP | MUX_MODE0)
-			AM4372_IOPAD(0x8dc, PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS DATA 15 */
-			AM4372_IOPAD(0x8e0, PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS VSYNC */
-			AM4372_IOPAD(0x8e4, PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS HSYNC */
-			AM4372_IOPAD(0x8e8, PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS PCLK */
-			AM4372_IOPAD(0x8ec, PIN_OUTPUT_PULLUP | MUX_MODE0) /* DSS AC BIAS EN */
+			AM4372_IOPAD(0x8dc, PIN_OUTPUT_PULLUP | MUX_MODE0)	/* DSS DATA 15 */
+			AM4372_IOPAD(0x8e0, PIN_OUTPUT_PULLUP | MUX_MODE0)	/* DSS VSYNC */
+			AM4372_IOPAD(0x8e4, PIN_OUTPUT_PULLUP | MUX_MODE0)	/* DSS HSYNC */
+			AM4372_IOPAD(0x8e8, PIN_OUTPUT_PULLUP | MUX_MODE0)	/* DSS PCLK */
+			AM4372_IOPAD(0x8ec, PIN_OUTPUT_PULLUP | MUX_MODE0)	/* DSS AC BIAS EN */
 
 		>;
 	};
@@ -353,84 +353,84 @@
 
 	vpfe0_pins_default: vpfe0_pins_default {
 		pinctrl-single,pins = <
-			AM4372_IOPAD(0x9b0, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_hd mode 0*/
-			AM4372_IOPAD(0x9b4, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_vd mode 0*/
-			AM4372_IOPAD(0x9c0, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_pclk mode 0*/
-			AM4372_IOPAD(0x9c4, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_data8 mode 0*/
-			AM4372_IOPAD(0x9c8, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_data9 mode 0*/
-			AM4372_IOPAD(0xa08, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_data0 mode 0*/
-			AM4372_IOPAD(0xa0c, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_data1 mode 0*/
-			AM4372_IOPAD(0xa10, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_data2 mode 0*/
-			AM4372_IOPAD(0xa14, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_data3 mode 0*/
-			AM4372_IOPAD(0xa18, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_data4 mode 0*/
-			AM4372_IOPAD(0xa1c, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_data5 mode 0*/
-			AM4372_IOPAD(0xa20, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_data6 mode 0*/
-			AM4372_IOPAD(0xa24, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam0_data7 mode 0*/
+			AM4372_IOPAD(0x9b0, PIN_INPUT_PULLUP | MUX_MODE0)	/* cam0_hd mode 0*/
+			AM4372_IOPAD(0x9b4, PIN_INPUT_PULLUP | MUX_MODE0)	/* cam0_vd mode 0*/
+			AM4372_IOPAD(0x9c0, PIN_INPUT_PULLUP | MUX_MODE0)	/* cam0_pclk mode 0*/
+			AM4372_IOPAD(0x9c4, PIN_INPUT_PULLUP | MUX_MODE0)	/* cam0_data8 mode 0*/
+			AM4372_IOPAD(0x9c8, PIN_INPUT_PULLUP | MUX_MODE0)	/* cam0_data9 mode 0*/
+			AM4372_IOPAD(0xa08, PIN_INPUT_PULLUP | MUX_MODE0)	/* cam0_data0 mode 0*/
+			AM4372_IOPAD(0xa0c, PIN_INPUT_PULLUP | MUX_MODE0)	/* cam0_data1 mode 0*/
+			AM4372_IOPAD(0xa10, PIN_INPUT_PULLUP | MUX_MODE0)	/* cam0_data2 mode 0*/
+			AM4372_IOPAD(0xa14, PIN_INPUT_PULLUP | MUX_MODE0)	/* cam0_data3 mode 0*/
+			AM4372_IOPAD(0xa18, PIN_INPUT_PULLUP | MUX_MODE0)	/* cam0_data4 mode 0*/
+			AM4372_IOPAD(0xa1c, PIN_INPUT_PULLUP | MUX_MODE0)	/* cam0_data5 mode 0*/
+			AM4372_IOPAD(0xa20, PIN_INPUT_PULLUP | MUX_MODE0)	/* cam0_data6 mode 0*/
+			AM4372_IOPAD(0xa24, PIN_INPUT_PULLUP | MUX_MODE0)	/* cam0_data7 mode 0*/
 		>;
 	};
 
 	vpfe0_pins_sleep: vpfe0_pins_sleep {
 		pinctrl-single,pins = <
-			AM4372_IOPAD(0x9b0, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam0_hd mode 0*/
-			AM4372_IOPAD(0x9b4, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam0_vd mode 0*/
-			AM4372_IOPAD(0x9c0, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam0_pclk mode 0*/
-			AM4372_IOPAD(0x9c4, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam0_data8 mode 0*/
-			AM4372_IOPAD(0x9c8, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam0_data9 mode 0*/
-			AM4372_IOPAD(0xa08, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam0_data0 mode 0*/
-			AM4372_IOPAD(0xa0c, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam0_data1 mode 0*/
-			AM4372_IOPAD(0xa10, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam0_data2 mode 0*/
-			AM4372_IOPAD(0xa14, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam0_data3 mode 0*/
-			AM4372_IOPAD(0xa18, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam0_data4 mode 0*/
-			AM4372_IOPAD(0xa1c, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam0_data5 mode 0*/
-			AM4372_IOPAD(0xa20, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam0_data6 mode 0*/
-			AM4372_IOPAD(0xa24, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam0_data7 mode 0*/
+			AM4372_IOPAD(0x9b0, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)	/* cam0_hd mode 0*/
+			AM4372_IOPAD(0x9b4, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)	/* cam0_vd mode 0*/
+			AM4372_IOPAD(0x9c0, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)	/* cam0_pclk mode 0*/
+			AM4372_IOPAD(0x9c4, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)	/* cam0_data8 mode 0*/
+			AM4372_IOPAD(0x9c8, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)	/* cam0_data9 mode 0*/
+			AM4372_IOPAD(0xa08, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)	/* cam0_data0 mode 0*/
+			AM4372_IOPAD(0xa0c, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)	/* cam0_data1 mode 0*/
+			AM4372_IOPAD(0xa10, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)	/* cam0_data2 mode 0*/
+			AM4372_IOPAD(0xa14, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)	/* cam0_data3 mode 0*/
+			AM4372_IOPAD(0xa18, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)	/* cam0_data4 mode 0*/
+			AM4372_IOPAD(0xa1c, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)	/* cam0_data5 mode 0*/
+			AM4372_IOPAD(0xa20, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)	/* cam0_data6 mode 0*/
+			AM4372_IOPAD(0xa24, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)	/* cam0_data7 mode 0*/
 		>;
 	};
 
 	vpfe1_pins_default: vpfe1_pins_default {
 		pinctrl-single,pins = <
-			AM4372_IOPAD(0x9cc, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_data9 mode 0*/
-			AM4372_IOPAD(0x9d0, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_data8 mode 0*/
-			AM4372_IOPAD(0x9d4, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_hd mode 0*/
-			AM4372_IOPAD(0x9d8, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_vd mode 0*/
-			AM4372_IOPAD(0x9dC, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_pclk mode 0*/
-			AM4372_IOPAD(0x9e8, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_data0 mode 0*/
-			AM4372_IOPAD(0x9ec, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_data1 mode 0*/
-			AM4372_IOPAD(0x9f0, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_data2 mode 0*/
-			AM4372_IOPAD(0x9f4, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_data3 mode 0*/
-			AM4372_IOPAD(0x9f8, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_data4 mode 0*/
-			AM4372_IOPAD(0x9fc, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_data5 mode 0*/
-			AM4372_IOPAD(0xa00, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_data6 mode 0*/
-			AM4372_IOPAD(0xa04, PIN_INPUT_PULLUP | MUX_MODE0)  /* cam1_data7 mode 0*/
+			AM4372_IOPAD(0x9cc, PIN_INPUT_PULLUP | MUX_MODE0)	/* cam1_data9 mode 0*/
+			AM4372_IOPAD(0x9d0, PIN_INPUT_PULLUP | MUX_MODE0)	/* cam1_data8 mode 0*/
+			AM4372_IOPAD(0x9d4, PIN_INPUT_PULLUP | MUX_MODE0)	/* cam1_hd mode 0*/
+			AM4372_IOPAD(0x9d8, PIN_INPUT_PULLUP | MUX_MODE0)	/* cam1_vd mode 0*/
+			AM4372_IOPAD(0x9dC, PIN_INPUT_PULLUP | MUX_MODE0)	/* cam1_pclk mode 0*/
+			AM4372_IOPAD(0x9e8, PIN_INPUT_PULLUP | MUX_MODE0)	/* cam1_data0 mode 0*/
+			AM4372_IOPAD(0x9ec, PIN_INPUT_PULLUP | MUX_MODE0)	/* cam1_data1 mode 0*/
+			AM4372_IOPAD(0x9f0, PIN_INPUT_PULLUP | MUX_MODE0)	/* cam1_data2 mode 0*/
+			AM4372_IOPAD(0x9f4, PIN_INPUT_PULLUP | MUX_MODE0)	/* cam1_data3 mode 0*/
+			AM4372_IOPAD(0x9f8, PIN_INPUT_PULLUP | MUX_MODE0)	/* cam1_data4 mode 0*/
+			AM4372_IOPAD(0x9fc, PIN_INPUT_PULLUP | MUX_MODE0)	/* cam1_data5 mode 0*/
+			AM4372_IOPAD(0xa00, PIN_INPUT_PULLUP | MUX_MODE0)	/* cam1_data6 mode 0*/
+			AM4372_IOPAD(0xa04, PIN_INPUT_PULLUP | MUX_MODE0)	/* cam1_data7 mode 0*/
 		>;
 	};
 
 	vpfe1_pins_sleep: vpfe1_pins_sleep {
 		pinctrl-single,pins = <
-			AM4372_IOPAD(0x9cc, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam1_data9 mode 0*/
-			AM4372_IOPAD(0x9d0, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam1_data8 mode 0*/
-			AM4372_IOPAD(0x9d4, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam1_hd mode 0*/
-			AM4372_IOPAD(0x9d8, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam1_vd mode 0*/
-			AM4372_IOPAD(0x9dc, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam1_pclk mode 0*/
-			AM4372_IOPAD(0x9e8, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam1_data0 mode 0*/
-			AM4372_IOPAD(0x9ec, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam1_data1 mode 0*/
-			AM4372_IOPAD(0x9f0, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam1_data2 mode 0*/
-			AM4372_IOPAD(0x9f4, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam1_data3 mode 0*/
-			AM4372_IOPAD(0x9f8, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam1_data4 mode 0*/
-			AM4372_IOPAD(0x9fc, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam1_data5 mode 0*/
-			AM4372_IOPAD(0xa00, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam1_data6 mode 0*/
-			AM4372_IOPAD(0xa04, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)  /* cam1_data7 mode 0*/
+			AM4372_IOPAD(0x9cc, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)	/* cam1_data9 mode 0*/
+			AM4372_IOPAD(0x9d0, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)	/* cam1_data8 mode 0*/
+			AM4372_IOPAD(0x9d4, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)	/* cam1_hd mode 0*/
+			AM4372_IOPAD(0x9d8, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)	/* cam1_vd mode 0*/
+			AM4372_IOPAD(0x9dc, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)	/* cam1_pclk mode 0*/
+			AM4372_IOPAD(0x9e8, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)	/* cam1_data0 mode 0*/
+			AM4372_IOPAD(0x9ec, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)	/* cam1_data1 mode 0*/
+			AM4372_IOPAD(0x9f0, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)	/* cam1_data2 mode 0*/
+			AM4372_IOPAD(0x9f4, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)	/* cam1_data3 mode 0*/
+			AM4372_IOPAD(0x9f8, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)	/* cam1_data4 mode 0*/
+			AM4372_IOPAD(0x9fc, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)	/* cam1_data5 mode 0*/
+			AM4372_IOPAD(0xa00, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)	/* cam1_data6 mode 0*/
+			AM4372_IOPAD(0xa04, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)	/* cam1_data7 mode 0*/
 		>;
 	};
 
 	mmc3_pins_default: pinmux_mmc3_pins_default {
 		pinctrl-single,pins = <
-			AM4372_IOPAD(0x88c, PIN_INPUT_PULLUP | MUX_MODE3)      /* gpmc_clk.mmc2_clk */
-			AM4372_IOPAD(0x888, PIN_INPUT_PULLUP | MUX_MODE3)      /* gpmc_csn3.mmc2_cmd */
-			AM4372_IOPAD(0x844, PIN_INPUT_PULLUP | MUX_MODE3)      /* gpmc_a1.mmc2_dat0 */
-			AM4372_IOPAD(0x848, PIN_INPUT_PULLUP | MUX_MODE3)      /* gpmc_a2.mmc2_dat1 */
-			AM4372_IOPAD(0x84c, PIN_INPUT_PULLUP | MUX_MODE3)      /* gpmc_a3.mmc2_dat2 */
-			AM4372_IOPAD(0x878, PIN_INPUT_PULLUP | MUX_MODE3)      /* gpmc_be1n.mmc2_dat3 */
+			AM4372_IOPAD(0x88c, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_clk.mmc2_clk */
+			AM4372_IOPAD(0x888, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_csn3.mmc2_cmd */
+			AM4372_IOPAD(0x844, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_a1.mmc2_dat0 */
+			AM4372_IOPAD(0x848, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_a2.mmc2_dat1 */
+			AM4372_IOPAD(0x84c, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_a3.mmc2_dat2 */
+			AM4372_IOPAD(0x878, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_be1n.mmc2_dat3 */
 		>;
 	};
 
@@ -463,19 +463,19 @@
 
 	uart3_pins: uart3_pins {
 		pinctrl-single,pins = <
-			AM4372_IOPAD(0xa28, PIN_INPUT | MUX_MODE0)		/* uart3_rxd.uart3_rxd */
-			AM4372_IOPAD(0xa2c, PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* uart3_txd.uart3_txd */
-			AM4372_IOPAD(0xa30, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart3_ctsn.uart3_ctsn */
-			AM4372_IOPAD(0xa34, PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* uart3_rtsn.uart3_rtsn */
+			AM4372_IOPAD(0xa28, PIN_INPUT | MUX_MODE0)			/* uart3_rxd.uart3_rxd */
+			AM4372_IOPAD(0xa2c, PIN_OUTPUT_PULLDOWN | MUX_MODE0)		/* uart3_txd.uart3_txd */
+			AM4372_IOPAD(0xa30, PIN_INPUT_PULLUP | MUX_MODE0)		/* uart3_ctsn.uart3_ctsn */
+			AM4372_IOPAD(0xa34, PIN_OUTPUT_PULLDOWN | MUX_MODE0)		/* uart3_rtsn.uart3_rtsn */
 		>;
 	};
 
 	mcasp1_pins: mcasp1_pins {
 		pinctrl-single,pins = <
-			AM4372_IOPAD(0x908, PIN_OUTPUT_PULLDOWN | MUX_MODE4)	/* mii1_col.mcasp1_axr2 */
-			AM4372_IOPAD(0x90c, PIN_INPUT_PULLDOWN | MUX_MODE4)	/* mii1_crs.mcasp1_aclkx */
-			AM4372_IOPAD(0x910, PIN_INPUT_PULLDOWN | MUX_MODE4)	/* mii1_rxerr.mcasp1_fsx */
-			AM4372_IOPAD(0x944, PIN_INPUT_PULLDOWN | MUX_MODE4)	/* rmii1_ref_clk.mcasp1_axr3 */
+			AM4372_IOPAD(0x908, PIN_OUTPUT_PULLDOWN | MUX_MODE4)		/* mii1_col.mcasp1_axr2 */
+			AM4372_IOPAD(0x90c, PIN_INPUT_PULLDOWN | MUX_MODE4)		/* mii1_crs.mcasp1_aclkx */
+			AM4372_IOPAD(0x910, PIN_INPUT_PULLDOWN | MUX_MODE4)		/* mii1_rxerr.mcasp1_fsx */
+			AM4372_IOPAD(0x944, PIN_INPUT_PULLDOWN | MUX_MODE4)		/* rmii1_ref_clk.mcasp1_axr3 */
 		>;
 	};
 
@@ -496,31 +496,31 @@
 
 	emmc_pins_default: emmc_pins_default {
 		pinctrl-single,pins = <
-			AM4372_IOPAD(0x800, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad0.mmc1_dat0 */
-			AM4372_IOPAD(0x804, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad1.mmc1_dat1 */
-			AM4372_IOPAD(0x808, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad2.mmc1_dat2 */
-			AM4372_IOPAD(0x80c, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad3.mmc1_dat3 */
-			AM4372_IOPAD(0x810, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad4.mmc1_dat4 */
-			AM4372_IOPAD(0x814, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad5.mmc1_dat5 */
-			AM4372_IOPAD(0x818, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad6.mmc1_dat6 */
-			AM4372_IOPAD(0x81c, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad7.mmc1_dat7 */
-			AM4372_IOPAD(0x880, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_csn1.mmc1_clk */
-			AM4372_IOPAD(0x884, PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_csn2.mmc1_cmd */
+			AM4372_IOPAD(0x800, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad0.mmc1_dat0 */
+			AM4372_IOPAD(0x804, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad1.mmc1_dat1 */
+			AM4372_IOPAD(0x808, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad2.mmc1_dat2 */
+			AM4372_IOPAD(0x80c, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad3.mmc1_dat3 */
+			AM4372_IOPAD(0x810, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad4.mmc1_dat4 */
+			AM4372_IOPAD(0x814, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad5.mmc1_dat5 */
+			AM4372_IOPAD(0x818, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad6.mmc1_dat6 */
+			AM4372_IOPAD(0x81c, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad7.mmc1_dat7 */
+			AM4372_IOPAD(0x880, PIN_INPUT_PULLUP | MUX_MODE2)	/* gpmc_csn1.mmc1_clk */
+			AM4372_IOPAD(0x884, PIN_INPUT_PULLUP | MUX_MODE2)	/* gpmc_csn2.mmc1_cmd */
 		>;
 	};
 
 	emmc_pins_sleep: emmc_pins_sleep {
 		pinctrl-single,pins = <
-			AM4372_IOPAD(0x800, PIN_INPUT_PULLDOWN | MUX_MODE7) /* gpmc_ad0.gpio1_0 */
-			AM4372_IOPAD(0x804, PIN_INPUT_PULLDOWN | MUX_MODE7) /* gpmc_ad1.gpio1_1 */
-			AM4372_IOPAD(0x808, PIN_INPUT_PULLDOWN | MUX_MODE7) /* gpmc_ad2.gpio1_2 */
-			AM4372_IOPAD(0x80c, PIN_INPUT_PULLDOWN | MUX_MODE7) /* gpmc_ad3.gpio1_3 */
-			AM4372_IOPAD(0x810, PIN_INPUT_PULLDOWN | MUX_MODE7) /* gpmc_ad4.gpio1_4 */
-			AM4372_IOPAD(0x814, PIN_INPUT_PULLDOWN | MUX_MODE7) /* gpmc_ad5.gpio1_5 */
-			AM4372_IOPAD(0x818, PIN_INPUT_PULLDOWN | MUX_MODE7) /* gpmc_ad6.gpio1_6 */
-			AM4372_IOPAD(0x81c, PIN_INPUT_PULLDOWN | MUX_MODE7) /* gpmc_ad7.gpio1_7 */
-			AM4372_IOPAD(0x880, PIN_INPUT_PULLDOWN | MUX_MODE7) /* gpmc_csn1.gpio1_30 */
-			AM4372_IOPAD(0x884, PIN_INPUT_PULLDOWN | MUX_MODE7) /* gpmc_csn2.gpio1_31 */
+			AM4372_IOPAD(0x800, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad0.gpio1_0 */
+			AM4372_IOPAD(0x804, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad1.gpio1_1 */
+			AM4372_IOPAD(0x808, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad2.gpio1_2 */
+			AM4372_IOPAD(0x80c, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad3.gpio1_3 */
+			AM4372_IOPAD(0x810, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad4.gpio1_4 */
+			AM4372_IOPAD(0x814, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad5.gpio1_5 */
+			AM4372_IOPAD(0x818, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad6.gpio1_6 */
+			AM4372_IOPAD(0x81c, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad7.gpio1_7 */
+			AM4372_IOPAD(0x880, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_csn1.gpio1_30 */
+			AM4372_IOPAD(0x884, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_csn2.gpio1_31 */
 		>;
 	};
 
@@ -599,8 +599,8 @@
 
 	uart0_pins_default: uart0_pins_default {
 		pinctrl-single,pins = <
-			AM4372_IOPAD(0x968, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE0) /* uart0_ctsn.uart0_ctsn */
-			AM4372_IOPAD(0x96C, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE0) /* uart0_rtsn.uart0_rtsn */
+			AM4372_IOPAD(0x968, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE0)	/* uart0_ctsn.uart0_ctsn */
+			AM4372_IOPAD(0x96C, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE0)	/* uart0_rtsn.uart0_rtsn */
 			AM4372_IOPAD(0x970, PIN_INPUT_PULLUP | SLEWCTRL_FAST | DS0_PULL_UP_DOWN_EN | MUX_MODE0) /* uart0_rxd.uart0_rxd */
 			AM4372_IOPAD(0x974, PIN_INPUT | PULL_DISABLE | SLEWCTRL_FAST | DS0_PULL_UP_DOWN_EN | MUX_MODE0) /* uart0_txd.uart0_txd */
 		>;
@@ -608,8 +608,8 @@
 
 	uart0_pins_sleep: uart0_pins_sleep {
 		pinctrl-single,pins = <
-			AM4372_IOPAD(0x968, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7) /* uart0_ctsn.uart0_ctsn */
-			AM4372_IOPAD(0x96C, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7) /* uart0_rtsn.uart0_rtsn */
+			AM4372_IOPAD(0x968, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)	/* uart0_ctsn.uart0_ctsn */
+			AM4372_IOPAD(0x96C, DS0_PULL_UP_DOWN_EN | INPUT_EN | MUX_MODE7)	/* uart0_rtsn.uart0_rtsn */
 			AM4372_IOPAD(0x970, PIN_INPUT_PULLUP | SLEWCTRL_FAST | DS0_PULL_UP_DOWN_EN | MUX_MODE0) /* uart0_rxd.uart0_rxd */
 			AM4372_IOPAD(0x974, PIN_INPUT_PULLDOWN | SLEWCTRL_FAST | DS0_PULL_UP_DOWN_EN | MUX_MODE0) /* uart0_txd.uart0_txd */
 		>;
diff --git a/arch/arm/boot/dts/am437x-idk-evm.dts b/arch/arm/boot/dts/am437x-idk-evm.dts
index bb28540..f99957c 100644
--- a/arch/arm/boot/dts/am437x-idk-evm.dts
+++ b/arch/arm/boot/dts/am437x-idk-evm.dts
@@ -178,14 +178,14 @@
 &am43xx_pinmux {
 	gpio_keys_pins_default: gpio_keys_pins_default {
 		pinctrl-single,pins = <
-			AM4372_IOPAD(0x9b8, PIN_INPUT | MUX_MODE7)	/* cam0_field.gpio4_2 */
+			AM4372_IOPAD(0x9b8, PIN_INPUT | MUX_MODE7)			/* cam0_field.gpio4_2 */
 		>;
 	};
 
 	i2c0_pins_default: i2c0_pins_default {
 		pinctrl-single,pins = <
-			AM4372_IOPAD(0x988, PIN_INPUT | SLEWCTRL_FAST | MUX_MODE0) /* i2c0_sda.i2c0_sda */
-			AM4372_IOPAD(0x98c, PIN_INPUT | SLEWCTRL_FAST | MUX_MODE0) /* i2c0_scl.i2c0_scl */
+			AM4372_IOPAD(0x988, PIN_INPUT | SLEWCTRL_FAST | MUX_MODE0)	/* i2c0_sda.i2c0_sda */
+			AM4372_IOPAD(0x98c, PIN_INPUT | SLEWCTRL_FAST | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
 		>;
 	};
 
@@ -198,8 +198,8 @@
 
 	i2c2_pins_default: i2c2_pins_default {
 		pinctrl-single,pins = <
-			AM4372_IOPAD(0x9e8, PIN_INPUT | SLEWCTRL_FAST | MUX_MODE3) /* cam1_data1.i2c2_scl */
-			AM4372_IOPAD(0x9ec, PIN_INPUT | SLEWCTRL_FAST | MUX_MODE3) /* cam1_data0.i2c2_sda */
+			AM4372_IOPAD(0x9e8, PIN_INPUT | SLEWCTRL_FAST | MUX_MODE3)	/* cam1_data1.i2c2_scl */
+			AM4372_IOPAD(0x9ec, PIN_INPUT | SLEWCTRL_FAST | MUX_MODE3)	/* cam1_data0.i2c2_sda */
 		>;
 	};
 
@@ -212,13 +212,13 @@
 
 	mmc1_pins_default: pinmux_mmc1_pins_default {
 		pinctrl-single,pins = <
-			AM4372_IOPAD(0x900, PIN_INPUT | MUX_MODE0) /* mmc0_clk.mmc0_clk */
-			AM4372_IOPAD(0x904, PIN_INPUT | MUX_MODE0) /* mmc0_cmd.mmc0_cmd */
-			AM4372_IOPAD(0x9f0, PIN_INPUT | MUX_MODE0) /* mmc0_dat3.mmc0_dat3 */
-			AM4372_IOPAD(0x9f4, PIN_INPUT | MUX_MODE0) /* mmc0_dat2.mmc0_dat2 */
-			AM4372_IOPAD(0x9f8, PIN_INPUT | MUX_MODE0) /* mmc0_dat1.mmc0_dat1 */
-			AM4372_IOPAD(0x9fc, PIN_INPUT | MUX_MODE0) /* mmc0_dat0.mmc0_dat0 */
-			AM4372_IOPAD(0x960, PIN_INPUT | MUX_MODE7) /* spi0_cs1.gpio0_6 */
+			AM4372_IOPAD(0x900, PIN_INPUT | MUX_MODE0)	/* mmc0_clk.mmc0_clk */
+			AM4372_IOPAD(0x904, PIN_INPUT | MUX_MODE0)	/* mmc0_cmd.mmc0_cmd */
+			AM4372_IOPAD(0x9f0, PIN_INPUT | MUX_MODE0)	/* mmc0_dat3.mmc0_dat3 */
+			AM4372_IOPAD(0x9f4, PIN_INPUT | MUX_MODE0)	/* mmc0_dat2.mmc0_dat2 */
+			AM4372_IOPAD(0x9f8, PIN_INPUT | MUX_MODE0)	/* mmc0_dat1.mmc0_dat1 */
+			AM4372_IOPAD(0x9fc, PIN_INPUT | MUX_MODE0)	/* mmc0_dat0.mmc0_dat0 */
+			AM4372_IOPAD(0x960, PIN_INPUT | MUX_MODE7)	/* spi0_cs1.gpio0_6 */
 		>;
 	};
 
diff --git a/arch/arm/boot/dts/am437x-l4.dtsi b/arch/arm/boot/dts/am437x-l4.dtsi
index 85c6f4f..3391218 100644
--- a/arch/arm/boot/dts/am437x-l4.dtsi
+++ b/arch/arm/boot/dts/am437x-l4.dtsi
@@ -2503,4 +2503,3 @@
 		};
 	};
 };
-
diff --git a/arch/arm/boot/dts/am43xx-clocks.dtsi b/arch/arm/boot/dts/am43xx-clocks.dtsi
index e3f4207..edc46cce 100644
--- a/arch/arm/boot/dts/am43xx-clocks.dtsi
+++ b/arch/arm/boot/dts/am43xx-clocks.dtsi
@@ -827,6 +827,5 @@
 			reg = <0xb20 0x4>;
 			#clock-cells = <2>;
 		};
-
 	};
 };
diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
index 1e6620f..b6a6daf 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
@@ -333,7 +333,6 @@
 			ti,enable-vbus-detection;
 			vbus-gpio = <&gpio4 21 GPIO_ACTIVE_HIGH>;
 		};
-
 	};
 
 	tmp102: tmp102@48 {
diff --git a/arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts b/arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts
index 3cf70c7..539f9b6 100644
--- a/arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts
+++ b/arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts
@@ -128,4 +128,3 @@
 		reg = <1>;
 	};
 };
-
diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index c15f5e9..4344eb8 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -312,4 +312,4 @@
 			clock-frequency = <2000000000>;
 		};
 	};
- };
+};
diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
index 2932a29..9532ca9 100644
--- a/arch/arm/boot/dts/armada-375.dtsi
+++ b/arch/arm/boot/dts/armada-375.dtsi
@@ -599,7 +599,6 @@
 				clocks = <&gateclk 6>;
 				status = "disabled";
 			};
-
 		};
 
 		crypto_sram0: sa-sram0 {
diff --git a/arch/arm/boot/dts/armada-388-rd.dts b/arch/arm/boot/dts/armada-388-rd.dts
index 328a4d6..82951c7 100644
--- a/arch/arm/boot/dts/armada-388-rd.dts
+++ b/arch/arm/boot/dts/armada-388-rd.dts
@@ -105,4 +105,3 @@
 		spi-max-frequency = <108000000>;
 	};
 };
-
diff --git a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi b/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
index 5975347..ccc61e2 100644
--- a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
+++ b/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
@@ -335,4 +335,3 @@
 &sdio {
 	status = "disabled";
 };
-
diff --git a/arch/arm/boot/dts/armada-xp-db-dxbc2.dts b/arch/arm/boot/dts/armada-xp-db-dxbc2.dts
index 8a3aa61..d18855b 100644
--- a/arch/arm/boot/dts/armada-xp-db-dxbc2.dts
+++ b/arch/arm/boot/dts/armada-xp-db-dxbc2.dts
@@ -113,6 +113,5 @@
 			reg = <0x00140000 0x00ec0000>;
 			label = "unused";
 		};
-
 	};
 };
diff --git a/arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts b/arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts
index df04805..0e0de21 100644
--- a/arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts
+++ b/arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts
@@ -104,6 +104,5 @@
 			reg = <0x00140000 0x00ec0000>;
 			label = "unused";
 		};
-
 	};
 };
diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
index b4cca50..6f8f88f 100644
--- a/arch/arm/boot/dts/armada-xp-gp.dts
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -34,13 +34,13 @@
 	memory@0 {
 		device_type = "memory";
 		/*
-                 * 8 GB of plug-in RAM modules by default.The amount
-                 * of memory available can be changed by the
-                 * bootloader according the size of the module
-                 * actually plugged. However, memory between
-                 * 0xF0000000 to 0xFFFFFFFF cannot be used, as it is
-                 * the address range used for I/O (internal registers,
-                 * MBus windows).
+		 * 8 GB of plug-in RAM modules by default.The amount
+		 * of memory available can be changed by the
+		 * bootloader according the size of the module
+		 * actually plugged. However, memory between
+		 * 0xF0000000 to 0xFFFFFFFF cannot be used, as it is
+		 * the address range used for I/O (internal registers,
+		 * MBus windows).
 		 */
 		reg = <0x00000000 0x00000000 0x00000000 0xf0000000>,
 		      <0x00000001 0x00000000 0x00000001 0x00000000>;
diff --git a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
index 87dcb50..7499402 100644
--- a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
+++ b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
@@ -27,9 +27,9 @@
 
 	soc {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xd0000000 0x100000
-			MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
-			MBUS_ID(0x09, 0x09) 0 0 0xf1100000 0x10000
-			MBUS_ID(0x09, 0x05) 0 0 0xf1110000 0x10000>;
+			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
+			  MBUS_ID(0x09, 0x09) 0 0 0xf1100000 0x10000
+			  MBUS_ID(0x09, 0x05) 0 0 0xf1110000 0x10000>;
 
 		internal-regs {
 			serial@12000 {
@@ -78,7 +78,6 @@
 					compatible = "nxp,pcf8563";
 					reg = <0x51>;
 				};
-
 			};
 
 			nand-controller@d0000 {
@@ -220,7 +219,6 @@
 			gpios = <&gpio_spi 4 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
-
 	};
 
 	/*
diff --git a/arch/arm/boot/dts/armada-xp-mv78230.dtsi b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
index 8558bf6..04f526c 100644
--- a/arch/arm/boot/dts/armada-xp-mv78230.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
@@ -61,21 +61,21 @@
 			bus-range = <0x00 0xff>;
 
 			ranges =
-			       <0x82000000 0 0x40000 MBUS_ID(0xf0, 0x01) 0x40000 0 0x00002000   /* Port 0.0 registers */
-				0x82000000 0 0x44000 MBUS_ID(0xf0, 0x01) 0x44000 0 0x00002000   /* Port 0.1 registers */
-				0x82000000 0 0x48000 MBUS_ID(0xf0, 0x01) 0x48000 0 0x00002000   /* Port 0.2 registers */
-				0x82000000 0 0x4c000 MBUS_ID(0xf0, 0x01) 0x4c000 0 0x00002000   /* Port 0.3 registers */
-				0x82000000 0 0x80000 MBUS_ID(0xf0, 0x01) 0x80000 0 0x00002000   /* Port 1.0 registers */
-				0x82000000 0x1 0       MBUS_ID(0x04, 0xe8) 0 1 0 /* Port 0.0 MEM */
-				0x81000000 0x1 0       MBUS_ID(0x04, 0xe0) 0 1 0 /* Port 0.0 IO  */
-				0x82000000 0x2 0       MBUS_ID(0x04, 0xd8) 0 1 0 /* Port 0.1 MEM */
-				0x81000000 0x2 0       MBUS_ID(0x04, 0xd0) 0 1 0 /* Port 0.1 IO  */
-				0x82000000 0x3 0       MBUS_ID(0x04, 0xb8) 0 1 0 /* Port 0.2 MEM */
-				0x81000000 0x3 0       MBUS_ID(0x04, 0xb0) 0 1 0 /* Port 0.2 IO  */
-				0x82000000 0x4 0       MBUS_ID(0x04, 0x78) 0 1 0 /* Port 0.3 MEM */
-				0x81000000 0x4 0       MBUS_ID(0x04, 0x70) 0 1 0 /* Port 0.3 IO  */
-				0x82000000 0x5 0       MBUS_ID(0x08, 0xe8) 0 1 0 /* Port 1.0 MEM */
-				0x81000000 0x5 0       MBUS_ID(0x08, 0xe0) 0 1 0 /* Port 1.0 IO  */>;
+			       <0x82000000   0 0x40000 MBUS_ID(0xf0, 0x01) 0x40000 0 0x00002000 /* Port 0.0 registers */
+				0x82000000   0 0x44000 MBUS_ID(0xf0, 0x01) 0x44000 0 0x00002000 /* Port 0.1 registers */
+				0x82000000   0 0x48000 MBUS_ID(0xf0, 0x01) 0x48000 0 0x00002000 /* Port 0.2 registers */
+				0x82000000   0 0x4c000 MBUS_ID(0xf0, 0x01) 0x4c000 0 0x00002000 /* Port 0.3 registers */
+				0x82000000   0 0x80000 MBUS_ID(0xf0, 0x01) 0x80000 0 0x00002000 /* Port 1.0 registers */
+				0x82000000 0x1       0 MBUS_ID(0x04, 0xe8)       0 1          0 /* Port 0.0 MEM */
+				0x81000000 0x1       0 MBUS_ID(0x04, 0xe0)       0 1          0 /* Port 0.0 IO  */
+				0x82000000 0x2       0 MBUS_ID(0x04, 0xd8)       0 1          0 /* Port 0.1 MEM */
+				0x81000000 0x2       0 MBUS_ID(0x04, 0xd0)       0 1          0 /* Port 0.1 IO  */
+				0x82000000 0x3       0 MBUS_ID(0x04, 0xb8)       0 1          0 /* Port 0.2 MEM */
+				0x81000000 0x3       0 MBUS_ID(0x04, 0xb0)       0 1          0 /* Port 0.2 IO  */
+				0x82000000 0x4       0 MBUS_ID(0x04, 0x78)       0 1          0 /* Port 0.3 MEM */
+				0x81000000 0x4       0 MBUS_ID(0x04, 0x70)       0 1          0 /* Port 0.3 IO  */
+				0x82000000 0x5       0 MBUS_ID(0x08, 0xe8)       0 1          0 /* Port 1.0 MEM */
+				0x81000000 0x5       0 MBUS_ID(0x08, 0xe0)       0 1          0 /* Port 1.0 IO  */>;
 
 			pcie1: pcie@1,0 {
 				device_type = "pci";
diff --git a/arch/arm/boot/dts/armada-xp-mv78260.dtsi b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
index 2d85fe8..e43f705 100644
--- a/arch/arm/boot/dts/armada-xp-mv78260.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
@@ -62,35 +62,35 @@
 			bus-range = <0x00 0xff>;
 
 			ranges =
-			       <0x82000000 0 0x40000 MBUS_ID(0xf0, 0x01) 0x40000 0 0x00002000   /* Port 0.0 registers */
-				0x82000000 0 0x42000 MBUS_ID(0xf0, 0x01) 0x42000 0 0x00002000   /* Port 2.0 registers */
-				0x82000000 0 0x44000 MBUS_ID(0xf0, 0x01) 0x44000 0 0x00002000   /* Port 0.1 registers */
-				0x82000000 0 0x48000 MBUS_ID(0xf0, 0x01) 0x48000 0 0x00002000   /* Port 0.2 registers */
-				0x82000000 0 0x4c000 MBUS_ID(0xf0, 0x01) 0x4c000 0 0x00002000   /* Port 0.3 registers */
-				0x82000000 0 0x80000 MBUS_ID(0xf0, 0x01) 0x80000 0 0x00002000   /* Port 1.0 registers */
-				0x82000000 0 0x84000 MBUS_ID(0xf0, 0x01) 0x84000 0 0x00002000   /* Port 1.1 registers */
-				0x82000000 0 0x88000 MBUS_ID(0xf0, 0x01) 0x88000 0 0x00002000   /* Port 1.2 registers */
-				0x82000000 0 0x8c000 MBUS_ID(0xf0, 0x01) 0x8c000 0 0x00002000   /* Port 1.3 registers */
-				0x82000000 0x1 0     MBUS_ID(0x04, 0xe8) 0 1 0 /* Port 0.0 MEM */
-				0x81000000 0x1 0     MBUS_ID(0x04, 0xe0) 0 1 0 /* Port 0.0 IO  */
-				0x82000000 0x2 0     MBUS_ID(0x04, 0xd8) 0 1 0 /* Port 0.1 MEM */
-				0x81000000 0x2 0     MBUS_ID(0x04, 0xd0) 0 1 0 /* Port 0.1 IO  */
-				0x82000000 0x3 0     MBUS_ID(0x04, 0xb8) 0 1 0 /* Port 0.2 MEM */
-				0x81000000 0x3 0     MBUS_ID(0x04, 0xb0) 0 1 0 /* Port 0.2 IO  */
-				0x82000000 0x4 0     MBUS_ID(0x04, 0x78) 0 1 0 /* Port 0.3 MEM */
-				0x81000000 0x4 0     MBUS_ID(0x04, 0x70) 0 1 0 /* Port 0.3 IO  */
+			       <0x82000000 0 0x40000 MBUS_ID(0xf0, 0x01) 0x40000 0 0x00002000 /* Port 0.0 registers */
+				0x82000000 0 0x42000 MBUS_ID(0xf0, 0x01) 0x42000 0 0x00002000 /* Port 2.0 registers */
+				0x82000000 0 0x44000 MBUS_ID(0xf0, 0x01) 0x44000 0 0x00002000 /* Port 0.1 registers */
+				0x82000000 0 0x48000 MBUS_ID(0xf0, 0x01) 0x48000 0 0x00002000 /* Port 0.2 registers */
+				0x82000000 0 0x4c000 MBUS_ID(0xf0, 0x01) 0x4c000 0 0x00002000 /* Port 0.3 registers */
+				0x82000000 0 0x80000 MBUS_ID(0xf0, 0x01) 0x80000 0 0x00002000 /* Port 1.0 registers */
+				0x82000000 0 0x84000 MBUS_ID(0xf0, 0x01) 0x84000 0 0x00002000 /* Port 1.1 registers */
+				0x82000000 0 0x88000 MBUS_ID(0xf0, 0x01) 0x88000 0 0x00002000 /* Port 1.2 registers */
+				0x82000000 0 0x8c000 MBUS_ID(0xf0, 0x01) 0x8c000 0 0x00002000 /* Port 1.3 registers */
+				0x82000000 0x1 0     MBUS_ID(0x04, 0xe8)       0 1          0 /* Port 0.0 MEM */
+				0x81000000 0x1 0     MBUS_ID(0x04, 0xe0)       0 1          0 /* Port 0.0 IO  */
+				0x82000000 0x2 0     MBUS_ID(0x04, 0xd8)       0 1          0 /* Port 0.1 MEM */
+				0x81000000 0x2 0     MBUS_ID(0x04, 0xd0)       0 1          0 /* Port 0.1 IO  */
+				0x82000000 0x3 0     MBUS_ID(0x04, 0xb8)       0 1          0 /* Port 0.2 MEM */
+				0x81000000 0x3 0     MBUS_ID(0x04, 0xb0)       0 1          0 /* Port 0.2 IO  */
+				0x82000000 0x4 0     MBUS_ID(0x04, 0x78)       0 1          0 /* Port 0.3 MEM */
+				0x81000000 0x4 0     MBUS_ID(0x04, 0x70)       0 1          0 /* Port 0.3 IO  */
 
-				0x82000000 0x5 0     MBUS_ID(0x08, 0xe8) 0 1 0 /* Port 1.0 MEM */
-				0x81000000 0x5 0     MBUS_ID(0x08, 0xe0) 0 1 0 /* Port 1.0 IO  */
-				0x82000000 0x6 0     MBUS_ID(0x08, 0xd8) 0 1 0 /* Port 1.1 MEM */
-				0x81000000 0x6 0     MBUS_ID(0x08, 0xd0) 0 1 0 /* Port 1.1 IO  */
-				0x82000000 0x7 0     MBUS_ID(0x08, 0xb8) 0 1 0 /* Port 1.2 MEM */
-				0x81000000 0x7 0     MBUS_ID(0x08, 0xb0) 0 1 0 /* Port 1.2 IO  */
-				0x82000000 0x8 0     MBUS_ID(0x08, 0x78) 0 1 0 /* Port 1.3 MEM */
-				0x81000000 0x8 0     MBUS_ID(0x08, 0x70) 0 1 0 /* Port 1.3 IO  */
+				0x82000000 0x5 0     MBUS_ID(0x08, 0xe8)       0 1          0 /* Port 1.0 MEM */
+				0x81000000 0x5 0     MBUS_ID(0x08, 0xe0)       0 1          0 /* Port 1.0 IO  */
+				0x82000000 0x6 0     MBUS_ID(0x08, 0xd8)       0 1          0 /* Port 1.1 MEM */
+				0x81000000 0x6 0     MBUS_ID(0x08, 0xd0)       0 1          0 /* Port 1.1 IO  */
+				0x82000000 0x7 0     MBUS_ID(0x08, 0xb8)       0 1          0 /* Port 1.2 MEM */
+				0x81000000 0x7 0     MBUS_ID(0x08, 0xb0)       0 1          0 /* Port 1.2 IO  */
+				0x82000000 0x8 0     MBUS_ID(0x08, 0x78)       0 1          0 /* Port 1.3 MEM */
+				0x81000000 0x8 0     MBUS_ID(0x08, 0x70)       0 1          0 /* Port 1.3 IO  */
 
-				0x82000000 0x9 0     MBUS_ID(0x04, 0xf8) 0 1 0 /* Port 2.0 MEM */
-				0x81000000 0x9 0     MBUS_ID(0x04, 0xf0) 0 1 0 /* Port 2.0 IO  */>;
+				0x82000000 0x9 0     MBUS_ID(0x04, 0xf8)       0 1          0 /* Port 2.0 MEM */
+				0x81000000 0x9 0     MBUS_ID(0x04, 0xf0)       0 1          0 /* Port 2.0 IO  */>;
 
 			pcie1: pcie@1,0 {
 				device_type = "pci";
diff --git a/arch/arm/boot/dts/armada-xp-mv78460.dtsi b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
index 230a3fd..4d07867 100644
--- a/arch/arm/boot/dts/armada-xp-mv78460.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
@@ -79,39 +79,39 @@
 			bus-range = <0x00 0xff>;
 
 			ranges =
-			       <0x82000000 0 0x40000 MBUS_ID(0xf0, 0x01) 0x40000 0 0x00002000   /* Port 0.0 registers */
-				0x82000000 0 0x42000 MBUS_ID(0xf0, 0x01) 0x42000 0 0x00002000   /* Port 2.0 registers */
-				0x82000000 0 0x44000 MBUS_ID(0xf0, 0x01) 0x44000 0 0x00002000   /* Port 0.1 registers */
-				0x82000000 0 0x48000 MBUS_ID(0xf0, 0x01) 0x48000 0 0x00002000   /* Port 0.2 registers */
-				0x82000000 0 0x4c000 MBUS_ID(0xf0, 0x01) 0x4c000 0 0x00002000   /* Port 0.3 registers */
-				0x82000000 0 0x80000 MBUS_ID(0xf0, 0x01) 0x80000 0 0x00002000   /* Port 1.0 registers */
-				0x82000000 0 0x82000 MBUS_ID(0xf0, 0x01) 0x82000 0 0x00002000   /* Port 3.0 registers */
-				0x82000000 0 0x84000 MBUS_ID(0xf0, 0x01) 0x84000 0 0x00002000   /* Port 1.1 registers */
-				0x82000000 0 0x88000 MBUS_ID(0xf0, 0x01) 0x88000 0 0x00002000   /* Port 1.2 registers */
-				0x82000000 0 0x8c000 MBUS_ID(0xf0, 0x01) 0x8c000 0 0x00002000   /* Port 1.3 registers */
-				0x82000000 0x1 0     MBUS_ID(0x04, 0xe8) 0 1 0 /* Port 0.0 MEM */
-				0x81000000 0x1 0     MBUS_ID(0x04, 0xe0) 0 1 0 /* Port 0.0 IO  */
-				0x82000000 0x2 0     MBUS_ID(0x04, 0xd8) 0 1 0 /* Port 0.1 MEM */
-				0x81000000 0x2 0     MBUS_ID(0x04, 0xd0) 0 1 0 /* Port 0.1 IO  */
-				0x82000000 0x3 0     MBUS_ID(0x04, 0xb8) 0 1 0 /* Port 0.2 MEM */
-				0x81000000 0x3 0     MBUS_ID(0x04, 0xb0) 0 1 0 /* Port 0.2 IO  */
-				0x82000000 0x4 0     MBUS_ID(0x04, 0x78) 0 1 0 /* Port 0.3 MEM */
-				0x81000000 0x4 0     MBUS_ID(0x04, 0x70) 0 1 0 /* Port 0.3 IO  */
+			       <0x82000000   0 0x40000 MBUS_ID(0xf0, 0x01) 0x40000 0 0x00002000 /* Port 0.0 registers */
+				0x82000000   0 0x42000 MBUS_ID(0xf0, 0x01) 0x42000 0 0x00002000 /* Port 2.0 registers */
+				0x82000000   0 0x44000 MBUS_ID(0xf0, 0x01) 0x44000 0 0x00002000 /* Port 0.1 registers */
+				0x82000000   0 0x48000 MBUS_ID(0xf0, 0x01) 0x48000 0 0x00002000 /* Port 0.2 registers */
+				0x82000000   0 0x4c000 MBUS_ID(0xf0, 0x01) 0x4c000 0 0x00002000 /* Port 0.3 registers */
+				0x82000000   0 0x80000 MBUS_ID(0xf0, 0x01) 0x80000 0 0x00002000 /* Port 1.0 registers */
+				0x82000000   0 0x82000 MBUS_ID(0xf0, 0x01) 0x82000 0 0x00002000 /* Port 3.0 registers */
+				0x82000000   0 0x84000 MBUS_ID(0xf0, 0x01) 0x84000 0 0x00002000 /* Port 1.1 registers */
+				0x82000000   0 0x88000 MBUS_ID(0xf0, 0x01) 0x88000 0 0x00002000 /* Port 1.2 registers */
+				0x82000000   0 0x8c000 MBUS_ID(0xf0, 0x01) 0x8c000 0 0x00002000 /* Port 1.3 registers */
+				0x82000000 0x1       0 MBUS_ID(0x04, 0xe8)       0 1          0 /* Port 0.0 MEM */
+				0x81000000 0x1       0 MBUS_ID(0x04, 0xe0)       0 1          0 /* Port 0.0 IO  */
+				0x82000000 0x2       0 MBUS_ID(0x04, 0xd8)       0 1          0 /* Port 0.1 MEM */
+				0x81000000 0x2       0 MBUS_ID(0x04, 0xd0)       0 1          0 /* Port 0.1 IO  */
+				0x82000000 0x3       0 MBUS_ID(0x04, 0xb8)       0 1          0 /* Port 0.2 MEM */
+				0x81000000 0x3       0 MBUS_ID(0x04, 0xb0)       0 1          0 /* Port 0.2 IO  */
+				0x82000000 0x4       0 MBUS_ID(0x04, 0x78)       0 1          0 /* Port 0.3 MEM */
+				0x81000000 0x4       0 MBUS_ID(0x04, 0x70)       0 1          0 /* Port 0.3 IO  */
 
-				0x82000000 0x5 0     MBUS_ID(0x08, 0xe8) 0 1 0 /* Port 1.0 MEM */
-				0x81000000 0x5 0     MBUS_ID(0x08, 0xe0) 0 1 0 /* Port 1.0 IO  */
-				0x82000000 0x6 0     MBUS_ID(0x08, 0xd8) 0 1 0 /* Port 1.1 MEM */
-				0x81000000 0x6 0     MBUS_ID(0x08, 0xd0) 0 1 0 /* Port 1.1 IO  */
-				0x82000000 0x7 0     MBUS_ID(0x08, 0xb8) 0 1 0 /* Port 1.2 MEM */
-				0x81000000 0x7 0     MBUS_ID(0x08, 0xb0) 0 1 0 /* Port 1.2 IO  */
-				0x82000000 0x8 0     MBUS_ID(0x08, 0x78) 0 1 0 /* Port 1.3 MEM */
-				0x81000000 0x8 0     MBUS_ID(0x08, 0x70) 0 1 0 /* Port 1.3 IO  */
+				0x82000000 0x5       0 MBUS_ID(0x08, 0xe8)       0 1          0 /* Port 1.0 MEM */
+				0x81000000 0x5       0 MBUS_ID(0x08, 0xe0)       0 1          0 /* Port 1.0 IO  */
+				0x82000000 0x6       0 MBUS_ID(0x08, 0xd8)       0 1          0 /* Port 1.1 MEM */
+				0x81000000 0x6       0 MBUS_ID(0x08, 0xd0)       0 1          0 /* Port 1.1 IO  */
+				0x82000000 0x7       0 MBUS_ID(0x08, 0xb8)       0 1          0 /* Port 1.2 MEM */
+				0x81000000 0x7       0 MBUS_ID(0x08, 0xb0)       0 1          0 /* Port 1.2 IO  */
+				0x82000000 0x8       0 MBUS_ID(0x08, 0x78)       0 1          0 /* Port 1.3 MEM */
+				0x81000000 0x8       0 MBUS_ID(0x08, 0x70)       0 1          0 /* Port 1.3 IO  */
 
-				0x82000000 0x9 0     MBUS_ID(0x04, 0xf8) 0 1 0 /* Port 2.0 MEM */
-				0x81000000 0x9 0     MBUS_ID(0x04, 0xf0) 0 1 0 /* Port 2.0 IO  */
+				0x82000000 0x9       0 MBUS_ID(0x04, 0xf8)       0 1          0 /* Port 2.0 MEM */
+				0x81000000 0x9       0 MBUS_ID(0x04, 0xf0)       0 1          0 /* Port 2.0 IO  */
 
-				0x82000000 0xa 0     MBUS_ID(0x08, 0xf8) 0 1 0 /* Port 3.0 MEM */
-				0x81000000 0xa 0     MBUS_ID(0x08, 0xf0) 0 1 0 /* Port 3.0 IO  */>;
+				0x82000000 0xa       0 MBUS_ID(0x08, 0xf8)       0 1          0 /* Port 3.0 MEM */
+				0x81000000 0xa       0 MBUS_ID(0x08, 0xf0)       0 1          0 /* Port 3.0 IO  */>;
 
 			pcie1: pcie@1,0 {
 				device_type = "pci";
diff --git a/arch/arm/boot/dts/at91-ariag25.dts b/arch/arm/boot/dts/at91-ariag25.dts
index e3e14b7..4c812af 100644
--- a/arch/arm/boot/dts/at91-ariag25.dts
+++ b/arch/arm/boot/dts/at91-ariag25.dts
@@ -178,7 +178,6 @@
 			gpios = <&pioB 8 GPIO_ACTIVE_HIGH>; /* PB8 */
 			linux,default-trigger = "heartbeat";
 		};
-
 	};
 
 	onewire {
diff --git a/arch/arm/boot/dts/at91-dvk_som60.dts b/arch/arm/boot/dts/at91-dvk_som60.dts
index ededd5b..772ca23 100644
--- a/arch/arm/boot/dts/at91-dvk_som60.dts
+++ b/arch/arm/boot/dts/at91-dvk_som60.dts
@@ -92,4 +92,3 @@
 &usb2 {
 	status = "okay";
 };
-
diff --git a/arch/arm/boot/dts/at91-dvk_su60_somc.dtsi b/arch/arm/boot/dts/at91-dvk_su60_somc.dtsi
index 21876da..7cc496c 100644
--- a/arch/arm/boot/dts/at91-dvk_su60_somc.dtsi
+++ b/arch/arm/boot/dts/at91-dvk_su60_somc.dtsi
@@ -156,4 +156,3 @@
 &usb2 {
 	status = "okay";
 };
-
diff --git a/arch/arm/boot/dts/at91-linea.dtsi b/arch/arm/boot/dts/at91-linea.dtsi
index c7b964e..8597261 100644
--- a/arch/arm/boot/dts/at91-linea.dtsi
+++ b/arch/arm/boot/dts/at91-linea.dtsi
@@ -55,7 +55,6 @@
 	status = "okay";
 };
 
-
 &nand_controller {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index fa54e88..9fe12f6 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -609,7 +609,6 @@
 			gpios = <&pioA PIN_PB6 GPIO_ACTIVE_LOW>;
 		};
 
-
 		green {
 			label = "green";
 			gpios = <&pioA PIN_PB5 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dts b/arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dts
index fe05aaa..07294c7 100644
--- a/arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dts
+++ b/arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dts
@@ -56,7 +56,6 @@
 						};
 					};
 				};
-
 			};
 
 			macb0: ethernet@f8020000 {
@@ -94,7 +93,6 @@
 				atmel,adc-ts-pressure-threshold = <10000>;
 			};
 
-
 			pinctrl@fc06a000 {
 				board {
 					pinctrl_mmc1_cd: mmc1_cd {
diff --git a/arch/arm/boot/dts/at91-vinco.dts b/arch/arm/boot/dts/at91-vinco.dts
index 4302772..0d0d9eb 100644
--- a/arch/arm/boot/dts/at91-vinco.dts
+++ b/arch/arm/boot/dts/at91-vinco.dts
@@ -212,7 +212,6 @@
 			/* 4G Modem */
 			status = "okay";
 		};
-
 	};
 
 	leds {
@@ -254,7 +253,6 @@
 			gpios = <&pioA 26 GPIO_ACTIVE_LOW>;
 			default-state = "on";
 		};
-
 	};
 
 	vcc_3v3_reg: fixedregulator_3v3 {
diff --git a/arch/arm/boot/dts/at91-wb45n.dtsi b/arch/arm/boot/dts/at91-wb45n.dtsi
index ebe61a2..3b5adb8 100644
--- a/arch/arm/boot/dts/at91-wb45n.dtsi
+++ b/arch/arm/boot/dts/at91-wb45n.dtsi
@@ -115,7 +115,6 @@
 					label = "logs";
 					reg = <0x7fa0000 0x60000>;
 				};
-
 			};
 		};
 	};
@@ -162,4 +161,3 @@
 		};
 	};
 };
-
diff --git a/arch/arm/boot/dts/at91-wb50n.dts b/arch/arm/boot/dts/at91-wb50n.dts
index a5e45bb..ab92e40 100644
--- a/arch/arm/boot/dts/at91-wb50n.dts
+++ b/arch/arm/boot/dts/at91-wb50n.dts
@@ -109,4 +109,3 @@
 &usb2 {
 	status = "okay";
 };
-
diff --git a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
index ec1f17a..4a69341 100644
--- a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
@@ -8,7 +8,6 @@
 #include "at91sam9g20.dtsi"
 
 / {
-
 	chosen {
 		bootargs = "mem=64M root=/dev/mtdblock5 rw rootfstype=ubifs";
 		stdout-path = "serial0:115200n8";
@@ -36,7 +35,6 @@
 						atmel,pins =
 							<AT91_PIOC 1 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* PC1 periph B */
 					};
-
 				};
 
 				mmc0_slot1 {
diff --git a/arch/arm/boot/dts/at91sam9x5cm.dtsi b/arch/arm/boot/dts/at91sam9x5cm.dtsi
index c4cc9cc..a836dcc 100644
--- a/arch/arm/boot/dts/at91sam9x5cm.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5cm.dtsi
@@ -141,5 +141,4 @@
 		pinctrl-0 = <&pinctrl_1wire_cm>;
 		status = "okay";
 	};
-
 };
diff --git a/arch/arm/boot/dts/atlas6-evb.dts b/arch/arm/boot/dts/atlas6-evb.dts
index 4088241..5b9ebfa 100644
--- a/arch/arm/boot/dts/atlas6-evb.dts
+++ b/arch/arm/boot/dts/atlas6-evb.dts
@@ -48,7 +48,6 @@
 					reg = <0x40>;
 				};
 			};
-
 		};
 		disp-iobg {
 			lcd@90010000 {
@@ -58,22 +57,23 @@
 			};
 		};
 	};
+
 	display: display@0 {
-	    panels {
-		panel0: panel@0 {
-			panel-name = "Innolux TFT";
-			hactive = <800>;
-			vactive = <480>;
-			left_margin = <20>;
-			right_margin = <234>;
-			upper_margin = <3>;
-			lower_margin = <41>;
-			hsync_len = <3>;
-			vsync_len = <2>;
-			pixclock = <33264000>;
-			sync = <3>;
-			timing = <0x88>;
+		panels {
+			panel0: panel@0 {
+				panel-name = "Innolux TFT";
+				hactive = <800>;
+				vactive = <480>;
+				left_margin = <20>;
+				right_margin = <234>;
+				upper_margin = <3>;
+				lower_margin = <41>;
+				hsync_len = <3>;
+				vsync_len = <2>;
+				pixclock = <33264000>;
+				sync = <3>;
+				timing = <0x88>;
 			};
-	    };
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/atlas6.dtsi b/arch/arm/boot/dts/atlas6.dtsi
index 5587b98..90f1e18 100644
--- a/arch/arm/boot/dts/atlas6.dtsi
+++ b/arch/arm/boot/dts/atlas6.dtsi
@@ -446,138 +446,138 @@
 						sirf,function = "i2c1";
 					};
 				};
-                                pwm0_pins_a: pwm0@0 {
-                                        pwm {
-                                                sirf,pins = "pwm0grp";
-                                                sirf,function = "pwm0";
-                                        };
-                                };
-                                pwm1_pins_a: pwm1@0 {
-                                        pwm {
-                                                sirf,pins = "pwm1grp";
-                                                sirf,function = "pwm1";
-                                        };
-                                };
-                                pwm2_pins_a: pwm2@0 {
-                                        pwm {
-                                                sirf,pins = "pwm2grp";
-                                                sirf,function = "pwm2";
-                                        };
-                                };
-                                pwm3_pins_a: pwm3@0 {
-                                        pwm {
-                                                sirf,pins = "pwm3grp";
-                                                sirf,function = "pwm3";
-                                        };
-                                };
+				pwm0_pins_a: pwm0@0 {
+					pwm {
+						sirf,pins = "pwm0grp";
+						sirf,function = "pwm0";
+					};
+				};
+				pwm1_pins_a: pwm1@0 {
+					pwm {
+						sirf,pins = "pwm1grp";
+						sirf,function = "pwm1";
+					};
+				};
+				pwm2_pins_a: pwm2@0 {
+					pwm {
+						sirf,pins = "pwm2grp";
+						sirf,function = "pwm2";
+					};
+				};
+				pwm3_pins_a: pwm3@0 {
+					pwm {
+						sirf,pins = "pwm3grp";
+						sirf,function = "pwm3";
+					};
+				};
 				pwm4_pins_a: pwm4@0 {
-                                        pwm {
-                                                sirf,pins = "pwm4grp";
-                                                sirf,function = "pwm4";
-                                        };
-                                };
-                                gps_pins_a: gps@0 {
-                                        gps {
-                                                sirf,pins = "gpsgrp";
-                                                sirf,function = "gps";
-                                        };
-                                };
-                                vip_pins_a: vip@0 {
-                                        vip {
-                                                sirf,pins = "vipgrp";
-                                                sirf,function = "vip";
-                                        };
-                                };
-                                sdmmc0_pins_a: sdmmc0@0 {
-                                        sdmmc0 {
-                                                sirf,pins = "sdmmc0grp";
-                                                sirf,function = "sdmmc0";
-                                        };
-                                };
-                                sdmmc1_pins_a: sdmmc1@0 {
-                                        sdmmc1 {
-                                                sirf,pins = "sdmmc1grp";
-                                                sirf,function = "sdmmc1";
-                                        };
-                                };
-                                sdmmc2_pins_a: sdmmc2@0 {
-                                        sdmmc2 {
-                                                sirf,pins = "sdmmc2grp";
-                                                sirf,function = "sdmmc2";
-                                        };
-                                };
+					pwm {
+						sirf,pins = "pwm4grp";
+						sirf,function = "pwm4";
+					};
+				};
+				gps_pins_a: gps@0 {
+					gps {
+						sirf,pins = "gpsgrp";
+						sirf,function = "gps";
+					};
+				};
+				vip_pins_a: vip@0 {
+					vip {
+						sirf,pins = "vipgrp";
+						sirf,function = "vip";
+					};
+				};
+				sdmmc0_pins_a: sdmmc0@0 {
+					sdmmc0 {
+						sirf,pins = "sdmmc0grp";
+						sirf,function = "sdmmc0";
+					};
+				};
+				sdmmc1_pins_a: sdmmc1@0 {
+					sdmmc1 {
+						sirf,pins = "sdmmc1grp";
+						sirf,function = "sdmmc1";
+					};
+				};
+				sdmmc2_pins_a: sdmmc2@0 {
+					sdmmc2 {
+						sirf,pins = "sdmmc2grp";
+						sirf,function = "sdmmc2";
+					};
+				};
 				sdmmc2_nowp_pins_a: sdmmc2_nowp@0 {
-                                        sdmmc2_nowp {
-                                                sirf,pins = "sdmmc2_nowpgrp";
-                                                sirf,function = "sdmmc2_nowp";
-                                        };
-                                };
-                                sdmmc3_pins_a: sdmmc3@0 {
-                                        sdmmc3 {
-                                                sirf,pins = "sdmmc3grp";
-                                                sirf,function = "sdmmc3";
-                                        };
-                                };
-                                sdmmc5_pins_a: sdmmc5@0 {
-                                        sdmmc5 {
-                                                sirf,pins = "sdmmc5grp";
-                                                sirf,function = "sdmmc5";
-                                        };
-                                };
+					sdmmc2_nowp {
+						sirf,pins = "sdmmc2_nowpgrp";
+						sirf,function = "sdmmc2_nowp";
+					};
+				};
+				sdmmc3_pins_a: sdmmc3@0 {
+					sdmmc3 {
+						sirf,pins = "sdmmc3grp";
+						sirf,function = "sdmmc3";
+					};
+				};
+				sdmmc5_pins_a: sdmmc5@0 {
+					sdmmc5 {
+						sirf,pins = "sdmmc5grp";
+						sirf,function = "sdmmc5";
+					};
+				};
 				i2s_mclk_pins_a: i2s_mclk@0 {
-                                        i2s_mclk {
-                                                sirf,pins = "i2smclkgrp";
-                                                sirf,function = "i2s_mclk";
-                                        };
-                                };
+					i2s_mclk {
+						sirf,pins = "i2smclkgrp";
+						sirf,function = "i2s_mclk";
+					};
+				};
 				i2s_ext_clk_input_pins_a: i2s_ext_clk_input@0 {
-                                        i2s_ext_clk_input {
-                                                sirf,pins = "i2s_ext_clk_inputgrp";
-                                                sirf,function = "i2s_ext_clk_input";
-                                        };
-                                };
-                                i2s_pins_a: i2s@0 {
-                                        i2s {
-                                                sirf,pins = "i2sgrp";
-                                                sirf,function = "i2s";
-                                        };
-                                };
+					i2s_ext_clk_input {
+						sirf,pins = "i2s_ext_clk_inputgrp";
+						sirf,function = "i2s_ext_clk_input";
+					};
+				};
+				i2s_pins_a: i2s@0 {
+					i2s {
+						sirf,pins = "i2sgrp";
+						sirf,function = "i2s";
+					};
+				};
 				i2s_no_din_pins_a: i2s_no_din@0 {
-                                        i2s_no_din {
-                                                sirf,pins = "i2s_no_dingrp";
-                                                sirf,function = "i2s_no_din";
-                                        };
-                                };
+					i2s_no_din {
+						sirf,pins = "i2s_no_dingrp";
+						sirf,function = "i2s_no_din";
+					};
+				};
 				i2s_6chn_pins_a: i2s_6chn@0 {
-                                        i2s_6chn {
-                                                sirf,pins = "i2s_6chngrp";
-                                                sirf,function = "i2s_6chn";
-                                        };
-                                };
-                                ac97_pins_a: ac97@0 {
-                                        ac97 {
-                                                sirf,pins = "ac97grp";
-                                                sirf,function = "ac97";
-                                        };
-                                };
-                                nand_pins_a: nand@0 {
-                                        nand {
-                                                sirf,pins = "nandgrp";
-                                                sirf,function = "nand";
-                                        };
-                                };
-                                usp0_pins_a: usp0@0 {
-                                        usp0 {
-                                                sirf,pins = "usp0grp";
-                                                sirf,function = "usp0";
-                                        };
-                                };
+					i2s_6chn {
+						sirf,pins = "i2s_6chngrp";
+						sirf,function = "i2s_6chn";
+					};
+				};
+				ac97_pins_a: ac97@0 {
+					ac97 {
+						sirf,pins = "ac97grp";
+						sirf,function = "ac97";
+					};
+				};
+				nand_pins_a: nand@0 {
+					nand {
+						sirf,pins = "nandgrp";
+						sirf,function = "nand";
+					};
+				};
+				usp0_pins_a: usp0@0 {
+					usp0 {
+						sirf,pins = "usp0grp";
+						sirf,function = "usp0";
+					};
+				};
 				usp0_uart_nostreamctrl_pins_a: usp0@1 {
-                                        usp0 {
-                                                sirf,pins = "usp0_uart_nostreamctrl_grp";
-                                                sirf,function = "usp0_uart_nostreamctrl";
-                                        };
-                                };
+					usp0 {
+						sirf,pins = "usp0_uart_nostreamctrl_grp";
+						sirf,function = "usp0_uart_nostreamctrl";
+					};
+				};
 				usp0_only_utfs_pins_a: usp0@2 {
 					usp0 {
 						sirf,pins = "usp0_only_utfs_grp";
@@ -590,66 +590,66 @@
 						sirf,function = "usp0_only_urfs";
 					};
 				};
-                                usp1_pins_a: usp1@0 {
-                                        usp1 {
-                                                sirf,pins = "usp1grp";
-                                                sirf,function = "usp1";
-                                        };
-                                };
+				usp1_pins_a: usp1@0 {
+					usp1 {
+						sirf,pins = "usp1grp";
+						sirf,function = "usp1";
+					};
+				};
 				usp1_uart_nostreamctrl_pins_a: usp1@1 {
-                                        usp1 {
-                                                sirf,pins = "usp1_uart_nostreamctrl_grp";
-                                                sirf,function = "usp1_uart_nostreamctrl";
-                                        };
-                                };
-                                usb0_upli_drvbus_pins_a: usb0_upli_drvbus@0 {
-                                        usb0_upli_drvbus {
-                                                sirf,pins = "usb0_upli_drvbusgrp";
-                                                sirf,function = "usb0_upli_drvbus";
-                                        };
-                                };
-                                usb1_utmi_drvbus_pins_a: usb1_utmi_drvbus@0 {
-                                        usb1_utmi_drvbus {
-                                                sirf,pins = "usb1_utmi_drvbusgrp";
-                                                sirf,function = "usb1_utmi_drvbus";
-                                        };
-                                };
-                                usb1_dp_dn_pins_a: usb1_dp_dn@0 {
-                                        usb1_dp_dn {
-                                                sirf,pins = "usb1_dp_dngrp";
-                                                sirf,function = "usb1_dp_dn";
-                                        };
-                                };
-                                uart1_route_io_usb1_pins_a: uart1_route_io_usb1@0 {
-                                        uart1_route_io_usb1 {
-                                                sirf,pins = "uart1_route_io_usb1grp";
-                                                sirf,function = "uart1_route_io_usb1";
-                                        };
-                                };
-                                warm_rst_pins_a: warm_rst@0 {
-                                        warm_rst {
-                                                sirf,pins = "warm_rstgrp";
-                                                sirf,function = "warm_rst";
-                                        };
-                                };
-                                pulse_count_pins_a: pulse_count@0 {
-                                        pulse_count {
-                                                sirf,pins = "pulse_countgrp";
-                                                sirf,function = "pulse_count";
-                                        };
-                                };
-                                cko0_pins_a: cko0@0 {
-                                        cko0 {
-                                                sirf,pins = "cko0grp";
-                                                sirf,function = "cko0";
-                                        };
-                                };
-                                cko1_pins_a: cko1@0 {
-                                        cko1 {
-                                                sirf,pins = "cko1grp";
-                                                sirf,function = "cko1";
-                                        };
-                                };
+					usp1 {
+						sirf,pins = "usp1_uart_nostreamctrl_grp";
+						sirf,function = "usp1_uart_nostreamctrl";
+					};
+				};
+				usb0_upli_drvbus_pins_a: usb0_upli_drvbus@0 {
+					usb0_upli_drvbus {
+						sirf,pins = "usb0_upli_drvbusgrp";
+						sirf,function = "usb0_upli_drvbus";
+					};
+				};
+				usb1_utmi_drvbus_pins_a: usb1_utmi_drvbus@0 {
+					usb1_utmi_drvbus {
+						sirf,pins = "usb1_utmi_drvbusgrp";
+						sirf,function = "usb1_utmi_drvbus";
+					};
+				};
+				usb1_dp_dn_pins_a: usb1_dp_dn@0 {
+					usb1_dp_dn {
+						sirf,pins = "usb1_dp_dngrp";
+						sirf,function = "usb1_dp_dn";
+					};
+				};
+				uart1_route_io_usb1_pins_a: uart1_route_io_usb1@0 {
+					uart1_route_io_usb1 {
+						sirf,pins = "uart1_route_io_usb1grp";
+						sirf,function = "uart1_route_io_usb1";
+					};
+				};
+				warm_rst_pins_a: warm_rst@0 {
+					warm_rst {
+						sirf,pins = "warm_rstgrp";
+						sirf,function = "warm_rst";
+					};
+				};
+				pulse_count_pins_a: pulse_count@0 {
+					pulse_count {
+						sirf,pins = "pulse_countgrp";
+						sirf,function = "pulse_count";
+					};
+				};
+				cko0_pins_a: cko0@0 {
+					cko0 {
+						sirf,pins = "cko0grp";
+						sirf,function = "cko0";
+					};
+				};
+				cko1_pins_a: cko1@0 {
+					cko1 {
+						sirf,pins = "cko1grp";
+						sirf,function = "cko1";
+					};
+				};
 			};
 
 			pwm@b0130000 {
diff --git a/arch/arm/boot/dts/atlas7-evb.dts b/arch/arm/boot/dts/atlas7-evb.dts
index 900e03b..3a2a886 100644
--- a/arch/arm/boot/dts/atlas7-evb.dts
+++ b/arch/arm/boot/dts/atlas7-evb.dts
@@ -42,7 +42,6 @@
 		};
 	};
 
-
 	noc {
 		mediam {
 			nand@17050000 {
@@ -123,6 +122,5 @@
 				debounce_interval = <100>;
 			};
 		};
-
 	};
 };
diff --git a/arch/arm/boot/dts/atlas7.dtsi b/arch/arm/boot/dts/atlas7.dtsi
index f3de9af..0708372 100644
--- a/arch/arm/boot/dts/atlas7.dtsi
+++ b/arch/arm/boot/dts/atlas7.dtsi
@@ -1783,7 +1783,6 @@
 				compatible = "sirf,atlas7-memc";
 				reg = <0x10800000 0x2000>;
 			};
-
 		};
 
 		btm {
@@ -1899,8 +1898,8 @@
 				compatible = "sirf,atlas7-retain";
 				reg = <0x188D0000 0x1000>;
 			};
-
 		};
+
 		disp-iobg {
 			/* lcdc0 */
 			compatible = "simple-bus";
@@ -1936,7 +1935,6 @@
 				interrupts = <0 61 0>;
 				clocks = <&car 104>;
 			};
-
 		};
 
 		graphics-iobg {
diff --git a/arch/arm/boot/dts/axm55xx.dtsi b/arch/arm/boot/dts/axm55xx.dtsi
index 2a93d3e..dc0fe5a 100644
--- a/arch/arm/boot/dts/axm55xx.dtsi
+++ b/arch/arm/boot/dts/axm55xx.dtsi
@@ -82,7 +82,6 @@
 				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 
-
 	pmu {
 		compatible = "arm,cortex-a15-pmu";
 		interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
@@ -196,9 +195,3 @@
 		};
 	};
 };
-
-/*
-  Local Variables:
-  mode: C
-  End:
-*/
diff --git a/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts b/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
index bc330b1..bd25862 100644
--- a/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
+++ b/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
@@ -41,7 +41,6 @@
 
 			gpio-controller;
 			#gpio-cells = <2>;
-
 		};
 	};
 
diff --git a/arch/arm/boot/dts/bcm4708.dtsi b/arch/arm/boot/dts/bcm4708.dtsi
index 1a19e97..f77f16c 100644
--- a/arch/arm/boot/dts/bcm4708.dtsi
+++ b/arch/arm/boot/dts/bcm4708.dtsi
@@ -40,7 +40,6 @@
 			reg = <0x1>;
 		};
 	};
-
 };
 
 &uart0 {
diff --git a/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts b/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts
index 6fcbb05..a35df53 100644
--- a/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts
+++ b/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts
@@ -42,7 +42,6 @@
 
 			gpio-controller;
 			#gpio-cells = <2>;
-
 		};
 	};
 
diff --git a/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts b/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts
index 77d1687..340228f 100644
--- a/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts
+++ b/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts
@@ -119,7 +119,6 @@
 	};
 };
 
-
 &usb2 {
 	vcc-gpio = <&chipcommon 13 GPIO_ACTIVE_HIGH>;
 };
diff --git a/arch/arm/boot/dts/dra7-l4.dtsi b/arch/arm/boot/dts/dra7-l4.dtsi
index 414f1cd..86b37d1 100644
--- a/arch/arm/boot/dts/dra7-l4.dtsi
+++ b/arch/arm/boot/dts/dra7-l4.dtsi
@@ -4598,4 +4598,3 @@
 		};
 	};
 };
-
diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index bb52c6f..0e6576b 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -815,6 +815,7 @@
 		clock-frequency = <0>;
 	};
 };
+
 &prm_clocks {
 	sys_clkin1: sys_clkin1@110 {
 		#clock-cells = <0>;
@@ -1538,7 +1539,6 @@
 			reg = <0x20 0x4>;
 			#clock-cells = <2>;
 		};
-
 	};
 
 	dsp1_cm: dsp1-cm@400 {
@@ -1553,7 +1553,6 @@
 			reg = <0x20 0x4>;
 			#clock-cells = <2>;
 		};
-
 	};
 
 	ipu_cm: ipu-cm@500 {
@@ -1574,7 +1573,6 @@
 			reg = <0x50 0x34>;
 			#clock-cells = <2>;
 		};
-
 	};
 
 	dsp2_cm: dsp2-cm@600 {
@@ -1589,7 +1587,6 @@
 			reg = <0x20 0x4>;
 			#clock-cells = <2>;
 		};
-
 	};
 
 	rtc_cm: rtc-cm@700 {
@@ -1605,7 +1602,6 @@
 			#clock-cells = <2>;
 		};
 	};
-
 };
 
 &cm_core {
@@ -1635,7 +1631,6 @@
 			reg = <0x20 0x74>;
 			#clock-cells = <2>;
 		};
-
 	};
 
 	ipu2_cm: ipu2-cm@900 {
@@ -1798,7 +1793,6 @@
 			#clock-cells = <2>;
 		};
 	};
-
 };
 
 &prm {
diff --git a/arch/arm/boot/dts/evk-pro3.dts b/arch/arm/boot/dts/evk-pro3.dts
index 20a4481..ea246fb 100644
--- a/arch/arm/boot/dts/evk-pro3.dts
+++ b/arch/arm/boot/dts/evk-pro3.dts
@@ -55,5 +55,4 @@
 	i2c-gpio-0 {
 		status = "okay";
 	};
-
 };
diff --git a/arch/arm/boot/dts/exynos4412-ppmu-common.dtsi b/arch/arm/boot/dts/exynos4412-ppmu-common.dtsi
index 3a3b2fa..7f187a3 100644
--- a/arch/arm/boot/dts/exynos4412-ppmu-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-ppmu-common.dtsi
@@ -7,41 +7,41 @@
  */
 
 &ppmu_dmc0 {
-       status = "okay";
+	status = "okay";
 
-       events {
-	       ppmu_dmc0_3: ppmu-event3-dmc0 {
-		       event-name = "ppmu-event3-dmc0";
-	       };
-       };
+	events {
+		ppmu_dmc0_3: ppmu-event3-dmc0 {
+			event-name = "ppmu-event3-dmc0";
+		};
+	};
 };
 
 &ppmu_dmc1 {
-       status = "okay";
+	status = "okay";
 
-       events {
-	       ppmu_dmc1_3: ppmu-event3-dmc1 {
-		       event-name = "ppmu-event3-dmc1";
-	       };
-       };
+	events {
+		ppmu_dmc1_3: ppmu-event3-dmc1 {
+			event-name = "ppmu-event3-dmc1";
+		};
+	};
 };
 
 &ppmu_leftbus {
-       status = "okay";
+	status = "okay";
 
-       events {
-	       ppmu_leftbus_3: ppmu-event3-leftbus {
-		       event-name = "ppmu-event3-leftbus";
-	       };
-       };
+	events {
+		ppmu_leftbus_3: ppmu-event3-leftbus {
+			event-name = "ppmu-event3-leftbus";
+		};
+	};
 };
 
 &ppmu_rightbus {
-       status = "okay";
+	status = "okay";
 
-       events {
-	       ppmu_rightbus_3: ppmu-event3-rightbus {
-		       event-name = "ppmu-event3-rightbus";
-	       };
-       };
+	events {
+		ppmu_rightbus_3: ppmu-event3-rightbus {
+			event-name = "ppmu-event3-rightbus";
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/exynos5410-pinctrl.dtsi b/arch/arm/boot/dts/exynos5410-pinctrl.dtsi
index 369a8a7..2d818ef 100644
--- a/arch/arm/boot/dts/exynos5410-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos5410-pinctrl.dtsi
@@ -620,5 +620,4 @@
 		samsung,pin-pud = <0>;
 		samsung,pin-drv = <0>;
 	};
-
 };
diff --git a/arch/arm/boot/dts/exynos5422-odroidhc1.dts b/arch/arm/boot/dts/exynos5422-odroidhc1.dts
index d271e75..69a0104 100644
--- a/arch/arm/boot/dts/exynos5422-odroidhc1.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidhc1.dts
@@ -216,7 +216,6 @@
 			};
 		};
 	};
-
 };
 
 &pwm {
diff --git a/arch/arm/boot/dts/highbank.dts b/arch/arm/boot/dts/highbank.dts
index 5027871..c7552a5 100644
--- a/arch/arm/boot/dts/highbank.dts
+++ b/arch/arm/boot/dts/highbank.dts
@@ -159,13 +159,11 @@
 			interrupts = <0 76 4  0 75 4  0 74 4  0 73 4>;
 		};
 
-
 		sregs@fff3c200 {
 			compatible = "calxeda,hb-sregs-l2-ecc";
 			reg = <0xfff3c200 0x100>;
 			interrupts = <0 71 4  0 72 4>;
 		};
-
 	};
 };
 
diff --git a/arch/arm/boot/dts/imx23-sansa.dts b/arch/arm/boot/dts/imx23-sansa.dts
index 46057d9..9744d02 100644
--- a/arch/arm/boot/dts/imx23-sansa.dts
+++ b/arch/arm/boot/dts/imx23-sansa.dts
@@ -203,5 +203,4 @@
 			pagesize = <32>;
 		};
 	};
-
 };
diff --git a/arch/arm/boot/dts/imx28-eukrea-mbmx283lc.dts b/arch/arm/boot/dts/imx28-eukrea-mbmx283lc.dts
index 28dab6d..227f352 100644
--- a/arch/arm/boot/dts/imx28-eukrea-mbmx283lc.dts
+++ b/arch/arm/boot/dts/imx28-eukrea-mbmx283lc.dts
@@ -46,7 +46,6 @@
 	};
 };
 
-
 &mac0 {
 	phy-mode = "rmii";
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index 96c1d10..39b365c 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -14,7 +14,6 @@
 		reg = <0x40000000 0x08000000>;
 	};
 
-
 	reg_3p3v: regulator-3p3v {
 		compatible = "regulator-fixed";
 		regulator-name = "3P3V";
diff --git a/arch/arm/boot/dts/imx28-sps1.dts b/arch/arm/boot/dts/imx28-sps1.dts
index 42c88a6..1cd1d61 100644
--- a/arch/arm/boot/dts/imx28-sps1.dts
+++ b/arch/arm/boot/dts/imx28-sps1.dts
@@ -167,6 +167,5 @@
 			default-trigger = "heartbeat";
 			reg = <2>;
 		};
-
 	};
 };
diff --git a/arch/arm/boot/dts/imx28-ts4600.dts b/arch/arm/boot/dts/imx28-ts4600.dts
index e3fd411..cfc119b 100644
--- a/arch/arm/boot/dts/imx28-ts4600.dts
+++ b/arch/arm/boot/dts/imx28-ts4600.dts
@@ -15,7 +15,6 @@
 #include "dt-bindings/gpio/gpio.h"
 
 / {
-
 	model = "Technologic Systems i.MX28 TS-4600";
 	compatible = "technologic,imx28-ts4600", "fsl,imx28";
 
@@ -39,7 +38,6 @@
 			};
 
 			pinctrl@80018000 {
-
 				en_sd_pwr: en-sd-pwr@0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
@@ -49,7 +47,6 @@
 					fsl,voltage = <MXS_VOLTAGE_HIGH>;
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
-
 			};
 		};
 
@@ -76,5 +73,4 @@
 		regulator-boot-on;
 		gpio = <&gpio3 28 GPIO_ACTIVE_LOW>;
 	};
-
 };
diff --git a/arch/arm/boot/dts/imx6dl-gw52xx.dts b/arch/arm/boot/dts/imx6dl-gw52xx.dts
index 5f9f894..5b95a026 100644
--- a/arch/arm/boot/dts/imx6dl-gw52xx.dts
+++ b/arch/arm/boot/dts/imx6dl-gw52xx.dts
@@ -54,24 +54,24 @@
 &iomuxc {
 	pinctrl_adv7180: adv7180grp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_D30__GPIO3_IO30          0x0001b0b0
-			MX6QDL_PAD_EIM_D31__GPIO3_IO31          0x4001b0b0
+			MX6QDL_PAD_EIM_D30__GPIO3_IO30		0x0001b0b0
+			MX6QDL_PAD_EIM_D31__GPIO3_IO31		0x4001b0b0
 		>;
 	};
 
 	pinctrl_ipu1_csi1: ipu1_csi1grp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_EB2__IPU1_CSI1_DATA19    0x1b0b0
-			MX6QDL_PAD_EIM_D16__IPU1_CSI1_DATA18    0x1b0b0
-			MX6QDL_PAD_EIM_D18__IPU1_CSI1_DATA17    0x1b0b0
-			MX6QDL_PAD_EIM_D19__IPU1_CSI1_DATA16    0x1b0b0
-			MX6QDL_PAD_EIM_D20__IPU1_CSI1_DATA15    0x1b0b0
-			MX6QDL_PAD_EIM_D26__IPU1_CSI1_DATA14    0x1b0b0
-			MX6QDL_PAD_EIM_D27__IPU1_CSI1_DATA13    0x1b0b0
-			MX6QDL_PAD_EIM_A17__IPU1_CSI1_DATA12    0x1b0b0
-			MX6QDL_PAD_EIM_D29__IPU1_CSI1_VSYNC     0x1b0b0
-			MX6QDL_PAD_EIM_EB3__IPU1_CSI1_HSYNC     0x1b0b0
-			MX6QDL_PAD_EIM_A16__IPU1_CSI1_PIXCLK    0x1b0b0
+			MX6QDL_PAD_EIM_EB2__IPU1_CSI1_DATA19	0x1b0b0
+			MX6QDL_PAD_EIM_D16__IPU1_CSI1_DATA18	0x1b0b0
+			MX6QDL_PAD_EIM_D18__IPU1_CSI1_DATA17	0x1b0b0
+			MX6QDL_PAD_EIM_D19__IPU1_CSI1_DATA16	0x1b0b0
+			MX6QDL_PAD_EIM_D20__IPU1_CSI1_DATA15	0x1b0b0
+			MX6QDL_PAD_EIM_D26__IPU1_CSI1_DATA14	0x1b0b0
+			MX6QDL_PAD_EIM_D27__IPU1_CSI1_DATA13	0x1b0b0
+			MX6QDL_PAD_EIM_A17__IPU1_CSI1_DATA12	0x1b0b0
+			MX6QDL_PAD_EIM_D29__IPU1_CSI1_VSYNC	0x1b0b0
+			MX6QDL_PAD_EIM_EB3__IPU1_CSI1_HSYNC	0x1b0b0
+			MX6QDL_PAD_EIM_A16__IPU1_CSI1_PIXCLK	0x1b0b0
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6dl-gw53xx.dts b/arch/arm/boot/dts/imx6dl-gw53xx.dts
index 9bfc620..bd2095b 100644
--- a/arch/arm/boot/dts/imx6dl-gw53xx.dts
+++ b/arch/arm/boot/dts/imx6dl-gw53xx.dts
@@ -54,24 +54,24 @@
 &iomuxc {
 	pinctrl_adv7180: adv7180grp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_D30__GPIO3_IO30          0x0001b0b0
-			MX6QDL_PAD_EIM_D31__GPIO3_IO31          0x4001b0b0
+			MX6QDL_PAD_EIM_D30__GPIO3_IO30		0x0001b0b0
+			MX6QDL_PAD_EIM_D31__GPIO3_IO31		0x4001b0b0
 		>;
 	};
 
 	pinctrl_ipu1_csi1: ipu1_csi1grp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_EB2__IPU1_CSI1_DATA19    0x1b0b0
-			MX6QDL_PAD_EIM_D16__IPU1_CSI1_DATA18    0x1b0b0
-			MX6QDL_PAD_EIM_D18__IPU1_CSI1_DATA17    0x1b0b0
-			MX6QDL_PAD_EIM_D19__IPU1_CSI1_DATA16    0x1b0b0
-			MX6QDL_PAD_EIM_D20__IPU1_CSI1_DATA15    0x1b0b0
-			MX6QDL_PAD_EIM_D26__IPU1_CSI1_DATA14    0x1b0b0
-			MX6QDL_PAD_EIM_D27__IPU1_CSI1_DATA13    0x1b0b0
-			MX6QDL_PAD_EIM_A17__IPU1_CSI1_DATA12    0x1b0b0
-			MX6QDL_PAD_EIM_D29__IPU1_CSI1_VSYNC     0x1b0b0
-			MX6QDL_PAD_EIM_EB3__IPU1_CSI1_HSYNC     0x1b0b0
-			MX6QDL_PAD_EIM_A16__IPU1_CSI1_PIXCLK    0x1b0b0
+			MX6QDL_PAD_EIM_EB2__IPU1_CSI1_DATA19	0x1b0b0
+			MX6QDL_PAD_EIM_D16__IPU1_CSI1_DATA18	0x1b0b0
+			MX6QDL_PAD_EIM_D18__IPU1_CSI1_DATA17	0x1b0b0
+			MX6QDL_PAD_EIM_D19__IPU1_CSI1_DATA16	0x1b0b0
+			MX6QDL_PAD_EIM_D20__IPU1_CSI1_DATA15	0x1b0b0
+			MX6QDL_PAD_EIM_D26__IPU1_CSI1_DATA14	0x1b0b0
+			MX6QDL_PAD_EIM_D27__IPU1_CSI1_DATA13	0x1b0b0
+			MX6QDL_PAD_EIM_A17__IPU1_CSI1_DATA12	0x1b0b0
+			MX6QDL_PAD_EIM_D29__IPU1_CSI1_VSYNC	0x1b0b0
+			MX6QDL_PAD_EIM_EB3__IPU1_CSI1_HSYNC	0x1b0b0
+			MX6QDL_PAD_EIM_A16__IPU1_CSI1_PIXCLK	0x1b0b0
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6dl-gw54xx.dts b/arch/arm/boot/dts/imx6dl-gw54xx.dts
index b909bdf..9a7174fe 100644
--- a/arch/arm/boot/dts/imx6dl-gw54xx.dts
+++ b/arch/arm/boot/dts/imx6dl-gw54xx.dts
@@ -54,24 +54,24 @@
 &iomuxc {
 	pinctrl_adv7180: adv7180grp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_D30__GPIO3_IO30          0x0001b0b0
-			MX6QDL_PAD_EIM_D31__GPIO3_IO31          0x4001b0b0
+			MX6QDL_PAD_EIM_D30__GPIO3_IO30		0x0001b0b0
+			MX6QDL_PAD_EIM_D31__GPIO3_IO31		0x4001b0b0
 		>;
 	};
 
 	pinctrl_ipu1_csi1: ipu1_csi1grp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_EB2__IPU1_CSI1_DATA19    0x1b0b0
-			MX6QDL_PAD_EIM_D16__IPU1_CSI1_DATA18    0x1b0b0
-			MX6QDL_PAD_EIM_D18__IPU1_CSI1_DATA17    0x1b0b0
-			MX6QDL_PAD_EIM_D19__IPU1_CSI1_DATA16    0x1b0b0
-			MX6QDL_PAD_EIM_D20__IPU1_CSI1_DATA15    0x1b0b0
-			MX6QDL_PAD_EIM_D26__IPU1_CSI1_DATA14    0x1b0b0
-			MX6QDL_PAD_EIM_D27__IPU1_CSI1_DATA13    0x1b0b0
-			MX6QDL_PAD_EIM_A17__IPU1_CSI1_DATA12    0x1b0b0
-			MX6QDL_PAD_EIM_D29__IPU1_CSI1_VSYNC     0x1b0b0
-			MX6QDL_PAD_EIM_EB3__IPU1_CSI1_HSYNC     0x1b0b0
-			MX6QDL_PAD_EIM_A16__IPU1_CSI1_PIXCLK    0x1b0b0
+			MX6QDL_PAD_EIM_EB2__IPU1_CSI1_DATA19	0x1b0b0
+			MX6QDL_PAD_EIM_D16__IPU1_CSI1_DATA18	0x1b0b0
+			MX6QDL_PAD_EIM_D18__IPU1_CSI1_DATA17	0x1b0b0
+			MX6QDL_PAD_EIM_D19__IPU1_CSI1_DATA16	0x1b0b0
+			MX6QDL_PAD_EIM_D20__IPU1_CSI1_DATA15	0x1b0b0
+			MX6QDL_PAD_EIM_D26__IPU1_CSI1_DATA14	0x1b0b0
+			MX6QDL_PAD_EIM_D27__IPU1_CSI1_DATA13	0x1b0b0
+			MX6QDL_PAD_EIM_A17__IPU1_CSI1_DATA12	0x1b0b0
+			MX6QDL_PAD_EIM_D29__IPU1_CSI1_VSYNC	0x1b0b0
+			MX6QDL_PAD_EIM_EB3__IPU1_CSI1_HSYNC	0x1b0b0
+			MX6QDL_PAD_EIM_A16__IPU1_CSI1_PIXCLK	0x1b0b0
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6dl-mamoj.dts b/arch/arm/boot/dts/imx6dl-mamoj.dts
index 385ce7b..6c270ca 100644
--- a/arch/arm/boot/dts/imx6dl-mamoj.dts
+++ b/arch/arm/boot/dts/imx6dl-mamoj.dts
@@ -373,7 +373,7 @@
 			MX6QDL_PAD_ENET_RXD0__ENET_RX_DATA0	0x1b0b0
 			MX6QDL_PAD_ENET_RXD1__ENET_RX_DATA1	0x1b0b0
 			MX6QDL_PAD_KEY_COL2__ENET_RX_DATA2	0x1b0b0
-			MX6QDL_PAD_KEY_COL0__ENET_RX_DATA3      0x1b0b0
+			MX6QDL_PAD_KEY_COL0__ENET_RX_DATA3	0x1b0b0
 			MX6QDL_PAD_ENET_CRS_DV__ENET_RX_EN	0x1b0b0
 			MX6QDL_PAD_ENET_RX_ER__ENET_RX_ER	0x1b0b0
 			MX6QDL_PAD_KEY_COL3__ENET_CRS		0x1b0b0
@@ -383,49 +383,49 @@
 
 	pinctrl_i2c3: i2c3grp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_3__I2C3_SCL     0x4001b8b1
-			MX6QDL_PAD_GPIO_6__I2C3_SDA     0x4001b8b1
+			MX6QDL_PAD_GPIO_3__I2C3_SCL		0x4001b8b1
+			MX6QDL_PAD_GPIO_6__I2C3_SDA		0x4001b8b1
 		>;
 	};
 
 	pinctrl_i2c4: i2c4grp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_7__I2C4_SCL	0x4001b8b1
-			MX6QDL_PAD_GPIO_8__I2C4_SDA	0x4001b8b1
+			MX6QDL_PAD_GPIO_7__I2C4_SCL		0x4001b8b1
+			MX6QDL_PAD_GPIO_8__I2C4_SDA		0x4001b8b1
 		>;
 	};
 
 	pinctrl_ipu1_lcdif: pinctrlipu1lcdif { /* parallel port 24-bit */
 		fsl,pins = <
-			MX6QDL_PAD_DI0_DISP_CLK__IPU1_DI0_DISP_CLK 0x10 /* VDOUT_PCLK */
-			MX6QDL_PAD_DI0_PIN15__IPU1_DI0_PIN15       0x10
-			MX6QDL_PAD_DI0_PIN2__IPU1_DI0_PIN02        0x10 /* VDOUT_HSYNC */
-			MX6QDL_PAD_DI0_PIN3__IPU1_DI0_PIN03        0x10 /* VDOUT_VSYNC */
-			MX6QDL_PAD_DI0_PIN4__IPU1_DI0_PIN04	   0x10 /* VDOUT_RESET */
-			MX6QDL_PAD_DISP0_DAT0__IPU1_DISP0_DATA00   0x10
-			MX6QDL_PAD_DISP0_DAT1__IPU1_DISP0_DATA01   0x10
-			MX6QDL_PAD_DISP0_DAT2__IPU1_DISP0_DATA02   0x10
-			MX6QDL_PAD_DISP0_DAT3__IPU1_DISP0_DATA03   0x10
-			MX6QDL_PAD_DISP0_DAT4__IPU1_DISP0_DATA04   0x10
-			MX6QDL_PAD_DISP0_DAT5__IPU1_DISP0_DATA05   0x10
-			MX6QDL_PAD_DISP0_DAT6__IPU1_DISP0_DATA06   0x10
-			MX6QDL_PAD_DISP0_DAT7__IPU1_DISP0_DATA07   0x10
-			MX6QDL_PAD_DISP0_DAT8__IPU1_DISP0_DATA08   0x10
-			MX6QDL_PAD_DISP0_DAT9__IPU1_DISP0_DATA09   0x10
-			MX6QDL_PAD_DISP0_DAT10__IPU1_DISP0_DATA10  0x10
-			MX6QDL_PAD_DISP0_DAT11__IPU1_DISP0_DATA11  0x10
-			MX6QDL_PAD_DISP0_DAT12__IPU1_DISP0_DATA12  0x10
-			MX6QDL_PAD_DISP0_DAT13__IPU1_DISP0_DATA13  0x10
-			MX6QDL_PAD_DISP0_DAT14__IPU1_DISP0_DATA14  0x10
-			MX6QDL_PAD_DISP0_DAT15__IPU1_DISP0_DATA15  0x10
-			MX6QDL_PAD_DISP0_DAT16__IPU1_DISP0_DATA16  0x10
-			MX6QDL_PAD_DISP0_DAT17__IPU1_DISP0_DATA17  0x10
-			MX6QDL_PAD_DISP0_DAT18__IPU1_DISP0_DATA18  0x10
-			MX6QDL_PAD_DISP0_DAT19__IPU1_DISP0_DATA19  0x10
-			MX6QDL_PAD_DISP0_DAT20__IPU1_DISP0_DATA20  0x10
-			MX6QDL_PAD_DISP0_DAT21__IPU1_DISP0_DATA21  0x10
-			MX6QDL_PAD_DISP0_DAT22__IPU1_DISP0_DATA22  0x10
-			MX6QDL_PAD_DISP0_DAT23__IPU1_DISP0_DATA23  0x10
+			MX6QDL_PAD_DI0_DISP_CLK__IPU1_DI0_DISP_CLK	0x10 /* VDOUT_PCLK */
+			MX6QDL_PAD_DI0_PIN15__IPU1_DI0_PIN15		0x10
+			MX6QDL_PAD_DI0_PIN2__IPU1_DI0_PIN02		0x10 /* VDOUT_HSYNC */
+			MX6QDL_PAD_DI0_PIN3__IPU1_DI0_PIN03		0x10 /* VDOUT_VSYNC */
+			MX6QDL_PAD_DI0_PIN4__IPU1_DI0_PIN04		0x10 /* VDOUT_RESET */
+			MX6QDL_PAD_DISP0_DAT0__IPU1_DISP0_DATA00	0x10
+			MX6QDL_PAD_DISP0_DAT1__IPU1_DISP0_DATA01	0x10
+			MX6QDL_PAD_DISP0_DAT2__IPU1_DISP0_DATA02	0x10
+			MX6QDL_PAD_DISP0_DAT3__IPU1_DISP0_DATA03	0x10
+			MX6QDL_PAD_DISP0_DAT4__IPU1_DISP0_DATA04	0x10
+			MX6QDL_PAD_DISP0_DAT5__IPU1_DISP0_DATA05	0x10
+			MX6QDL_PAD_DISP0_DAT6__IPU1_DISP0_DATA06	0x10
+			MX6QDL_PAD_DISP0_DAT7__IPU1_DISP0_DATA07	0x10
+			MX6QDL_PAD_DISP0_DAT8__IPU1_DISP0_DATA08	0x10
+			MX6QDL_PAD_DISP0_DAT9__IPU1_DISP0_DATA09	0x10
+			MX6QDL_PAD_DISP0_DAT10__IPU1_DISP0_DATA10	0x10
+			MX6QDL_PAD_DISP0_DAT11__IPU1_DISP0_DATA11	0x10
+			MX6QDL_PAD_DISP0_DAT12__IPU1_DISP0_DATA12	0x10
+			MX6QDL_PAD_DISP0_DAT13__IPU1_DISP0_DATA13	0x10
+			MX6QDL_PAD_DISP0_DAT14__IPU1_DISP0_DATA14	0x10
+			MX6QDL_PAD_DISP0_DAT15__IPU1_DISP0_DATA15	0x10
+			MX6QDL_PAD_DISP0_DAT16__IPU1_DISP0_DATA16	0x10
+			MX6QDL_PAD_DISP0_DAT17__IPU1_DISP0_DATA17	0x10
+			MX6QDL_PAD_DISP0_DAT18__IPU1_DISP0_DATA18	0x10
+			MX6QDL_PAD_DISP0_DAT19__IPU1_DISP0_DATA19	0x10
+			MX6QDL_PAD_DISP0_DAT20__IPU1_DISP0_DATA20	0x10
+			MX6QDL_PAD_DISP0_DAT21__IPU1_DISP0_DATA21	0x10
+			MX6QDL_PAD_DISP0_DAT22__IPU1_DISP0_DATA22	0x10
+			MX6QDL_PAD_DISP0_DAT23__IPU1_DISP0_DATA23	0x10
 		>;
 	};
 
@@ -463,27 +463,27 @@
 
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
-			MX6QDL_PAD_SD1_CMD__SD1_CMD    0x17069
-			MX6QDL_PAD_SD1_CLK__SD1_CLK    0x10079
-			MX6QDL_PAD_SD1_DAT0__SD1_DATA0 0x17069
-			MX6QDL_PAD_SD1_DAT1__SD1_DATA1 0x17069
-			MX6QDL_PAD_SD1_DAT2__SD1_DATA2 0x17069
-			MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x17069
+			MX6QDL_PAD_SD1_CMD__SD1_CMD		0x17069
+			MX6QDL_PAD_SD1_CLK__SD1_CLK		0x10079
+			MX6QDL_PAD_SD1_DAT0__SD1_DATA0		0x17069
+			MX6QDL_PAD_SD1_DAT1__SD1_DATA1		0x17069
+			MX6QDL_PAD_SD1_DAT2__SD1_DATA2		0x17069
+			MX6QDL_PAD_SD1_DAT3__SD1_DATA3		0x17069
 		>;
 	};
 
 	pinctrl_usdhc3: usdhc3grp {
 		fsl,pins = <
-			MX6QDL_PAD_SD3_CMD__SD3_CMD	0x17059
-			MX6QDL_PAD_SD3_CLK__SD3_CLK	0x10059
-			MX6QDL_PAD_SD3_DAT0__SD3_DATA0	0x17059
-			MX6QDL_PAD_SD3_DAT1__SD3_DATA1	0x17059
-			MX6QDL_PAD_SD3_DAT2__SD3_DATA2	0x17059
-			MX6QDL_PAD_SD3_DAT3__SD3_DATA3	0x17059
-			MX6QDL_PAD_SD3_DAT4__SD3_DATA4	0x17059
-			MX6QDL_PAD_SD3_DAT5__SD3_DATA5	0x17059
-			MX6QDL_PAD_SD3_DAT6__SD3_DATA6	0x17059
-			MX6QDL_PAD_SD3_DAT7__SD3_DATA7	0x17059
+			MX6QDL_PAD_SD3_CMD__SD3_CMD		0x17059
+			MX6QDL_PAD_SD3_CLK__SD3_CLK		0x10059
+			MX6QDL_PAD_SD3_DAT0__SD3_DATA0		0x17059
+			MX6QDL_PAD_SD3_DAT1__SD3_DATA1		0x17059
+			MX6QDL_PAD_SD3_DAT2__SD3_DATA2		0x17059
+			MX6QDL_PAD_SD3_DAT3__SD3_DATA3		0x17059
+			MX6QDL_PAD_SD3_DAT4__SD3_DATA4		0x17059
+			MX6QDL_PAD_SD3_DAT5__SD3_DATA5		0x17059
+			MX6QDL_PAD_SD3_DAT6__SD3_DATA6		0x17059
+			MX6QDL_PAD_SD3_DAT7__SD3_DATA7		0x17059
 		>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6q-ba16.dtsi b/arch/arm/boot/dts/imx6q-ba16.dtsi
index adc9455..6caf87c 100644
--- a/arch/arm/boot/dts/imx6q-ba16.dtsi
+++ b/arch/arm/boot/dts/imx6q-ba16.dtsi
@@ -414,29 +414,29 @@
 
 	pinctrl_audmux: audmuxgrp {
 		fsl,pins = <
-			MX6QDL_PAD_DISP0_DAT20__AUD4_TXC  0x130b0
-			MX6QDL_PAD_DISP0_DAT21__AUD4_TXD  0x130b0
-			MX6QDL_PAD_DISP0_DAT22__AUD4_TXFS 0x130b0
-			MX6QDL_PAD_DISP0_DAT23__AUD4_RXD  0x130b0
+			MX6QDL_PAD_DISP0_DAT20__AUD4_TXC	0x130b0
+			MX6QDL_PAD_DISP0_DAT21__AUD4_TXD	0x130b0
+			MX6QDL_PAD_DISP0_DAT22__AUD4_TXFS	0x130b0
+			MX6QDL_PAD_DISP0_DAT23__AUD4_RXD	0x130b0
 		>;
 	};
 
 	pinctrl_display: dispgrp {
 		fsl,pins = <
 			/* BLEN_OUT */
-			MX6QDL_PAD_GPIO_0__GPIO1_IO00    0x1b0b0
+			MX6QDL_PAD_GPIO_0__GPIO1_IO00		0x1b0b0
 			/* LVDS_PPEN_OUT */
-			MX6QDL_PAD_EIM_D22__GPIO3_IO22   0x1b0b0
+			MX6QDL_PAD_EIM_D22__GPIO3_IO22		0x1b0b0
 		>;
 	};
 
 	pinctrl_ecspi1: ecspi1grp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_D17__ECSPI1_MISO	0x100b1
-			MX6QDL_PAD_EIM_D18__ECSPI1_MOSI	0x100b1
-			MX6QDL_PAD_EIM_D16__ECSPI1_SCLK	0x100b1
+			MX6QDL_PAD_EIM_D17__ECSPI1_MISO		0x100b1
+			MX6QDL_PAD_EIM_D18__ECSPI1_MOSI		0x100b1
+			MX6QDL_PAD_EIM_D16__ECSPI1_SCLK		0x100b1
 			/* SPI1 CS */
-			MX6QDL_PAD_EIM_EB2__GPIO2_IO30	0x1b0b0
+			MX6QDL_PAD_EIM_EB2__GPIO2_IO30		0x1b0b0
 		>;
 	};
 
@@ -451,189 +451,189 @@
 
 	pinctrl_enet: enetgrp {
 		fsl,pins = <
-			MX6QDL_PAD_ENET_MDIO__ENET_MDIO       0x100b0
-			MX6QDL_PAD_ENET_MDC__ENET_MDC         0x100b0
-			MX6QDL_PAD_RGMII_TXC__RGMII_TXC       0x10030
-			MX6QDL_PAD_RGMII_TD0__RGMII_TD0       0x10030
-			MX6QDL_PAD_RGMII_TD1__RGMII_TD1       0x10030
-			MX6QDL_PAD_RGMII_TD2__RGMII_TD2       0x10030
-			MX6QDL_PAD_RGMII_TD3__RGMII_TD3       0x10030
-			MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL 0x10030
-			MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK  0x100b0
-			MX6QDL_PAD_RGMII_RXC__RGMII_RXC       0x1b030
-			MX6QDL_PAD_RGMII_RD0__RGMII_RD0       0x1b030
-			MX6QDL_PAD_RGMII_RD1__RGMII_RD1       0x1b030
-			MX6QDL_PAD_RGMII_RD2__RGMII_RD2       0x1b030
-			MX6QDL_PAD_RGMII_RD3__RGMII_RD3       0x1b030
-			MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL 0x1b030
+			MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x100b0
+			MX6QDL_PAD_ENET_MDC__ENET_MDC		0x100b0
+			MX6QDL_PAD_RGMII_TXC__RGMII_TXC		0x10030
+			MX6QDL_PAD_RGMII_TD0__RGMII_TD0		0x10030
+			MX6QDL_PAD_RGMII_TD1__RGMII_TD1		0x10030
+			MX6QDL_PAD_RGMII_TD2__RGMII_TD2		0x10030
+			MX6QDL_PAD_RGMII_TD3__RGMII_TD3		0x10030
+			MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL	0x10030
+			MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK	0x100b0
+			MX6QDL_PAD_RGMII_RXC__RGMII_RXC		0x1b030
+			MX6QDL_PAD_RGMII_RD0__RGMII_RD0		0x1b030
+			MX6QDL_PAD_RGMII_RD1__RGMII_RD1		0x1b030
+			MX6QDL_PAD_RGMII_RD2__RGMII_RD2		0x1b030
+			MX6QDL_PAD_RGMII_RD3__RGMII_RD3		0x1b030
+			MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL	0x1b030
 			/* FEC Reset */
-			MX6QDL_PAD_ENET_TX_EN__GPIO1_IO28     0x1b0b0
+			MX6QDL_PAD_ENET_TX_EN__GPIO1_IO28	0x1b0b0
 			/* AR8033 Interrupt */
-			MX6QDL_PAD_GPIO_19__GPIO4_IO05        0x1b0b0
+			MX6QDL_PAD_GPIO_19__GPIO4_IO05		0x1b0b0
 		>;
 	};
 
 	pinctrl_hog: hoggrp {
 		fsl,pins = <
 			/* GPIO 0-7 */
-			MX6QDL_PAD_NANDF_D0__GPIO2_IO00  0x1b0b0
-			MX6QDL_PAD_NANDF_D1__GPIO2_IO01  0x1b0b0
-			MX6QDL_PAD_NANDF_D2__GPIO2_IO02  0x1b0b0
-			MX6QDL_PAD_NANDF_D3__GPIO2_IO03  0x1b0b0
-			MX6QDL_PAD_NANDF_D4__GPIO2_IO04  0x1b0b0
-			MX6QDL_PAD_NANDF_D5__GPIO2_IO05  0x1b0b0
-			MX6QDL_PAD_NANDF_D6__GPIO2_IO06  0x1b0b0
-			MX6QDL_PAD_NANDF_D7__GPIO2_IO07  0x1b0b0
+			MX6QDL_PAD_NANDF_D0__GPIO2_IO00		0x1b0b0
+			MX6QDL_PAD_NANDF_D1__GPIO2_IO01		0x1b0b0
+			MX6QDL_PAD_NANDF_D2__GPIO2_IO02		0x1b0b0
+			MX6QDL_PAD_NANDF_D3__GPIO2_IO03		0x1b0b0
+			MX6QDL_PAD_NANDF_D4__GPIO2_IO04		0x1b0b0
+			MX6QDL_PAD_NANDF_D5__GPIO2_IO05		0x1b0b0
+			MX6QDL_PAD_NANDF_D6__GPIO2_IO06		0x1b0b0
+			MX6QDL_PAD_NANDF_D7__GPIO2_IO07		0x1b0b0
 			/* SUS_S3_OUT to CPLD */
-			MX6QDL_PAD_KEY_ROW2__GPIO4_IO11  0x1b0b0
+			MX6QDL_PAD_KEY_ROW2__GPIO4_IO11		0x1b0b0
 		>;
 	};
 
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
-			MX6QDL_PAD_CSI0_DAT8__I2C1_SDA	0x4001b8b1
-			MX6QDL_PAD_CSI0_DAT9__I2C1_SCL	0x4001b8b1
+			MX6QDL_PAD_CSI0_DAT8__I2C1_SDA		0x4001b8b1
+			MX6QDL_PAD_CSI0_DAT9__I2C1_SCL		0x4001b8b1
 		>;
 	};
 
 	pinctrl_i2c2: i2c2grp {
 		fsl,pins = <
-			MX6QDL_PAD_KEY_COL3__I2C2_SCL	0x4001b8b1
-			MX6QDL_PAD_KEY_ROW3__I2C2_SDA	0x4001b8b1
+			MX6QDL_PAD_KEY_COL3__I2C2_SCL		0x4001b8b1
+			MX6QDL_PAD_KEY_ROW3__I2C2_SDA		0x4001b8b1
 		>;
 	};
 
 	pinctrl_i2c3: i2c3grp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_3__I2C3_SCL	0x4001b8b1
-			MX6QDL_PAD_GPIO_6__I2C3_SDA	0x4001b8b1
+			MX6QDL_PAD_GPIO_3__I2C3_SCL		0x4001b8b1
+			MX6QDL_PAD_GPIO_6__I2C3_SDA		0x4001b8b1
 		>;
 	};
 
 	pinctrl_pcie: pciegrp {
 		fsl,pins = <
 			/* PCIe Reset */
-			MX6QDL_PAD_GPIO_17__GPIO7_IO12	0x1b0b0
+			MX6QDL_PAD_GPIO_17__GPIO7_IO12		0x1b0b0
 			/* PCIe Wake */
-			MX6QDL_PAD_GPIO_5__GPIO1_IO05	0x1b0b0
+			MX6QDL_PAD_GPIO_5__GPIO1_IO05		0x1b0b0
 		>;
 	};
 
 	pinctrl_pmic: pmicgrp {
 		fsl,pins = <
 			/* PMIC Interrupt */
-			MX6QDL_PAD_GPIO_18__GPIO7_IO13	0x1b0b0
+			MX6QDL_PAD_GPIO_18__GPIO7_IO13		0x1b0b0
 		>;
 	};
 
 	pinctrl_pwm1: pwm1grp {
 		fsl,pins = <
-			MX6QDL_PAD_SD1_DAT3__PWM1_OUT	0x1b0b1
+			MX6QDL_PAD_SD1_DAT3__PWM1_OUT		0x1b0b1
 		>;
 	};
 
 	pinctrl_pwm2: pwm2grp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_1__PWM2_OUT	0x1b0b1
+			MX6QDL_PAD_GPIO_1__PWM2_OUT		0x1b0b1
 		>;
 	};
 
 	pinctrl_rtc: rtcgrp {
 		fsl,pins = <
 			/* RTC_INT */
-			MX6QDL_PAD_KEY_COL2__GPIO4_IO10	0x1b0b0
+			MX6QDL_PAD_KEY_COL2__GPIO4_IO10		0x1b0b0
 		>;
 	};
 
 	pinctrl_uart3: uart3grp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_D25__UART3_RX_DATA 0x1b0b1
-			MX6QDL_PAD_EIM_D24__UART3_TX_DATA 0x1b0b1
-			MX6QDL_PAD_EIM_D23__UART3_CTS_B   0x1b0b1
-			MX6QDL_PAD_EIM_D31__UART3_RTS_B   0x1b0b1
+			MX6QDL_PAD_EIM_D25__UART3_RX_DATA	0x1b0b1
+			MX6QDL_PAD_EIM_D24__UART3_TX_DATA	0x1b0b1
+			MX6QDL_PAD_EIM_D23__UART3_CTS_B		0x1b0b1
+			MX6QDL_PAD_EIM_D31__UART3_RTS_B		0x1b0b1
 		>;
 	};
 
 	pinctrl_uart4: uart4grp {
 		fsl,pins = <
-			MX6QDL_PAD_KEY_COL0__UART4_TX_DATA 0x1b0b1
-			MX6QDL_PAD_KEY_ROW0__UART4_RX_DATA 0x1b0b1
+			MX6QDL_PAD_KEY_COL0__UART4_TX_DATA	0x1b0b1
+			MX6QDL_PAD_KEY_ROW0__UART4_RX_DATA	0x1b0b1
 		>;
 	};
 
 	pinctrl_usbhub: usbhubgrp {
 		fsl,pins = <
 			/* HUB_RESET */
-			MX6QDL_PAD_GPIO_16__GPIO7_IO11	0x1b0b0
+			MX6QDL_PAD_GPIO_16__GPIO7_IO11		0x1b0b0
 		>;
 	};
 
 	pinctrl_usbotg: usbotggrp {
 		fsl,pins = <
-			MX6QDL_PAD_ENET_RX_ER__USB_OTG_ID 0x17059
+			MX6QDL_PAD_ENET_RX_ER__USB_OTG_ID	0x17059
 		>;
 	};
 
 	pinctrl_usdhc2: usdhc2grp {
 		fsl,pins = <
-			MX6QDL_PAD_SD2_CMD__SD2_CMD	0x17059
-			MX6QDL_PAD_SD2_CLK__SD2_CLK	0x10059
-			MX6QDL_PAD_SD2_DAT0__SD2_DATA0	0x17059
-			MX6QDL_PAD_SD2_DAT1__SD2_DATA1	0x17059
-			MX6QDL_PAD_SD2_DAT2__SD2_DATA2	0x17059
-			MX6QDL_PAD_SD2_DAT3__SD2_DATA3	0x17059
+			MX6QDL_PAD_SD2_CMD__SD2_CMD		0x17059
+			MX6QDL_PAD_SD2_CLK__SD2_CLK		0x10059
+			MX6QDL_PAD_SD2_DAT0__SD2_DATA0		0x17059
+			MX6QDL_PAD_SD2_DAT1__SD2_DATA1		0x17059
+			MX6QDL_PAD_SD2_DAT2__SD2_DATA2		0x17059
+			MX6QDL_PAD_SD2_DAT3__SD2_DATA3		0x17059
 			/* uSDHC2 CD */
-			MX6QDL_PAD_GPIO_4__GPIO1_IO04	0x1b0b0
+			MX6QDL_PAD_GPIO_4__GPIO1_IO04		0x1b0b0
 		>;
 	};
 
 	pinctrl_usdhc3: usdhc3grp {
 		fsl,pins = <
-			MX6QDL_PAD_SD3_CMD__SD3_CMD	0x17059
-			MX6QDL_PAD_SD3_CLK__SD3_CLK	0x10059
-			MX6QDL_PAD_SD3_DAT0__SD3_DATA0	0x17059
-			MX6QDL_PAD_SD3_DAT1__SD3_DATA1	0x17059
-			MX6QDL_PAD_SD3_DAT2__SD3_DATA2	0x17059
-			MX6QDL_PAD_SD3_DAT3__SD3_DATA3	0x17059
-			MX6QDL_PAD_SD3_DAT4__SD3_DATA4	0x17059
-			MX6QDL_PAD_SD3_DAT5__SD3_DATA5	0x17059
-			MX6QDL_PAD_SD3_DAT6__SD3_DATA6	0x17059
-			MX6QDL_PAD_SD3_DAT7__SD3_DATA7	0x17059
+			MX6QDL_PAD_SD3_CMD__SD3_CMD		0x17059
+			MX6QDL_PAD_SD3_CLK__SD3_CLK		0x10059
+			MX6QDL_PAD_SD3_DAT0__SD3_DATA0		0x17059
+			MX6QDL_PAD_SD3_DAT1__SD3_DATA1		0x17059
+			MX6QDL_PAD_SD3_DAT2__SD3_DATA2		0x17059
+			MX6QDL_PAD_SD3_DAT3__SD3_DATA3		0x17059
+			MX6QDL_PAD_SD3_DAT4__SD3_DATA4		0x17059
+			MX6QDL_PAD_SD3_DAT5__SD3_DATA5		0x17059
+			MX6QDL_PAD_SD3_DAT6__SD3_DATA6		0x17059
+			MX6QDL_PAD_SD3_DAT7__SD3_DATA7		0x17059
 		>;
 	};
 
 	pinctrl_usdhc3_reset: usdhc3grp-reset {
 		fsl,pins = <
-			MX6QDL_PAD_SD3_RST__SD3_RESET   0x170F9
+			MX6QDL_PAD_SD3_RST__SD3_RESET		0x170F9
 		>;
 	};
 
 	pinctrl_usdhc4: usdhc4grp {
 		fsl,pins = <
-			MX6QDL_PAD_SD4_CMD__SD4_CMD	0x17059
-			MX6QDL_PAD_SD4_CLK__SD4_CLK	0x17059
-			MX6QDL_PAD_SD4_DAT0__SD4_DATA0	0x17059
-			MX6QDL_PAD_SD4_DAT1__SD4_DATA1	0x17059
-			MX6QDL_PAD_SD4_DAT2__SD4_DATA2	0x17059
-			MX6QDL_PAD_SD4_DAT3__SD4_DATA3	0x17059
-			MX6QDL_PAD_SD4_DAT4__SD4_DATA4	0x17059
-			MX6QDL_PAD_SD4_DAT5__SD4_DATA5	0x17059
-			MX6QDL_PAD_SD4_DAT6__SD4_DATA6	0x17059
-			MX6QDL_PAD_SD4_DAT7__SD4_DATA7	0x17059
+			MX6QDL_PAD_SD4_CMD__SD4_CMD		0x17059
+			MX6QDL_PAD_SD4_CLK__SD4_CLK		0x17059
+			MX6QDL_PAD_SD4_DAT0__SD4_DATA0		0x17059
+			MX6QDL_PAD_SD4_DAT1__SD4_DATA1		0x17059
+			MX6QDL_PAD_SD4_DAT2__SD4_DATA2		0x17059
+			MX6QDL_PAD_SD4_DAT3__SD4_DATA3		0x17059
+			MX6QDL_PAD_SD4_DAT4__SD4_DATA4		0x17059
+			MX6QDL_PAD_SD4_DAT5__SD4_DATA5		0x17059
+			MX6QDL_PAD_SD4_DAT6__SD4_DATA6		0x17059
+			MX6QDL_PAD_SD4_DAT7__SD4_DATA7		0x17059
 			/* uSDHC4 CD */
-			MX6QDL_PAD_NANDF_CS0__GPIO6_IO11 0x1b0b0
+			MX6QDL_PAD_NANDF_CS0__GPIO6_IO11	0x1b0b0
 			/* uSDHC4 SDIO PWR */
-			MX6QDL_PAD_NANDF_CS1__GPIO6_IO14 0x1b0b0
+			MX6QDL_PAD_NANDF_CS1__GPIO6_IO14	0x1b0b0
 			/* uSDHC4 SDIO WP */
-			MX6QDL_PAD_NANDF_CS2__GPIO6_IO15 0x1b0b0
+			MX6QDL_PAD_NANDF_CS2__GPIO6_IO15	0x1b0b0
 			/* uSDHC4 SDIO LED */
-			MX6QDL_PAD_NANDF_CS3__GPIO6_IO16 0x1b0b0
+			MX6QDL_PAD_NANDF_CS3__GPIO6_IO16	0x1b0b0
 		>;
 	};
 
 	pinctrl_wdog: wdoggrp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_9__WDOG1_B	0x1b0b0
+			MX6QDL_PAD_GPIO_9__WDOG1_B		0x1b0b0
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6q-bx50v3.dtsi b/arch/arm/boot/dts/imx6q-bx50v3.dtsi
index fa27dcd..fce203a 100644
--- a/arch/arm/boot/dts/imx6q-bx50v3.dtsi
+++ b/arch/arm/boot/dts/imx6q-bx50v3.dtsi
@@ -321,15 +321,15 @@
 
 	pinctrl_i2c2_gpio: i2c2gpiogrp {
 		fsl,pins = <
-			MX6QDL_PAD_KEY_COL3__GPIO4_IO12	0x1b0b0
-			MX6QDL_PAD_KEY_ROW3__GPIO4_IO13	0x1b0b0
+			MX6QDL_PAD_KEY_COL3__GPIO4_IO12		0x1b0b0
+			MX6QDL_PAD_KEY_ROW3__GPIO4_IO13		0x1b0b0
 		>;
 	};
 
 	pinctrl_i2c3_gpio: i2c3gpiogrp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_3__GPIO1_IO03	0x1b0b0
-			MX6QDL_PAD_GPIO_6__GPIO1_IO06	0x1b0b0
+			MX6QDL_PAD_GPIO_3__GPIO1_IO03		0x1b0b0
+			MX6QDL_PAD_GPIO_6__GPIO1_IO06		0x1b0b0
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6q-cm-fx6.dts b/arch/arm/boot/dts/imx6q-cm-fx6.dts
index cab9e92..59e05d8 100644
--- a/arch/arm/boot/dts/imx6q-cm-fx6.dts
+++ b/arch/arm/boot/dts/imx6q-cm-fx6.dts
@@ -304,21 +304,21 @@
 &iomuxc {
 	pinctrl_audmux: audmuxgrp {
 		fsl,pins = <
-			MX6QDL_PAD_SD2_CMD__AUD4_RXC   0x17059
-			MX6QDL_PAD_SD2_DAT0__AUD4_RXD  0x17059
-			MX6QDL_PAD_SD2_DAT3__AUD4_TXC  0x17059
-			MX6QDL_PAD_SD2_DAT2__AUD4_TXD  0x17059
-			MX6QDL_PAD_SD2_DAT1__AUD4_TXFS 0x17059
+			MX6QDL_PAD_SD2_CMD__AUD4_RXC		0x17059
+			MX6QDL_PAD_SD2_DAT0__AUD4_RXD		0x17059
+			MX6QDL_PAD_SD2_DAT3__AUD4_TXC		0x17059
+			MX6QDL_PAD_SD2_DAT2__AUD4_TXD		0x17059
+			MX6QDL_PAD_SD2_DAT1__AUD4_TXFS		0x17059
 		>;
 	};
 
 	pinctrl_ecspi1: ecspi1grp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_D16__ECSPI1_SCLK	0x100b1
-			MX6QDL_PAD_EIM_D17__ECSPI1_MISO	0x100b1
-			MX6QDL_PAD_EIM_D18__ECSPI1_MOSI	0x100b1
-			MX6QDL_PAD_EIM_EB2__GPIO2_IO30	0x100b1
-			MX6QDL_PAD_EIM_D19__GPIO3_IO19	0x100b1
+			MX6QDL_PAD_EIM_D16__ECSPI1_SCLK		0x100b1
+			MX6QDL_PAD_EIM_D17__ECSPI1_MISO		0x100b1
+			MX6QDL_PAD_EIM_D18__ECSPI1_MOSI		0x100b1
+			MX6QDL_PAD_EIM_EB2__GPIO2_IO30		0x100b1
+			MX6QDL_PAD_EIM_D19__GPIO3_IO19		0x100b1
 		>;
 	};
 
@@ -366,15 +366,15 @@
 
 	pinctrl_i2c3: i2c3grp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_3__I2C3_SCL	0x4001b8b1
-			MX6QDL_PAD_GPIO_6__I2C3_SDA	0x4001b8b1
+			MX6QDL_PAD_GPIO_3__I2C3_SCL		0x4001b8b1
+			MX6QDL_PAD_GPIO_6__I2C3_SDA		0x4001b8b1
 		>;
 	};
 
 	pinctrl_pcie: pciegrp {
 		fsl,pins = <
 			MX6QDL_PAD_ENET_RXD1__GPIO1_IO26	0x1b0b1
-			MX6QDL_PAD_EIM_CS1__GPIO2_IO24	0x1b0b1
+			MX6QDL_PAD_EIM_CS1__GPIO2_IO24		0x1b0b1
 		>;
 	};
 
@@ -387,8 +387,8 @@
 
 	pinctrl_spdif: spdifgrp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_16__SPDIF_IN  0x1b0b0
-			MX6QDL_PAD_GPIO_19__SPDIF_OUT 0x1b0b0
+			MX6QDL_PAD_GPIO_16__SPDIF_IN		0x1b0b0
+			MX6QDL_PAD_GPIO_19__SPDIF_OUT		0x1b0b0
 		>;
 	};
 
@@ -401,25 +401,25 @@
 
 	pinctrl_usbh1: usbh1grp {
 		fsl,pins = <
-			MX6QDL_PAD_SD3_RST__GPIO7_IO08	0x1b0b1
+			MX6QDL_PAD_SD3_RST__GPIO7_IO08		0x1b0b1
 		>;
 	};
 
 	pinctrl_usbotg: usbotggrp {
 		fsl,pins = <
 			MX6QDL_PAD_ENET_RX_ER__USB_OTG_ID	0x17059
-			MX6QDL_PAD_EIM_D22__GPIO3_IO22	0x130b0
+			MX6QDL_PAD_EIM_D22__GPIO3_IO22		0x130b0
 		>;
 	};
 
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
-			MX6QDL_PAD_SD1_CMD__SD1_CMD	0x17071
-			MX6QDL_PAD_SD1_CLK__SD1_CLK	0x10071
-			MX6QDL_PAD_SD1_DAT0__SD1_DATA0	0x17071
-			MX6QDL_PAD_SD1_DAT1__SD1_DATA1	0x17071
-			MX6QDL_PAD_SD1_DAT2__SD1_DATA2	0x17071
-			MX6QDL_PAD_SD1_DAT3__SD1_DATA3	0x17071
+			MX6QDL_PAD_SD1_CMD__SD1_CMD		0x17071
+			MX6QDL_PAD_SD1_CLK__SD1_CLK		0x10071
+			MX6QDL_PAD_SD1_DAT0__SD1_DATA0		0x17071
+			MX6QDL_PAD_SD1_DAT1__SD1_DATA1		0x17071
+			MX6QDL_PAD_SD1_DAT2__SD1_DATA2		0x17071
+			MX6QDL_PAD_SD1_DAT3__SD1_DATA3		0x17071
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6q-display5.dtsi b/arch/arm/boot/dts/imx6q-display5.dtsi
index 83524bb..32598aa 100644
--- a/arch/arm/boot/dts/imx6q-display5.dtsi
+++ b/arch/arm/boot/dts/imx6q-display5.dtsi
@@ -440,17 +440,17 @@
 	pinctrl_audmux: audmuxgrp {
 		fsl,pins = <
 			/* I2S OUTPUT AUD6*/
-			MX6QDL_PAD_DI0_PIN4__AUD6_RXD  0x130b0
-			MX6QDL_PAD_DI0_PIN2__AUD6_TXD  0x130b0
-			MX6QDL_PAD_DI0_PIN3__AUD6_TXFS  0x130b0
-			MX6QDL_PAD_DI0_PIN15__AUD6_TXC  0x130b0
+			MX6QDL_PAD_DI0_PIN4__AUD6_RXD		0x130b0
+			MX6QDL_PAD_DI0_PIN2__AUD6_TXD		0x130b0
+			MX6QDL_PAD_DI0_PIN3__AUD6_TXFS		0x130b0
+			MX6QDL_PAD_DI0_PIN15__AUD6_TXC		0x130b0
 		>;
 	};
 
 	pinctrl_backlight: dispgrp {
 		fsl,pins = <
 			/* BLEN_OUT */
-			MX6QDL_PAD_DISP0_DAT13__GPIO5_IO07    0x1b0b0
+			MX6QDL_PAD_DISP0_DAT13__GPIO5_IO07	0x1b0b0
 		>;
 	};
 
@@ -464,13 +464,13 @@
 
 	pinctrl_ecspi2_cs: ecspi2csgrp {
 		fsl,pins = <
-			MX6QDL_PAD_CSI0_DAT11__GPIO5_IO29 0x100b1
+			MX6QDL_PAD_CSI0_DAT11__GPIO5_IO29	0x100b1
 		>;
 	};
 
 	pinctrl_ecspi2_flwp: ecspi2flwpgrp {
 		fsl,pins = <
-			MX6QDL_PAD_SD3_DAT5__GPIO7_IO00 0x1b0b0
+			MX6QDL_PAD_SD3_DAT5__GPIO7_IO00		0x1b0b0
 		>;
 	};
 
@@ -484,13 +484,13 @@
 
 	pinctrl_ecspi3_cs: ecspi3csgrp {
 		fsl,pins = <
-			MX6QDL_PAD_DISP0_DAT3__GPIO4_IO24 0x1b0b0
+			MX6QDL_PAD_DISP0_DAT3__GPIO4_IO24	0x1b0b0
 		>;
 	};
 
 	pinctrl_ecspi3_flwp: ecspi3flwpgrp {
 		fsl,pins = <
-			MX6QDL_PAD_DISP0_DAT6__GPIO4_IO27 0x1b0b0
+			MX6QDL_PAD_DISP0_DAT6__GPIO4_IO27	0x1b0b0
 		>;
 	};
 
@@ -511,7 +511,7 @@
 			MX6QDL_PAD_RGMII_RD2__RGMII_RD2		0x1b0b0
 			MX6QDL_PAD_RGMII_RD3__RGMII_RD3		0x1b0b0
 			MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL	0x1b0b0
-			MX6QDL_PAD_GPIO_16__ENET_REF_CLK 0x4001b0a8
+			MX6QDL_PAD_GPIO_16__ENET_REF_CLK	0x4001b0a8
 			MX6QDL_PAD_GPIO_6__ENET_IRQ		0x000b1
 			MX6QDL_PAD_ENET_RXD0__GPIO1_IO27        0x1b0b0
 		>;
@@ -519,35 +519,35 @@
 
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_D21__I2C1_SCL	0x4001b8b1
-			MX6QDL_PAD_EIM_D28__I2C1_SDA	0x4001b8b1
+			MX6QDL_PAD_EIM_D21__I2C1_SCL		0x4001b8b1
+			MX6QDL_PAD_EIM_D28__I2C1_SDA		0x4001b8b1
 		>;
 	};
 
 	pinctrl_i2c2: i2c2grp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_EB2__I2C2_SCL	0x4001b8b1
-			MX6QDL_PAD_EIM_D16__I2C2_SDA	0x4001b8b1
+			MX6QDL_PAD_EIM_EB2__I2C2_SCL		0x4001b8b1
+			MX6QDL_PAD_EIM_D16__I2C2_SDA		0x4001b8b1
 		>;
 	};
 
 	pinctrl_i2c3: i2c3grp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_D17__I2C3_SCL	0x4001b8b1
-			MX6QDL_PAD_EIM_D18__I2C3_SDA	0x4001b8b1
+			MX6QDL_PAD_EIM_D17__I2C3_SCL		0x4001b8b1
+			MX6QDL_PAD_EIM_D18__I2C3_SDA		0x4001b8b1
 		>;
 	};
 
 	pinctrl_pwm2: pwm2grp {
 		fsl,pins = <
-			MX6QDL_PAD_DISP0_DAT9__PWM2_OUT	0x1b0b1
+			MX6QDL_PAD_DISP0_DAT9__PWM2_OUT		0x1b0b1
 		>;
 	};
 
 	pinctrl_reg_lvds: reqlvdsgrp {
 		fsl,pins = <
 			/* LVDS_PPEN_OUT */
-			MX6QDL_PAD_DISP0_DAT19__GPIO5_IO13      0x1b0b0
+			MX6QDL_PAD_DISP0_DAT19__GPIO5_IO13	0x1b0b0
 		>;
 	};
 
@@ -563,19 +563,19 @@
 	pinctrl_uart5: uart5grp {
 		fsl,pins = <
 			MX6QDL_PAD_CSI0_DAT14__UART5_TX_DATA	0x1b0b1
-			MX6QDL_PAD_CSI0_DAT15__UART5_RX_DATA    0x1b0b1
+			MX6QDL_PAD_CSI0_DAT15__UART5_RX_DATA	0x1b0b1
 		>;
 	};
 
 	pinctrl_usbh1: usbh1grp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_D30__USB_H1_OC  0x030b0
+			MX6QDL_PAD_EIM_D30__USB_H1_OC		0x030b0
 		>;
 	};
 
 	pinctrl_usbh1_vbus: usbh1_vbus_grp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_D31__GPIO3_IO31 0x1b0b0
+			MX6QDL_PAD_EIM_D31__GPIO3_IO31		0x1b0b0
 		>;
 	};
 
@@ -591,7 +591,7 @@
 			MX6QDL_PAD_SD4_DAT5__SD4_DATA5		0x17059
 			MX6QDL_PAD_SD4_DAT6__SD4_DATA6		0x17059
 			MX6QDL_PAD_SD4_DAT7__SD4_DATA7		0x17059
-			MX6QDL_PAD_NANDF_ALE__SD4_RESET	0x17059
+			MX6QDL_PAD_NANDF_ALE__SD4_RESET		0x17059
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
index ee8c38e..9b08c10 100644
--- a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
+++ b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
@@ -301,8 +301,8 @@
 	imx6q-dmo-edmqmx6 {
 		pinctrl_hog: hoggrp {
 			fsl,pins = <
-				MX6QDL_PAD_EIM_A16__GPIO2_IO22 0x80000000
-				MX6QDL_PAD_EIM_A17__GPIO2_IO21 0x80000000
+				MX6QDL_PAD_EIM_A16__GPIO2_IO22		0x80000000
+				MX6QDL_PAD_EIM_A17__GPIO2_IO21		0x80000000
 			>;
 		};
 
@@ -378,11 +378,11 @@
 		};
 
 		pinctrl_stmpe1: stmpe1grp {
-			fsl,pins = <MX6QDL_PAD_EIM_D30__GPIO3_IO30 0x80000000>;
+			fsl,pins = <MX6QDL_PAD_EIM_D30__GPIO3_IO30	0x80000000>;
 		};
 
 		pinctrl_stmpe2: stmpe2grp {
-			fsl,pins = <MX6QDL_PAD_EIM_A25__GPIO5_IO02 0x80000000>;
+			fsl,pins = <MX6QDL_PAD_EIM_A25__GPIO5_IO02	0x80000000>;
 		};
 
 		pinctrl_uart1: uart1grp {
diff --git a/arch/arm/boot/dts/imx6q-dms-ba16.dts b/arch/arm/boot/dts/imx6q-dms-ba16.dts
index 57761f3..bef7a4b 100644
--- a/arch/arm/boot/dts/imx6q-dms-ba16.dts
+++ b/arch/arm/boot/dts/imx6q-dms-ba16.dts
@@ -60,29 +60,29 @@
 &iomuxc {
 	pinctrl_i2c1_gpio: i2c1gpiogrp {
 		fsl,pins = <
-			MX6QDL_PAD_CSI0_DAT8__GPIO5_IO26        0x1b0b0
-			MX6QDL_PAD_CSI0_DAT9__GPIO5_IO27        0x1b0b0
+			MX6QDL_PAD_CSI0_DAT8__GPIO5_IO26	0x1b0b0
+			MX6QDL_PAD_CSI0_DAT9__GPIO5_IO27	0x1b0b0
 		>;
 	};
 
 	pinctrl_i2c2_gpio: i2c2gpiogrp {
 		fsl,pins = <
-			MX6QDL_PAD_KEY_COL3__GPIO4_IO12 0x1b0b0
-			MX6QDL_PAD_KEY_ROW3__GPIO4_IO13 0x1b0b0
+			MX6QDL_PAD_KEY_COL3__GPIO4_IO12		0x1b0b0
+			MX6QDL_PAD_KEY_ROW3__GPIO4_IO13		0x1b0b0
 		>;
 	};
 
 	pinctrl_i2c3_gpio: i2c3gpiogrp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_3__GPIO1_IO03   0x1b0b0
-			MX6QDL_PAD_GPIO_6__GPIO1_IO06   0x1b0b0
+			MX6QDL_PAD_GPIO_3__GPIO1_IO03		0x1b0b0
+			MX6QDL_PAD_GPIO_6__GPIO1_IO06		0x1b0b0
 		>;
 	};
 
 	pinctrl_usbotgvbus: usbotgvbusgrp {
 		fsl,pins = <
-			MX6QDL_PAD_ENET_RX_ER__USB_OTG_ID 0x17059
-			MX6QDL_PAD_KEY_ROW4__GPIO4_IO15 0x000b0
+			MX6QDL_PAD_ENET_RX_ER__USB_OTG_ID	0x17059
+			MX6QDL_PAD_KEY_ROW4__GPIO4_IO15		0x000b0
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6q-evi.dts b/arch/arm/boot/dts/imx6q-evi.dts
index c63f371..5598048 100644
--- a/arch/arm/boot/dts/imx6q-evi.dts
+++ b/arch/arm/boot/dts/imx6q-evi.dts
@@ -252,266 +252,266 @@
 	pinctrl_hog: hoggrp {
 		fsl,pins = <
 			/* pwr mcu alert irq */
-			MX6QDL_PAD_SD4_DAT2__GPIO2_IO10 0x1b0b0
+			MX6QDL_PAD_SD4_DAT2__GPIO2_IO10		0x1b0b0
 			/* remainder ???? */
-			MX6QDL_PAD_CSI0_MCLK__GPIO5_IO19 0x1b0b0
+			MX6QDL_PAD_CSI0_MCLK__GPIO5_IO19	0x1b0b0
 		>;
 	};
 
 	pinctrl_ecspi1: ecspi1grp {
 		fsl,pins = <
-			MX6QDL_PAD_KEY_COL1__ECSPI1_MISO 0x100b1
-			MX6QDL_PAD_KEY_ROW0__ECSPI1_MOSI 0x100b1
-			MX6QDL_PAD_KEY_COL0__ECSPI1_SCLK 0x100b1
+			MX6QDL_PAD_KEY_COL1__ECSPI1_MISO	0x100b1
+			MX6QDL_PAD_KEY_ROW0__ECSPI1_MOSI	0x100b1
+			MX6QDL_PAD_KEY_COL0__ECSPI1_SCLK	0x100b1
 		>;
 	};
 
 	pinctrl_ecspi1cs: ecspi1csgrp {
 		fsl,pins = <
-			MX6QDL_PAD_KEY_COL2__GPIO4_IO10 0x1b0b0
+			MX6QDL_PAD_KEY_COL2__GPIO4_IO10		0x1b0b0
 		>;
 	};
 
 	pinctrl_ecspi3: ecspi3grp {
 		fsl,pins = <
-			MX6QDL_PAD_DISP0_DAT0__ECSPI3_SCLK 0x10068
-			MX6QDL_PAD_DISP0_DAT1__ECSPI3_MOSI 0x10068
-			MX6QDL_PAD_DISP0_DAT2__ECSPI3_MISO 0x1f068
+			MX6QDL_PAD_DISP0_DAT0__ECSPI3_SCLK	0x10068
+			MX6QDL_PAD_DISP0_DAT1__ECSPI3_MOSI	0x10068
+			MX6QDL_PAD_DISP0_DAT2__ECSPI3_MISO	0x1f068
 		>;
 	};
 
 	pinctrl_ecspi3cs: ecspi3csgrp {
 		fsl,pins = <
-			MX6QDL_PAD_DISP0_DAT3__GPIO4_IO24 0x1b0b0
-			MX6QDL_PAD_DISP0_DAT4__GPIO4_IO25 0x1b0b0
-			MX6QDL_PAD_DISP0_DAT5__GPIO4_IO26 0x1b0b0
-			MX6QDL_PAD_DISP0_DAT6__GPIO4_IO27 0x1b0b0
+			MX6QDL_PAD_DISP0_DAT3__GPIO4_IO24	0x1b0b0
+			MX6QDL_PAD_DISP0_DAT4__GPIO4_IO25	0x1b0b0
+			MX6QDL_PAD_DISP0_DAT5__GPIO4_IO26	0x1b0b0
+			MX6QDL_PAD_DISP0_DAT6__GPIO4_IO27	0x1b0b0
 		>;
 	};
 
 	pinctrl_ecspi5: ecspi5grp {
 		fsl,pins = <
-			MX6QDL_PAD_SD2_CLK__ECSPI5_SCLK 0x100b1
-			MX6QDL_PAD_SD2_CMD__ECSPI5_MOSI 0x100b1
-			MX6QDL_PAD_SD2_DAT0__ECSPI5_MISO 0x100b1
+			MX6QDL_PAD_SD2_CLK__ECSPI5_SCLK		0x100b1
+			MX6QDL_PAD_SD2_CMD__ECSPI5_MOSI		0x100b1
+			MX6QDL_PAD_SD2_DAT0__ECSPI5_MISO	0x100b1
 		>;
 	};
 
 	pinctrl_ecspi5cs: ecspi5csgrp {
 		fsl,pins = <
-			MX6QDL_PAD_SD2_DAT1__GPIO1_IO14 0x1b0b0
-			MX6QDL_PAD_SD2_DAT2__GPIO1_IO13 0x1b0b0
-			MX6QDL_PAD_SD2_DAT3__GPIO1_IO12 0x1b0b0
-			MX6QDL_PAD_SD4_DAT1__GPIO2_IO09 0x1b0b0
+			MX6QDL_PAD_SD2_DAT1__GPIO1_IO14		0x1b0b0
+			MX6QDL_PAD_SD2_DAT2__GPIO1_IO13		0x1b0b0
+			MX6QDL_PAD_SD2_DAT3__GPIO1_IO12		0x1b0b0
+			MX6QDL_PAD_SD4_DAT1__GPIO2_IO09		0x1b0b0
 		>;
 	};
 
 	pinctrl_enet: enetgrp {
 		fsl,pins = <
-			MX6QDL_PAD_ENET_MDIO__ENET_MDIO 0x1b0b0
-			MX6QDL_PAD_ENET_MDC__ENET_MDC 0x1b0b0
-			MX6QDL_PAD_RGMII_TXC__RGMII_TXC 0x1b030
-			MX6QDL_PAD_RGMII_TD0__RGMII_TD0 0x1b030
-			MX6QDL_PAD_RGMII_TD1__RGMII_TD1 0x1b030
-			MX6QDL_PAD_RGMII_TD2__RGMII_TD2 0x1b030
-			MX6QDL_PAD_RGMII_TD3__RGMII_TD3 0x1b030
-			MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL 0x1b030
-			MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK 0x1b0b0
-			MX6QDL_PAD_RGMII_RXC__RGMII_RXC 0x1b030
-			MX6QDL_PAD_RGMII_RD0__RGMII_RD0 0x1b030
-			MX6QDL_PAD_RGMII_RD1__RGMII_RD1 0x1b030
-			MX6QDL_PAD_RGMII_RD2__RGMII_RD2 0x1b030
-			MX6QDL_PAD_RGMII_RD3__RGMII_RD3 0x1b030
-			MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL 0x1b030
-			MX6QDL_PAD_ENET_TX_EN__ENET_TX_EN 0x4001b0a8
-			MX6QDL_PAD_ENET_CRS_DV__GPIO1_IO25 0x1b0b0
-			MX6QDL_PAD_GPIO_6__ENET_IRQ 0x000b1
+			MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x1b0b0
+			MX6QDL_PAD_ENET_MDC__ENET_MDC		0x1b0b0
+			MX6QDL_PAD_RGMII_TXC__RGMII_TXC		0x1b030
+			MX6QDL_PAD_RGMII_TD0__RGMII_TD0		0x1b030
+			MX6QDL_PAD_RGMII_TD1__RGMII_TD1		0x1b030
+			MX6QDL_PAD_RGMII_TD2__RGMII_TD2		0x1b030
+			MX6QDL_PAD_RGMII_TD3__RGMII_TD3		0x1b030
+			MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL	0x1b030
+			MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK	0x1b0b0
+			MX6QDL_PAD_RGMII_RXC__RGMII_RXC		0x1b030
+			MX6QDL_PAD_RGMII_RD0__RGMII_RD0		0x1b030
+			MX6QDL_PAD_RGMII_RD1__RGMII_RD1		0x1b030
+			MX6QDL_PAD_RGMII_RD2__RGMII_RD2		0x1b030
+			MX6QDL_PAD_RGMII_RD3__RGMII_RD3		0x1b030
+			MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL	0x1b030
+			MX6QDL_PAD_ENET_TX_EN__ENET_TX_EN	0x4001b0a8
+			MX6QDL_PAD_ENET_CRS_DV__GPIO1_IO25	0x1b0b0
+			MX6QDL_PAD_GPIO_6__ENET_IRQ	0x000b1
 		>;
 	};
 
 	pinctrl_fpgaspi: fpgaspigrp {
 		fsl,pins = <
-			MX6QDL_PAD_KEY_ROW1__GPIO4_IO09 0x1b0b0
-			MX6QDL_PAD_KEY_ROW2__GPIO4_IO11 0x1b0b0
+			MX6QDL_PAD_KEY_ROW1__GPIO4_IO09		0x1b0b0
+			MX6QDL_PAD_KEY_ROW2__GPIO4_IO11		0x1b0b0
 		>;
 	};
 
 	pinctrl_gpminand: gpminandgrp {
 		fsl,pins = <
-			MX6QDL_PAD_NANDF_CLE__NAND_CLE 0xb0b1
-			MX6QDL_PAD_NANDF_ALE__NAND_ALE 0xb0b1
-			MX6QDL_PAD_NANDF_WP_B__NAND_WP_B 0xb0b1
-			MX6QDL_PAD_NANDF_RB0__NAND_READY_B 0xb000
-			MX6QDL_PAD_NANDF_CS0__NAND_CE0_B 0xb0b1
-			MX6QDL_PAD_NANDF_CS1__NAND_CE1_B 0xb0b1
-			MX6QDL_PAD_SD4_CMD__NAND_RE_B 0xb0b1
-			MX6QDL_PAD_SD4_CLK__NAND_WE_B 0xb0b1
-			MX6QDL_PAD_NANDF_D0__NAND_DATA00 0xb0b1
-			MX6QDL_PAD_NANDF_D1__NAND_DATA01 0xb0b1
-			MX6QDL_PAD_NANDF_D2__NAND_DATA02 0xb0b1
-			MX6QDL_PAD_NANDF_D3__NAND_DATA03 0xb0b1
-			MX6QDL_PAD_NANDF_D4__NAND_DATA04 0xb0b1
-			MX6QDL_PAD_NANDF_D5__NAND_DATA05 0xb0b1
-			MX6QDL_PAD_NANDF_D6__NAND_DATA06 0xb0b1
-			MX6QDL_PAD_NANDF_D7__NAND_DATA07 0xb0b1
-			MX6QDL_PAD_SD4_DAT0__NAND_DQS 0x00b1
+			MX6QDL_PAD_NANDF_CLE__NAND_CLE		0xb0b1
+			MX6QDL_PAD_NANDF_ALE__NAND_ALE		0xb0b1
+			MX6QDL_PAD_NANDF_WP_B__NAND_WP_B	0xb0b1
+			MX6QDL_PAD_NANDF_RB0__NAND_READY_B	0xb000
+			MX6QDL_PAD_NANDF_CS0__NAND_CE0_B	0xb0b1
+			MX6QDL_PAD_NANDF_CS1__NAND_CE1_B	0xb0b1
+			MX6QDL_PAD_SD4_CMD__NAND_RE_B		0xb0b1
+			MX6QDL_PAD_SD4_CLK__NAND_WE_B		0xb0b1
+			MX6QDL_PAD_NANDF_D0__NAND_DATA00	0xb0b1
+			MX6QDL_PAD_NANDF_D1__NAND_DATA01	0xb0b1
+			MX6QDL_PAD_NANDF_D2__NAND_DATA02	0xb0b1
+			MX6QDL_PAD_NANDF_D3__NAND_DATA03	0xb0b1
+			MX6QDL_PAD_NANDF_D4__NAND_DATA04	0xb0b1
+			MX6QDL_PAD_NANDF_D5__NAND_DATA05	0xb0b1
+			MX6QDL_PAD_NANDF_D6__NAND_DATA06	0xb0b1
+			MX6QDL_PAD_NANDF_D7__NAND_DATA07	0xb0b1
+			MX6QDL_PAD_SD4_DAT0__NAND_DQS		0x00b1
 		>;
 	};
 
 	pinctrl_i2c2: i2c2grp {
 		fsl,pins = <
-			MX6QDL_PAD_KEY_ROW3__I2C2_SDA 0x4001b8b1
-			MX6QDL_PAD_KEY_COL3__I2C2_SCL 0x4001b8b1
+			MX6QDL_PAD_KEY_ROW3__I2C2_SDA		0x4001b8b1
+			MX6QDL_PAD_KEY_COL3__I2C2_SCL		0x4001b8b1
 		>;
 	};
 
 	pinctrl_i2c3: i2c3grp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_5__I2C3_SCL 0x4001b8b1
-			MX6QDL_PAD_GPIO_16__I2C3_SDA 0x4001b8b1
+			MX6QDL_PAD_GPIO_5__I2C3_SCL		0x4001b8b1
+			MX6QDL_PAD_GPIO_16__I2C3_SDA		0x4001b8b1
 		>;
 	};
 
 	pinctrl_i2c3_gpio: i2c3gpiogrp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_5__GPIO1_IO05 0x4001b8b1
-			MX6QDL_PAD_GPIO_16__GPIO7_IO11 0x4001b8b1
+			MX6QDL_PAD_GPIO_5__GPIO1_IO05		0x4001b8b1
+			MX6QDL_PAD_GPIO_16__GPIO7_IO11		0x4001b8b1
 		>;
 	};
 
 	pinctrl_weimcs: weimcsgrp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_CS0__EIM_CS0_B 0xb0b1
-			MX6QDL_PAD_EIM_CS1__EIM_CS1_B 0xb0b1
+			MX6QDL_PAD_EIM_CS0__EIM_CS0_B		0xb0b1
+			MX6QDL_PAD_EIM_CS1__EIM_CS1_B		0xb0b1
 		>;
 	};
 
 	pinctrl_weimfpga: weimfpgagrp {
 		fsl,pins = <
 			/* weim misc */
-			MX6QDL_PAD_EIM_OE__EIM_OE_B 0xb0b1
-			MX6QDL_PAD_EIM_RW__EIM_RW 0xb0b1
-			MX6QDL_PAD_EIM_WAIT__EIM_WAIT_B 0xb060
-			MX6QDL_PAD_EIM_BCLK__EIM_BCLK 0xb0b1
-			MX6QDL_PAD_EIM_LBA__EIM_LBA_B 0xb0b1
-			MX6QDL_PAD_EIM_EB0__EIM_EB0_B 0xb0b1
-			MX6QDL_PAD_EIM_EB1__EIM_EB1_B 0xb0b1
-			MX6QDL_PAD_EIM_EB2__EIM_EB2_B 0xb0b1
-			MX6QDL_PAD_EIM_EB3__EIM_EB3_B 0xb0b1
+			MX6QDL_PAD_EIM_OE__EIM_OE_B		0xb0b1
+			MX6QDL_PAD_EIM_RW__EIM_RW		0xb0b1
+			MX6QDL_PAD_EIM_WAIT__EIM_WAIT_B		0xb060
+			MX6QDL_PAD_EIM_BCLK__EIM_BCLK		0xb0b1
+			MX6QDL_PAD_EIM_LBA__EIM_LBA_B		0xb0b1
+			MX6QDL_PAD_EIM_EB0__EIM_EB0_B		0xb0b1
+			MX6QDL_PAD_EIM_EB1__EIM_EB1_B		0xb0b1
+			MX6QDL_PAD_EIM_EB2__EIM_EB2_B		0xb0b1
+			MX6QDL_PAD_EIM_EB3__EIM_EB3_B		0xb0b1
 			/* weim data */
-			MX6QDL_PAD_CSI0_DATA_EN__EIM_DATA00 0x1b0b0
-			MX6QDL_PAD_CSI0_VSYNC__EIM_DATA01 0x1b0b0
-			MX6QDL_PAD_CSI0_DAT4__EIM_DATA02 0x1b0b0
-			MX6QDL_PAD_CSI0_DAT5__EIM_DATA03 0x1b0b0
-			MX6QDL_PAD_CSI0_DAT6__EIM_DATA04 0x1b0b0
-			MX6QDL_PAD_CSI0_DAT7__EIM_DATA05 0x1b0b0
-			MX6QDL_PAD_CSI0_DAT8__EIM_DATA06 0x1b0b0
-			MX6QDL_PAD_CSI0_DAT9__EIM_DATA07 0x1b0b0
-			MX6QDL_PAD_CSI0_DAT12__EIM_DATA08 0x1b0b0
-			MX6QDL_PAD_CSI0_DAT13__EIM_DATA09 0x1b0b0
-			MX6QDL_PAD_CSI0_DAT14__EIM_DATA10 0x1b0b0
-			MX6QDL_PAD_CSI0_DAT15__EIM_DATA11 0x1b0b0
-			MX6QDL_PAD_CSI0_DAT16__EIM_DATA12 0x1b0b0
-			MX6QDL_PAD_CSI0_DAT17__EIM_DATA13 0x1b0b0
-			MX6QDL_PAD_CSI0_DAT18__EIM_DATA14 0x1b0b0
-			MX6QDL_PAD_CSI0_DAT19__EIM_DATA15 0x1b0b0
-			MX6QDL_PAD_EIM_D16__EIM_DATA16 0x1b0b0
-			MX6QDL_PAD_EIM_D17__EIM_DATA17 0x1b0b0
-			MX6QDL_PAD_EIM_D18__EIM_DATA18 0x1b0b0
-			MX6QDL_PAD_EIM_D19__EIM_DATA19 0x1b0b0
-			MX6QDL_PAD_EIM_D20__EIM_DATA20 0x1b0b0
-			MX6QDL_PAD_EIM_D21__EIM_DATA21 0x1b0b0
-			MX6QDL_PAD_EIM_D22__EIM_DATA22 0x1b0b0
-			MX6QDL_PAD_EIM_D23__EIM_DATA23 0x1b0b0
-			MX6QDL_PAD_EIM_D24__EIM_DATA24 0x1b0b0
-			MX6QDL_PAD_EIM_D25__EIM_DATA25 0x1b0b0
-			MX6QDL_PAD_EIM_D26__EIM_DATA26 0x1b0b0
-			MX6QDL_PAD_EIM_D27__EIM_DATA27 0x1b0b0
-			MX6QDL_PAD_EIM_D28__EIM_DATA28 0x1b0b0
-			MX6QDL_PAD_EIM_D29__EIM_DATA29 0x1b0b0
-			MX6QDL_PAD_EIM_D30__EIM_DATA30 0x1b0b0
-			MX6QDL_PAD_EIM_D31__EIM_DATA31 0x1b0b0
+			MX6QDL_PAD_CSI0_DATA_EN__EIM_DATA00	0x1b0b0
+			MX6QDL_PAD_CSI0_VSYNC__EIM_DATA01	0x1b0b0
+			MX6QDL_PAD_CSI0_DAT4__EIM_DATA02	0x1b0b0
+			MX6QDL_PAD_CSI0_DAT5__EIM_DATA03	0x1b0b0
+			MX6QDL_PAD_CSI0_DAT6__EIM_DATA04	0x1b0b0
+			MX6QDL_PAD_CSI0_DAT7__EIM_DATA05	0x1b0b0
+			MX6QDL_PAD_CSI0_DAT8__EIM_DATA06	0x1b0b0
+			MX6QDL_PAD_CSI0_DAT9__EIM_DATA07	0x1b0b0
+			MX6QDL_PAD_CSI0_DAT12__EIM_DATA08	0x1b0b0
+			MX6QDL_PAD_CSI0_DAT13__EIM_DATA09	0x1b0b0
+			MX6QDL_PAD_CSI0_DAT14__EIM_DATA10	0x1b0b0
+			MX6QDL_PAD_CSI0_DAT15__EIM_DATA11	0x1b0b0
+			MX6QDL_PAD_CSI0_DAT16__EIM_DATA12	0x1b0b0
+			MX6QDL_PAD_CSI0_DAT17__EIM_DATA13	0x1b0b0
+			MX6QDL_PAD_CSI0_DAT18__EIM_DATA14	0x1b0b0
+			MX6QDL_PAD_CSI0_DAT19__EIM_DATA15	0x1b0b0
+			MX6QDL_PAD_EIM_D16__EIM_DATA16		0x1b0b0
+			MX6QDL_PAD_EIM_D17__EIM_DATA17		0x1b0b0
+			MX6QDL_PAD_EIM_D18__EIM_DATA18		0x1b0b0
+			MX6QDL_PAD_EIM_D19__EIM_DATA19		0x1b0b0
+			MX6QDL_PAD_EIM_D20__EIM_DATA20		0x1b0b0
+			MX6QDL_PAD_EIM_D21__EIM_DATA21		0x1b0b0
+			MX6QDL_PAD_EIM_D22__EIM_DATA22		0x1b0b0
+			MX6QDL_PAD_EIM_D23__EIM_DATA23		0x1b0b0
+			MX6QDL_PAD_EIM_D24__EIM_DATA24		0x1b0b0
+			MX6QDL_PAD_EIM_D25__EIM_DATA25		0x1b0b0
+			MX6QDL_PAD_EIM_D26__EIM_DATA26		0x1b0b0
+			MX6QDL_PAD_EIM_D27__EIM_DATA27		0x1b0b0
+			MX6QDL_PAD_EIM_D28__EIM_DATA28		0x1b0b0
+			MX6QDL_PAD_EIM_D29__EIM_DATA29		0x1b0b0
+			MX6QDL_PAD_EIM_D30__EIM_DATA30		0x1b0b0
+			MX6QDL_PAD_EIM_D31__EIM_DATA31		0x1b0b0
 			/* weim address */
-			MX6QDL_PAD_EIM_A25__EIM_ADDR25 0xb0b1
-			MX6QDL_PAD_EIM_A24__EIM_ADDR24 0xb0b1
-			MX6QDL_PAD_EIM_A23__EIM_ADDR23 0xb0b1
-			MX6QDL_PAD_EIM_A22__EIM_ADDR22 0xb0b1
-			MX6QDL_PAD_EIM_A21__EIM_ADDR21 0xb0b1
-			MX6QDL_PAD_EIM_A20__EIM_ADDR20 0xb0b1
-			MX6QDL_PAD_EIM_A19__EIM_ADDR19 0xb0b1
-			MX6QDL_PAD_EIM_A18__EIM_ADDR18 0xb0b1
-			MX6QDL_PAD_EIM_A17__EIM_ADDR17 0xb0b1
-			MX6QDL_PAD_EIM_A16__EIM_ADDR16 0xb0b1
-			MX6QDL_PAD_EIM_DA15__EIM_AD15 0xb0b1
-			MX6QDL_PAD_EIM_DA14__EIM_AD14 0xb0b1
-			MX6QDL_PAD_EIM_DA13__EIM_AD13 0xb0b1
-			MX6QDL_PAD_EIM_DA12__EIM_AD12 0xb0b1
-			MX6QDL_PAD_EIM_DA11__EIM_AD11 0xb0b1
-			MX6QDL_PAD_EIM_DA10__EIM_AD10 0xb0b1
-			MX6QDL_PAD_EIM_DA9__EIM_AD09 0xb0b1
-			MX6QDL_PAD_EIM_DA8__EIM_AD08 0xb0b1
-			MX6QDL_PAD_EIM_DA7__EIM_AD07 0xb0b1
-			MX6QDL_PAD_EIM_DA6__EIM_AD06 0xb0b1
-			MX6QDL_PAD_EIM_DA5__EIM_AD05 0xb0b1
-			MX6QDL_PAD_EIM_DA4__EIM_AD04 0xb0b1
-			MX6QDL_PAD_EIM_DA3__EIM_AD03 0xb0b1
-			MX6QDL_PAD_EIM_DA2__EIM_AD02 0xb0b1
-			MX6QDL_PAD_EIM_DA1__EIM_AD01 0xb0b1
-			MX6QDL_PAD_EIM_DA0__EIM_AD00 0xb0b1
+			MX6QDL_PAD_EIM_A25__EIM_ADDR25		0xb0b1
+			MX6QDL_PAD_EIM_A24__EIM_ADDR24		0xb0b1
+			MX6QDL_PAD_EIM_A23__EIM_ADDR23		0xb0b1
+			MX6QDL_PAD_EIM_A22__EIM_ADDR22		0xb0b1
+			MX6QDL_PAD_EIM_A21__EIM_ADDR21		0xb0b1
+			MX6QDL_PAD_EIM_A20__EIM_ADDR20		0xb0b1
+			MX6QDL_PAD_EIM_A19__EIM_ADDR19		0xb0b1
+			MX6QDL_PAD_EIM_A18__EIM_ADDR18		0xb0b1
+			MX6QDL_PAD_EIM_A17__EIM_ADDR17		0xb0b1
+			MX6QDL_PAD_EIM_A16__EIM_ADDR16		0xb0b1
+			MX6QDL_PAD_EIM_DA15__EIM_AD15		0xb0b1
+			MX6QDL_PAD_EIM_DA14__EIM_AD14		0xb0b1
+			MX6QDL_PAD_EIM_DA13__EIM_AD13		0xb0b1
+			MX6QDL_PAD_EIM_DA12__EIM_AD12		0xb0b1
+			MX6QDL_PAD_EIM_DA11__EIM_AD11		0xb0b1
+			MX6QDL_PAD_EIM_DA10__EIM_AD10		0xb0b1
+			MX6QDL_PAD_EIM_DA9__EIM_AD09		0xb0b1
+			MX6QDL_PAD_EIM_DA8__EIM_AD08		0xb0b1
+			MX6QDL_PAD_EIM_DA7__EIM_AD07		0xb0b1
+			MX6QDL_PAD_EIM_DA6__EIM_AD06		0xb0b1
+			MX6QDL_PAD_EIM_DA5__EIM_AD05		0xb0b1
+			MX6QDL_PAD_EIM_DA4__EIM_AD04		0xb0b1
+			MX6QDL_PAD_EIM_DA3__EIM_AD03		0xb0b1
+			MX6QDL_PAD_EIM_DA2__EIM_AD02		0xb0b1
+			MX6QDL_PAD_EIM_DA1__EIM_AD01		0xb0b1
+			MX6QDL_PAD_EIM_DA0__EIM_AD00		0xb0b1
 		>;
 	};
 
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
-			MX6QDL_PAD_CSI0_DAT10__UART1_TX_DATA 0x1b0b1
-			MX6QDL_PAD_CSI0_DAT11__UART1_RX_DATA 0x1b0b1
+			MX6QDL_PAD_CSI0_DAT10__UART1_TX_DATA	0x1b0b1
+			MX6QDL_PAD_CSI0_DAT11__UART1_RX_DATA	0x1b0b1
 		>;
 	};
 
 	pinctrl_uart2: uart2grp {
 		fsl,pins = <
-			MX6QDL_PAD_SD3_DAT5__UART2_TX_DATA 0x1b0b1
-			MX6QDL_PAD_SD3_DAT4__UART2_RX_DATA 0x1b0b1
-			MX6QDL_PAD_SD3_CLK__UART2_RTS_B 0x1b0b1
-			MX6QDL_PAD_SD3_CMD__UART2_CTS_B 0x1b0b1
+			MX6QDL_PAD_SD3_DAT5__UART2_TX_DATA	0x1b0b1
+			MX6QDL_PAD_SD3_DAT4__UART2_RX_DATA	0x1b0b1
+			MX6QDL_PAD_SD3_CLK__UART2_RTS_B		0x1b0b1
+			MX6QDL_PAD_SD3_CMD__UART2_CTS_B		0x1b0b1
 		>;
 	};
 
 	pinctrl_usbh1: usbh1grp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_3__USB_H1_OC 0x1b0b0
+			MX6QDL_PAD_GPIO_3__USB_H1_OC		0x1b0b0
 			/* usbh1_b OC */
-			MX6QDL_PAD_GPIO_0__GPIO1_IO00 0x1b0b0
+			MX6QDL_PAD_GPIO_0__GPIO1_IO00		0x1b0b0
 		>;
 	};
 
 	pinctrl_usbh1_hubreset: usbh1hubresetgrp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_17__GPIO7_IO12 0x1b0b0
+			MX6QDL_PAD_GPIO_17__GPIO7_IO12		0x1b0b0
 		>;
 	};
 
 	pinctrl_usbotg: usbotggrp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_1__USB_OTG_ID 0x17059
-			MX6QDL_PAD_KEY_COL4__USB_OTG_OC 0x1b0b0
+			MX6QDL_PAD_GPIO_1__USB_OTG_ID		0x17059
+			MX6QDL_PAD_KEY_COL4__USB_OTG_OC		0x1b0b0
 		>;
 	};
 
 	pinctrl_usbotgvbus: usbotgvbusgrp {
 		fsl,pins = <
-			MX6QDL_PAD_KEY_ROW4__GPIO4_IO15 0x000b0
+			MX6QDL_PAD_KEY_ROW4__GPIO4_IO15		0x000b0
 		>;
 	};
 
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
-			MX6QDL_PAD_SD1_CMD__SD1_CMD 0x17059
-			MX6QDL_PAD_SD1_CLK__SD1_CLK 0x10059
-			MX6QDL_PAD_SD1_DAT0__SD1_DATA0 0x17059
-			MX6QDL_PAD_SD1_DAT1__SD1_DATA1 0x17059
-			MX6QDL_PAD_SD1_DAT2__SD1_DATA2 0x17059
-			MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x17059
+			MX6QDL_PAD_SD1_CMD__SD1_CMD		0x17059
+			MX6QDL_PAD_SD1_CLK__SD1_CLK		0x10059
+			MX6QDL_PAD_SD1_DAT0__SD1_DATA0		0x17059
+			MX6QDL_PAD_SD1_DAT1__SD1_DATA1		0x17059
+			MX6QDL_PAD_SD1_DAT2__SD1_DATA2		0x17059
+			MX6QDL_PAD_SD1_DAT3__SD1_DATA3		0x17059
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6q-gw52xx.dts b/arch/arm/boot/dts/imx6q-gw52xx.dts
index 0b8ae00..96227d6 100644
--- a/arch/arm/boot/dts/imx6q-gw52xx.dts
+++ b/arch/arm/boot/dts/imx6q-gw52xx.dts
@@ -54,24 +54,24 @@
 &iomuxc {
 	pinctrl_adv7180: adv7180grp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_D30__GPIO3_IO30          0x0001b0b0
-			MX6QDL_PAD_EIM_D31__GPIO3_IO31          0x4001b0b0
+			MX6QDL_PAD_EIM_D30__GPIO3_IO30		0x0001b0b0
+			MX6QDL_PAD_EIM_D31__GPIO3_IO31		0x4001b0b0
 		>;
 	};
 
 	pinctrl_ipu2_csi1: ipu2_csi1grp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_EB2__IPU2_CSI1_DATA19    0x1b0b0
-			MX6QDL_PAD_EIM_D16__IPU2_CSI1_DATA18    0x1b0b0
-			MX6QDL_PAD_EIM_D18__IPU2_CSI1_DATA17    0x1b0b0
-			MX6QDL_PAD_EIM_D19__IPU2_CSI1_DATA16    0x1b0b0
-			MX6QDL_PAD_EIM_D20__IPU2_CSI1_DATA15    0x1b0b0
-			MX6QDL_PAD_EIM_D26__IPU2_CSI1_DATA14    0x1b0b0
-			MX6QDL_PAD_EIM_D27__IPU2_CSI1_DATA13    0x1b0b0
-			MX6QDL_PAD_EIM_A17__IPU2_CSI1_DATA12    0x1b0b0
-			MX6QDL_PAD_EIM_D29__IPU2_CSI1_VSYNC     0x1b0b0
-			MX6QDL_PAD_EIM_EB3__IPU2_CSI1_HSYNC     0x1b0b0
-			MX6QDL_PAD_EIM_A16__IPU2_CSI1_PIXCLK    0x1b0b0
+			MX6QDL_PAD_EIM_EB2__IPU2_CSI1_DATA19	0x1b0b0
+			MX6QDL_PAD_EIM_D16__IPU2_CSI1_DATA18	0x1b0b0
+			MX6QDL_PAD_EIM_D18__IPU2_CSI1_DATA17	0x1b0b0
+			MX6QDL_PAD_EIM_D19__IPU2_CSI1_DATA16	0x1b0b0
+			MX6QDL_PAD_EIM_D20__IPU2_CSI1_DATA15	0x1b0b0
+			MX6QDL_PAD_EIM_D26__IPU2_CSI1_DATA14	0x1b0b0
+			MX6QDL_PAD_EIM_D27__IPU2_CSI1_DATA13	0x1b0b0
+			MX6QDL_PAD_EIM_A17__IPU2_CSI1_DATA12	0x1b0b0
+			MX6QDL_PAD_EIM_D29__IPU2_CSI1_VSYNC	0x1b0b0
+			MX6QDL_PAD_EIM_EB3__IPU2_CSI1_HSYNC	0x1b0b0
+			MX6QDL_PAD_EIM_A16__IPU2_CSI1_PIXCLK	0x1b0b0
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6q-gw53xx.dts b/arch/arm/boot/dts/imx6q-gw53xx.dts
index a56ef77..a3b6469 100644
--- a/arch/arm/boot/dts/imx6q-gw53xx.dts
+++ b/arch/arm/boot/dts/imx6q-gw53xx.dts
@@ -58,24 +58,24 @@
 &iomuxc {
 	pinctrl_adv7180: adv7180grp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_D30__GPIO3_IO30          0x0001b0b0
-			MX6QDL_PAD_EIM_D31__GPIO3_IO31          0x4001b0b0
+			MX6QDL_PAD_EIM_D30__GPIO3_IO30		0x0001b0b0
+			MX6QDL_PAD_EIM_D31__GPIO3_IO31		0x4001b0b0
 		>;
 	};
 
 	pinctrl_ipu2_csi1: ipu2_csi1grp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_EB2__IPU2_CSI1_DATA19    0x1b0b0
-			MX6QDL_PAD_EIM_D16__IPU2_CSI1_DATA18    0x1b0b0
-			MX6QDL_PAD_EIM_D18__IPU2_CSI1_DATA17    0x1b0b0
-			MX6QDL_PAD_EIM_D19__IPU2_CSI1_DATA16    0x1b0b0
-			MX6QDL_PAD_EIM_D20__IPU2_CSI1_DATA15    0x1b0b0
-			MX6QDL_PAD_EIM_D26__IPU2_CSI1_DATA14    0x1b0b0
-			MX6QDL_PAD_EIM_D27__IPU2_CSI1_DATA13    0x1b0b0
-			MX6QDL_PAD_EIM_A17__IPU2_CSI1_DATA12    0x1b0b0
-			MX6QDL_PAD_EIM_D29__IPU2_CSI1_VSYNC     0x1b0b0
-			MX6QDL_PAD_EIM_EB3__IPU2_CSI1_HSYNC     0x1b0b0
-			MX6QDL_PAD_EIM_A16__IPU2_CSI1_PIXCLK    0x1b0b0
+			MX6QDL_PAD_EIM_EB2__IPU2_CSI1_DATA19	0x1b0b0
+			MX6QDL_PAD_EIM_D16__IPU2_CSI1_DATA18	0x1b0b0
+			MX6QDL_PAD_EIM_D18__IPU2_CSI1_DATA17	0x1b0b0
+			MX6QDL_PAD_EIM_D19__IPU2_CSI1_DATA16	0x1b0b0
+			MX6QDL_PAD_EIM_D20__IPU2_CSI1_DATA15	0x1b0b0
+			MX6QDL_PAD_EIM_D26__IPU2_CSI1_DATA14	0x1b0b0
+			MX6QDL_PAD_EIM_D27__IPU2_CSI1_DATA13	0x1b0b0
+			MX6QDL_PAD_EIM_A17__IPU2_CSI1_DATA12	0x1b0b0
+			MX6QDL_PAD_EIM_D29__IPU2_CSI1_VSYNC	0x1b0b0
+			MX6QDL_PAD_EIM_EB3__IPU2_CSI1_HSYNC	0x1b0b0
+			MX6QDL_PAD_EIM_A16__IPU2_CSI1_PIXCLK	0x1b0b0
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6q-gw54xx.dts b/arch/arm/boot/dts/imx6q-gw54xx.dts
index 56e5b50..420e4ae 100644
--- a/arch/arm/boot/dts/imx6q-gw54xx.dts
+++ b/arch/arm/boot/dts/imx6q-gw54xx.dts
@@ -58,24 +58,24 @@
 &iomuxc {
 	pinctrl_adv7180: adv7180grp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_D30__GPIO3_IO30          0x0001b0b0
-			MX6QDL_PAD_EIM_D31__GPIO3_IO31          0x4001b0b0
+			MX6QDL_PAD_EIM_D30__GPIO3_IO30		0x0001b0b0
+			MX6QDL_PAD_EIM_D31__GPIO3_IO31		0x4001b0b0
 		>;
 	};
 
 	pinctrl_ipu2_csi1: ipu2_csi1grp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_EB2__IPU2_CSI1_DATA19    0x1b0b0
-			MX6QDL_PAD_EIM_D16__IPU2_CSI1_DATA18    0x1b0b0
-			MX6QDL_PAD_EIM_D18__IPU2_CSI1_DATA17    0x1b0b0
-			MX6QDL_PAD_EIM_D19__IPU2_CSI1_DATA16    0x1b0b0
-			MX6QDL_PAD_EIM_D20__IPU2_CSI1_DATA15    0x1b0b0
-			MX6QDL_PAD_EIM_D26__IPU2_CSI1_DATA14    0x1b0b0
-			MX6QDL_PAD_EIM_D27__IPU2_CSI1_DATA13    0x1b0b0
-			MX6QDL_PAD_EIM_A17__IPU2_CSI1_DATA12    0x1b0b0
-			MX6QDL_PAD_EIM_D29__IPU2_CSI1_VSYNC     0x1b0b0
-			MX6QDL_PAD_EIM_EB3__IPU2_CSI1_HSYNC     0x1b0b0
-			MX6QDL_PAD_EIM_A16__IPU2_CSI1_PIXCLK    0x1b0b0
+			MX6QDL_PAD_EIM_EB2__IPU2_CSI1_DATA19	0x1b0b0
+			MX6QDL_PAD_EIM_D16__IPU2_CSI1_DATA18	0x1b0b0
+			MX6QDL_PAD_EIM_D18__IPU2_CSI1_DATA17	0x1b0b0
+			MX6QDL_PAD_EIM_D19__IPU2_CSI1_DATA16	0x1b0b0
+			MX6QDL_PAD_EIM_D20__IPU2_CSI1_DATA15	0x1b0b0
+			MX6QDL_PAD_EIM_D26__IPU2_CSI1_DATA14	0x1b0b0
+			MX6QDL_PAD_EIM_D27__IPU2_CSI1_DATA13	0x1b0b0
+			MX6QDL_PAD_EIM_A17__IPU2_CSI1_DATA12	0x1b0b0
+			MX6QDL_PAD_EIM_D29__IPU2_CSI1_VSYNC	0x1b0b0
+			MX6QDL_PAD_EIM_EB3__IPU2_CSI1_HSYNC	0x1b0b0
+			MX6QDL_PAD_EIM_A16__IPU2_CSI1_PIXCLK	0x1b0b0
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6q-kp.dtsi b/arch/arm/boot/dts/imx6q-kp.dtsi
index 24c8169..69a69ba 100644
--- a/arch/arm/boot/dts/imx6q-kp.dtsi
+++ b/arch/arm/boot/dts/imx6q-kp.dtsi
@@ -218,161 +218,161 @@
 &iomuxc {
 	pinctrl_audmux: audmuxgrp {
 		fsl,pins = <
-			MX6QDL_PAD_CSI0_DAT7__AUD3_RXD		0x130b0
-			MX6QDL_PAD_CSI0_DAT4__AUD3_TXC		0x130b0
-			MX6QDL_PAD_CSI0_DAT5__AUD3_TXD		0x110b0
-			MX6QDL_PAD_CSI0_DAT6__AUD3_TXFS	0x130b0
+			MX6QDL_PAD_CSI0_DAT7__AUD3_RXD			0x130b0
+			MX6QDL_PAD_CSI0_DAT4__AUD3_TXC			0x130b0
+			MX6QDL_PAD_CSI0_DAT5__AUD3_TXD			0x110b0
+			MX6QDL_PAD_CSI0_DAT6__AUD3_TXFS			0x130b0
 		>;
 	};
 
 	pinctrl_codec: codecgrp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_BCLK__GPIO6_IO31   0x1b0b0
+			MX6QDL_PAD_EIM_BCLK__GPIO6_IO31			0x1b0b0
 			/* sgtl5000 sys_mclk clock routed to CLKO1 */
-			MX6QDL_PAD_GPIO_0__CCM_CLKO1      0x000b0
+			MX6QDL_PAD_GPIO_0__CCM_CLKO1			0x000b0
 		>;
 	};
 
 	pinctrl_enet: enetgrp {
 		fsl,pins = <
-			MX6QDL_PAD_ENET_MDIO__ENET_MDIO	0x1b0b0
-			MX6QDL_PAD_ENET_MDC__ENET_MDC		0x1b0b0
-			MX6QDL_PAD_RGMII_TXC__RGMII_TXC	0x1b0b0
-			MX6QDL_PAD_RGMII_TD0__RGMII_TD0	0x1b0b0
-			MX6QDL_PAD_RGMII_TD1__RGMII_TD1	0x1b0b0
-			MX6QDL_PAD_RGMII_TD2__RGMII_TD2	0x1b0b0
-			MX6QDL_PAD_RGMII_TD3__RGMII_TD3	0x1b0b0
-			MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL	0x1b0b0
-			MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK	0x1b0b0
-			MX6QDL_PAD_RGMII_RXC__RGMII_RXC	0x1b0b0
-			MX6QDL_PAD_RGMII_RD0__RGMII_RD0	0x1b0b0
-			MX6QDL_PAD_RGMII_RD1__RGMII_RD1	0x1b0b0
-			MX6QDL_PAD_RGMII_RD2__RGMII_RD2	0x1b0b0
-			MX6QDL_PAD_RGMII_RD3__RGMII_RD3	0x1b0b0
-			MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL	0x1b0b0
-			MX6QDL_PAD_GPIO_16__ENET_REF_CLK 0x4001b0a8
+			MX6QDL_PAD_ENET_MDIO__ENET_MDIO			0x1b0b0
+			MX6QDL_PAD_ENET_MDC__ENET_MDC			0x1b0b0
+			MX6QDL_PAD_RGMII_TXC__RGMII_TXC			0x1b0b0
+			MX6QDL_PAD_RGMII_TD0__RGMII_TD0			0x1b0b0
+			MX6QDL_PAD_RGMII_TD1__RGMII_TD1			0x1b0b0
+			MX6QDL_PAD_RGMII_TD2__RGMII_TD2			0x1b0b0
+			MX6QDL_PAD_RGMII_TD3__RGMII_TD3			0x1b0b0
+			MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL		0x1b0b0
+			MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK		0x1b0b0
+			MX6QDL_PAD_RGMII_RXC__RGMII_RXC			0x1b0b0
+			MX6QDL_PAD_RGMII_RD0__RGMII_RD0			0x1b0b0
+			MX6QDL_PAD_RGMII_RD1__RGMII_RD1			0x1b0b0
+			MX6QDL_PAD_RGMII_RD2__RGMII_RD2			0x1b0b0
+			MX6QDL_PAD_RGMII_RD3__RGMII_RD3			0x1b0b0
+			MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL		0x1b0b0
+			MX6QDL_PAD_GPIO_16__ENET_REF_CLK		0x4001b0a8
 		>;
 	};
 
 	pinctrl_flexcan1: can1grp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_7__FLEXCAN1_TX        0x1b0b0
-			MX6QDL_PAD_GPIO_8__FLEXCAN1_RX        0x1b0b0
+			MX6QDL_PAD_GPIO_7__FLEXCAN1_TX			0x1b0b0
+			MX6QDL_PAD_GPIO_8__FLEXCAN1_RX			0x1b0b0
 		>;
 	};
 
 	pinctrl_flexcan2: can2grp {
 		fsl,pins = <
-			MX6QDL_PAD_KEY_COL4__FLEXCAN2_TX        0x1b0b0
-			MX6QDL_PAD_KEY_ROW4__FLEXCAN2_RX        0x1b0b0
+			MX6QDL_PAD_KEY_COL4__FLEXCAN2_TX		0x1b0b0
+			MX6QDL_PAD_KEY_ROW4__FLEXCAN2_RX		0x1b0b0
 		>;
 	};
 
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
-			MX6QDL_PAD_CSI0_DAT8__I2C1_SDA	0x4001b8b1
-			MX6QDL_PAD_CSI0_DAT9__I2C1_SCL	0x4001b8b1
+			MX6QDL_PAD_CSI0_DAT8__I2C1_SDA			0x4001b8b1
+			MX6QDL_PAD_CSI0_DAT9__I2C1_SCL			0x4001b8b1
 		>;
 	};
 
 	pinctrl_i2c2: i2c2grp {
 		fsl,pins = <
-			MX6QDL_PAD_KEY_COL3__I2C2_SCL	0x4001b8b1
-			MX6QDL_PAD_KEY_ROW3__I2C2_SDA	0x4001b8b1
+			MX6QDL_PAD_KEY_COL3__I2C2_SCL			0x4001b8b1
+			MX6QDL_PAD_KEY_ROW3__I2C2_SDA			0x4001b8b1
 		 >;
 	};
 
 	pinctrl_ipu1: ipu1grp {
 		fsl,pins = <
-			MX6QDL_PAD_DI0_DISP_CLK__IPU1_DI0_DISP_CLK 0x10
-			MX6QDL_PAD_DI0_PIN15__IPU1_DI0_PIN15       0x10
-			MX6QDL_PAD_DI0_PIN2__IPU1_DI0_PIN02        0x10
-			MX6QDL_PAD_DI0_PIN3__IPU1_DI0_PIN03        0x10
-			MX6QDL_PAD_DISP0_DAT0__IPU1_DISP0_DATA00   0x10
-			MX6QDL_PAD_DISP0_DAT1__IPU1_DISP0_DATA01   0x10
-			MX6QDL_PAD_DISP0_DAT2__IPU1_DISP0_DATA02   0x10
-			MX6QDL_PAD_DISP0_DAT3__IPU1_DISP0_DATA03   0x10
-			MX6QDL_PAD_DISP0_DAT4__IPU1_DISP0_DATA04   0x10
-			MX6QDL_PAD_DISP0_DAT5__IPU1_DISP0_DATA05   0x10
-			MX6QDL_PAD_DISP0_DAT6__IPU1_DISP0_DATA06   0x10
-			MX6QDL_PAD_DISP0_DAT7__IPU1_DISP0_DATA07   0x10
-			MX6QDL_PAD_DISP0_DAT8__IPU1_DISP0_DATA08   0x10
-			MX6QDL_PAD_DISP0_DAT9__IPU1_DISP0_DATA09   0x10
-			MX6QDL_PAD_DISP0_DAT10__IPU1_DISP0_DATA10  0x10
-			MX6QDL_PAD_DISP0_DAT11__IPU1_DISP0_DATA11  0x10
-			MX6QDL_PAD_DISP0_DAT12__IPU1_DISP0_DATA12  0x10
-			MX6QDL_PAD_DISP0_DAT13__IPU1_DISP0_DATA13  0x10
-			MX6QDL_PAD_DISP0_DAT14__IPU1_DISP0_DATA14  0x10
-			MX6QDL_PAD_DISP0_DAT15__IPU1_DISP0_DATA15  0x10
-			MX6QDL_PAD_DISP0_DAT16__IPU1_DISP0_DATA16  0x10
-			MX6QDL_PAD_DISP0_DAT17__IPU1_DISP0_DATA17  0x10
-			MX6QDL_PAD_DISP0_DAT18__IPU1_DISP0_DATA18  0x10
-			MX6QDL_PAD_DISP0_DAT19__IPU1_DISP0_DATA19  0x10
-			MX6QDL_PAD_DISP0_DAT20__IPU1_DISP0_DATA20  0x10
-			MX6QDL_PAD_DISP0_DAT21__IPU1_DISP0_DATA21  0x10
-			MX6QDL_PAD_DISP0_DAT22__IPU1_DISP0_DATA22  0x10
-			MX6QDL_PAD_DISP0_DAT23__IPU1_DISP0_DATA23  0x10
+			MX6QDL_PAD_DI0_DISP_CLK__IPU1_DI0_DISP_CLK	0x10
+			MX6QDL_PAD_DI0_PIN15__IPU1_DI0_PIN15		0x10
+			MX6QDL_PAD_DI0_PIN2__IPU1_DI0_PIN02		0x10
+			MX6QDL_PAD_DI0_PIN3__IPU1_DI0_PIN03		0x10
+			MX6QDL_PAD_DISP0_DAT0__IPU1_DISP0_DATA00	0x10
+			MX6QDL_PAD_DISP0_DAT1__IPU1_DISP0_DATA01	0x10
+			MX6QDL_PAD_DISP0_DAT2__IPU1_DISP0_DATA02	0x10
+			MX6QDL_PAD_DISP0_DAT3__IPU1_DISP0_DATA03	0x10
+			MX6QDL_PAD_DISP0_DAT4__IPU1_DISP0_DATA04	0x10
+			MX6QDL_PAD_DISP0_DAT5__IPU1_DISP0_DATA05	0x10
+			MX6QDL_PAD_DISP0_DAT6__IPU1_DISP0_DATA06	0x10
+			MX6QDL_PAD_DISP0_DAT7__IPU1_DISP0_DATA07	0x10
+			MX6QDL_PAD_DISP0_DAT8__IPU1_DISP0_DATA08	0x10
+			MX6QDL_PAD_DISP0_DAT9__IPU1_DISP0_DATA09	0x10
+			MX6QDL_PAD_DISP0_DAT10__IPU1_DISP0_DATA10	0x10
+			MX6QDL_PAD_DISP0_DAT11__IPU1_DISP0_DATA11	0x10
+			MX6QDL_PAD_DISP0_DAT12__IPU1_DISP0_DATA12	0x10
+			MX6QDL_PAD_DISP0_DAT13__IPU1_DISP0_DATA13	0x10
+			MX6QDL_PAD_DISP0_DAT14__IPU1_DISP0_DATA14	0x10
+			MX6QDL_PAD_DISP0_DAT15__IPU1_DISP0_DATA15	0x10
+			MX6QDL_PAD_DISP0_DAT16__IPU1_DISP0_DATA16	0x10
+			MX6QDL_PAD_DISP0_DAT17__IPU1_DISP0_DATA17	0x10
+			MX6QDL_PAD_DISP0_DAT18__IPU1_DISP0_DATA18	0x10
+			MX6QDL_PAD_DISP0_DAT19__IPU1_DISP0_DATA19	0x10
+			MX6QDL_PAD_DISP0_DAT20__IPU1_DISP0_DATA20	0x10
+			MX6QDL_PAD_DISP0_DAT21__IPU1_DISP0_DATA21	0x10
+			MX6QDL_PAD_DISP0_DAT22__IPU1_DISP0_DATA22	0x10
+			MX6QDL_PAD_DISP0_DAT23__IPU1_DISP0_DATA23	0x10
 		>;
 	};
 
 	pinctrl_pwm1: pwm1grp {
 		fsl,pins = <
-			MX6QDL_PAD_SD1_DAT3__PWM1_OUT		0x1b0b1
+			MX6QDL_PAD_SD1_DAT3__PWM1_OUT			0x1b0b1
 		>;
 	};
 
 	pinctrl_pwm2: pwm2grp {
 		fsl,pins = <
-			MX6QDL_PAD_SD1_DAT2__PWM2_OUT		0x1b0b1
+			MX6QDL_PAD_SD1_DAT2__PWM2_OUT			0x1b0b1
 		>;
 	};
 
 	pinctrl_ts: tsgrp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_9__GPIO1_IO09 0x1b0b0
-			MX6QDL_PAD_EIM_A25__GPIO5_IO02 0x1b0b0
+			MX6QDL_PAD_GPIO_9__GPIO1_IO09			0x1b0b0
+			MX6QDL_PAD_EIM_A25__GPIO5_IO02			0x1b0b0
 		>;
 	};
 
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
-			MX6QDL_PAD_SD3_DAT7__UART1_TX_DATA	0x1b0b1
-			MX6QDL_PAD_SD3_DAT6__UART1_RX_DATA	0x1b0b1
+			MX6QDL_PAD_SD3_DAT7__UART1_TX_DATA		0x1b0b1
+			MX6QDL_PAD_SD3_DAT6__UART1_RX_DATA		0x1b0b1
 		>;
 	};
 
 	pinctrl_uart2: uart2grp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_D26__UART2_TX_DATA       0x1b0b1
-			MX6QDL_PAD_EIM_D27__UART2_RX_DATA       0x1b0b1
-			MX6QDL_PAD_EIM_D28__UART2_CTS_B         0x1b0b1
-			MX6QDL_PAD_EIM_D29__UART2_RTS_B         0x1b0b1
+			MX6QDL_PAD_EIM_D26__UART2_TX_DATA		0x1b0b1
+			MX6QDL_PAD_EIM_D27__UART2_RX_DATA		0x1b0b1
+			MX6QDL_PAD_EIM_D28__UART2_CTS_B			0x1b0b1
+			MX6QDL_PAD_EIM_D29__UART2_RTS_B			0x1b0b1
 		>;
 	};
 
 	pinctrl_usdhc2: usdhc2grp {
 		fsl,pins = <
-			MX6QDL_PAD_SD2_CMD__SD2_CMD		0x17059
-			MX6QDL_PAD_SD2_CLK__SD2_CLK		0x10059
-			MX6QDL_PAD_SD2_DAT0__SD2_DATA0		0x17059
-			MX6QDL_PAD_SD2_DAT1__SD2_DATA1		0x17059
-			MX6QDL_PAD_SD2_DAT2__SD2_DATA2		0x17059
-			MX6QDL_PAD_SD2_DAT3__SD2_DATA3		0x17059
+			MX6QDL_PAD_SD2_CMD__SD2_CMD			0x17059
+			MX6QDL_PAD_SD2_CLK__SD2_CLK			0x10059
+			MX6QDL_PAD_SD2_DAT0__SD2_DATA0			0x17059
+			MX6QDL_PAD_SD2_DAT1__SD2_DATA1			0x17059
+			MX6QDL_PAD_SD2_DAT2__SD2_DATA2			0x17059
+			MX6QDL_PAD_SD2_DAT3__SD2_DATA3			0x17059
 		>;
 	};
 
 	pinctrl_usdhc4: usdhc4grp {
 		fsl,pins = <
-			MX6QDL_PAD_SD4_CMD__SD4_CMD		0x17059
-			MX6QDL_PAD_SD4_CLK__SD4_CLK		0x10059
-			MX6QDL_PAD_SD4_DAT0__SD4_DATA0		0x17059
-			MX6QDL_PAD_SD4_DAT1__SD4_DATA1		0x17059
-			MX6QDL_PAD_SD4_DAT2__SD4_DATA2		0x17059
-			MX6QDL_PAD_SD4_DAT3__SD4_DATA3		0x17059
-			MX6QDL_PAD_SD4_DAT4__SD4_DATA4		0x17059
-			MX6QDL_PAD_SD4_DAT5__SD4_DATA5		0x17059
-			MX6QDL_PAD_SD4_DAT6__SD4_DATA6		0x17059
-			MX6QDL_PAD_SD4_DAT7__SD4_DATA7		0x17059
+			MX6QDL_PAD_SD4_CMD__SD4_CMD			0x17059
+			MX6QDL_PAD_SD4_CLK__SD4_CLK			0x10059
+			MX6QDL_PAD_SD4_DAT0__SD4_DATA0			0x17059
+			MX6QDL_PAD_SD4_DAT1__SD4_DATA1			0x17059
+			MX6QDL_PAD_SD4_DAT2__SD4_DATA2			0x17059
+			MX6QDL_PAD_SD4_DAT3__SD4_DATA3			0x17059
+			MX6QDL_PAD_SD4_DAT4__SD4_DATA4			0x17059
+			MX6QDL_PAD_SD4_DAT5__SD4_DATA5			0x17059
+			MX6QDL_PAD_SD4_DAT6__SD4_DATA6			0x17059
+			MX6QDL_PAD_SD4_DAT7__SD4_DATA7			0x17059
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6q-mccmon6.dts b/arch/arm/boot/dts/imx6q-mccmon6.dts
index 74d9824..8abf217 100644
--- a/arch/arm/boot/dts/imx6q-mccmon6.dts
+++ b/arch/arm/boot/dts/imx6q-mccmon6.dts
@@ -300,7 +300,7 @@
 	pinctrl_backlight: dispgrp {
 		fsl,pins = <
 			/* BLEN_OUT */
-			MX6QDL_PAD_GPIO_2__GPIO1_IO02    0x1b0b0
+			MX6QDL_PAD_GPIO_2__GPIO1_IO02		0x1b0b0
 		>;
 	};
 
@@ -314,13 +314,13 @@
 
 	pinctrl_ecspi3_cs: ecspi3csgrp {
 		fsl,pins = <
-			MX6QDL_PAD_DISP0_DAT3__GPIO4_IO24 0x80000000
+			MX6QDL_PAD_DISP0_DAT3__GPIO4_IO24	0x80000000
 		>;
 	};
 
 	pinctrl_ecspi3_flwp: ecspi3flwpgrp {
 		fsl,pins = <
-			MX6QDL_PAD_DISP0_DAT6__GPIO4_IO27 0x80000000
+			MX6QDL_PAD_DISP0_DAT6__GPIO4_IO27	0x80000000
 		>;
 	};
 
@@ -341,36 +341,36 @@
 			MX6QDL_PAD_RGMII_RD2__RGMII_RD2		0x1b0b0
 			MX6QDL_PAD_RGMII_RD3__RGMII_RD3		0x1b0b0
 			MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL	0x1b0b0
-			MX6QDL_PAD_GPIO_16__ENET_REF_CLK 0x4001b0a8
+			MX6QDL_PAD_GPIO_16__ENET_REF_CLK	0x4001b0a8
 			MX6QDL_PAD_GPIO_6__ENET_IRQ		0x000b1
-			MX6QDL_PAD_ENET_RXD0__GPIO1_IO27        0x1b0b0
+			MX6QDL_PAD_ENET_RXD0__GPIO1_IO27	0x1b0b0
 		>;
 	};
 
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
-			MX6QDL_PAD_CSI0_DAT9__I2C1_SCL	0x4001b8b1
-			MX6QDL_PAD_CSI0_DAT8__I2C1_SDA	0x4001b8b1
+			MX6QDL_PAD_CSI0_DAT9__I2C1_SCL		0x4001b8b1
+			MX6QDL_PAD_CSI0_DAT8__I2C1_SDA		0x4001b8b1
 		>;
 	};
 
 	pinctrl_i2c2: i2c2grp {
 		fsl,pins = <
-			MX6QDL_PAD_KEY_COL3__I2C2_SCL	0x4001b8b1
-			MX6QDL_PAD_KEY_ROW3__I2C2_SDA	0x4001b8b1
+			MX6QDL_PAD_KEY_COL3__I2C2_SCL		0x4001b8b1
+			MX6QDL_PAD_KEY_ROW3__I2C2_SDA		0x4001b8b1
 		>;
 	};
 
 	pinctrl_pwm2: pwm2grp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_1__PWM2_OUT	0x1b0b1
+			MX6QDL_PAD_GPIO_1__PWM2_OUT		0x1b0b1
 		>;
 	};
 
 	pinctrl_reg_lvds: reqlvdsgrp {
 		fsl,pins = <
 			/* LVDS_PPEN_OUT */
-			MX6QDL_PAD_SD1_DAT2__GPIO1_IO19         0x1b0b0
+			MX6QDL_PAD_SD1_DAT2__GPIO1_IO19		0x1b0b0
 		>;
 	};
 
@@ -428,7 +428,7 @@
 		fsl,pins = <
 			MX6QDL_PAD_EIM_OE__EIM_OE_B		0xb0b1
 			MX6QDL_PAD_EIM_RW__EIM_RW		0xb0b1
-			MX6QDL_PAD_EIM_WAIT__EIM_WAIT_B	0xb060
+			MX6QDL_PAD_EIM_WAIT__EIM_WAIT_B		0xb060
 			MX6QDL_PAD_EIM_D16__EIM_DATA16		0x1b0b0
 			MX6QDL_PAD_EIM_D17__EIM_DATA17		0x1b0b0
 			MX6QDL_PAD_EIM_D18__EIM_DATA18		0x1b0b0
diff --git a/arch/arm/boot/dts/imx6q-pistachio.dts b/arch/arm/boot/dts/imx6q-pistachio.dts
index a31b17e..04a3049 100644
--- a/arch/arm/boot/dts/imx6q-pistachio.dts
+++ b/arch/arm/boot/dts/imx6q-pistachio.dts
@@ -327,22 +327,22 @@
 
 	pinctrl_hog: hoggrp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_D22__GPIO3_IO22	0x1b0b0  /*pcie power*/
-			MX6QDL_PAD_EIM_A25__GPIO5_IO02	0x1b0b0   /*LCD power*/
-			MX6QDL_PAD_EIM_D16__GPIO3_IO16	0x1b0b0   /*backlight power*/
-			MX6QDL_PAD_GPIO_2__GPIO1_IO02		0x1b0b1 /*SD3 CD pin*/
-			MX6QDL_PAD_KEY_COL2__GPIO4_IO10	0x1b0b0 /*codec power*/
-			MX6QDL_PAD_EIM_A16__GPIO2_IO22	0x1b0b0 /*touch reset*/
+			MX6QDL_PAD_EIM_D22__GPIO3_IO22		0x1b0b0  /*pcie power*/
+			MX6QDL_PAD_EIM_A25__GPIO5_IO02		0x1b0b0  /*LCD power*/
+			MX6QDL_PAD_EIM_D16__GPIO3_IO16		0x1b0b0  /*backlight power*/
+			MX6QDL_PAD_GPIO_2__GPIO1_IO02		0x1b0b1  /*SD3 CD pin*/
+			MX6QDL_PAD_KEY_COL2__GPIO4_IO10		0x1b0b0  /*codec power*/
+			MX6QDL_PAD_EIM_A16__GPIO2_IO22		0x1b0b0  /*touch reset*/
 			MX6QDL_PAD_NANDF_ALE__GPIO6_IO08	0x1b0b01 /*touch irq*/
-			MX6QDL_PAD_GPIO_7__GPIO1_IO07	 0x1b0b0/*backlight pwr*/
-			MX6QDL_PAD_GPIO_16__GPIO7_IO11	0x1b0b0 /*gpio 5V_1*/
-			MX6QDL_PAD_EIM_A19__GPIO2_IO19	0x1b0b0 /*gpio 5V_2*/
-			MX6QDL_PAD_EIM_A24__GPIO5_IO04	0x1b0b0 /*gpio 5V_3*/
-			MX6QDL_PAD_GPIO_17__GPIO7_IO12	0x1b0b0 /*gpio 5V_4*/
-			MX6QDL_PAD_NANDF_CLE__GPIO6_IO07	0x1b0b0 /*AUX_5V_EN*/
-			MX6QDL_PAD_NANDF_WP_B__GPIO6_IO09	0x1b0b0 /*AUX_5VB_EN*/
-			MX6QDL_PAD_NANDF_RB0__GPIO6_IO10	0x1b0b0 /*AUX_3V3_EN*/
-			MX6QDL_PAD_EIM_D21__GPIO3_IO21	0x1b0b0 /*I2C expander pwr*/
+			MX6QDL_PAD_GPIO_7__GPIO1_IO07		0x1b0b0  /*backlight pwr*/
+			MX6QDL_PAD_GPIO_16__GPIO7_IO11		0x1b0b0  /*gpio 5V_1*/
+			MX6QDL_PAD_EIM_A19__GPIO2_IO19		0x1b0b0  /*gpio 5V_2*/
+			MX6QDL_PAD_EIM_A24__GPIO5_IO04		0x1b0b0  /*gpio 5V_3*/
+			MX6QDL_PAD_GPIO_17__GPIO7_IO12		0x1b0b0  /*gpio 5V_4*/
+			MX6QDL_PAD_NANDF_CLE__GPIO6_IO07	0x1b0b0  /*AUX_5V_EN*/
+			MX6QDL_PAD_NANDF_WP_B__GPIO6_IO09	0x1b0b0  /*AUX_5VB_EN*/
+			MX6QDL_PAD_NANDF_RB0__GPIO6_IO10	0x1b0b0  /*AUX_3V3_EN*/
+			MX6QDL_PAD_EIM_D21__GPIO3_IO21		0x1b0b0  /*I2C expander pwr*/
 		>;
 	};
 
@@ -404,13 +404,13 @@
 
 	pinctrl_gpio_keys: gpio_keysgrp {
 		fsl,pins = <
-			MX6QDL_PAD_SD4_DAT4__GPIO2_IO12 0x1b0b0
+			MX6QDL_PAD_SD4_DAT4__GPIO2_IO12		0x1b0b0
 		>;
 	};
 
 	pinctrl_hdmi_cec: hdmicecgrp {
 		fsl,pins = <
-			MX6QDL_PAD_KEY_ROW2__HDMI_TX_CEC_LINE 0x108b0
+			MX6QDL_PAD_KEY_ROW2__HDMI_TX_CEC_LINE	0x108b0
 		>;
 	};
 
@@ -437,15 +437,15 @@
 
 	pinctrl_i2c1_sgtl5000: i2c1-sgtl5000grp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_0__CCM_CLKO1			0x000b0 /* sys_mclk */
-			MX6QDL_PAD_SD3_RST__GPIO7_IO08		0x130b0 /*headphone det*/
-			MX6QDL_PAD_GPIO_8__GPIO1_IO08			0x130b0 /*microphone det*/
+			MX6QDL_PAD_GPIO_0__CCM_CLKO1		0x000b0 /* sys_mclk */
+			MX6QDL_PAD_SD3_RST__GPIO7_IO08		0x130b0 /* headphone det */
+			MX6QDL_PAD_GPIO_8__GPIO1_IO08		0x130b0 /* microphone det */
 		>;
 	};
 
 	pinctrl_pwm1: pwm1grp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_9__PWM1_OUT	    0x1b0b1
+			MX6QDL_PAD_GPIO_9__PWM1_OUT		0x1b0b1
 		>;
 	};
 
@@ -453,11 +453,11 @@
 		fsl,pins = <
 			MX6QDL_PAD_CSI0_DAT10__UART1_RX_DATA	0x1b0b1
 			MX6QDL_PAD_CSI0_DAT11__UART1_TX_DATA	0x1b0b1
-			MX6QDL_PAD_EIM_D20__UART1_CTS_B	0x1b0b1
-			MX6QDL_PAD_EIM_D19__UART1_RTS_B	0x1b0b1
-			MX6QDL_PAD_EIM_D23__UART1_DCD_B	0x1b0b0
-			MX6QDL_PAD_EIM_D24__UART1_DTR_B	0x1b0b0
-			MX6QDL_PAD_EIM_D25__UART1_DSR_B	0x1b0b0
+			MX6QDL_PAD_EIM_D20__UART1_CTS_B		0x1b0b1
+			MX6QDL_PAD_EIM_D19__UART1_RTS_B		0x1b0b1
+			MX6QDL_PAD_EIM_D23__UART1_DCD_B		0x1b0b0
+			MX6QDL_PAD_EIM_D24__UART1_DTR_B		0x1b0b0
+			MX6QDL_PAD_EIM_D25__UART1_DSR_B		0x1b0b0
 		>;
 	};
 
@@ -465,8 +465,8 @@
 		fsl,pins = <
 			MX6QDL_PAD_EIM_D26__UART2_TX_DATA	0x1b0b1
 			MX6QDL_PAD_EIM_D27__UART2_RX_DATA	0x1b0b1
-			MX6QDL_PAD_EIM_D28__UART2_CTS_B	0x1b0b1
-			MX6QDL_PAD_EIM_D29__UART2_RTS_B	0x1b0b1
+			MX6QDL_PAD_EIM_D28__UART2_CTS_B		0x1b0b1
+			MX6QDL_PAD_EIM_D29__UART2_RTS_B		0x1b0b1
 		>;
 	};
 
@@ -494,7 +494,7 @@
 			MX6QDL_PAD_CSI0_DAT15__UART5_RX_DATA	0x1b0b1
 			MX6QDL_PAD_CSI0_DAT18__UART5_RTS_B	0x1b0b1
 			MX6QDL_PAD_CSI0_DAT19__UART5_CTS_B	0x1b0b1
-			MX6QDL_PAD_EIM_A21__GPIO2_IO17		 0x15059 /*BT_EN*/
+			MX6QDL_PAD_EIM_A21__GPIO2_IO17		0x15059 /*BT_EN*/
 		>;
 	};
 
@@ -527,7 +527,7 @@
 			MX6QDL_PAD_SD2_DAT1__SD2_DATA1		0x17059
 			MX6QDL_PAD_SD2_DAT2__SD2_DATA2		0x17059
 			MX6QDL_PAD_SD2_DAT3__SD2_DATA3		0x17059
-			MX6QDL_PAD_EIM_RW__GPIO2_IO26			0x15059 /*WL_EN_LDO*/
+			MX6QDL_PAD_EIM_RW__GPIO2_IO26		0x15059 /*WL_EN_LDO*/
 			MX6QDL_PAD_EIM_CS1__GPIO2_IO24		0x15059 /*WL_EN*/
 			MX6QDL_PAD_CSI0_PIXCLK__GPIO5_IO18	0x15059 /*WL_IRQ*/
 		>;
@@ -546,7 +546,7 @@
 
 	pinctrl_wdog: wdoggrp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_1__WDOG2_B	0x1b0b00
+			MX6QDL_PAD_GPIO_1__WDOG2_B		0x1b0b00
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6q-tbs2910.dts b/arch/arm/boot/dts/imx6q-tbs2910.dts
index 2ce8399..d7bf475 100644
--- a/arch/arm/boot/dts/imx6q-tbs2910.dts
+++ b/arch/arm/boot/dts/imx6q-tbs2910.dts
@@ -240,149 +240,149 @@
 &iomuxc {
 	pinctrl_enet: enetgrp {
 		fsl,pins = <
-			MX6QDL_PAD_ENET_MDIO__ENET_MDIO       0x1b0b0
-			MX6QDL_PAD_ENET_MDC__ENET_MDC         0x1b0b0
-			MX6QDL_PAD_RGMII_TXC__RGMII_TXC       0x1b030
-			MX6QDL_PAD_RGMII_TD0__RGMII_TD0       0x1b030
-			MX6QDL_PAD_RGMII_TD1__RGMII_TD1       0x1b030
-			MX6QDL_PAD_RGMII_TD2__RGMII_TD2       0x1b030
-			MX6QDL_PAD_RGMII_TD3__RGMII_TD3       0x1b030
-			MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL 0x1b030
-			MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK  0x1b0b0
-			MX6QDL_PAD_RGMII_RXC__RGMII_RXC       0x1b030
-			MX6QDL_PAD_RGMII_RD0__RGMII_RD0       0x1b030
-			MX6QDL_PAD_RGMII_RD1__RGMII_RD1       0x1b030
-			MX6QDL_PAD_RGMII_RD2__RGMII_RD2       0x1b030
-			MX6QDL_PAD_RGMII_RD3__RGMII_RD3       0x1b030
-			MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL 0x1b030
-			MX6QDL_PAD_GPIO_16__ENET_REF_CLK      0x4001b0a8
-			MX6QDL_PAD_ENET_CRS_DV__GPIO1_IO25    0x1b059
+			MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x1b0b0
+			MX6QDL_PAD_ENET_MDC__ENET_MDC		0x1b0b0
+			MX6QDL_PAD_RGMII_TXC__RGMII_TXC		0x1b030
+			MX6QDL_PAD_RGMII_TD0__RGMII_TD0		0x1b030
+			MX6QDL_PAD_RGMII_TD1__RGMII_TD1		0x1b030
+			MX6QDL_PAD_RGMII_TD2__RGMII_TD2		0x1b030
+			MX6QDL_PAD_RGMII_TD3__RGMII_TD3		0x1b030
+			MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL	0x1b030
+			MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK	0x1b0b0
+			MX6QDL_PAD_RGMII_RXC__RGMII_RXC		0x1b030
+			MX6QDL_PAD_RGMII_RD0__RGMII_RD0		0x1b030
+			MX6QDL_PAD_RGMII_RD1__RGMII_RD1		0x1b030
+			MX6QDL_PAD_RGMII_RD2__RGMII_RD2		0x1b030
+			MX6QDL_PAD_RGMII_RD3__RGMII_RD3		0x1b030
+			MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL	0x1b030
+			MX6QDL_PAD_GPIO_16__ENET_REF_CLK	0x4001b0a8
+			MX6QDL_PAD_ENET_CRS_DV__GPIO1_IO25	0x1b059
 		>;
 	};
 
 	pinctrl_gpio_fan: gpiofangrp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_D28__GPIO3_IO28        0x130b1
+			MX6QDL_PAD_EIM_D28__GPIO3_IO28		0x130b1
 		>;
 	};
 
 	pinctrl_gpio_leds: gpioledsgrp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_2__GPIO1_IO02         0x130b1
+			MX6QDL_PAD_GPIO_2__GPIO1_IO02		0x130b1
 		>;
 	};
 
 	pinctrl_hdmi: hdmigrp {
 		fsl,pins = <
-			MX6QDL_PAD_KEY_ROW2__HDMI_TX_CEC_LINE 0x1f8b0
+			MX6QDL_PAD_KEY_ROW2__HDMI_TX_CEC_LINE	0x1f8b0
 		>;
 	};
 
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
-			MX6QDL_PAD_CSI0_DAT9__I2C1_SCL        0x4001b8b1
-			MX6QDL_PAD_CSI0_DAT8__I2C1_SDA        0x4001b8b1
+			MX6QDL_PAD_CSI0_DAT9__I2C1_SCL		0x4001b8b1
+			MX6QDL_PAD_CSI0_DAT8__I2C1_SDA		0x4001b8b1
 		>;
 	};
 
 	pinctrl_i2c2: i2c2grp {
 		fsl,pins = <
-			MX6QDL_PAD_KEY_COL3__I2C2_SCL         0x4001b8b1
-			MX6QDL_PAD_KEY_ROW3__I2C2_SDA         0x4001b8b1
+			MX6QDL_PAD_KEY_COL3__I2C2_SCL		0x4001b8b1
+			MX6QDL_PAD_KEY_ROW3__I2C2_SDA		0x4001b8b1
 		>;
 	};
 
 	pinctrl_i2c3: i2c3grp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_3__I2C3_SCL           0x4001b8b1
-			MX6QDL_PAD_GPIO_6__I2C3_SDA           0x4001b8b1
+			MX6QDL_PAD_GPIO_3__I2C3_SCL		0x4001b8b1
+			MX6QDL_PAD_GPIO_6__I2C3_SDA		0x4001b8b1
 		>;
 	};
 
 	pinctrl_ir: irgrp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_D18__GPIO3_IO18        0x17059
+			MX6QDL_PAD_EIM_D18__GPIO3_IO18		0x17059
 		>;
 	};
 
 	pinctrl_pcie: pciegrp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_17__GPIO7_IO12        0x17059
+			MX6QDL_PAD_GPIO_17__GPIO7_IO12		0x17059
 		>;
 	};
 
 	pinctrl_sgtl5000: sgtl5000grp {
 		fsl,pins = <
-			MX6QDL_PAD_CSI0_DAT7__AUD3_RXD        0x130b0
-			MX6QDL_PAD_CSI0_DAT4__AUD3_TXC        0x130b0
-			MX6QDL_PAD_CSI0_DAT5__AUD3_TXD        0x110b0
-			MX6QDL_PAD_CSI0_DAT6__AUD3_TXFS       0x130b0
-			MX6QDL_PAD_GPIO_0__CCM_CLKO1          0x130b0
+			MX6QDL_PAD_CSI0_DAT7__AUD3_RXD		0x130b0
+			MX6QDL_PAD_CSI0_DAT4__AUD3_TXC		0x130b0
+			MX6QDL_PAD_CSI0_DAT5__AUD3_TXD		0x110b0
+			MX6QDL_PAD_CSI0_DAT6__AUD3_TXFS		0x130b0
+			MX6QDL_PAD_GPIO_0__CCM_CLKO1		0x130b0
 		>;
 	};
 
 	pinctrl_spdif: spdifgrp {
-		fsl,pins = <MX6QDL_PAD_GPIO_19__SPDIF_OUT     0x13091
+		fsl,pins = <MX6QDL_PAD_GPIO_19__SPDIF_OUT	0x13091
 		>;
 	};
 
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
-			MX6QDL_PAD_CSI0_DAT10__UART1_TX_DATA  0x1b0b1
-			MX6QDL_PAD_CSI0_DAT11__UART1_RX_DATA  0x1b0b1
+			MX6QDL_PAD_CSI0_DAT10__UART1_TX_DATA	0x1b0b1
+			MX6QDL_PAD_CSI0_DAT11__UART1_RX_DATA	0x1b0b1
 		>;
 	};
 
 	pinctrl_uart2: uart2grp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_D26__UART2_TX_DATA     0x1b0b1
-			MX6QDL_PAD_EIM_D27__UART2_RX_DATA     0x1b0b1
+			MX6QDL_PAD_EIM_D26__UART2_TX_DATA	0x1b0b1
+			MX6QDL_PAD_EIM_D27__UART2_RX_DATA	0x1b0b1
 		>;
 	};
 
 	pinctrl_usbotg: usbotggrp {
 		fsl,pins = <
-			MX6QDL_PAD_ENET_RX_ER__USB_OTG_ID     0x17059
+			MX6QDL_PAD_ENET_RX_ER__USB_OTG_ID	0x17059
 		>;
 	};
 
 	pinctrl_usdhc2: usdhc2grp {
 		fsl,pins = <
-			MX6QDL_PAD_SD2_CMD__SD2_CMD           0x17059
-			MX6QDL_PAD_SD2_CLK__SD2_CLK           0x10059
-			MX6QDL_PAD_SD2_DAT0__SD2_DATA0        0x17059
-			MX6QDL_PAD_SD2_DAT1__SD2_DATA1        0x17059
-			MX6QDL_PAD_SD2_DAT2__SD2_DATA2        0x17059
-			MX6QDL_PAD_SD2_DAT3__SD2_DATA3        0x17059
-			MX6QDL_PAD_NANDF_D2__GPIO2_IO02       0x17059
+			MX6QDL_PAD_SD2_CMD__SD2_CMD		0x17059
+			MX6QDL_PAD_SD2_CLK__SD2_CLK		0x10059
+			MX6QDL_PAD_SD2_DAT0__SD2_DATA0		0x17059
+			MX6QDL_PAD_SD2_DAT1__SD2_DATA1		0x17059
+			MX6QDL_PAD_SD2_DAT2__SD2_DATA2		0x17059
+			MX6QDL_PAD_SD2_DAT3__SD2_DATA3		0x17059
+			MX6QDL_PAD_NANDF_D2__GPIO2_IO02		0x17059
 		>;
 	};
 
 	pinctrl_usdhc3: usdhc3grp {
 		fsl,pins = <
-			MX6QDL_PAD_SD3_CMD__SD3_CMD           0x17059
-			MX6QDL_PAD_SD3_CLK__SD3_CLK           0x10059
-			MX6QDL_PAD_SD3_DAT0__SD3_DATA0        0x17059
-			MX6QDL_PAD_SD3_DAT1__SD3_DATA1        0x17059
-			MX6QDL_PAD_SD3_DAT2__SD3_DATA2        0x17059
-			MX6QDL_PAD_SD3_DAT3__SD3_DATA3        0x17059
-			MX6QDL_PAD_NANDF_D0__GPIO2_IO00       0x17059
-			MX6QDL_PAD_NANDF_D1__GPIO2_IO01       0x17059
+			MX6QDL_PAD_SD3_CMD__SD3_CMD		0x17059
+			MX6QDL_PAD_SD3_CLK__SD3_CLK		0x10059
+			MX6QDL_PAD_SD3_DAT0__SD3_DATA0		0x17059
+			MX6QDL_PAD_SD3_DAT1__SD3_DATA1		0x17059
+			MX6QDL_PAD_SD3_DAT2__SD3_DATA2		0x17059
+			MX6QDL_PAD_SD3_DAT3__SD3_DATA3		0x17059
+			MX6QDL_PAD_NANDF_D0__GPIO2_IO00		0x17059
+			MX6QDL_PAD_NANDF_D1__GPIO2_IO01		0x17059
 		>;
 	};
 
 	pinctrl_usdhc4: usdhc4grp {
 		fsl,pins = <
-			MX6QDL_PAD_SD4_CMD__SD4_CMD           0x17059
-			MX6QDL_PAD_SD4_CLK__SD4_CLK           0x10059
-			MX6QDL_PAD_SD4_DAT0__SD4_DATA0        0x17059
-			MX6QDL_PAD_SD4_DAT1__SD4_DATA1        0x17059
-			MX6QDL_PAD_SD4_DAT2__SD4_DATA2        0x17059
-			MX6QDL_PAD_SD4_DAT3__SD4_DATA3        0x17059
-			MX6QDL_PAD_SD4_DAT4__SD4_DATA4        0x17059
-			MX6QDL_PAD_SD4_DAT5__SD4_DATA5        0x17059
-			MX6QDL_PAD_SD4_DAT6__SD4_DATA6        0x17059
-			MX6QDL_PAD_SD4_DAT7__SD4_DATA7        0x17059
+			MX6QDL_PAD_SD4_CMD__SD4_CMD		0x17059
+			MX6QDL_PAD_SD4_CLK__SD4_CLK		0x10059
+			MX6QDL_PAD_SD4_DAT0__SD4_DATA0		0x17059
+			MX6QDL_PAD_SD4_DAT1__SD4_DATA1		0x17059
+			MX6QDL_PAD_SD4_DAT2__SD4_DATA2		0x17059
+			MX6QDL_PAD_SD4_DAT3__SD4_DATA3		0x17059
+			MX6QDL_PAD_SD4_DAT4__SD4_DATA4		0x17059
+			MX6QDL_PAD_SD4_DAT5__SD4_DATA5		0x17059
+			MX6QDL_PAD_SD4_DAT6__SD4_DATA6		0x17059
+			MX6QDL_PAD_SD4_DAT7__SD4_DATA7		0x17059
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6q-utilite-pro.dts b/arch/arm/boot/dts/imx6q-utilite-pro.dts
index d16ff20..8dc7ced 100644
--- a/arch/arm/boot/dts/imx6q-utilite-pro.dts
+++ b/arch/arm/boot/dts/imx6q-utilite-pro.dts
@@ -207,114 +207,114 @@
 &iomuxc {
 	pinctrl_gpio_keys: gpio_keysgrp {
 		fsl,pins = <
-			MX6QDL_PAD_ENET_TXD1__GPIO1_IO29 0x1b0b0
+			MX6QDL_PAD_ENET_TXD1__GPIO1_IO29		0x1b0b0
 		>;
 	};
 
 	pinctrl_hdmicec: hdmicecgrp {
 		fsl,pins = <
-			MX6QDL_PAD_KEY_ROW2__HDMI_TX_CEC_LINE 0x1f8b0
+			MX6QDL_PAD_KEY_ROW2__HDMI_TX_CEC_LINE		0x1f8b0
 		>;
 	};
 
 	pinctrl_hpd: hpdgrp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_4__GPIO1_IO04 0x1b0b0
+			MX6QDL_PAD_GPIO_4__GPIO1_IO04			0x1b0b0
 		>;
 	};
 
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_D21__I2C1_SCL 0x4001b8b1
-			MX6QDL_PAD_EIM_D28__I2C1_SDA 0x4001b8b1
+			MX6QDL_PAD_EIM_D21__I2C1_SCL			0x4001b8b1
+			MX6QDL_PAD_EIM_D28__I2C1_SDA			0x4001b8b1
 		>;
 	};
 
 	pinctrl_i2c1mux: i2c1muxgrp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_2__GPIO1_IO02 0x1b0b0
+			MX6QDL_PAD_GPIO_2__GPIO1_IO02			0x1b0b0
 		>;
 	};
 
 	pinctrl_i2c2: i2c2grp {
 		fsl,pins = <
-			MX6QDL_PAD_KEY_COL3__I2C2_SCL 0x4001b8b1
-			MX6QDL_PAD_KEY_ROW3__I2C2_SDA 0x4001b8b1
+			MX6QDL_PAD_KEY_COL3__I2C2_SCL			0x4001b8b1
+			MX6QDL_PAD_KEY_ROW3__I2C2_SDA			0x4001b8b1
 		>;
 	};
 
 	pinctrl_ipu1: ipu1grp {
 		fsl,pins = <
-			MX6QDL_PAD_DI0_DISP_CLK__IPU1_DI0_DISP_CLK 0x38
-			MX6QDL_PAD_DI0_PIN15__IPU1_DI0_PIN15       0x38
-			MX6QDL_PAD_DI0_PIN2__IPU1_DI0_PIN02        0x38
-			MX6QDL_PAD_DI0_PIN3__IPU1_DI0_PIN03        0x38
-			MX6QDL_PAD_DISP0_DAT0__IPU1_DISP0_DATA00   0x38
-			MX6QDL_PAD_DISP0_DAT1__IPU1_DISP0_DATA01   0x38
-			MX6QDL_PAD_DISP0_DAT2__IPU1_DISP0_DATA02   0x38
-			MX6QDL_PAD_DISP0_DAT3__IPU1_DISP0_DATA03   0x38
-			MX6QDL_PAD_DISP0_DAT4__IPU1_DISP0_DATA04   0x38
-			MX6QDL_PAD_DISP0_DAT5__IPU1_DISP0_DATA05   0x38
-			MX6QDL_PAD_DISP0_DAT6__IPU1_DISP0_DATA06   0x38
-			MX6QDL_PAD_DISP0_DAT7__IPU1_DISP0_DATA07   0x38
-			MX6QDL_PAD_DISP0_DAT8__IPU1_DISP0_DATA08   0x38
-			MX6QDL_PAD_DISP0_DAT9__IPU1_DISP0_DATA09   0x38
-			MX6QDL_PAD_DISP0_DAT10__IPU1_DISP0_DATA10  0x38
-			MX6QDL_PAD_DISP0_DAT11__IPU1_DISP0_DATA11  0x38
-			MX6QDL_PAD_DISP0_DAT12__IPU1_DISP0_DATA12  0x38
-			MX6QDL_PAD_DISP0_DAT13__IPU1_DISP0_DATA13  0x38
-			MX6QDL_PAD_DISP0_DAT14__IPU1_DISP0_DATA14  0x38
-			MX6QDL_PAD_DISP0_DAT15__IPU1_DISP0_DATA15  0x38
-			MX6QDL_PAD_DISP0_DAT16__IPU1_DISP0_DATA16  0x38
-			MX6QDL_PAD_DISP0_DAT17__IPU1_DISP0_DATA17  0x38
-			MX6QDL_PAD_DISP0_DAT18__IPU1_DISP0_DATA18  0x38
-			MX6QDL_PAD_DISP0_DAT19__IPU1_DISP0_DATA19  0x38
-			MX6QDL_PAD_DISP0_DAT20__IPU1_DISP0_DATA20  0x38
-			MX6QDL_PAD_DISP0_DAT21__IPU1_DISP0_DATA21  0x38
-			MX6QDL_PAD_DISP0_DAT22__IPU1_DISP0_DATA22  0x38
-			MX6QDL_PAD_DISP0_DAT23__IPU1_DISP0_DATA23  0x38
+			MX6QDL_PAD_DI0_DISP_CLK__IPU1_DI0_DISP_CLK	0x38
+			MX6QDL_PAD_DI0_PIN15__IPU1_DI0_PIN15		0x38
+			MX6QDL_PAD_DI0_PIN2__IPU1_DI0_PIN02		0x38
+			MX6QDL_PAD_DI0_PIN3__IPU1_DI0_PIN03		0x38
+			MX6QDL_PAD_DISP0_DAT0__IPU1_DISP0_DATA00	0x38
+			MX6QDL_PAD_DISP0_DAT1__IPU1_DISP0_DATA01	0x38
+			MX6QDL_PAD_DISP0_DAT2__IPU1_DISP0_DATA02	0x38
+			MX6QDL_PAD_DISP0_DAT3__IPU1_DISP0_DATA03	0x38
+			MX6QDL_PAD_DISP0_DAT4__IPU1_DISP0_DATA04	0x38
+			MX6QDL_PAD_DISP0_DAT5__IPU1_DISP0_DATA05	0x38
+			MX6QDL_PAD_DISP0_DAT6__IPU1_DISP0_DATA06	0x38
+			MX6QDL_PAD_DISP0_DAT7__IPU1_DISP0_DATA07	0x38
+			MX6QDL_PAD_DISP0_DAT8__IPU1_DISP0_DATA08	0x38
+			MX6QDL_PAD_DISP0_DAT9__IPU1_DISP0_DATA09	0x38
+			MX6QDL_PAD_DISP0_DAT10__IPU1_DISP0_DATA10	0x38
+			MX6QDL_PAD_DISP0_DAT11__IPU1_DISP0_DATA11	0x38
+			MX6QDL_PAD_DISP0_DAT12__IPU1_DISP0_DATA12	0x38
+			MX6QDL_PAD_DISP0_DAT13__IPU1_DISP0_DATA13	0x38
+			MX6QDL_PAD_DISP0_DAT14__IPU1_DISP0_DATA14	0x38
+			MX6QDL_PAD_DISP0_DAT15__IPU1_DISP0_DATA15	0x38
+			MX6QDL_PAD_DISP0_DAT16__IPU1_DISP0_DATA16	0x38
+			MX6QDL_PAD_DISP0_DAT17__IPU1_DISP0_DATA17	0x38
+			MX6QDL_PAD_DISP0_DAT18__IPU1_DISP0_DATA18	0x38
+			MX6QDL_PAD_DISP0_DAT19__IPU1_DISP0_DATA19	0x38
+			MX6QDL_PAD_DISP0_DAT20__IPU1_DISP0_DATA20	0x38
+			MX6QDL_PAD_DISP0_DAT21__IPU1_DISP0_DATA21	0x38
+			MX6QDL_PAD_DISP0_DAT22__IPU1_DISP0_DATA22	0x38
+			MX6QDL_PAD_DISP0_DAT23__IPU1_DISP0_DATA23	0x38
 		>;
 	};
 
 	pinctrl_uart2: uart2grp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_7__UART2_TX_DATA 0x1b0b1
-			MX6QDL_PAD_GPIO_8__UART2_RX_DATA 0x1b0b1
-			MX6QDL_PAD_SD4_DAT5__UART2_RTS_B 0x1b0b1
-			MX6QDL_PAD_SD4_DAT6__UART2_CTS_B 0x1b0b1
+			MX6QDL_PAD_GPIO_7__UART2_TX_DATA		0x1b0b1
+			MX6QDL_PAD_GPIO_8__UART2_RX_DATA		0x1b0b1
+			MX6QDL_PAD_SD4_DAT5__UART2_RTS_B		0x1b0b1
+			MX6QDL_PAD_SD4_DAT6__UART2_CTS_B		0x1b0b1
 		>;
 	};
 
 	pinctrl_usdhc3: usdhc3grp {
 		fsl,pins = <
-			MX6QDL_PAD_SD3_CMD__SD3_CMD	0x17059
-			MX6QDL_PAD_SD3_CLK__SD3_CLK	0x10059
-			MX6QDL_PAD_SD3_DAT0__SD3_DATA0	0x17059
-			MX6QDL_PAD_SD3_DAT1__SD3_DATA1	0x17059
-			MX6QDL_PAD_SD3_DAT2__SD3_DATA2	0x17059
-			MX6QDL_PAD_SD3_DAT3__SD3_DATA3	0x17059
+			MX6QDL_PAD_SD3_CMD__SD3_CMD			0x17059
+			MX6QDL_PAD_SD3_CLK__SD3_CLK			0x10059
+			MX6QDL_PAD_SD3_DAT0__SD3_DATA0			0x17059
+			MX6QDL_PAD_SD3_DAT1__SD3_DATA1			0x17059
+			MX6QDL_PAD_SD3_DAT2__SD3_DATA2			0x17059
+			MX6QDL_PAD_SD3_DAT3__SD3_DATA3			0x17059
 		>;
 	};
 
 	pinctrl_usdhc3_100mhz: usdhc3grp-100mhz {
 		fsl,pins = <
-			MX6QDL_PAD_SD3_CMD__SD3_CMD	0x170B9
-			MX6QDL_PAD_SD3_CLK__SD3_CLK	0x100B9
-			MX6QDL_PAD_SD3_DAT0__SD3_DATA0	0x170B9
-			MX6QDL_PAD_SD3_DAT1__SD3_DATA1	0x170B9
-			MX6QDL_PAD_SD3_DAT2__SD3_DATA2	0x170B9
-			MX6QDL_PAD_SD3_DAT3__SD3_DATA3	0x170B9
+			MX6QDL_PAD_SD3_CMD__SD3_CMD			0x170B9
+			MX6QDL_PAD_SD3_CLK__SD3_CLK			0x100B9
+			MX6QDL_PAD_SD3_DAT0__SD3_DATA0			0x170B9
+			MX6QDL_PAD_SD3_DAT1__SD3_DATA1			0x170B9
+			MX6QDL_PAD_SD3_DAT2__SD3_DATA2			0x170B9
+			MX6QDL_PAD_SD3_DAT3__SD3_DATA3			0x170B9
 		>;
 	};
 
 	pinctrl_usdhc3_200mhz: usdhc3grp-200mhz {
 		fsl,pins = <
-			MX6QDL_PAD_SD3_CMD__SD3_CMD	0x170F9
-			MX6QDL_PAD_SD3_CLK__SD3_CLK	0x100F9
-			MX6QDL_PAD_SD3_DAT0__SD3_DATA0	0x170F9
-			MX6QDL_PAD_SD3_DAT1__SD3_DATA1	0x170F9
-			MX6QDL_PAD_SD3_DAT2__SD3_DATA2	0x170F9
-			MX6QDL_PAD_SD3_DAT3__SD3_DATA3	0x170F9
+			MX6QDL_PAD_SD3_CMD__SD3_CMD			0x170F9
+			MX6QDL_PAD_SD3_CLK__SD3_CLK			0x100F9
+			MX6QDL_PAD_SD3_DAT0__SD3_DATA0			0x170F9
+			MX6QDL_PAD_SD3_DAT1__SD3_DATA1			0x170F9
+			MX6QDL_PAD_SD3_DAT2__SD3_DATA2			0x170F9
+			MX6QDL_PAD_SD3_DAT3__SD3_DATA3			0x170F9
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index 7c4ad54..9ed3068 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -491,463 +491,463 @@
 &iomuxc {
 	pinctrl_apalis_gpio1: gpio2io04grp {
 		fsl,pins = <
-			MX6QDL_PAD_NANDF_D4__GPIO2_IO04 0x130b0
+			MX6QDL_PAD_NANDF_D4__GPIO2_IO04			0x130b0
 		>;
 	};
 
 	pinctrl_apalis_gpio2: gpio2io05grp {
 		fsl,pins = <
-			MX6QDL_PAD_NANDF_D5__GPIO2_IO05 0x130b0
+			MX6QDL_PAD_NANDF_D5__GPIO2_IO05			0x130b0
 		>;
 	};
 
 	pinctrl_apalis_gpio3: gpio2io06grp {
 		fsl,pins = <
-			MX6QDL_PAD_NANDF_D6__GPIO2_IO06 0x130b0
+			MX6QDL_PAD_NANDF_D6__GPIO2_IO06			0x130b0
 		>;
 	};
 
 	pinctrl_apalis_gpio4: gpio2io07grp {
 		fsl,pins = <
-			MX6QDL_PAD_NANDF_D7__GPIO2_IO07 0x130b0
+			MX6QDL_PAD_NANDF_D7__GPIO2_IO07			0x130b0
 		>;
 	};
 
 	pinctrl_apalis_gpio5: gpio6io10grp {
 		fsl,pins = <
-			MX6QDL_PAD_NANDF_RB0__GPIO6_IO10 0x130b0
+			MX6QDL_PAD_NANDF_RB0__GPIO6_IO10		0x130b0
 		>;
 	};
 
 	pinctrl_apalis_gpio6: gpio6io09grp {
 		fsl,pins = <
-			MX6QDL_PAD_NANDF_WP_B__GPIO6_IO09 0x130b0
+			MX6QDL_PAD_NANDF_WP_B__GPIO6_IO09		0x130b0
 		>;
 	};
 
 	pinctrl_apalis_gpio7: gpio1io02grp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_2__GPIO1_IO02 0x130b0
+			MX6QDL_PAD_GPIO_2__GPIO1_IO02			0x130b0
 		>;
 	};
 
 	pinctrl_apalis_gpio8: gpio1io06grp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_6__GPIO1_IO06 0x130b0
+			MX6QDL_PAD_GPIO_6__GPIO1_IO06			0x130b0
 		>;
 	};
 
 	pinctrl_audmux: audmuxgrp {
 		fsl,pins = <
-			MX6QDL_PAD_DISP0_DAT20__AUD4_TXC	0x130b0
-			MX6QDL_PAD_DISP0_DAT21__AUD4_TXD	0x130b0
-			MX6QDL_PAD_DISP0_DAT22__AUD4_TXFS	0x130b0
-			MX6QDL_PAD_DISP0_DAT23__AUD4_RXD	0x130b0
+			MX6QDL_PAD_DISP0_DAT20__AUD4_TXC		0x130b0
+			MX6QDL_PAD_DISP0_DAT21__AUD4_TXD		0x130b0
+			MX6QDL_PAD_DISP0_DAT22__AUD4_TXFS		0x130b0
+			MX6QDL_PAD_DISP0_DAT23__AUD4_RXD		0x130b0
 			/* SGTL5000 sys_mclk */
-			MX6QDL_PAD_GPIO_5__CCM_CLKO1		0x130b0
+			MX6QDL_PAD_GPIO_5__CCM_CLKO1			0x130b0
 		>;
 	};
 
 	pinctrl_cam_mclk: cammclkgrp {
 		fsl,pins = <
 			/* CAM sys_mclk */
-			MX6QDL_PAD_NANDF_CS2__CCM_CLKO2 0x00b0
+			MX6QDL_PAD_NANDF_CS2__CCM_CLKO2			0x00b0
 		>;
 	};
 
 	pinctrl_ecspi1: ecspi1grp {
 		fsl,pins = <
-			MX6QDL_PAD_CSI0_DAT6__ECSPI1_MISO 0x100b1
-			MX6QDL_PAD_CSI0_DAT5__ECSPI1_MOSI 0x100b1
-			MX6QDL_PAD_CSI0_DAT4__ECSPI1_SCLK 0x100b1
+			MX6QDL_PAD_CSI0_DAT6__ECSPI1_MISO		0x100b1
+			MX6QDL_PAD_CSI0_DAT5__ECSPI1_MOSI		0x100b1
+			MX6QDL_PAD_CSI0_DAT4__ECSPI1_SCLK		0x100b1
 			/* SPI1 cs */
-			MX6QDL_PAD_CSI0_DAT7__GPIO5_IO25 0x000b1
+			MX6QDL_PAD_CSI0_DAT7__GPIO5_IO25		0x000b1
 		>;
 	};
 
 	pinctrl_ecspi2: ecspi2grp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_OE__ECSPI2_MISO 0x100b1
-			MX6QDL_PAD_EIM_CS1__ECSPI2_MOSI 0x100b1
-			MX6QDL_PAD_EIM_CS0__ECSPI2_SCLK 0x100b1
+			MX6QDL_PAD_EIM_OE__ECSPI2_MISO			0x100b1
+			MX6QDL_PAD_EIM_CS1__ECSPI2_MOSI			0x100b1
+			MX6QDL_PAD_EIM_CS0__ECSPI2_SCLK			0x100b1
 			/* SPI2 cs */
-			MX6QDL_PAD_EIM_RW__GPIO2_IO26 0x000b1
+			MX6QDL_PAD_EIM_RW__GPIO2_IO26			0x000b1
 		>;
 	};
 
 	pinctrl_enet: enetgrp {
 		fsl,pins = <
-			MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x100b0
-			MX6QDL_PAD_ENET_MDC__ENET_MDC		0x100b0
-			MX6QDL_PAD_RGMII_TXC__RGMII_TXC		0x10030
-			MX6QDL_PAD_RGMII_TD0__RGMII_TD0		0x10030
-			MX6QDL_PAD_RGMII_TD1__RGMII_TD1		0x10030
-			MX6QDL_PAD_RGMII_TD2__RGMII_TD2		0x10030
-			MX6QDL_PAD_RGMII_TD3__RGMII_TD3		0x10030
-			MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL	0x10030
-			MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK	0x100b0
-			MX6QDL_PAD_RGMII_RXC__RGMII_RXC		0x1b030
-			MX6QDL_PAD_RGMII_RD0__RGMII_RD0		0x1b030
-			MX6QDL_PAD_RGMII_RD1__RGMII_RD1		0x1b030
-			MX6QDL_PAD_RGMII_RD2__RGMII_RD2		0x1b030
-			MX6QDL_PAD_RGMII_RD3__RGMII_RD3		0x1b030
-			MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL	0x1b030
+			MX6QDL_PAD_ENET_MDIO__ENET_MDIO			0x100b0
+			MX6QDL_PAD_ENET_MDC__ENET_MDC			0x100b0
+			MX6QDL_PAD_RGMII_TXC__RGMII_TXC			0x10030
+			MX6QDL_PAD_RGMII_TD0__RGMII_TD0			0x10030
+			MX6QDL_PAD_RGMII_TD1__RGMII_TD1			0x10030
+			MX6QDL_PAD_RGMII_TD2__RGMII_TD2			0x10030
+			MX6QDL_PAD_RGMII_TD3__RGMII_TD3			0x10030
+			MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL		0x10030
+			MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK		0x100b0
+			MX6QDL_PAD_RGMII_RXC__RGMII_RXC			0x1b030
+			MX6QDL_PAD_RGMII_RD0__RGMII_RD0			0x1b030
+			MX6QDL_PAD_RGMII_RD1__RGMII_RD1			0x1b030
+			MX6QDL_PAD_RGMII_RD2__RGMII_RD2			0x1b030
+			MX6QDL_PAD_RGMII_RD3__RGMII_RD3			0x1b030
+			MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL		0x1b030
 			/* Ethernet PHY reset */
-			MX6QDL_PAD_ENET_CRS_DV__GPIO1_IO25	0x000b0
+			MX6QDL_PAD_ENET_CRS_DV__GPIO1_IO25		0x000b0
 			/* Ethernet PHY interrupt */
-			MX6QDL_PAD_ENET_TXD0__GPIO1_IO30	0x000b1
+			MX6QDL_PAD_ENET_TXD0__GPIO1_IO30		0x000b1
 		>;
 	};
 
 	pinctrl_flexcan1: flexcan1grp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_7__FLEXCAN1_TX 0x1b0b0
-			MX6QDL_PAD_GPIO_8__FLEXCAN1_RX 0x1b0b0
+			MX6QDL_PAD_GPIO_7__FLEXCAN1_TX			0x1b0b0
+			MX6QDL_PAD_GPIO_8__FLEXCAN1_RX			0x1b0b0
 		>;
 	};
 
 	pinctrl_flexcan2: flexcan2grp {
 		fsl,pins = <
-			MX6QDL_PAD_KEY_COL4__FLEXCAN2_TX 0x1b0b0
-			MX6QDL_PAD_KEY_ROW4__FLEXCAN2_RX 0x1b0b0
+			MX6QDL_PAD_KEY_COL4__FLEXCAN2_TX		0x1b0b0
+			MX6QDL_PAD_KEY_ROW4__FLEXCAN2_RX		0x1b0b0
 		>;
 	};
 
 	pinctrl_gpio_bl_on: gpioblon {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_DA13__GPIO3_IO13 0x1b0b0
+			MX6QDL_PAD_EIM_DA13__GPIO3_IO13			0x1b0b0
 		>;
 	};
 
 	pinctrl_gpio_keys: gpio1io04grp {
 		fsl,pins = <
 			/* Power button */
-			MX6QDL_PAD_GPIO_4__GPIO1_IO04 0x1b0b0
+			MX6QDL_PAD_GPIO_4__GPIO1_IO04			0x1b0b0
 		>;
 	};
 
 	pinctrl_hdmi_cec: hdmicecgrp {
 		fsl,pins = <
-			MX6QDL_PAD_KEY_ROW2__HDMI_TX_CEC_LINE 0x1f8b0
+			MX6QDL_PAD_KEY_ROW2__HDMI_TX_CEC_LINE		0x1f8b0
 		>;
 	};
 
 	pinctrl_hdmi_ddc: hdmiddcgrp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_EB2__HDMI_TX_DDC_SCL 0x4001b8b1
-			MX6QDL_PAD_EIM_D16__HDMI_TX_DDC_SDA 0x4001b8b1
+			MX6QDL_PAD_EIM_EB2__HDMI_TX_DDC_SCL		0x4001b8b1
+			MX6QDL_PAD_EIM_D16__HDMI_TX_DDC_SDA		0x4001b8b1
 		>;
 	};
 
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
-			MX6QDL_PAD_CSI0_DAT8__I2C1_SDA 0x4001b8b1
-			MX6QDL_PAD_CSI0_DAT9__I2C1_SCL 0x4001b8b1
+			MX6QDL_PAD_CSI0_DAT8__I2C1_SDA			0x4001b8b1
+			MX6QDL_PAD_CSI0_DAT9__I2C1_SCL			0x4001b8b1
 		>;
 	};
 
 	pinctrl_i2c2: i2c2grp {
 		fsl,pins = <
-			MX6QDL_PAD_KEY_COL3__I2C2_SCL 0x4001b8b1
-			MX6QDL_PAD_KEY_ROW3__I2C2_SDA 0x4001b8b1
+			MX6QDL_PAD_KEY_COL3__I2C2_SCL			0x4001b8b1
+			MX6QDL_PAD_KEY_ROW3__I2C2_SDA			0x4001b8b1
 		>;
 	};
 
 	pinctrl_i2c3: i2c3grp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_D17__I2C3_SCL 0x4001b8b1
-			MX6QDL_PAD_EIM_D18__I2C3_SDA 0x4001b8b1
+			MX6QDL_PAD_EIM_D17__I2C3_SCL			0x4001b8b1
+			MX6QDL_PAD_EIM_D18__I2C3_SDA			0x4001b8b1
 		>;
 	};
 
 	pinctrl_i2c3_recovery: i2c3recoverygrp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_D17__GPIO3_IO17 0x4001b8b1
-			MX6QDL_PAD_EIM_D18__GPIO3_IO18 0x4001b8b1
+			MX6QDL_PAD_EIM_D17__GPIO3_IO17			0x4001b8b1
+			MX6QDL_PAD_EIM_D18__GPIO3_IO18			0x4001b8b1
 		>;
 	};
 
 	pinctrl_ipu1_csi0: ipu1csi0grp { /* parallel camera */
 		fsl,pins = <
-			MX6QDL_PAD_CSI0_DAT12__IPU1_CSI0_DATA12  0xb0b1
-			MX6QDL_PAD_CSI0_DAT13__IPU1_CSI0_DATA13  0xb0b1
-			MX6QDL_PAD_CSI0_DAT14__IPU1_CSI0_DATA14  0xb0b1
-			MX6QDL_PAD_CSI0_DAT15__IPU1_CSI0_DATA15  0xb0b1
-			MX6QDL_PAD_CSI0_DAT16__IPU1_CSI0_DATA16  0xb0b1
-			MX6QDL_PAD_CSI0_DAT17__IPU1_CSI0_DATA17  0xb0b1
-			MX6QDL_PAD_CSI0_DAT18__IPU1_CSI0_DATA18  0xb0b1
-			MX6QDL_PAD_CSI0_DAT19__IPU1_CSI0_DATA19  0xb0b1
-			MX6QDL_PAD_CSI0_PIXCLK__IPU1_CSI0_PIXCLK 0xb0b1
-			MX6QDL_PAD_CSI0_MCLK__IPU1_CSI0_HSYNC    0xb0b1
-			MX6QDL_PAD_CSI0_VSYNC__IPU1_CSI0_VSYNC   0xb0b1
+			MX6QDL_PAD_CSI0_DAT12__IPU1_CSI0_DATA12		0xb0b1
+			MX6QDL_PAD_CSI0_DAT13__IPU1_CSI0_DATA13		0xb0b1
+			MX6QDL_PAD_CSI0_DAT14__IPU1_CSI0_DATA14		0xb0b1
+			MX6QDL_PAD_CSI0_DAT15__IPU1_CSI0_DATA15		0xb0b1
+			MX6QDL_PAD_CSI0_DAT16__IPU1_CSI0_DATA16		0xb0b1
+			MX6QDL_PAD_CSI0_DAT17__IPU1_CSI0_DATA17		0xb0b1
+			MX6QDL_PAD_CSI0_DAT18__IPU1_CSI0_DATA18		0xb0b1
+			MX6QDL_PAD_CSI0_DAT19__IPU1_CSI0_DATA19		0xb0b1
+			MX6QDL_PAD_CSI0_PIXCLK__IPU1_CSI0_PIXCLK	0xb0b1
+			MX6QDL_PAD_CSI0_MCLK__IPU1_CSI0_HSYNC		0xb0b1
+			MX6QDL_PAD_CSI0_VSYNC__IPU1_CSI0_VSYNC		0xb0b1
 		>;
 	};
 
 	pinctrl_ipu1_lcdif: ipu1lcdifgrp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_A16__IPU1_DI1_DISP_CLK	0x61
+			MX6QDL_PAD_EIM_A16__IPU1_DI1_DISP_CLK		0x61
 			/* DE */
-			MX6QDL_PAD_EIM_DA10__IPU1_DI1_PIN15	0x61
+			MX6QDL_PAD_EIM_DA10__IPU1_DI1_PIN15		0x61
 			/* HSync */
-			MX6QDL_PAD_EIM_DA11__IPU1_DI1_PIN02	0x61
+			MX6QDL_PAD_EIM_DA11__IPU1_DI1_PIN02		0x61
 			/* VSync */
-			MX6QDL_PAD_EIM_DA12__IPU1_DI1_PIN03	0x61
-			MX6QDL_PAD_EIM_DA9__IPU1_DISP1_DATA00	0x61
-			MX6QDL_PAD_EIM_DA8__IPU1_DISP1_DATA01	0x61
-			MX6QDL_PAD_EIM_DA7__IPU1_DISP1_DATA02	0x61
-			MX6QDL_PAD_EIM_DA6__IPU1_DISP1_DATA03	0x61
-			MX6QDL_PAD_EIM_DA5__IPU1_DISP1_DATA04	0x61
-			MX6QDL_PAD_EIM_DA4__IPU1_DISP1_DATA05	0x61
-			MX6QDL_PAD_EIM_DA3__IPU1_DISP1_DATA06	0x61
-			MX6QDL_PAD_EIM_DA2__IPU1_DISP1_DATA07	0x61
-			MX6QDL_PAD_EIM_DA1__IPU1_DISP1_DATA08	0x61
-			MX6QDL_PAD_EIM_DA0__IPU1_DISP1_DATA09	0x61
-			MX6QDL_PAD_EIM_EB1__IPU1_DISP1_DATA10	0x61
-			MX6QDL_PAD_EIM_EB0__IPU1_DISP1_DATA11	0x61
-			MX6QDL_PAD_EIM_A17__IPU1_DISP1_DATA12	0x61
-			MX6QDL_PAD_EIM_A18__IPU1_DISP1_DATA13	0x61
-			MX6QDL_PAD_EIM_A19__IPU1_DISP1_DATA14	0x61
-			MX6QDL_PAD_EIM_A20__IPU1_DISP1_DATA15	0x61
-			MX6QDL_PAD_EIM_A21__IPU1_DISP1_DATA16	0x61
-			MX6QDL_PAD_EIM_A22__IPU1_DISP1_DATA17	0x61
-			MX6QDL_PAD_EIM_A23__IPU1_DISP1_DATA18	0x61
-			MX6QDL_PAD_EIM_A24__IPU1_DISP1_DATA19	0x61
-			MX6QDL_PAD_EIM_D31__IPU1_DISP1_DATA20	0x61
-			MX6QDL_PAD_EIM_D30__IPU1_DISP1_DATA21	0x61
-			MX6QDL_PAD_EIM_D26__IPU1_DISP1_DATA22	0x61
-			MX6QDL_PAD_EIM_D27__IPU1_DISP1_DATA23	0x61
+			MX6QDL_PAD_EIM_DA12__IPU1_DI1_PIN03		0x61
+			MX6QDL_PAD_EIM_DA9__IPU1_DISP1_DATA00		0x61
+			MX6QDL_PAD_EIM_DA8__IPU1_DISP1_DATA01		0x61
+			MX6QDL_PAD_EIM_DA7__IPU1_DISP1_DATA02		0x61
+			MX6QDL_PAD_EIM_DA6__IPU1_DISP1_DATA03		0x61
+			MX6QDL_PAD_EIM_DA5__IPU1_DISP1_DATA04		0x61
+			MX6QDL_PAD_EIM_DA4__IPU1_DISP1_DATA05		0x61
+			MX6QDL_PAD_EIM_DA3__IPU1_DISP1_DATA06		0x61
+			MX6QDL_PAD_EIM_DA2__IPU1_DISP1_DATA07		0x61
+			MX6QDL_PAD_EIM_DA1__IPU1_DISP1_DATA08		0x61
+			MX6QDL_PAD_EIM_DA0__IPU1_DISP1_DATA09		0x61
+			MX6QDL_PAD_EIM_EB1__IPU1_DISP1_DATA10		0x61
+			MX6QDL_PAD_EIM_EB0__IPU1_DISP1_DATA11		0x61
+			MX6QDL_PAD_EIM_A17__IPU1_DISP1_DATA12		0x61
+			MX6QDL_PAD_EIM_A18__IPU1_DISP1_DATA13		0x61
+			MX6QDL_PAD_EIM_A19__IPU1_DISP1_DATA14		0x61
+			MX6QDL_PAD_EIM_A20__IPU1_DISP1_DATA15		0x61
+			MX6QDL_PAD_EIM_A21__IPU1_DISP1_DATA16		0x61
+			MX6QDL_PAD_EIM_A22__IPU1_DISP1_DATA17		0x61
+			MX6QDL_PAD_EIM_A23__IPU1_DISP1_DATA18		0x61
+			MX6QDL_PAD_EIM_A24__IPU1_DISP1_DATA19		0x61
+			MX6QDL_PAD_EIM_D31__IPU1_DISP1_DATA20		0x61
+			MX6QDL_PAD_EIM_D30__IPU1_DISP1_DATA21		0x61
+			MX6QDL_PAD_EIM_D26__IPU1_DISP1_DATA22		0x61
+			MX6QDL_PAD_EIM_D27__IPU1_DISP1_DATA23		0x61
 		>;
 	};
 
 	pinctrl_ipu2_vdac: ipu2vdacgrp {
 		fsl,pins = <
-			MX6QDL_PAD_DI0_DISP_CLK__IPU2_DI0_DISP_CLK 0xd1
-			MX6QDL_PAD_DI0_PIN15__IPU2_DI0_PIN15       0xd1
-			MX6QDL_PAD_DI0_PIN2__IPU2_DI0_PIN02        0xd1
-			MX6QDL_PAD_DI0_PIN3__IPU2_DI0_PIN03        0xd1
-			MX6QDL_PAD_DISP0_DAT0__IPU2_DISP0_DATA00   0xf9
-			MX6QDL_PAD_DISP0_DAT1__IPU2_DISP0_DATA01   0xf9
-			MX6QDL_PAD_DISP0_DAT2__IPU2_DISP0_DATA02   0xf9
-			MX6QDL_PAD_DISP0_DAT3__IPU2_DISP0_DATA03   0xf9
-			MX6QDL_PAD_DISP0_DAT4__IPU2_DISP0_DATA04   0xf9
-			MX6QDL_PAD_DISP0_DAT5__IPU2_DISP0_DATA05   0xf9
-			MX6QDL_PAD_DISP0_DAT6__IPU2_DISP0_DATA06   0xf9
-			MX6QDL_PAD_DISP0_DAT7__IPU2_DISP0_DATA07   0xf9
-			MX6QDL_PAD_DISP0_DAT8__IPU2_DISP0_DATA08   0xf9
-			MX6QDL_PAD_DISP0_DAT9__IPU2_DISP0_DATA09   0xf9
-			MX6QDL_PAD_DISP0_DAT10__IPU2_DISP0_DATA10  0xf9
-			MX6QDL_PAD_DISP0_DAT11__IPU2_DISP0_DATA11  0xf9
-			MX6QDL_PAD_DISP0_DAT12__IPU2_DISP0_DATA12  0xf9
-			MX6QDL_PAD_DISP0_DAT13__IPU2_DISP0_DATA13  0xf9
-			MX6QDL_PAD_DISP0_DAT14__IPU2_DISP0_DATA14  0xf9
-			MX6QDL_PAD_DISP0_DAT15__IPU2_DISP0_DATA15  0xf9
+			MX6QDL_PAD_DI0_DISP_CLK__IPU2_DI0_DISP_CLK	0xd1
+			MX6QDL_PAD_DI0_PIN15__IPU2_DI0_PIN15		0xd1
+			MX6QDL_PAD_DI0_PIN2__IPU2_DI0_PIN02		0xd1
+			MX6QDL_PAD_DI0_PIN3__IPU2_DI0_PIN03		0xd1
+			MX6QDL_PAD_DISP0_DAT0__IPU2_DISP0_DATA00	0xf9
+			MX6QDL_PAD_DISP0_DAT1__IPU2_DISP0_DATA01	0xf9
+			MX6QDL_PAD_DISP0_DAT2__IPU2_DISP0_DATA02	0xf9
+			MX6QDL_PAD_DISP0_DAT3__IPU2_DISP0_DATA03	0xf9
+			MX6QDL_PAD_DISP0_DAT4__IPU2_DISP0_DATA04	0xf9
+			MX6QDL_PAD_DISP0_DAT5__IPU2_DISP0_DATA05	0xf9
+			MX6QDL_PAD_DISP0_DAT6__IPU2_DISP0_DATA06	0xf9
+			MX6QDL_PAD_DISP0_DAT7__IPU2_DISP0_DATA07	0xf9
+			MX6QDL_PAD_DISP0_DAT8__IPU2_DISP0_DATA08	0xf9
+			MX6QDL_PAD_DISP0_DAT9__IPU2_DISP0_DATA09	0xf9
+			MX6QDL_PAD_DISP0_DAT10__IPU2_DISP0_DATA10	0xf9
+			MX6QDL_PAD_DISP0_DAT11__IPU2_DISP0_DATA11	0xf9
+			MX6QDL_PAD_DISP0_DAT12__IPU2_DISP0_DATA12	0xf9
+			MX6QDL_PAD_DISP0_DAT13__IPU2_DISP0_DATA13	0xf9
+			MX6QDL_PAD_DISP0_DAT14__IPU2_DISP0_DATA14	0xf9
+			MX6QDL_PAD_DISP0_DAT15__IPU2_DISP0_DATA15	0xf9
 		>;
 	};
 
 	pinctrl_mmc_cd: gpiommccdgrp {
 		fsl,pins = <
 			 /* MMC1 CD */
-			MX6QDL_PAD_DI0_PIN4__GPIO4_IO20 0x000b0
+			MX6QDL_PAD_DI0_PIN4__GPIO4_IO20			0x000b0
 		>;
 	};
 
 	pinctrl_pwm1: pwm1grp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_9__PWM1_OUT 0x1b0b1
+			MX6QDL_PAD_GPIO_9__PWM1_OUT			0x1b0b1
 		>;
 	};
 
 	pinctrl_pwm2: pwm2grp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_1__PWM2_OUT 0x1b0b1
+			MX6QDL_PAD_GPIO_1__PWM2_OUT			0x1b0b1
 		>;
 	};
 
 	pinctrl_pwm3: pwm3grp {
 		fsl,pins = <
-			MX6QDL_PAD_SD4_DAT1__PWM3_OUT 0x1b0b1
+			MX6QDL_PAD_SD4_DAT1__PWM3_OUT			0x1b0b1
 		>;
 	};
 
 	pinctrl_pwm4: pwm4grp {
 		fsl,pins = <
-			MX6QDL_PAD_SD4_DAT2__PWM4_OUT 0x1b0b1
+			MX6QDL_PAD_SD4_DAT2__PWM4_OUT			0x1b0b1
 		>;
 	};
 
 	pinctrl_regulator_usbh_pwr: gpioregusbhpwrgrp {
 		fsl,pins = <
 			/* USBH_EN */
-			MX6QDL_PAD_GPIO_0__GPIO1_IO00 0x0f058
+			MX6QDL_PAD_GPIO_0__GPIO1_IO00			0x0f058
 		>;
 	};
 
 	pinctrl_regulator_usbhub_pwr: gpioregusbhubpwrgrp {
 		fsl,pins = <
 			/* USBH_HUB_EN */
-			MX6QDL_PAD_EIM_D28__GPIO3_IO28 0x0f058
+			MX6QDL_PAD_EIM_D28__GPIO3_IO28			0x0f058
 		>;
 	};
 
 	pinctrl_regulator_usbotg_pwr: gpioregusbotgpwrgrp {
 		fsl,pins = <
 			/* USBO1 power en */
-			MX6QDL_PAD_EIM_D22__GPIO3_IO22 0x0f058
+			MX6QDL_PAD_EIM_D22__GPIO3_IO22			0x0f058
 		>;
 	};
 
 	pinctrl_reset_moci: gpioresetmocigrp {
 		fsl,pins = <
 			/* RESET_MOCI control */
-			MX6QDL_PAD_ENET_TX_EN__GPIO1_IO28 0x0f058
+			MX6QDL_PAD_ENET_TX_EN__GPIO1_IO28		0x0f058
 		>;
 	};
 
 	pinctrl_sd_cd: gpiosdcdgrp {
 		fsl,pins = <
 			/* SD1 CD */
-			MX6QDL_PAD_NANDF_CS1__GPIO6_IO14 0x000b0
+			MX6QDL_PAD_NANDF_CS1__GPIO6_IO14		0x000b0
 		>;
 	};
 
 	pinctrl_spdif: spdifgrp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_16__SPDIF_IN  0x1b0b0
-			MX6QDL_PAD_GPIO_17__SPDIF_OUT 0x1b0b0
+			MX6QDL_PAD_GPIO_16__SPDIF_IN			0x1b0b0
+			MX6QDL_PAD_GPIO_17__SPDIF_OUT			0x1b0b0
 		>;
 	};
 
 	pinctrl_touch_int: gpiotouchintgrp {
 		fsl,pins = <
 			/* STMPE811 interrupt */
-			MX6QDL_PAD_KEY_COL2__GPIO4_IO10 0x1b0b0
+			MX6QDL_PAD_KEY_COL2__GPIO4_IO10			0x1b0b0
 		>;
 	};
 
 	pinctrl_uart1_dce: uart1dcegrp {
 		fsl,pins = <
-			MX6QDL_PAD_CSI0_DAT10__UART1_TX_DATA 0x1b0b1
-			MX6QDL_PAD_CSI0_DAT11__UART1_RX_DATA 0x1b0b1
+			MX6QDL_PAD_CSI0_DAT10__UART1_TX_DATA		0x1b0b1
+			MX6QDL_PAD_CSI0_DAT11__UART1_RX_DATA		0x1b0b1
 		>;
 	};
 
 	/* DTE mode */
 	pinctrl_uart1_dte: uart1dtegrp {
 		fsl,pins = <
-			MX6QDL_PAD_CSI0_DAT10__UART1_RX_DATA 0x1b0b1
-			MX6QDL_PAD_CSI0_DAT11__UART1_TX_DATA 0x1b0b1
-			MX6QDL_PAD_EIM_D19__UART1_RTS_B 0x1b0b1
-			MX6QDL_PAD_EIM_D20__UART1_CTS_B 0x1b0b1
+			MX6QDL_PAD_CSI0_DAT10__UART1_RX_DATA		0x1b0b1
+			MX6QDL_PAD_CSI0_DAT11__UART1_TX_DATA		0x1b0b1
+			MX6QDL_PAD_EIM_D19__UART1_RTS_B			0x1b0b1
+			MX6QDL_PAD_EIM_D20__UART1_CTS_B			0x1b0b1
 		>;
 	};
 
 	/* Additional DTR, DSR, DCD */
 	pinctrl_uart1_ctrl: uart1ctrlgrp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_D23__UART1_DCD_B 0x1b0b0
-			MX6QDL_PAD_EIM_D24__UART1_DTR_B 0x1b0b0
-			MX6QDL_PAD_EIM_D25__UART1_DSR_B 0x1b0b0
+			MX6QDL_PAD_EIM_D23__UART1_DCD_B			0x1b0b0
+			MX6QDL_PAD_EIM_D24__UART1_DTR_B			0x1b0b0
+			MX6QDL_PAD_EIM_D25__UART1_DSR_B			0x1b0b0
 		>;
 	};
 
 	pinctrl_uart2_dce: uart2dcegrp {
 		fsl,pins = <
-			MX6QDL_PAD_SD4_DAT4__UART2_RX_DATA	0x1b0b1
-			MX6QDL_PAD_SD4_DAT7__UART2_TX_DATA	0x1b0b1
+			MX6QDL_PAD_SD4_DAT4__UART2_RX_DATA		0x1b0b1
+			MX6QDL_PAD_SD4_DAT7__UART2_TX_DATA		0x1b0b1
 		>;
 	};
 
 	/* DTE mode */
 	pinctrl_uart2_dte: uart2dtegrp {
 		fsl,pins = <
-			MX6QDL_PAD_SD4_DAT4__UART2_TX_DATA	0x1b0b1
-			MX6QDL_PAD_SD4_DAT7__UART2_RX_DATA	0x1b0b1
-			MX6QDL_PAD_SD4_DAT6__UART2_RTS_B	0x1b0b1
-			MX6QDL_PAD_SD4_DAT5__UART2_CTS_B	0x1b0b1
+			MX6QDL_PAD_SD4_DAT4__UART2_TX_DATA		0x1b0b1
+			MX6QDL_PAD_SD4_DAT7__UART2_RX_DATA		0x1b0b1
+			MX6QDL_PAD_SD4_DAT6__UART2_RTS_B		0x1b0b1
+			MX6QDL_PAD_SD4_DAT5__UART2_CTS_B		0x1b0b1
 		>;
 	};
 
 	pinctrl_uart4_dce: uart4dcegrp {
 		fsl,pins = <
-			MX6QDL_PAD_KEY_COL0__UART4_TX_DATA 0x1b0b1
-			MX6QDL_PAD_KEY_ROW0__UART4_RX_DATA 0x1b0b1
+			MX6QDL_PAD_KEY_COL0__UART4_TX_DATA		0x1b0b1
+			MX6QDL_PAD_KEY_ROW0__UART4_RX_DATA		0x1b0b1
 		>;
 	};
 
 	/* DTE mode */
 	pinctrl_uart4_dte: uart4dtegrp {
 		fsl,pins = <
-			MX6QDL_PAD_KEY_COL0__UART4_RX_DATA 0x1b0b1
-			MX6QDL_PAD_KEY_ROW0__UART4_TX_DATA 0x1b0b1
+			MX6QDL_PAD_KEY_COL0__UART4_RX_DATA		0x1b0b1
+			MX6QDL_PAD_KEY_ROW0__UART4_TX_DATA		0x1b0b1
 		>;
 	};
 
 	pinctrl_uart5_dce: uart5dcegrp {
 		fsl,pins = <
-			MX6QDL_PAD_KEY_COL1__UART5_TX_DATA 0x1b0b1
-			MX6QDL_PAD_KEY_ROW1__UART5_RX_DATA 0x1b0b1
+			MX6QDL_PAD_KEY_COL1__UART5_TX_DATA		0x1b0b1
+			MX6QDL_PAD_KEY_ROW1__UART5_RX_DATA		0x1b0b1
 		>;
 	};
 
 	/* DTE mode */
 	pinctrl_uart5_dte: uart5dtegrp {
 		fsl,pins = <
-			MX6QDL_PAD_KEY_COL1__UART5_RX_DATA 0x1b0b1
-			MX6QDL_PAD_KEY_ROW1__UART5_TX_DATA 0x1b0b1
+			MX6QDL_PAD_KEY_COL1__UART5_RX_DATA		0x1b0b1
+			MX6QDL_PAD_KEY_ROW1__UART5_TX_DATA		0x1b0b1
 		>;
 	};
 
 	pinctrl_usbotg: usbotggrp {
 		fsl,pins = <
-			MX6QDL_PAD_ENET_RX_ER__USB_OTG_ID 0x17059
+			MX6QDL_PAD_ENET_RX_ER__USB_OTG_ID		0x17059
 		>;
 	};
 
 	pinctrl_usdhc1_4bit: usdhc1grp_4bit {
 		fsl,pins = <
-			MX6QDL_PAD_SD1_CMD__SD1_CMD    0x17071
-			MX6QDL_PAD_SD1_CLK__SD1_CLK    0x10071
-			MX6QDL_PAD_SD1_DAT0__SD1_DATA0 0x17071
-			MX6QDL_PAD_SD1_DAT1__SD1_DATA1 0x17071
-			MX6QDL_PAD_SD1_DAT2__SD1_DATA2 0x17071
-			MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x17071
+			MX6QDL_PAD_SD1_CMD__SD1_CMD			0x17071
+			MX6QDL_PAD_SD1_CLK__SD1_CLK			0x10071
+			MX6QDL_PAD_SD1_DAT0__SD1_DATA0			0x17071
+			MX6QDL_PAD_SD1_DAT1__SD1_DATA1			0x17071
+			MX6QDL_PAD_SD1_DAT2__SD1_DATA2			0x17071
+			MX6QDL_PAD_SD1_DAT3__SD1_DATA3			0x17071
 		>;
 	};
 
 	pinctrl_usdhc1_8bit: usdhc1grp_8bit {
 		fsl,pins = <
-			MX6QDL_PAD_NANDF_D0__SD1_DATA4 0x17071
-			MX6QDL_PAD_NANDF_D1__SD1_DATA5 0x17071
-			MX6QDL_PAD_NANDF_D2__SD1_DATA6 0x17071
-			MX6QDL_PAD_NANDF_D3__SD1_DATA7 0x17071
+			MX6QDL_PAD_NANDF_D0__SD1_DATA4			0x17071
+			MX6QDL_PAD_NANDF_D1__SD1_DATA5			0x17071
+			MX6QDL_PAD_NANDF_D2__SD1_DATA6			0x17071
+			MX6QDL_PAD_NANDF_D3__SD1_DATA7			0x17071
 		>;
 	};
 
 	pinctrl_usdhc2: usdhc2grp {
 		fsl,pins = <
-			MX6QDL_PAD_SD2_CMD__SD2_CMD    0x17071
-			MX6QDL_PAD_SD2_CLK__SD2_CLK    0x10071
-			MX6QDL_PAD_SD2_DAT0__SD2_DATA0 0x17071
-			MX6QDL_PAD_SD2_DAT1__SD2_DATA1 0x17071
-			MX6QDL_PAD_SD2_DAT2__SD2_DATA2 0x17071
-			MX6QDL_PAD_SD2_DAT3__SD2_DATA3 0x17071
+			MX6QDL_PAD_SD2_CMD__SD2_CMD			0x17071
+			MX6QDL_PAD_SD2_CLK__SD2_CLK			0x10071
+			MX6QDL_PAD_SD2_DAT0__SD2_DATA0			0x17071
+			MX6QDL_PAD_SD2_DAT1__SD2_DATA1			0x17071
+			MX6QDL_PAD_SD2_DAT2__SD2_DATA2			0x17071
+			MX6QDL_PAD_SD2_DAT3__SD2_DATA3			0x17071
 		>;
 	};
 
 	pinctrl_usdhc3: usdhc3grp {
 		fsl,pins = <
-			MX6QDL_PAD_SD3_CMD__SD3_CMD    0x17059
-			MX6QDL_PAD_SD3_CLK__SD3_CLK    0x10059
-			MX6QDL_PAD_SD3_DAT0__SD3_DATA0 0x17059
-			MX6QDL_PAD_SD3_DAT1__SD3_DATA1 0x17059
-			MX6QDL_PAD_SD3_DAT2__SD3_DATA2 0x17059
-			MX6QDL_PAD_SD3_DAT3__SD3_DATA3 0x17059
-			MX6QDL_PAD_SD3_DAT4__SD3_DATA4 0x17059
-			MX6QDL_PAD_SD3_DAT5__SD3_DATA5 0x17059
-			MX6QDL_PAD_SD3_DAT6__SD3_DATA6 0x17059
-			MX6QDL_PAD_SD3_DAT7__SD3_DATA7 0x17059
+			MX6QDL_PAD_SD3_CMD__SD3_CMD			0x17059
+			MX6QDL_PAD_SD3_CLK__SD3_CLK			0x10059
+			MX6QDL_PAD_SD3_DAT0__SD3_DATA0			0x17059
+			MX6QDL_PAD_SD3_DAT1__SD3_DATA1			0x17059
+			MX6QDL_PAD_SD3_DAT2__SD3_DATA2			0x17059
+			MX6QDL_PAD_SD3_DAT3__SD3_DATA3			0x17059
+			MX6QDL_PAD_SD3_DAT4__SD3_DATA4			0x17059
+			MX6QDL_PAD_SD3_DAT5__SD3_DATA5			0x17059
+			MX6QDL_PAD_SD3_DAT6__SD3_DATA6			0x17059
+			MX6QDL_PAD_SD3_DAT7__SD3_DATA7			0x17059
 			/* eMMC reset */
-			MX6QDL_PAD_SD3_RST__SD3_RESET  0x17059
+			MX6QDL_PAD_SD3_RST__SD3_RESET			0x17059
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6qdl-apf6dev.dtsi b/arch/arm/boot/dts/imx6qdl-apf6dev.dtsi
index 9fc1fa4..f18a2c2 100644
--- a/arch/arm/boot/dts/imx6qdl-apf6dev.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apf6dev.dtsi
@@ -300,83 +300,83 @@
 	apf6dev {
 		pinctrl_audmux: audmuxgrp {
 			fsl,pins = <
-				MX6QDL_PAD_CSI0_DAT4__AUD3_TXC  0x1b0b0
-				MX6QDL_PAD_CSI0_DAT5__AUD3_TXD  0x1b0b0
-				MX6QDL_PAD_CSI0_DAT6__AUD3_TXFS 0x1b0b0
-				MX6QDL_PAD_CSI0_DAT7__AUD3_RXD  0x1b0b0
-				MX6QDL_PAD_GPIO_0__CCM_CLKO1    0x130b0
+				MX6QDL_PAD_CSI0_DAT4__AUD3_TXC			0x1b0b0
+				MX6QDL_PAD_CSI0_DAT5__AUD3_TXD			0x1b0b0
+				MX6QDL_PAD_CSI0_DAT6__AUD3_TXFS			0x1b0b0
+				MX6QDL_PAD_CSI0_DAT7__AUD3_RXD			0x1b0b0
+				MX6QDL_PAD_GPIO_0__CCM_CLKO1			0x130b0
 			>;
 		};
 
 		pinctrl_ecspi1: ecspi1grp {
 			fsl,pins = <
-				MX6QDL_PAD_KEY_COL1__ECSPI1_MISO 0x100b1
-				MX6QDL_PAD_KEY_ROW0__ECSPI1_MOSI 0x100b1
-				MX6QDL_PAD_KEY_COL0__ECSPI1_SCLK 0x100b1
-				MX6QDL_PAD_KEY_ROW1__GPIO4_IO09  0x1b0b0
-				MX6QDL_PAD_KEY_ROW2__GPIO4_IO11  0x1b0b0
-				MX6QDL_PAD_KEY_COL2__GPIO4_IO10  0x1b0b0
+				MX6QDL_PAD_KEY_COL1__ECSPI1_MISO		0x100b1
+				MX6QDL_PAD_KEY_ROW0__ECSPI1_MOSI		0x100b1
+				MX6QDL_PAD_KEY_COL0__ECSPI1_SCLK		0x100b1
+				MX6QDL_PAD_KEY_ROW1__GPIO4_IO09			0x1b0b0
+				MX6QDL_PAD_KEY_ROW2__GPIO4_IO11			0x1b0b0
+				MX6QDL_PAD_KEY_COL2__GPIO4_IO10			0x1b0b0
 			>;
 		};
 
 		pinctrl_flexcan2: flexcan2grp {
 			fsl,pins = <
-				MX6QDL_PAD_KEY_COL4__FLEXCAN2_TX 0x1b0b0
-				MX6QDL_PAD_KEY_ROW4__FLEXCAN2_RX 0x1b0b0
+				MX6QDL_PAD_KEY_COL4__FLEXCAN2_TX		0x1b0b0
+				MX6QDL_PAD_KEY_ROW4__FLEXCAN2_RX		0x1b0b0
 			>;
 		};
 
 		pinctrl_gpio_keys: gpiokeysgrp {
 			fsl,pins = <
-				MX6QDL_PAD_GPIO_9__GPIO1_IO09 0x1b0b0
+				MX6QDL_PAD_GPIO_9__GPIO1_IO09			0x1b0b0
 			>;
 		};
 
 		pinctrl_gpio_leds: gpioledsgrp {
 			fsl,pins = <
-				MX6QDL_PAD_GPIO_17__GPIO7_IO12 0x130b0
+				MX6QDL_PAD_GPIO_17__GPIO7_IO12			0x130b0
 			>;
 		};
 
 		pinctrl_gpios: gpiosgrp {
 			fsl,pins = <
-				MX6QDL_PAD_DI0_PIN4__GPIO4_IO20		0x100b1
-				MX6QDL_PAD_DISP0_DAT18__GPIO5_IO12	0x100b1
-				MX6QDL_PAD_DISP0_DAT19__GPIO5_IO13	0x100b1
-				MX6QDL_PAD_DISP0_DAT20__GPIO5_IO14	0x100b1
-				MX6QDL_PAD_DISP0_DAT21__GPIO5_IO15	0x100b1
-				MX6QDL_PAD_DISP0_DAT22__GPIO5_IO16	0x100b1
-				MX6QDL_PAD_DISP0_DAT23__GPIO5_IO17	0x100b1
-				MX6QDL_PAD_CSI0_PIXCLK__GPIO5_IO18	0x100b1
-				MX6QDL_PAD_CSI0_VSYNC__GPIO5_IO21	0x100b1
+				MX6QDL_PAD_DI0_PIN4__GPIO4_IO20			0x100b1
+				MX6QDL_PAD_DISP0_DAT18__GPIO5_IO12		0x100b1
+				MX6QDL_PAD_DISP0_DAT19__GPIO5_IO13		0x100b1
+				MX6QDL_PAD_DISP0_DAT20__GPIO5_IO14		0x100b1
+				MX6QDL_PAD_DISP0_DAT21__GPIO5_IO15		0x100b1
+				MX6QDL_PAD_DISP0_DAT22__GPIO5_IO16		0x100b1
+				MX6QDL_PAD_DISP0_DAT23__GPIO5_IO17		0x100b1
+				MX6QDL_PAD_CSI0_PIXCLK__GPIO5_IO18		0x100b1
+				MX6QDL_PAD_CSI0_VSYNC__GPIO5_IO21		0x100b1
 			>;
 		};
 
 		pinctrl_gsm: gsmgrp {
 			fsl,pins = <
-				MX6QDL_PAD_GPIO_4__GPIO1_IO04  0x130b0 /* GSM_POKIN */
-				MX6QDL_PAD_GPIO_18__GPIO7_IO13 0x130b0 /* GSM_PWR_EN */
+				MX6QDL_PAD_GPIO_4__GPIO1_IO04			0x130b0 /* GSM_POKIN */
+				MX6QDL_PAD_GPIO_18__GPIO7_IO13			0x130b0 /* GSM_PWR_EN */
 			>;
 		};
 
 		pinctrl_i2c1: i2c1grp {
 			fsl,pins = <
-				MX6QDL_PAD_CSI0_DAT8__I2C1_SDA 0x4001b8b1
-				MX6QDL_PAD_CSI0_DAT9__I2C1_SCL 0x4001b8b1
+				MX6QDL_PAD_CSI0_DAT8__I2C1_SDA			0x4001b8b1
+				MX6QDL_PAD_CSI0_DAT9__I2C1_SCL			0x4001b8b1
 			>;
 		};
 
 		pinctrl_i2c2: i2c2grp {
 			fsl,pins = <
-				MX6QDL_PAD_KEY_COL3__I2C2_SCL 0x4001b8b1
-				MX6QDL_PAD_KEY_ROW3__I2C2_SDA 0x4001b8b1
+				MX6QDL_PAD_KEY_COL3__I2C2_SCL			0x4001b8b1
+				MX6QDL_PAD_KEY_ROW3__I2C2_SDA			0x4001b8b1
 			>;
 		};
 
 		pinctrl_i2c3: i2c3grp {
 			fsl,pins = <
-				MX6QDL_PAD_GPIO_6__I2C3_SDA 0x4001b8b1
-				MX6QDL_PAD_GPIO_5__I2C3_SCL 0x4001b8b1
+				MX6QDL_PAD_GPIO_6__I2C3_SDA			0x4001b8b1
+				MX6QDL_PAD_GPIO_5__I2C3_SCL			0x4001b8b1
 			>;
 		};
 
@@ -409,65 +409,65 @@
 
 		pinctrl_pcie: pciegrp {
 			fsl,pins = <
-				MX6QDL_PAD_CSI0_DAT16__GPIO6_IO02 0x130b0
+				MX6QDL_PAD_CSI0_DAT16__GPIO6_IO02		0x130b0
 			>;
 		};
 
 		pinctrl_pwm3: pwm3grp {
 			fsl,pins = <
-				MX6QDL_PAD_SD4_DAT1__PWM3_OUT 0x1b0b1
+				MX6QDL_PAD_SD4_DAT1__PWM3_OUT			0x1b0b1
 			>;
 		};
 
 		pinctrl_uart1: uart1grp {
 			fsl,pins = <
-				MX6QDL_PAD_CSI0_DAT10__UART1_TX_DATA 0x1b0b0
-				MX6QDL_PAD_CSI0_DAT11__UART1_RX_DATA 0x1b0b0
+				MX6QDL_PAD_CSI0_DAT10__UART1_TX_DATA		0x1b0b0
+				MX6QDL_PAD_CSI0_DAT11__UART1_RX_DATA		0x1b0b0
 			>;
 		};
 
 		pinctrl_uart3: uart3grp {
 			fsl,pins = <
-				MX6QDL_PAD_EIM_D23__UART3_CTS_B   0x1b0b0
-				MX6QDL_PAD_EIM_D24__UART3_TX_DATA 0x1b0b0
-				MX6QDL_PAD_EIM_D25__UART3_RX_DATA 0x1b0b0
-				MX6QDL_PAD_EIM_D31__UART3_RTS_B   0x1b0b0
+				MX6QDL_PAD_EIM_D23__UART3_CTS_B			0x1b0b0
+				MX6QDL_PAD_EIM_D24__UART3_TX_DATA		0x1b0b0
+				MX6QDL_PAD_EIM_D25__UART3_RX_DATA		0x1b0b0
+				MX6QDL_PAD_EIM_D31__UART3_RTS_B			0x1b0b0
 			>;
 		};
 
 		pinctrl_uart4: uart4grp {
 			fsl,pins = <
-				MX6QDL_PAD_CSI0_DAT12__UART4_TX_DATA 0x1b0b0
-				MX6QDL_PAD_CSI0_DAT13__UART4_RX_DATA 0x1b0b0
+				MX6QDL_PAD_CSI0_DAT12__UART4_TX_DATA		0x1b0b0
+				MX6QDL_PAD_CSI0_DAT13__UART4_RX_DATA		0x1b0b0
 			>;
 		};
 
 		pinctrl_usbotg: usbotggrp {
 			fsl,pins = <
-				MX6QDL_PAD_GPIO_1__USB_OTG_ID 0x1b0b0
+				MX6QDL_PAD_GPIO_1__USB_OTG_ID			0x1b0b0
 			>;
 		};
 
 		pinctrl_usdhc2: usdhc2grp {
 			fsl,pins = <
-				MX6QDL_PAD_SD2_CMD__SD2_CMD    0x17059
-				MX6QDL_PAD_SD2_CLK__SD2_CLK    0x10059
-				MX6QDL_PAD_SD2_DAT0__SD2_DATA0 0x17059
-				MX6QDL_PAD_SD2_DAT1__SD2_DATA1 0x17059
-				MX6QDL_PAD_SD2_DAT2__SD2_DATA2 0x17059
-				MX6QDL_PAD_SD2_DAT3__SD2_DATA3 0x17059
+				MX6QDL_PAD_SD2_CMD__SD2_CMD			0x17059
+				MX6QDL_PAD_SD2_CLK__SD2_CLK			0x10059
+				MX6QDL_PAD_SD2_DAT0__SD2_DATA0			0x17059
+				MX6QDL_PAD_SD2_DAT1__SD2_DATA1			0x17059
+				MX6QDL_PAD_SD2_DAT2__SD2_DATA2			0x17059
+				MX6QDL_PAD_SD2_DAT3__SD2_DATA3			0x17059
 			>;
 		};
 
 		pinctrl_spdif: spdifgrp {
 			fsl,pins = <
-				MX6QDL_PAD_GPIO_19__SPDIF_OUT 0x1b0b0
+				MX6QDL_PAD_GPIO_19__SPDIF_OUT			0x1b0b0
 			>;
 		};
 
 		pinctrl_touchscreen: touchscreengrp {
 			fsl,pins = <
-				MX6QDL_PAD_CSI0_DAT17__GPIO6_IO03 0x1b0b0
+				MX6QDL_PAD_CSI0_DAT17__GPIO6_IO03		0x1b0b0
 			>;
 		};
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-aristainetos.dtsi b/arch/arm/boot/dts/imx6qdl-aristainetos.dtsi
index ee4d0f8..d292cf6 100644
--- a/arch/arm/boot/dts/imx6qdl-aristainetos.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-aristainetos.dtsi
@@ -185,140 +185,140 @@
 
 	imx6qdl-aristainetos {
 		pinctrl_aristainetos_usbh1_vbus: aristainetos-usbh1-vbus {
-			fsl,pins = <MX6QDL_PAD_EIM_D31__GPIO3_IO31 0x130b0>;
+			fsl,pins = <MX6QDL_PAD_EIM_D31__GPIO3_IO31		0x130b0>;
 		};
 
 		pinctrl_aristainetos_usbotg_vbus: aristainetos-usbotg-vbus {
-			fsl,pins = <MX6QDL_PAD_KEY_ROW4__GPIO4_IO15 0x130b0>;
+			fsl,pins = <MX6QDL_PAD_KEY_ROW4__GPIO4_IO15		0x130b0>;
 		};
 
 		pinctrl_audmux: audmuxgrp {
 			fsl,pins = <
-				MX6QDL_PAD_CSI0_DAT7__AUD3_RXD  0x1b0b0
-				MX6QDL_PAD_CSI0_DAT4__AUD3_TXC  0x1b0b0
-				MX6QDL_PAD_CSI0_DAT5__AUD3_TXD  0x1b0b0
-				MX6QDL_PAD_CSI0_DAT6__AUD3_TXFS 0x1b0b0
+				MX6QDL_PAD_CSI0_DAT7__AUD3_RXD			0x1b0b0
+				MX6QDL_PAD_CSI0_DAT4__AUD3_TXC			0x1b0b0
+				MX6QDL_PAD_CSI0_DAT5__AUD3_TXD			0x1b0b0
+				MX6QDL_PAD_CSI0_DAT6__AUD3_TXFS			0x1b0b0
 			>;
 		};
 
 		pinctrl_backlight: backlightgrp {
 			fsl,pins = <
-				MX6QDL_PAD_GPIO_9__PWM1_OUT	0x1b0b0
-				MX6QDL_PAD_SD4_DAT1__PWM3_OUT	0x1b0b0
-				MX6QDL_PAD_GPIO_2__GPIO1_IO02	0x1b0b0
+				MX6QDL_PAD_GPIO_9__PWM1_OUT			0x1b0b0
+				MX6QDL_PAD_SD4_DAT1__PWM3_OUT			0x1b0b0
+				MX6QDL_PAD_GPIO_2__GPIO1_IO02			0x1b0b0
 			>;
 		};
 
 		pinctrl_ecspi2: ecspi2grp {
 			fsl,pins = <
-				MX6QDL_PAD_EIM_OE__ECSPI2_MISO 0x100b1
-				MX6QDL_PAD_EIM_CS0__ECSPI2_SCLK 0x100b1
-				MX6QDL_PAD_EIM_CS1__ECSPI2_MOSI 0x100b1
-				MX6QDL_PAD_EIM_D24__GPIO3_IO24  0x100b1
+				MX6QDL_PAD_EIM_OE__ECSPI2_MISO			0x100b1
+				MX6QDL_PAD_EIM_CS0__ECSPI2_SCLK			0x100b1
+				MX6QDL_PAD_EIM_CS1__ECSPI2_MOSI			0x100b1
+				MX6QDL_PAD_EIM_D24__GPIO3_IO24			0x100b1
 			>;
 		};
 
 		pinctrl_ecspi4: ecspi4grp {
 			fsl,pins = <
-				MX6QDL_PAD_EIM_D21__ECSPI4_SCLK 0x100b1
-				MX6QDL_PAD_EIM_D22__ECSPI4_MISO 0x100b1
-				MX6QDL_PAD_EIM_D28__ECSPI4_MOSI 0x100b1
-				MX6QDL_PAD_EIM_D20__GPIO3_IO20  0x100b1
-				MX6QDL_PAD_SD4_DAT7__GPIO2_IO15 0x1b0b0 /* WP pin */
+				MX6QDL_PAD_EIM_D21__ECSPI4_SCLK			0x100b1
+				MX6QDL_PAD_EIM_D22__ECSPI4_MISO			0x100b1
+				MX6QDL_PAD_EIM_D28__ECSPI4_MOSI			0x100b1
+				MX6QDL_PAD_EIM_D20__GPIO3_IO20			0x100b1
+				MX6QDL_PAD_SD4_DAT7__GPIO2_IO15			0x1b0b0 /* WP pin */
 			>;
 		};
 
 		pinctrl_enet: enetgrp {
 			fsl,pins = <
-				MX6QDL_PAD_GPIO_16__ENET_REF_CLK 0x4001b0a8
-				MX6QDL_PAD_ENET_MDIO__ENET_MDIO  0x1b0b0
-				MX6QDL_PAD_ENET_MDC__ENET_MDC    0x1b0b0
-				MX6QDL_PAD_ENET_TXD0__ENET_TX_DATA0 0x1b0b0
-				MX6QDL_PAD_ENET_TXD1__ENET_TX_DATA1 0x1b0b0
-				MX6QDL_PAD_ENET_TX_EN__ENET_TX_EN   0x1b0b0
-				MX6QDL_PAD_ENET_RX_ER__ENET_RX_ER   0x1b0b0
-				MX6QDL_PAD_ENET_RXD0__ENET_RX_DATA0 0x1b0b0
-				MX6QDL_PAD_ENET_RXD1__ENET_RX_DATA1 0x1b0b0
-				MX6QDL_PAD_ENET_CRS_DV__ENET_RX_EN  0x1b0b0
+				MX6QDL_PAD_GPIO_16__ENET_REF_CLK		0x4001b0a8
+				MX6QDL_PAD_ENET_MDIO__ENET_MDIO			0x1b0b0
+				MX6QDL_PAD_ENET_MDC__ENET_MDC			0x1b0b0
+				MX6QDL_PAD_ENET_TXD0__ENET_TX_DATA0		0x1b0b0
+				MX6QDL_PAD_ENET_TXD1__ENET_TX_DATA1		0x1b0b0
+				MX6QDL_PAD_ENET_TX_EN__ENET_TX_EN		0x1b0b0
+				MX6QDL_PAD_ENET_RX_ER__ENET_RX_ER		0x1b0b0
+				MX6QDL_PAD_ENET_RXD0__ENET_RX_DATA0		0x1b0b0
+				MX6QDL_PAD_ENET_RXD1__ENET_RX_DATA1		0x1b0b0
+				MX6QDL_PAD_ENET_CRS_DV__ENET_RX_EN		0x1b0b0
 			>;
 		};
 
 		pinctrl_flexcan1: flexcan1grp {
 			fsl,pins = <
-				MX6QDL_PAD_KEY_ROW2__FLEXCAN1_RX	0x1b0b0
-				MX6QDL_PAD_KEY_COL2__FLEXCAN1_TX	0x1b0b0
+				MX6QDL_PAD_KEY_ROW2__FLEXCAN1_RX		0x1b0b0
+				MX6QDL_PAD_KEY_COL2__FLEXCAN1_TX		0x1b0b0
 			>;
 		};
 
 		pinctrl_flexcan2: flexcan2grp {
 			fsl,pins = <
-				MX6QDL_PAD_SD3_DAT0__FLEXCAN2_TX	0x1b0b0
-				MX6QDL_PAD_SD3_DAT1__FLEXCAN2_RX	0x1b0b0
+				MX6QDL_PAD_SD3_DAT0__FLEXCAN2_TX		0x1b0b0
+				MX6QDL_PAD_SD3_DAT1__FLEXCAN2_RX		0x1b0b0
 				>;
 		};
 
 		pinctrl_gpio: gpiogrp {
 			fsl,pins = <
-				MX6QDL_PAD_SD4_DAT2__GPIO2_IO10	0x1b0b0
-				MX6QDL_PAD_SD4_DAT3__GPIO2_IO11	0x1b0b0
-				MX6QDL_PAD_SD4_DAT4__GPIO2_IO12 0x1b0b0
-				MX6QDL_PAD_SD4_DAT5__GPIO2_IO13	0x1b0b0
-				MX6QDL_PAD_GPIO_3__GPIO1_IO03	0x1b0b0
-				MX6QDL_PAD_GPIO_4__GPIO1_IO04	0x1b0b0
-				MX6QDL_PAD_GPIO_5__GPIO1_IO05	0x1b0b0
-				MX6QDL_PAD_GPIO_6__GPIO1_IO06	0x1b0b0
-				MX6QDL_PAD_GPIO_7__GPIO1_IO07	0x1b0b0
-				MX6QDL_PAD_GPIO_8__GPIO1_IO08	0x1b0b0
-				MX6QDL_PAD_KEY_COL0__GPIO4_IO06	0x1b0b0
+				MX6QDL_PAD_SD4_DAT2__GPIO2_IO10			0x1b0b0
+				MX6QDL_PAD_SD4_DAT3__GPIO2_IO11			0x1b0b0
+				MX6QDL_PAD_SD4_DAT4__GPIO2_IO12			0x1b0b0
+				MX6QDL_PAD_SD4_DAT5__GPIO2_IO13			0x1b0b0
+				MX6QDL_PAD_GPIO_3__GPIO1_IO03			0x1b0b0
+				MX6QDL_PAD_GPIO_4__GPIO1_IO04			0x1b0b0
+				MX6QDL_PAD_GPIO_5__GPIO1_IO05			0x1b0b0
+				MX6QDL_PAD_GPIO_6__GPIO1_IO06			0x1b0b0
+				MX6QDL_PAD_GPIO_7__GPIO1_IO07			0x1b0b0
+				MX6QDL_PAD_GPIO_8__GPIO1_IO08			0x1b0b0
+				MX6QDL_PAD_KEY_COL0__GPIO4_IO06			0x1b0b0
 			>;
 		};
 
 		pinctrl_gpmi_nand: gpminandgrp {
 			fsl,pins = <
-				MX6QDL_PAD_NANDF_CLE__NAND_CLE     0xb0b1
-				MX6QDL_PAD_NANDF_ALE__NAND_ALE     0xb0b1
-				MX6QDL_PAD_NANDF_WP_B__NAND_WP_B   0xb0b1
-				MX6QDL_PAD_NANDF_RB0__NAND_READY_B 0xb000
-				MX6QDL_PAD_NANDF_CS0__NAND_CE0_B   0xb0b1
-				MX6QDL_PAD_NANDF_CS1__NAND_CE1_B   0xb0b1
-				MX6QDL_PAD_SD4_CMD__NAND_RE_B      0xb0b1
-				MX6QDL_PAD_SD4_CLK__NAND_WE_B      0xb0b1
-				MX6QDL_PAD_NANDF_D0__NAND_DATA00   0xb0b1
-				MX6QDL_PAD_NANDF_D1__NAND_DATA01   0xb0b1
-				MX6QDL_PAD_NANDF_D2__NAND_DATA02   0xb0b1
-				MX6QDL_PAD_NANDF_D3__NAND_DATA03   0xb0b1
-				MX6QDL_PAD_NANDF_D4__NAND_DATA04   0xb0b1
-				MX6QDL_PAD_NANDF_D5__NAND_DATA05   0xb0b1
-				MX6QDL_PAD_NANDF_D6__NAND_DATA06   0xb0b1
-				MX6QDL_PAD_NANDF_D7__NAND_DATA07   0xb0b1
-				MX6QDL_PAD_SD4_DAT0__NAND_DQS      0x00b1
+				MX6QDL_PAD_NANDF_CLE__NAND_CLE			0xb0b1
+				MX6QDL_PAD_NANDF_ALE__NAND_ALE			0xb0b1
+				MX6QDL_PAD_NANDF_WP_B__NAND_WP_B		0xb0b1
+				MX6QDL_PAD_NANDF_RB0__NAND_READY_B		0xb000
+				MX6QDL_PAD_NANDF_CS0__NAND_CE0_B		0xb0b1
+				MX6QDL_PAD_NANDF_CS1__NAND_CE1_B		0xb0b1
+				MX6QDL_PAD_SD4_CMD__NAND_RE_B			0xb0b1
+				MX6QDL_PAD_SD4_CLK__NAND_WE_B			0xb0b1
+				MX6QDL_PAD_NANDF_D0__NAND_DATA00		0xb0b1
+				MX6QDL_PAD_NANDF_D1__NAND_DATA01		0xb0b1
+				MX6QDL_PAD_NANDF_D2__NAND_DATA02		0xb0b1
+				MX6QDL_PAD_NANDF_D3__NAND_DATA03		0xb0b1
+				MX6QDL_PAD_NANDF_D4__NAND_DATA04		0xb0b1
+				MX6QDL_PAD_NANDF_D5__NAND_DATA05		0xb0b1
+				MX6QDL_PAD_NANDF_D6__NAND_DATA06		0xb0b1
+				MX6QDL_PAD_NANDF_D7__NAND_DATA07		0xb0b1
+				MX6QDL_PAD_SD4_DAT0__NAND_DQS			0x00b1
 			>;
 		};
 
 		pinctrl_hog: hoggrp {
 			fsl,pins = <
-				MX6QDL_PAD_EIM_D29__GPIO3_IO29   0x10
+				MX6QDL_PAD_EIM_D29__GPIO3_IO29			0x10
 			>;
 		};
 
 		pinctrl_i2c1: i2c1grp {
 			fsl,pins = <
-				MX6QDL_PAD_CSI0_DAT8__I2C1_SDA 0x4001b8b1
-				MX6QDL_PAD_CSI0_DAT9__I2C1_SCL 0x4001b8b1
+				MX6QDL_PAD_CSI0_DAT8__I2C1_SDA			0x4001b8b1
+				MX6QDL_PAD_CSI0_DAT9__I2C1_SCL			0x4001b8b1
 			>;
 		};
 
 		pinctrl_i2c2: i2c2grp {
 			fsl,pins = <
-				MX6QDL_PAD_KEY_COL3__I2C2_SCL 0x4001b8b1
-				MX6QDL_PAD_KEY_ROW3__I2C2_SDA 0x4001b8b1
+				MX6QDL_PAD_KEY_COL3__I2C2_SCL			0x4001b8b1
+				MX6QDL_PAD_KEY_ROW3__I2C2_SDA			0x4001b8b1
 			>;
 		};
 
 		pinctrl_i2c3: i2c3grp {
 			fsl,pins = <
-				MX6QDL_PAD_EIM_D17__I2C3_SCL 0x4001b8b1
-				MX6QDL_PAD_EIM_D18__I2C3_SDA 0x4001b8b1
+				MX6QDL_PAD_EIM_D17__I2C3_SCL			0x4001b8b1
+				MX6QDL_PAD_EIM_D18__I2C3_SDA			0x4001b8b1
 			>;
 		};
 
@@ -358,54 +358,54 @@
 
 		pinctrl_uart2: uart2grp {
 			fsl,pins = <
-				MX6QDL_PAD_EIM_D26__UART2_TX_DATA 0x1b0b1
-				MX6QDL_PAD_EIM_D27__UART2_RX_DATA 0x1b0b1
+				MX6QDL_PAD_EIM_D26__UART2_TX_DATA		0x1b0b1
+				MX6QDL_PAD_EIM_D27__UART2_RX_DATA		0x1b0b1
 			>;
 		};
 
 		pinctrl_uart4: uart4grp {
 			fsl,pins = <
-				MX6QDL_PAD_CSI0_DAT12__UART4_TX_DATA 0x1b0b1
-				MX6QDL_PAD_CSI0_DAT13__UART4_RX_DATA 0x1b0b1
-				MX6QDL_PAD_CSI0_DAT16__UART4_RTS_B 0x1b0b1
-				MX6QDL_PAD_CSI0_DAT17__UART4_CTS_B 0x1b0b1
+				MX6QDL_PAD_CSI0_DAT12__UART4_TX_DATA		0x1b0b1
+				MX6QDL_PAD_CSI0_DAT13__UART4_RX_DATA		0x1b0b1
+				MX6QDL_PAD_CSI0_DAT16__UART4_RTS_B		0x1b0b1
+				MX6QDL_PAD_CSI0_DAT17__UART4_CTS_B		0x1b0b1
 			>;
 		};
 
 		pinctrl_uart5: uart5grp {
 			fsl,pins = <
-				MX6QDL_PAD_CSI0_DAT14__UART5_TX_DATA 0x1b0b1
-				MX6QDL_PAD_CSI0_DAT15__UART5_RX_DATA 0x1b0b1
+				MX6QDL_PAD_CSI0_DAT14__UART5_TX_DATA		0x1b0b1
+				MX6QDL_PAD_CSI0_DAT15__UART5_RX_DATA		0x1b0b1
 			>;
 		};
 
 		pinctrl_usbotg: usbotggrp {
 			fsl,pins = <
-				MX6QDL_PAD_GPIO_1__USB_OTG_ID 0x17059
+				MX6QDL_PAD_GPIO_1__USB_OTG_ID			0x17059
 			>;
 		};
 
 		pinctrl_usdhc1: usdhc1grp {
 			fsl,pins = <
-				MX6QDL_PAD_SD1_CMD__SD1_CMD    0x17059
-				MX6QDL_PAD_SD1_CLK__SD1_CLK    0x10059
-				MX6QDL_PAD_SD1_DAT0__SD1_DATA0 0x17059
-				MX6QDL_PAD_SD1_DAT1__SD1_DATA1 0x17059
-				MX6QDL_PAD_SD1_DAT2__SD1_DATA2 0x17059
-				MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x17059
-				MX6QDL_PAD_KEY_ROW0__GPIO4_IO07 0x1b0b0
+				MX6QDL_PAD_SD1_CMD__SD1_CMD			0x17059
+				MX6QDL_PAD_SD1_CLK__SD1_CLK			0x10059
+				MX6QDL_PAD_SD1_DAT0__SD1_DATA0			0x17059
+				MX6QDL_PAD_SD1_DAT1__SD1_DATA1			0x17059
+				MX6QDL_PAD_SD1_DAT2__SD1_DATA2			0x17059
+				MX6QDL_PAD_SD1_DAT3__SD1_DATA3			0x17059
+				MX6QDL_PAD_KEY_ROW0__GPIO4_IO07			0x1b0b0
 			>;
 		};
 
 		pinctrl_usdhc2: usdhc2grp {
 			fsl,pins = <
-				MX6QDL_PAD_SD2_CMD__SD2_CMD    0x17059
-				MX6QDL_PAD_SD2_CLK__SD2_CLK    0x10059
-				MX6QDL_PAD_SD2_DAT0__SD2_DATA0 0x17059
-				MX6QDL_PAD_SD2_DAT1__SD2_DATA1 0x17059
-				MX6QDL_PAD_SD2_DAT2__SD2_DATA2 0x17059
-				MX6QDL_PAD_SD2_DAT3__SD2_DATA3 0x17059
-				MX6QDL_PAD_KEY_COL1__GPIO4_IO08 0x1b0b0
+				MX6QDL_PAD_SD2_CMD__SD2_CMD			0x17059
+				MX6QDL_PAD_SD2_CLK__SD2_CLK			0x10059
+				MX6QDL_PAD_SD2_DAT0__SD2_DATA0			0x17059
+				MX6QDL_PAD_SD2_DAT1__SD2_DATA1			0x17059
+				MX6QDL_PAD_SD2_DAT2__SD2_DATA2			0x17059
+				MX6QDL_PAD_SD2_DAT3__SD2_DATA3			0x17059
+				MX6QDL_PAD_KEY_COL1__GPIO4_IO08			0x1b0b0
 			>;
 		};
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi b/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi
index 3767508..48dfeca 100644
--- a/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi
@@ -405,76 +405,76 @@
 
 	pinctrl_audmux: audmux {
 		fsl,pins = <
-			MX6QDL_PAD_CSI0_DAT7__AUD3_RXD  0x1b0b0
-			MX6QDL_PAD_CSI0_DAT4__AUD3_TXC  0x1b0b0
-			MX6QDL_PAD_CSI0_DAT5__AUD3_TXD  0x1b0b0
-			MX6QDL_PAD_CSI0_DAT6__AUD3_TXFS 0x1b0b0
+			MX6QDL_PAD_CSI0_DAT7__AUD3_RXD		0x1b0b0
+			MX6QDL_PAD_CSI0_DAT4__AUD3_TXC		0x1b0b0
+			MX6QDL_PAD_CSI0_DAT5__AUD3_TXD		0x1b0b0
+			MX6QDL_PAD_CSI0_DAT6__AUD3_TXFS		0x1b0b0
 		>;
 	};
 
 	pinctrl_ecspi1: ecspi1grp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_D17__ECSPI1_MISO 0x100b1
-			MX6QDL_PAD_EIM_D18__ECSPI1_MOSI 0x100b1
-			MX6QDL_PAD_EIM_D16__ECSPI1_SCLK 0x100b1
-			MX6QDL_PAD_KEY_ROW1__GPIO4_IO09 0x100b1 /* SS0# */
-			MX6QDL_PAD_KEY_COL2__GPIO4_IO10 0x100b1 /* SS1# */
-			MX6QDL_PAD_KEY_ROW2__GPIO4_IO11 0x100b1 /* SS2# */
+			MX6QDL_PAD_EIM_D17__ECSPI1_MISO		0x100b1
+			MX6QDL_PAD_EIM_D18__ECSPI1_MOSI		0x100b1
+			MX6QDL_PAD_EIM_D16__ECSPI1_SCLK		0x100b1
+			MX6QDL_PAD_KEY_ROW1__GPIO4_IO09		0x100b1 /* SS0# */
+			MX6QDL_PAD_KEY_COL2__GPIO4_IO10		0x100b1 /* SS1# */
+			MX6QDL_PAD_KEY_ROW2__GPIO4_IO11		0x100b1 /* SS2# */
 		>;
 	};
 
 	pinctrl_ecspi2: ecspi2grp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_OE__ECSPI2_MISO  0x100b1
-			MX6QDL_PAD_EIM_CS0__ECSPI2_SCLK 0x100b1
-			MX6QDL_PAD_EIM_CS1__ECSPI2_MOSI 0x100b1
-			MX6QDL_PAD_EIM_RW__GPIO2_IO26   0x100b1 /* SS0# */
-			MX6QDL_PAD_EIM_LBA__GPIO2_IO27  0x100b1 /* SS1# */
+			MX6QDL_PAD_EIM_OE__ECSPI2_MISO		0x100b1
+			MX6QDL_PAD_EIM_CS0__ECSPI2_SCLK		0x100b1
+			MX6QDL_PAD_EIM_CS1__ECSPI2_MOSI		0x100b1
+			MX6QDL_PAD_EIM_RW__GPIO2_IO26		0x100b1 /* SS0# */
+			MX6QDL_PAD_EIM_LBA__GPIO2_IO27		0x100b1 /* SS1# */
 		>;
 	};
 
 	pinctrl_ecspi4: ecspi4grp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_D21__ECSPI4_SCLK 0x100b1
-			MX6QDL_PAD_EIM_D22__ECSPI4_MISO 0x100b1
-			MX6QDL_PAD_EIM_D28__ECSPI4_MOSI 0x100b1
-			MX6QDL_PAD_EIM_D29__GPIO3_IO29  0x100b1 /* SS0# */
-			MX6QDL_PAD_EIM_A25__GPIO5_IO02  0x100b1 /* SS1# */
-			MX6QDL_PAD_SD4_DAT7__GPIO2_IO15 0x1b0b0 /* WP pin */
+			MX6QDL_PAD_EIM_D21__ECSPI4_SCLK		0x100b1
+			MX6QDL_PAD_EIM_D22__ECSPI4_MISO		0x100b1
+			MX6QDL_PAD_EIM_D28__ECSPI4_MOSI		0x100b1
+			MX6QDL_PAD_EIM_D29__GPIO3_IO29		0x100b1 /* SS0# */
+			MX6QDL_PAD_EIM_A25__GPIO5_IO02		0x100b1 /* SS1# */
+			MX6QDL_PAD_SD4_DAT7__GPIO2_IO15		0x1b0b0 /* WP pin */
 		>;
 	};
 
 	pinctrl_enet: enetgrp {
 		fsl,pins = <
-			MX6QDL_PAD_ENET_MDIO__ENET_MDIO       0x1b0b0
-			MX6QDL_PAD_ENET_MDC__ENET_MDC         0x1b0b0
-			MX6QDL_PAD_RGMII_TXC__RGMII_TXC       0x1b0b0
-			MX6QDL_PAD_RGMII_TD0__RGMII_TD0       0x1b0b0
-			MX6QDL_PAD_RGMII_TD1__RGMII_TD1       0x1b0b0
-			MX6QDL_PAD_RGMII_TD2__RGMII_TD2       0x1b0b0
-			MX6QDL_PAD_RGMII_TD3__RGMII_TD3       0x1b0b0
-			MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL 0x1b0b0
-			MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK  0x1b0b0
-			MX6QDL_PAD_RGMII_RXC__RGMII_RXC       0x1b0b0
-			MX6QDL_PAD_RGMII_RD0__RGMII_RD0       0x1b0b0
-			MX6QDL_PAD_RGMII_RD1__RGMII_RD1       0x1b0b0
-			MX6QDL_PAD_RGMII_RD2__RGMII_RD2       0x1b0b0
-			MX6QDL_PAD_RGMII_RD3__RGMII_RD3       0x1b0b0
-			MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL 0x1b0b0
+			MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x1b0b0
+			MX6QDL_PAD_ENET_MDC__ENET_MDC		0x1b0b0
+			MX6QDL_PAD_RGMII_TXC__RGMII_TXC		0x1b0b0
+			MX6QDL_PAD_RGMII_TD0__RGMII_TD0		0x1b0b0
+			MX6QDL_PAD_RGMII_TD1__RGMII_TD1		0x1b0b0
+			MX6QDL_PAD_RGMII_TD2__RGMII_TD2		0x1b0b0
+			MX6QDL_PAD_RGMII_TD3__RGMII_TD3		0x1b0b0
+			MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL	0x1b0b0
+			MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK	0x1b0b0
+			MX6QDL_PAD_RGMII_RXC__RGMII_RXC		0x1b0b0
+			MX6QDL_PAD_RGMII_RD0__RGMII_RD0		0x1b0b0
+			MX6QDL_PAD_RGMII_RD1__RGMII_RD1		0x1b0b0
+			MX6QDL_PAD_RGMII_RD2__RGMII_RD2		0x1b0b0
+			MX6QDL_PAD_RGMII_RD3__RGMII_RD3		0x1b0b0
+			MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL	0x1b0b0
 		>;
 	};
 
 	pinctrl_flexcan1: flexcan1grp {
 		fsl,pins = <
-			MX6QDL_PAD_SD3_CLK__FLEXCAN1_RX 0x1b0b0
-			MX6QDL_PAD_SD3_CMD__FLEXCAN1_TX 0x1b0b0
+			MX6QDL_PAD_SD3_CLK__FLEXCAN1_RX		0x1b0b0
+			MX6QDL_PAD_SD3_CMD__FLEXCAN1_TX		0x1b0b0
 		>;
 	};
 
 	pinctrl_flexcan2: flexcan2grp {
 		fsl,pins = <
-			MX6QDL_PAD_SD3_DAT0__FLEXCAN2_TX 0x1b0b0
-			MX6QDL_PAD_SD3_DAT1__FLEXCAN2_RX 0x1b0b0
+			MX6QDL_PAD_SD3_DAT0__FLEXCAN2_TX	0x1b0b0
+			MX6QDL_PAD_SD3_DAT1__FLEXCAN2_RX	0x1b0b0
 		>;
 	};
 
@@ -498,56 +498,56 @@
 
 	pinctrl_gpmi_nand: gpmi-nand {
 		fsl,pins = <
-			MX6QDL_PAD_NANDF_CLE__NAND_CLE     0xb0b1
-			MX6QDL_PAD_NANDF_ALE__NAND_ALE     0xb0b1
-			MX6QDL_PAD_NANDF_WP_B__NAND_WP_B   0xb0b1
-			MX6QDL_PAD_NANDF_RB0__NAND_READY_B 0xb000
-			MX6QDL_PAD_NANDF_CS0__NAND_CE0_B   0xb0b1
-			MX6QDL_PAD_SD4_CMD__NAND_RE_B      0xb0b1
-			MX6QDL_PAD_SD4_CLK__NAND_WE_B      0xb0b1
-			MX6QDL_PAD_NANDF_D0__NAND_DATA00   0xb0b1
-			MX6QDL_PAD_NANDF_D1__NAND_DATA01   0xb0b1
-			MX6QDL_PAD_NANDF_D2__NAND_DATA02   0xb0b1
-			MX6QDL_PAD_NANDF_D3__NAND_DATA03   0xb0b1
-			MX6QDL_PAD_NANDF_D4__NAND_DATA04   0xb0b1
-			MX6QDL_PAD_NANDF_D5__NAND_DATA05   0xb0b1
-			MX6QDL_PAD_NANDF_D6__NAND_DATA06   0xb0b1
-			MX6QDL_PAD_NANDF_D7__NAND_DATA07   0xb0b1
+			MX6QDL_PAD_NANDF_CLE__NAND_CLE		0xb0b1
+			MX6QDL_PAD_NANDF_ALE__NAND_ALE		0xb0b1
+			MX6QDL_PAD_NANDF_WP_B__NAND_WP_B	0xb0b1
+			MX6QDL_PAD_NANDF_RB0__NAND_READY_B	0xb000
+			MX6QDL_PAD_NANDF_CS0__NAND_CE0_B	0xb0b1
+			MX6QDL_PAD_SD4_CMD__NAND_RE_B		0xb0b1
+			MX6QDL_PAD_SD4_CLK__NAND_WE_B		0xb0b1
+			MX6QDL_PAD_NANDF_D0__NAND_DATA00	0xb0b1
+			MX6QDL_PAD_NANDF_D1__NAND_DATA01	0xb0b1
+			MX6QDL_PAD_NANDF_D2__NAND_DATA02	0xb0b1
+			MX6QDL_PAD_NANDF_D3__NAND_DATA03	0xb0b1
+			MX6QDL_PAD_NANDF_D4__NAND_DATA04	0xb0b1
+			MX6QDL_PAD_NANDF_D5__NAND_DATA05	0xb0b1
+			MX6QDL_PAD_NANDF_D6__NAND_DATA06	0xb0b1
+			MX6QDL_PAD_NANDF_D7__NAND_DATA07	0xb0b1
 		>;
 	};
 
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
-			MX6QDL_PAD_CSI0_DAT8__I2C1_SDA 0x4001b8b1
-			MX6QDL_PAD_CSI0_DAT9__I2C1_SCL 0x4001b8b1
+			MX6QDL_PAD_CSI0_DAT8__I2C1_SDA		0x4001b8b1
+			MX6QDL_PAD_CSI0_DAT9__I2C1_SCL		0x4001b8b1
 		>;
 	};
 
 	pinctrl_i2c2: i2c2grp {
 		fsl,pins = <
-			MX6QDL_PAD_KEY_COL3__I2C2_SCL 0x4001b8b1
-			MX6QDL_PAD_KEY_ROW3__I2C2_SDA 0x4001b8b1
+			MX6QDL_PAD_KEY_COL3__I2C2_SCL		0x4001b8b1
+			MX6QDL_PAD_KEY_ROW3__I2C2_SDA		0x4001b8b1
 		>;
 	};
 
 	pinctrl_i2c3: i2c3grp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_5__I2C3_SCL 0x4001b8b1
-			MX6QDL_PAD_GPIO_6__I2C3_SDA 0x4001b8b1
+			MX6QDL_PAD_GPIO_5__I2C3_SCL		0x4001b8b1
+			MX6QDL_PAD_GPIO_6__I2C3_SDA		0x4001b8b1
 		>;
 	};
 
 	pinctrl_i2c4: i2c4grp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_7__I2C4_SCL 0x4001b8b1
-			MX6QDL_PAD_GPIO_8__I2C4_SDA 0x4001b8b1
+			MX6QDL_PAD_GPIO_7__I2C4_SCL		0x4001b8b1
+			MX6QDL_PAD_GPIO_8__I2C4_SDA		0x4001b8b1
 		>;
 	};
 
 	pinctrl_pwm1: pwm1grp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_9__PWM1_OUT	0x1b0b0
-			MX6QDL_PAD_EIM_BCLK__GPIO6_IO31	0x1b0b0 /* backlight enable */
+			MX6QDL_PAD_GPIO_9__PWM1_OUT		0x1b0b0
+			MX6QDL_PAD_EIM_BCLK__GPIO6_IO31		0x1b0b0 /* backlight enable */
 		>;
 	};
 
@@ -562,35 +562,35 @@
 
 	pinctrl_uart2: uart2grp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_D26__UART2_TX_DATA 0x1b0b1
-			MX6QDL_PAD_EIM_D27__UART2_RX_DATA 0x1b0b1
+			MX6QDL_PAD_EIM_D26__UART2_TX_DATA	0x1b0b1
+			MX6QDL_PAD_EIM_D27__UART2_RX_DATA	0x1b0b1
 		>;
 	};
 
 	pinctrl_uart3: uart3grp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_D24__UART3_TX_DATA 0x1b0b1
-			MX6QDL_PAD_EIM_D25__UART3_RX_DATA 0x1b0b1
-			MX6QDL_PAD_EIM_D31__UART3_RTS_B	  0x1b0b1
-			MX6QDL_PAD_EIM_D23__UART3_CTS_B	  0x1b0b1
+			MX6QDL_PAD_EIM_D24__UART3_TX_DATA	0x1b0b1
+			MX6QDL_PAD_EIM_D25__UART3_RX_DATA	0x1b0b1
+			MX6QDL_PAD_EIM_D31__UART3_RTS_B		0x1b0b1
+			MX6QDL_PAD_EIM_D23__UART3_CTS_B		0x1b0b1
 		>;
 	};
 
 	pinctrl_uart4: uart4grp {
 		fsl,pins = <
-			MX6QDL_PAD_KEY_COL0__UART4_TX_DATA 0x1b0b1
-			MX6QDL_PAD_KEY_ROW0__UART4_RX_DATA 0x1b0b1
+			MX6QDL_PAD_KEY_COL0__UART4_TX_DATA	0x1b0b1
+			MX6QDL_PAD_KEY_ROW0__UART4_RX_DATA	0x1b0b1
 		>;
 	};
 
 	pinctrl_usbotg: usbotggrp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_1__USB_OTG_ID 0x17059
+			MX6QDL_PAD_GPIO_1__USB_OTG_ID		0x17059
 		>;
 	};
 
 	pinctrl_aristainetos2_usbh1_vbus: aristainetos-usbh1-vbus {
-		fsl,pins = <MX6QDL_PAD_GPIO_0__USB_H1_PWR 0x130b0>;
+		fsl,pins = <MX6QDL_PAD_GPIO_0__USB_H1_PWR	0x130b0>;
 	};
 
 	pinctrl_aristainetos2_usbotg_vbus: aristainetos-usbotg-vbus {
@@ -599,12 +599,12 @@
 
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
-			MX6QDL_PAD_SD1_CMD__SD1_CMD    0x17059
-			MX6QDL_PAD_SD1_CLK__SD1_CLK    0x10059
-			MX6QDL_PAD_SD1_DAT0__SD1_DATA0 0x17059
-			MX6QDL_PAD_SD1_DAT1__SD1_DATA1 0x17059
-			MX6QDL_PAD_SD1_DAT2__SD1_DATA2 0x17059
-			MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x17059
+			MX6QDL_PAD_SD1_CMD__SD1_CMD		0x17059
+			MX6QDL_PAD_SD1_CLK__SD1_CLK		0x10059
+			MX6QDL_PAD_SD1_DAT0__SD1_DATA0		0x17059
+			MX6QDL_PAD_SD1_DAT1__SD1_DATA1		0x17059
+			MX6QDL_PAD_SD1_DAT2__SD1_DATA2		0x17059
+			MX6QDL_PAD_SD1_DAT3__SD1_DATA3		0x17059
 			MX6QDL_PAD_ENET_RXD0__GPIO1_IO27	0x1b0b0 /* SD1 card detect input */
 			MX6QDL_PAD_DI0_PIN4__GPIO4_IO20		0x1b0b0 /* SD1 write protect input */
 		>;
@@ -612,12 +612,12 @@
 
 	pinctrl_usdhc2: usdhc2grp {
 		fsl,pins = <
-			MX6QDL_PAD_SD2_CMD__SD2_CMD    0x71
-			MX6QDL_PAD_SD2_CLK__SD2_CLK    0x71
-			MX6QDL_PAD_SD2_DAT0__SD2_DATA0 0x71
-			MX6QDL_PAD_SD2_DAT1__SD2_DATA1 0x71
-			MX6QDL_PAD_SD2_DAT2__SD2_DATA2 0x71
-			MX6QDL_PAD_SD2_DAT3__SD2_DATA3 0x71
+			MX6QDL_PAD_SD2_CMD__SD2_CMD		0x71
+			MX6QDL_PAD_SD2_CLK__SD2_CLK		0x71
+			MX6QDL_PAD_SD2_DAT0__SD2_DATA0		0x71
+			MX6QDL_PAD_SD2_DAT1__SD2_DATA1		0x71
+			MX6QDL_PAD_SD2_DAT2__SD2_DATA2		0x71
+			MX6QDL_PAD_SD2_DAT3__SD2_DATA3		0x71
 			MX6QDL_PAD_SD3_RST__GPIO7_IO08		0x1b0b0 /* SD2 level shifter output enable */
 			MX6QDL_PAD_GPIO_19__GPIO4_IO05		0x1b0b0 /* SD2 card detect input */
 			MX6QDL_PAD_SD4_DAT2__GPIO2_IO10		0x1b0b0 /* SD2 write protect input */
diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
index 1beac22..484c9a3 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -417,29 +417,29 @@
 &iomuxc {
 	pinctrl_audmux: audmuxgrp {
 		fsl,pins = <
-			MX6QDL_PAD_KEY_COL0__AUD5_TXC	0x130b0
-			MX6QDL_PAD_KEY_ROW0__AUD5_TXD	0x130b0
-			MX6QDL_PAD_KEY_COL1__AUD5_TXFS	0x130b0
-			MX6QDL_PAD_KEY_ROW1__AUD5_RXD	0x130b0
+			MX6QDL_PAD_KEY_COL0__AUD5_TXC		0x130b0
+			MX6QDL_PAD_KEY_ROW0__AUD5_TXD		0x130b0
+			MX6QDL_PAD_KEY_COL1__AUD5_TXFS		0x130b0
+			MX6QDL_PAD_KEY_ROW1__AUD5_RXD		0x130b0
 			/* SGTL5000 sys_mclk */
-			MX6QDL_PAD_GPIO_0__CCM_CLKO1	0x000b0
+			MX6QDL_PAD_GPIO_0__CCM_CLKO1		0x000b0
 		>;
 	};
 
 	pinctrl_cam_mclk: cammclkgrp {
 		fsl,pins = <
 			/* Parallel Camera CAM sys_mclk */
-			MX6QDL_PAD_NANDF_CS2__CCM_CLKO2	0x00b0
+			MX6QDL_PAD_NANDF_CS2__CCM_CLKO2		0x00b0
 		>;
 	};
 
 	pinctrl_ecspi4: ecspi4grp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_D22__ECSPI4_MISO	0x100b1
-			MX6QDL_PAD_EIM_D28__ECSPI4_MOSI	0x100b1
-			MX6QDL_PAD_EIM_D21__ECSPI4_SCLK 0x100b1
+			MX6QDL_PAD_EIM_D22__ECSPI4_MISO		0x100b1
+			MX6QDL_PAD_EIM_D28__ECSPI4_MOSI		0x100b1
+			MX6QDL_PAD_EIM_D21__ECSPI4_SCLK		0x100b1
 			/* SPI CS */
-			MX6QDL_PAD_EIM_A25__GPIO5_IO02	0x000b1
+			MX6QDL_PAD_EIM_A25__GPIO5_IO02		0x000b1
 		>;
 	};
 
@@ -454,7 +454,7 @@
 			MX6QDL_PAD_ENET_TXD0__ENET_TX_DATA0	0x1b0b0
 			MX6QDL_PAD_ENET_TXD1__ENET_TX_DATA1	0x1b0b0
 			MX6QDL_PAD_ENET_CRS_DV__ENET_RX_EN	0x1b0b0
-			MX6QDL_PAD_GPIO_16__ENET_REF_CLK     ((1<<30) | 0x1b0b0)
+			MX6QDL_PAD_GPIO_16__ENET_REF_CLK	((1<<30) | 0x1b0b0)
 		>;
 	};
 
@@ -486,29 +486,29 @@
 
 	pinctrl_hdmi_ddc: hdmiddcgrp {
 		fsl,pins = <
-			MX6QDL_PAD_KEY_COL3__HDMI_TX_DDC_SCL 0x4001b8b1
-			MX6QDL_PAD_KEY_ROW3__HDMI_TX_DDC_SDA 0x4001b8b1
+			MX6QDL_PAD_KEY_COL3__HDMI_TX_DDC_SCL	0x4001b8b1
+			MX6QDL_PAD_KEY_ROW3__HDMI_TX_DDC_SDA	0x4001b8b1
 		>;
 	};
 
 	pinctrl_i2c2: i2c2grp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_EB2__I2C2_SCL 0x4001b8b1
-			MX6QDL_PAD_EIM_D16__I2C2_SDA 0x4001b8b1
+			MX6QDL_PAD_EIM_EB2__I2C2_SCL		0x4001b8b1
+			MX6QDL_PAD_EIM_D16__I2C2_SDA		0x4001b8b1
 		>;
 	};
 
 	pinctrl_i2c3: i2c3grp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_3__I2C3_SCL 0x4001b8b1
-			MX6QDL_PAD_GPIO_6__I2C3_SDA 0x4001b8b1
+			MX6QDL_PAD_GPIO_3__I2C3_SCL		0x4001b8b1
+			MX6QDL_PAD_GPIO_6__I2C3_SDA		0x4001b8b1
 		>;
 	};
 
 	pinctrl_i2c3_recovery: i2c3recoverygrp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_3__GPIO1_IO03 0x4001b8b1
-			MX6QDL_PAD_GPIO_6__GPIO1_IO06 0x4001b8b1
+			MX6QDL_PAD_GPIO_3__GPIO1_IO03		0x4001b8b1
+			MX6QDL_PAD_GPIO_6__GPIO1_IO06		0x4001b8b1
 		>;
 	};
 
@@ -561,85 +561,85 @@
 	pinctrl_mic_gnd: gpiomicgnd {
 		fsl,pins = <
 			/* Controls Mic GND, PU or '1' pull Mic GND to GND */
-			MX6QDL_PAD_RGMII_TD1__GPIO6_IO21 0x1b0b0
+			MX6QDL_PAD_RGMII_TD1__GPIO6_IO21	0x1b0b0
 		>;
 	};
 
 	pinctrl_mmc_cd: gpiommccd {
 		fsl,pins = <
-			MX6QDL_PAD_NANDF_D5__GPIO2_IO05	0x1b0b1
+			MX6QDL_PAD_NANDF_D5__GPIO2_IO05		0x1b0b1
 		>;
 	};
 
 	pinctrl_pwm1: pwm1grp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_9__PWM1_OUT	0x1b0b1
+			MX6QDL_PAD_GPIO_9__PWM1_OUT		0x1b0b1
 		>;
 	};
 
 	pinctrl_pwm2: pwm2grp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_1__PWM2_OUT	0x1b0b1
-			MX6QDL_PAD_EIM_A21__GPIO2_IO17	0x00040
+			MX6QDL_PAD_GPIO_1__PWM2_OUT		0x1b0b1
+			MX6QDL_PAD_EIM_A21__GPIO2_IO17		0x00040
 		>;
 	};
 
 	pinctrl_pwm3: pwm3grp {
 		fsl,pins = <
-			MX6QDL_PAD_SD4_DAT1__PWM3_OUT	0x1b0b1
-			MX6QDL_PAD_EIM_A22__GPIO2_IO16	0x00040
+			MX6QDL_PAD_SD4_DAT1__PWM3_OUT		0x1b0b1
+			MX6QDL_PAD_EIM_A22__GPIO2_IO16		0x00040
 		>;
 	};
 
 	pinctrl_pwm4: pwm4grp {
 		fsl,pins = <
-			MX6QDL_PAD_SD4_DAT2__PWM4_OUT	0x1b0b1
+			MX6QDL_PAD_SD4_DAT2__PWM4_OUT		0x1b0b1
 		>;
 	};
 
 	pinctrl_regulator_usbh_pwr: gpioregusbhpwrgrp {
 		fsl,pins = <
 			/* USBH_EN */
-			MX6QDL_PAD_EIM_D31__GPIO3_IO31	0x0f058
+			MX6QDL_PAD_EIM_D31__GPIO3_IO31		0x0f058
 		>;
 	};
 
 	pinctrl_spdif: spdifgrp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_17__SPDIF_OUT 0x1b0b0
+			MX6QDL_PAD_GPIO_17__SPDIF_OUT		0x1b0b0
 		>;
 	};
 
 	pinctrl_touch_int: gpiotouchintgrp {
 		fsl,pins = <
 			/* STMPE811 interrupt */
-			MX6QDL_PAD_RGMII_TD0__GPIO6_IO20 0x1b0b0
+			MX6QDL_PAD_RGMII_TD0__GPIO6_IO20	0x1b0b0
 		>;
 	};
 
 	pinctrl_uart1_dce: uart1dcegrp {
 		fsl,pins = <
-			MX6QDL_PAD_CSI0_DAT10__UART1_TX_DATA 0x1b0b1
-			MX6QDL_PAD_CSI0_DAT11__UART1_RX_DATA 0x1b0b1
+			MX6QDL_PAD_CSI0_DAT10__UART1_TX_DATA	0x1b0b1
+			MX6QDL_PAD_CSI0_DAT11__UART1_RX_DATA	0x1b0b1
 		>;
 	};
 
 	/* DTE mode */
 	pinctrl_uart1_dte: uart1dtegrp {
 		fsl,pins = <
-			MX6QDL_PAD_CSI0_DAT10__UART1_RX_DATA 0x1b0b1
-			MX6QDL_PAD_CSI0_DAT11__UART1_TX_DATA 0x1b0b1
-			MX6QDL_PAD_EIM_D19__UART1_RTS_B	0x1b0b1
-			MX6QDL_PAD_EIM_D20__UART1_CTS_B 0x1b0b1
+			MX6QDL_PAD_CSI0_DAT10__UART1_RX_DATA	0x1b0b1
+			MX6QDL_PAD_CSI0_DAT11__UART1_TX_DATA	0x1b0b1
+			MX6QDL_PAD_EIM_D19__UART1_RTS_B		0x1b0b1
+			MX6QDL_PAD_EIM_D20__UART1_CTS_B		0x1b0b1
 		>;
 	};
 
 	/* Additional DTR, DSR, DCD */
 	pinctrl_uart1_ctrl: uart1ctrlgrp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_D23__UART1_DCD_B 0x1b0b0
-			MX6QDL_PAD_EIM_D24__UART1_DTR_B 0x1b0b0
-			MX6QDL_PAD_EIM_D25__UART1_DSR_B 0x1b0b0
+			MX6QDL_PAD_EIM_D23__UART1_DCD_B		0x1b0b0
+			MX6QDL_PAD_EIM_D24__UART1_DTR_B		0x1b0b0
+			MX6QDL_PAD_EIM_D25__UART1_DSR_B		0x1b0b0
 		>;
 	};
 
@@ -672,50 +672,50 @@
 
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
-			MX6QDL_PAD_SD1_CMD__SD1_CMD	0x17071
-			MX6QDL_PAD_SD1_CLK__SD1_CLK	0x10071
-			MX6QDL_PAD_SD1_DAT0__SD1_DATA0	0x17071
-			MX6QDL_PAD_SD1_DAT1__SD1_DATA1	0x17071
-			MX6QDL_PAD_SD1_DAT2__SD1_DATA2	0x17071
-			MX6QDL_PAD_SD1_DAT3__SD1_DATA3	0x17071
+			MX6QDL_PAD_SD1_CMD__SD1_CMD		0x17071
+			MX6QDL_PAD_SD1_CLK__SD1_CLK		0x10071
+			MX6QDL_PAD_SD1_DAT0__SD1_DATA0		0x17071
+			MX6QDL_PAD_SD1_DAT1__SD1_DATA1		0x17071
+			MX6QDL_PAD_SD1_DAT2__SD1_DATA2		0x17071
+			MX6QDL_PAD_SD1_DAT3__SD1_DATA3		0x17071
 		>;
 	};
 
 	pinctrl_usdhc3: usdhc3grp {
 		fsl,pins = <
-			MX6QDL_PAD_SD3_CMD__SD3_CMD	0x17059
-			MX6QDL_PAD_SD3_CLK__SD3_CLK	0x10059
-			MX6QDL_PAD_SD3_DAT0__SD3_DATA0	0x17059
-			MX6QDL_PAD_SD3_DAT1__SD3_DATA1	0x17059
-			MX6QDL_PAD_SD3_DAT2__SD3_DATA2	0x17059
-			MX6QDL_PAD_SD3_DAT3__SD3_DATA3	0x17059
-			MX6QDL_PAD_SD3_DAT4__SD3_DATA4	0x17059
-			MX6QDL_PAD_SD3_DAT5__SD3_DATA5	0x17059
-			MX6QDL_PAD_SD3_DAT6__SD3_DATA6	0x17059
-			MX6QDL_PAD_SD3_DAT7__SD3_DATA7	0x17059
+			MX6QDL_PAD_SD3_CMD__SD3_CMD		0x17059
+			MX6QDL_PAD_SD3_CLK__SD3_CLK		0x10059
+			MX6QDL_PAD_SD3_DAT0__SD3_DATA0		0x17059
+			MX6QDL_PAD_SD3_DAT1__SD3_DATA1		0x17059
+			MX6QDL_PAD_SD3_DAT2__SD3_DATA2		0x17059
+			MX6QDL_PAD_SD3_DAT3__SD3_DATA3		0x17059
+			MX6QDL_PAD_SD3_DAT4__SD3_DATA4		0x17059
+			MX6QDL_PAD_SD3_DAT5__SD3_DATA5		0x17059
+			MX6QDL_PAD_SD3_DAT6__SD3_DATA6		0x17059
+			MX6QDL_PAD_SD3_DAT7__SD3_DATA7		0x17059
 			/* eMMC reset */
-			MX6QDL_PAD_SD3_RST__SD3_RESET	0x17059
+			MX6QDL_PAD_SD3_RST__SD3_RESET		0x17059
 		>;
 	};
 
 	pinctrl_weim_cs0: weimcs0grp {
 		fsl,pins = <
 			/* nEXT_CS0 */
-			MX6QDL_PAD_EIM_CS0__EIM_CS0_B	0xb0b1
+			MX6QDL_PAD_EIM_CS0__EIM_CS0_B		0xb0b1
 		>;
 	};
 
 	pinctrl_weim_cs1: weimcs1grp {
 		fsl,pins = <
 			/* nEXT_CS1 */
-			MX6QDL_PAD_EIM_CS1__EIM_CS1_B	0xb0b1
+			MX6QDL_PAD_EIM_CS1__EIM_CS1_B		0xb0b1
 		>;
 	};
 
 	pinctrl_weim_cs2: weimcs2grp {
 		fsl,pins = <
 			/* nEXT_CS2 */
-			MX6QDL_PAD_SD2_DAT1__EIM_CS2_B	0xb0b1
+			MX6QDL_PAD_SD2_DAT1__EIM_CS2_B		0xb0b1
 		>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
index e3be453..860037c 100644
--- a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
@@ -157,38 +157,38 @@
 
 		pinctrl_cubox_i_i2c2: cubox-i-i2c2 {
 			fsl,pins = <
-				MX6QDL_PAD_KEY_COL3__I2C2_SCL 0x4001b8b1
-				MX6QDL_PAD_KEY_ROW3__I2C2_SDA 0x4001b8b1
+				MX6QDL_PAD_KEY_COL3__I2C2_SCL		0x4001b8b1
+				MX6QDL_PAD_KEY_ROW3__I2C2_SDA		0x4001b8b1
 			>;
 		};
 
 		pinctrl_cubox_i_i2c3: cubox-i-i2c3 {
 			fsl,pins = <
-				MX6QDL_PAD_EIM_D17__I2C3_SCL 0x4001b8b1
-				MX6QDL_PAD_EIM_D18__I2C3_SDA 0x4001b8b1
+				MX6QDL_PAD_EIM_D17__I2C3_SCL		0x4001b8b1
+				MX6QDL_PAD_EIM_D18__I2C3_SDA		0x4001b8b1
 			>;
 		};
 
 		pinctrl_cubox_i_ir: cubox-i-ir {
 			fsl,pins = <
-				MX6QDL_PAD_EIM_DA9__GPIO3_IO09 0x80000000
+				MX6QDL_PAD_EIM_DA9__GPIO3_IO09		0x80000000
 			>;
 		};
 
 		pinctrl_cubox_i_pwm1: cubox-i-pwm1-front-led {
-			fsl,pins = <MX6QDL_PAD_DISP0_DAT8__PWM1_OUT 0x1b0b0>;
+			fsl,pins = <MX6QDL_PAD_DISP0_DAT8__PWM1_OUT	0x1b0b0>;
 		};
 
 		pinctrl_cubox_i_spdif: cubox-i-spdif {
-			fsl,pins = <MX6QDL_PAD_GPIO_17__SPDIF_OUT 0x13091>;
+			fsl,pins = <MX6QDL_PAD_GPIO_17__SPDIF_OUT	0x13091>;
 		};
 
 		pinctrl_cubox_i_usbh1: cubox-i-usbh1 {
-			fsl,pins = <MX6QDL_PAD_GPIO_3__USB_H1_OC 0x1b0b0>;
+			fsl,pins = <MX6QDL_PAD_GPIO_3__USB_H1_OC	0x1b0b0>;
 		};
 
 		pinctrl_cubox_i_usbh1_vbus: cubox-i-usbh1-vbus {
-			fsl,pins = <MX6QDL_PAD_GPIO_0__GPIO1_IO00 0x4001b0b0>;
+			fsl,pins = <MX6QDL_PAD_GPIO_0__GPIO1_IO00	0x4001b0b0>;
 		};
 
 		pinctrl_cubox_i_usbotg: cubox-i-usbotg {
@@ -197,36 +197,36 @@
 			 * leaving it as a pull-up, even if it is just 10uA.
 			 */
 			fsl,pins = <
-				MX6QDL_PAD_GPIO_1__USB_OTG_ID 0x13059
-				MX6QDL_PAD_KEY_COL4__USB_OTG_OC 0x1b0b0
+				MX6QDL_PAD_GPIO_1__USB_OTG_ID		0x13059
+				MX6QDL_PAD_KEY_COL4__USB_OTG_OC		0x1b0b0
 			>;
 		};
 
 		pinctrl_cubox_i_usbotg_vbus: cubox-i-usbotg-vbus {
-			fsl,pins = <MX6QDL_PAD_EIM_D22__GPIO3_IO22 0x4001b0b0>;
+			fsl,pins = <MX6QDL_PAD_EIM_D22__GPIO3_IO22	0x4001b0b0>;
 		};
 
 		pinctrl_cubox_i_usdhc2_aux: cubox-i-usdhc2-aux {
 			fsl,pins = <
-				MX6QDL_PAD_GPIO_4__GPIO1_IO04    0x1f071
-				MX6QDL_PAD_KEY_ROW1__SD2_VSELECT 0x1b071
+				MX6QDL_PAD_GPIO_4__GPIO1_IO04		0x1f071
+				MX6QDL_PAD_KEY_ROW1__SD2_VSELECT	0x1b071
 			>;
 		};
 
 		pinctrl_cubox_i_usdhc2: cubox-i-usdhc2 {
 			fsl,pins = <
-				MX6QDL_PAD_SD2_CMD__SD2_CMD    0x17059
-				MX6QDL_PAD_SD2_CLK__SD2_CLK    0x10059
-				MX6QDL_PAD_SD2_DAT0__SD2_DATA0 0x17059
-				MX6QDL_PAD_SD2_DAT1__SD2_DATA1 0x17059
-				MX6QDL_PAD_SD2_DAT2__SD2_DATA2 0x17059
-				MX6QDL_PAD_SD2_DAT3__SD2_DATA3 0x13059
+				MX6QDL_PAD_SD2_CMD__SD2_CMD		0x17059
+				MX6QDL_PAD_SD2_CLK__SD2_CLK		0x10059
+				MX6QDL_PAD_SD2_DAT0__SD2_DATA0		0x17059
+				MX6QDL_PAD_SD2_DAT1__SD2_DATA1		0x17059
+				MX6QDL_PAD_SD2_DAT2__SD2_DATA2		0x17059
+				MX6QDL_PAD_SD2_DAT3__SD2_DATA3		0x13059
 			>;
 		};
 
 		pinctrl_gpio_key: gpio-key {
 			fsl,pins = <
-				MX6QDL_PAD_EIM_DA8__GPIO3_IO08	0x17059
+				MX6QDL_PAD_EIM_DA8__GPIO3_IO08		0x17059
 			>;
 		};
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi b/arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi
index ebe7a8b..3e2714d 100644
--- a/arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi
@@ -58,10 +58,10 @@
 	imx6qdl-dfi-fs700-m60 {
 		pinctrl_hog: hoggrp {
 			fsl,pins = <
-				MX6QDL_PAD_ENET_CRS_DV__GPIO1_IO25 0x80000000
-				MX6QDL_PAD_GPIO_18__GPIO7_IO13 0x80000000 /* PMIC irq */
-				MX6QDL_PAD_EIM_D26__GPIO3_IO26 0x80000000 /* MAX11801 irq */
-				MX6QDL_PAD_NANDF_D5__GPIO2_IO05 0x000030b0 /* Backlight enable */
+				MX6QDL_PAD_ENET_CRS_DV__GPIO1_IO25	0x80000000
+				MX6QDL_PAD_GPIO_18__GPIO7_IO13		0x80000000 /* PMIC irq */
+				MX6QDL_PAD_EIM_D26__GPIO3_IO26		0x80000000 /* MAX11801 irq */
+				MX6QDL_PAD_NANDF_D5__GPIO2_IO05		0x000030b0 /* Backlight enable */
 			>;
 		};
 
@@ -114,7 +114,7 @@
 				MX6QDL_PAD_SD2_DAT1__SD2_DATA1		0x17059
 				MX6QDL_PAD_SD2_DAT2__SD2_DATA2		0x17059
 				MX6QDL_PAD_SD2_DAT3__SD2_DATA3		0x17059
-				MX6QDL_PAD_NANDF_D2__GPIO2_IO02 0x80000000 /* card detect */
+				MX6QDL_PAD_NANDF_D2__GPIO2_IO02		0x80000000 /* card detect */
 			>;
 		};
 
@@ -149,7 +149,7 @@
 				MX6QDL_PAD_DISP0_DAT2__ECSPI3_MISO	0x100b1
 				MX6QDL_PAD_DISP0_DAT1__ECSPI3_MOSI	0x100b1
 				MX6QDL_PAD_DISP0_DAT0__ECSPI3_SCLK	0x100b1
-				MX6QDL_PAD_DISP0_DAT3__GPIO4_IO24 0x80000000 /* SPI NOR chipselect */
+				MX6QDL_PAD_DISP0_DAT3__GPIO4_IO24	0x80000000 /* SPI NOR chipselect */
 			>;
 		};
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-emcon.dtsi b/arch/arm/boot/dts/imx6qdl-emcon.dtsi
index 397e205..cc4b7be 100644
--- a/arch/arm/boot/dts/imx6qdl-emcon.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-emcon.dtsi
@@ -359,17 +359,17 @@
 
 	pinctrl_cpi1: csi0grp {
 		fsl,pins = <
-			MX6QDL_PAD_CSI0_PIXCLK__IPU1_CSI0_PIXCLK 0xb0b1
-			MX6QDL_PAD_CSI0_MCLK__IPU1_CSI0_HSYNC	0x1b0b1
-			MX6QDL_PAD_CSI0_VSYNC__IPU1_CSI0_VSYNC	0x1b0b1
-			MX6QDL_PAD_CSI0_DAT12__IPU1_CSI0_DATA12 0x1b0b1
-			MX6QDL_PAD_CSI0_DAT13__IPU1_CSI0_DATA13 0x1b0b1
-			MX6QDL_PAD_CSI0_DAT14__IPU1_CSI0_DATA14 0x1b0b1
-			MX6QDL_PAD_CSI0_DAT15__IPU1_CSI0_DATA15 0x1b0b1
-			MX6QDL_PAD_CSI0_DAT16__IPU1_CSI0_DATA16 0x1b0b1
-			MX6QDL_PAD_CSI0_DAT17__IPU1_CSI0_DATA17 0x1b0b1
-			MX6QDL_PAD_CSI0_DAT18__IPU1_CSI0_DATA18 0x1b0b1
-			MX6QDL_PAD_CSI0_DAT19__IPU1_CSI0_DATA19 0x1b0b1
+			MX6QDL_PAD_CSI0_PIXCLK__IPU1_CSI0_PIXCLK	0xb0b1
+			MX6QDL_PAD_CSI0_MCLK__IPU1_CSI0_HSYNC		0x1b0b1
+			MX6QDL_PAD_CSI0_VSYNC__IPU1_CSI0_VSYNC		0x1b0b1
+			MX6QDL_PAD_CSI0_DAT12__IPU1_CSI0_DATA12		0x1b0b1
+			MX6QDL_PAD_CSI0_DAT13__IPU1_CSI0_DATA13		0x1b0b1
+			MX6QDL_PAD_CSI0_DAT14__IPU1_CSI0_DATA14		0x1b0b1
+			MX6QDL_PAD_CSI0_DAT15__IPU1_CSI0_DATA15		0x1b0b1
+			MX6QDL_PAD_CSI0_DAT16__IPU1_CSI0_DATA16		0x1b0b1
+			MX6QDL_PAD_CSI0_DAT17__IPU1_CSI0_DATA17		0x1b0b1
+			MX6QDL_PAD_CSI0_DAT18__IPU1_CSI0_DATA18		0x1b0b1
+			MX6QDL_PAD_CSI0_DAT19__IPU1_CSI0_DATA19		0x1b0b1
 		>;
 	};
 
@@ -472,14 +472,14 @@
 			MX6QDL_PAD_RGMII_TD1__RGMII_TD1			0x1b030
 			MX6QDL_PAD_RGMII_TD2__RGMII_TD2			0x1b030
 			MX6QDL_PAD_RGMII_TD3__RGMII_TD3			0x1b030
-			MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL	0x1b030
-			MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK	0x4001a0b1
+			MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL		0x1b030
+			MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK		0x4001a0b1
 			MX6QDL_PAD_RGMII_RXC__RGMII_RXC			0x1b030
 			MX6QDL_PAD_RGMII_RD0__RGMII_RD0			0x1b030
 			MX6QDL_PAD_RGMII_RD1__RGMII_RD1			0x1b030
 			MX6QDL_PAD_RGMII_RD2__RGMII_RD2			0x1b030
 			MX6QDL_PAD_RGMII_RD3__RGMII_RD3			0x1b030
-			MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL	0x1b0b0
+			MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL		0x1b0b0
 			MX6QDL_PAD_CSI0_DATA_EN__GPIO5_IO20		0x1b058
 			MX6QDL_PAD_ENET_TXD0__GPIO1_IO30		0x1b0b0
 		 >;
@@ -487,22 +487,22 @@
 
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
-			MX6QDL_PAD_CSI0_DAT8__I2C1_SDA		0x4001b8b1
-			MX6QDL_PAD_CSI0_DAT9__I2C1_SCL		0x4001b8b1
+			MX6QDL_PAD_CSI0_DAT8__I2C1_SDA			0x4001b8b1
+			MX6QDL_PAD_CSI0_DAT9__I2C1_SCL			0x4001b8b1
 		>;
 	};
 
 	pinctrl_i2c2: i2c2grp {
 		fsl,pins = <
-			MX6QDL_PAD_KEY_COL3__I2C2_SCL		0x4001b8b1
-			MX6QDL_PAD_KEY_ROW3__I2C2_SDA		0x4001b8b1
+			MX6QDL_PAD_KEY_COL3__I2C2_SCL			0x4001b8b1
+			MX6QDL_PAD_KEY_ROW3__I2C2_SDA			0x4001b8b1
 		>;
 	};
 
 	pinctrl_i2c3: i2c3grp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_3__I2C3_SCL		0x4000b070
-			MX6QDL_PAD_GPIO_6__I2C3_SDA		0x4001b870
+			MX6QDL_PAD_GPIO_3__I2C3_SCL			0x4000b070
+			MX6QDL_PAD_GPIO_6__I2C3_SDA			0x4001b870
 		>;
 	};
 
@@ -576,34 +576,34 @@
 
 	pinctrl_rgb24_display: rgbgrp {
 		fsl,pins = <
-			MX6QDL_PAD_DI0_DISP_CLK__IPU1_DI0_DISP_CLK 0x10
-			MX6QDL_PAD_DI0_PIN15__IPU1_DI0_PIN15       0x10
-			MX6QDL_PAD_DI0_PIN2__IPU1_DI0_PIN02        0x10
-			MX6QDL_PAD_DI0_PIN3__IPU1_DI0_PIN03        0x10
-			MX6QDL_PAD_DISP0_DAT0__IPU1_DISP0_DATA00   0x10
-			MX6QDL_PAD_DISP0_DAT1__IPU1_DISP0_DATA01   0x10
-			MX6QDL_PAD_DISP0_DAT2__IPU1_DISP0_DATA02   0x10
-			MX6QDL_PAD_DISP0_DAT3__IPU1_DISP0_DATA03   0x10
-			MX6QDL_PAD_DISP0_DAT4__IPU1_DISP0_DATA04   0x10
-			MX6QDL_PAD_DISP0_DAT5__IPU1_DISP0_DATA05   0x10
-			MX6QDL_PAD_DISP0_DAT6__IPU1_DISP0_DATA06   0x10
-			MX6QDL_PAD_DISP0_DAT7__IPU1_DISP0_DATA07   0x10
-			MX6QDL_PAD_DISP0_DAT8__IPU1_DISP0_DATA08   0x10
-			MX6QDL_PAD_DISP0_DAT9__IPU1_DISP0_DATA09   0x10
-			MX6QDL_PAD_DISP0_DAT10__IPU1_DISP0_DATA10  0x10
-			MX6QDL_PAD_DISP0_DAT11__IPU1_DISP0_DATA11  0x10
-			MX6QDL_PAD_DISP0_DAT12__IPU1_DISP0_DATA12  0x10
-			MX6QDL_PAD_DISP0_DAT13__IPU1_DISP0_DATA13  0x10
-			MX6QDL_PAD_DISP0_DAT14__IPU1_DISP0_DATA14  0x10
-			MX6QDL_PAD_DISP0_DAT15__IPU1_DISP0_DATA15  0x10
-			MX6QDL_PAD_DISP0_DAT16__IPU1_DISP0_DATA16  0x10
-			MX6QDL_PAD_DISP0_DAT17__IPU1_DISP0_DATA17  0x10
-			MX6QDL_PAD_DISP0_DAT18__IPU1_DISP0_DATA18  0x10
-			MX6QDL_PAD_DISP0_DAT19__IPU1_DISP0_DATA19  0x10
-			MX6QDL_PAD_DISP0_DAT20__IPU1_DISP0_DATA20  0x10
-			MX6QDL_PAD_DISP0_DAT21__IPU1_DISP0_DATA21  0x10
-			MX6QDL_PAD_DISP0_DAT22__IPU1_DISP0_DATA22  0x10
-			MX6QDL_PAD_DISP0_DAT23__IPU1_DISP0_DATA23  0x10
+			MX6QDL_PAD_DI0_DISP_CLK__IPU1_DI0_DISP_CLK	0x10
+			MX6QDL_PAD_DI0_PIN15__IPU1_DI0_PIN15		0x10
+			MX6QDL_PAD_DI0_PIN2__IPU1_DI0_PIN02		0x10
+			MX6QDL_PAD_DI0_PIN3__IPU1_DI0_PIN03		0x10
+			MX6QDL_PAD_DISP0_DAT0__IPU1_DISP0_DATA00	0x10
+			MX6QDL_PAD_DISP0_DAT1__IPU1_DISP0_DATA01	0x10
+			MX6QDL_PAD_DISP0_DAT2__IPU1_DISP0_DATA02	0x10
+			MX6QDL_PAD_DISP0_DAT3__IPU1_DISP0_DATA03	0x10
+			MX6QDL_PAD_DISP0_DAT4__IPU1_DISP0_DATA04	0x10
+			MX6QDL_PAD_DISP0_DAT5__IPU1_DISP0_DATA05	0x10
+			MX6QDL_PAD_DISP0_DAT6__IPU1_DISP0_DATA06	0x10
+			MX6QDL_PAD_DISP0_DAT7__IPU1_DISP0_DATA07	0x10
+			MX6QDL_PAD_DISP0_DAT8__IPU1_DISP0_DATA08	0x10
+			MX6QDL_PAD_DISP0_DAT9__IPU1_DISP0_DATA09	0x10
+			MX6QDL_PAD_DISP0_DAT10__IPU1_DISP0_DATA10	0x10
+			MX6QDL_PAD_DISP0_DAT11__IPU1_DISP0_DATA11	0x10
+			MX6QDL_PAD_DISP0_DAT12__IPU1_DISP0_DATA12	0x10
+			MX6QDL_PAD_DISP0_DAT13__IPU1_DISP0_DATA13	0x10
+			MX6QDL_PAD_DISP0_DAT14__IPU1_DISP0_DATA14	0x10
+			MX6QDL_PAD_DISP0_DAT15__IPU1_DISP0_DATA15	0x10
+			MX6QDL_PAD_DISP0_DAT16__IPU1_DISP0_DATA16	0x10
+			MX6QDL_PAD_DISP0_DAT17__IPU1_DISP0_DATA17	0x10
+			MX6QDL_PAD_DISP0_DAT18__IPU1_DISP0_DATA18	0x10
+			MX6QDL_PAD_DISP0_DAT19__IPU1_DISP0_DATA19	0x10
+			MX6QDL_PAD_DISP0_DAT20__IPU1_DISP0_DATA20	0x10
+			MX6QDL_PAD_DISP0_DAT21__IPU1_DISP0_DATA21	0x10
+			MX6QDL_PAD_DISP0_DAT22__IPU1_DISP0_DATA22	0x10
+			MX6QDL_PAD_DISP0_DAT23__IPU1_DISP0_DATA23	0x10
 		>;
 	};
 
@@ -634,8 +634,8 @@
 
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
-			MX6QDL_PAD_CSI0_DAT10__UART1_TX_DATA	0x1b0b1
-			MX6QDL_PAD_CSI0_DAT11__UART1_RX_DATA	0x1b0b1
+			MX6QDL_PAD_CSI0_DAT10__UART1_TX_DATA		0x1b0b1
+			MX6QDL_PAD_CSI0_DAT11__UART1_RX_DATA		0x1b0b1
 		>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
index d360996..fa68228 100644
--- a/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
@@ -335,171 +335,171 @@
 &iomuxc {
 	pinctrl_adv7180: adv7180grp {
 		fsl,pins = <
-			MX6QDL_PAD_CSI0_DAT5__GPIO5_IO23        0x0001b0b0
-			MX6QDL_PAD_CSI0_DATA_EN__GPIO5_IO20     0x4001b0b0
+			MX6QDL_PAD_CSI0_DAT5__GPIO5_IO23		0x0001b0b0
+			MX6QDL_PAD_CSI0_DATA_EN__GPIO5_IO20		0x4001b0b0
 		>;
 	};
 
 	pinctrl_enet: enetgrp {
 		fsl,pins = <
-			MX6QDL_PAD_RGMII_RXC__RGMII_RXC		0x1b030
-			MX6QDL_PAD_RGMII_RD0__RGMII_RD0		0x1b030
-			MX6QDL_PAD_RGMII_RD1__RGMII_RD1		0x1b030
-			MX6QDL_PAD_RGMII_RD2__RGMII_RD2		0x1b030
-			MX6QDL_PAD_RGMII_RD3__RGMII_RD3		0x1b030
-			MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL	0x1b030
-			MX6QDL_PAD_RGMII_TXC__RGMII_TXC		0x1b030
-			MX6QDL_PAD_RGMII_TD0__RGMII_TD0		0x1b030
-			MX6QDL_PAD_RGMII_TD1__RGMII_TD1		0x1b030
-			MX6QDL_PAD_RGMII_TD2__RGMII_TD2		0x1b030
-			MX6QDL_PAD_RGMII_TD3__RGMII_TD3		0x1b030
-			MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL	0x1b030
-			MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK	0x1b0b0
-			MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x1b0b0
-			MX6QDL_PAD_ENET_MDC__ENET_MDC		0x1b0b0
-			MX6QDL_PAD_GPIO_16__ENET_REF_CLK	0x4001b0a8
-			MX6QDL_PAD_ENET_TXD0__GPIO1_IO30	0x1b0b0 /* PHY Reset */
+			MX6QDL_PAD_RGMII_RXC__RGMII_RXC			0x1b030
+			MX6QDL_PAD_RGMII_RD0__RGMII_RD0			0x1b030
+			MX6QDL_PAD_RGMII_RD1__RGMII_RD1			0x1b030
+			MX6QDL_PAD_RGMII_RD2__RGMII_RD2			0x1b030
+			MX6QDL_PAD_RGMII_RD3__RGMII_RD3			0x1b030
+			MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL		0x1b030
+			MX6QDL_PAD_RGMII_TXC__RGMII_TXC			0x1b030
+			MX6QDL_PAD_RGMII_TD0__RGMII_TD0			0x1b030
+			MX6QDL_PAD_RGMII_TD1__RGMII_TD1			0x1b030
+			MX6QDL_PAD_RGMII_TD2__RGMII_TD2			0x1b030
+			MX6QDL_PAD_RGMII_TD3__RGMII_TD3			0x1b030
+			MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL		0x1b030
+			MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK		0x1b0b0
+			MX6QDL_PAD_ENET_MDIO__ENET_MDIO			0x1b0b0
+			MX6QDL_PAD_ENET_MDC__ENET_MDC			0x1b0b0
+			MX6QDL_PAD_GPIO_16__ENET_REF_CLK		0x4001b0a8
+			MX6QDL_PAD_ENET_TXD0__GPIO1_IO30		0x1b0b0 /* PHY Reset */
 		>;
 	};
 
 	pinctrl_gpio_leds: gpioledsgrp {
 		fsl,pins = <
-			MX6QDL_PAD_KEY_COL0__GPIO4_IO06		0x1b0b0
-			MX6QDL_PAD_KEY_ROW0__GPIO4_IO07		0x1b0b0
+			MX6QDL_PAD_KEY_COL0__GPIO4_IO06			0x1b0b0
+			MX6QDL_PAD_KEY_ROW0__GPIO4_IO07			0x1b0b0
 		>;
 	};
 
 	pinctrl_gpmi_nand: gpminandgrp {
 		fsl,pins = <
-			MX6QDL_PAD_NANDF_CLE__NAND_CLE		0xb0b1
-			MX6QDL_PAD_NANDF_ALE__NAND_ALE		0xb0b1
-			MX6QDL_PAD_NANDF_WP_B__NAND_WP_B	0xb0b1
-			MX6QDL_PAD_NANDF_RB0__NAND_READY_B	0xb000
-			MX6QDL_PAD_NANDF_CS0__NAND_CE0_B	0xb0b1
-			MX6QDL_PAD_SD4_CMD__NAND_RE_B		0xb0b1
-			MX6QDL_PAD_SD4_CLK__NAND_WE_B		0xb0b1
-			MX6QDL_PAD_NANDF_D0__NAND_DATA00	0xb0b1
-			MX6QDL_PAD_NANDF_D1__NAND_DATA01	0xb0b1
-			MX6QDL_PAD_NANDF_D2__NAND_DATA02	0xb0b1
-			MX6QDL_PAD_NANDF_D3__NAND_DATA03	0xb0b1
-			MX6QDL_PAD_NANDF_D4__NAND_DATA04	0xb0b1
-			MX6QDL_PAD_NANDF_D5__NAND_DATA05	0xb0b1
-			MX6QDL_PAD_NANDF_D6__NAND_DATA06	0xb0b1
-			MX6QDL_PAD_NANDF_D7__NAND_DATA07	0xb0b1
+			MX6QDL_PAD_NANDF_CLE__NAND_CLE			0xb0b1
+			MX6QDL_PAD_NANDF_ALE__NAND_ALE			0xb0b1
+			MX6QDL_PAD_NANDF_WP_B__NAND_WP_B		0xb0b1
+			MX6QDL_PAD_NANDF_RB0__NAND_READY_B		0xb000
+			MX6QDL_PAD_NANDF_CS0__NAND_CE0_B		0xb0b1
+			MX6QDL_PAD_SD4_CMD__NAND_RE_B			0xb0b1
+			MX6QDL_PAD_SD4_CLK__NAND_WE_B			0xb0b1
+			MX6QDL_PAD_NANDF_D0__NAND_DATA00		0xb0b1
+			MX6QDL_PAD_NANDF_D1__NAND_DATA01		0xb0b1
+			MX6QDL_PAD_NANDF_D2__NAND_DATA02		0xb0b1
+			MX6QDL_PAD_NANDF_D3__NAND_DATA03		0xb0b1
+			MX6QDL_PAD_NANDF_D4__NAND_DATA04		0xb0b1
+			MX6QDL_PAD_NANDF_D5__NAND_DATA05		0xb0b1
+			MX6QDL_PAD_NANDF_D6__NAND_DATA06		0xb0b1
+			MX6QDL_PAD_NANDF_D7__NAND_DATA07		0xb0b1
 		>;
 	};
 
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_D21__I2C1_SCL		0x4001b8b1
-			MX6QDL_PAD_EIM_D28__I2C1_SDA		0x4001b8b1
+			MX6QDL_PAD_EIM_D21__I2C1_SCL			0x4001b8b1
+			MX6QDL_PAD_EIM_D28__I2C1_SDA			0x4001b8b1
 		>;
 	};
 
 	pinctrl_i2c2: i2c2grp {
 		fsl,pins = <
-			MX6QDL_PAD_KEY_COL3__I2C2_SCL		0x4001b8b1
-			MX6QDL_PAD_KEY_ROW3__I2C2_SDA		0x4001b8b1
+			MX6QDL_PAD_KEY_COL3__I2C2_SCL			0x4001b8b1
+			MX6QDL_PAD_KEY_ROW3__I2C2_SDA			0x4001b8b1
 		>;
 	};
 
 	pinctrl_i2c3: i2c3grp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_3__I2C3_SCL		0x4001b8b1
-			MX6QDL_PAD_GPIO_6__I2C3_SDA		0x4001b8b1
+			MX6QDL_PAD_GPIO_3__I2C3_SCL			0x4001b8b1
+			MX6QDL_PAD_GPIO_6__I2C3_SDA			0x4001b8b1
 		>;
 	};
 
 	pinctrl_ipu1_csi0: ipu1csi0grp {
 		fsl,pins = <
-			MX6QDL_PAD_CSI0_DAT12__IPU1_CSI0_DATA12    0x1b0b0
-			MX6QDL_PAD_CSI0_DAT13__IPU1_CSI0_DATA13    0x1b0b0
-			MX6QDL_PAD_CSI0_DAT14__IPU1_CSI0_DATA14    0x1b0b0
-			MX6QDL_PAD_CSI0_DAT15__IPU1_CSI0_DATA15    0x1b0b0
-			MX6QDL_PAD_CSI0_DAT16__IPU1_CSI0_DATA16    0x1b0b0
-			MX6QDL_PAD_CSI0_DAT17__IPU1_CSI0_DATA17    0x1b0b0
-			MX6QDL_PAD_CSI0_DAT18__IPU1_CSI0_DATA18    0x1b0b0
-			MX6QDL_PAD_CSI0_DAT19__IPU1_CSI0_DATA19    0x1b0b0
-			MX6QDL_PAD_CSI0_MCLK__IPU1_CSI0_HSYNC      0x1b0b0
-			MX6QDL_PAD_CSI0_VSYNC__IPU1_CSI0_VSYNC     0x1b0b0
-			MX6QDL_PAD_CSI0_PIXCLK__IPU1_CSI0_PIXCLK   0x1b0b0
+			MX6QDL_PAD_CSI0_DAT12__IPU1_CSI0_DATA12		0x1b0b0
+			MX6QDL_PAD_CSI0_DAT13__IPU1_CSI0_DATA13		0x1b0b0
+			MX6QDL_PAD_CSI0_DAT14__IPU1_CSI0_DATA14		0x1b0b0
+			MX6QDL_PAD_CSI0_DAT15__IPU1_CSI0_DATA15		0x1b0b0
+			MX6QDL_PAD_CSI0_DAT16__IPU1_CSI0_DATA16		0x1b0b0
+			MX6QDL_PAD_CSI0_DAT17__IPU1_CSI0_DATA17		0x1b0b0
+			MX6QDL_PAD_CSI0_DAT18__IPU1_CSI0_DATA18		0x1b0b0
+			MX6QDL_PAD_CSI0_DAT19__IPU1_CSI0_DATA19		0x1b0b0
+			MX6QDL_PAD_CSI0_MCLK__IPU1_CSI0_HSYNC		0x1b0b0
+			MX6QDL_PAD_CSI0_VSYNC__IPU1_CSI0_VSYNC		0x1b0b0
+			MX6QDL_PAD_CSI0_PIXCLK__IPU1_CSI0_PIXCLK	0x1b0b0
 		>;
 	};
 
 	pinctrl_pcie: pciegrp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_0__GPIO1_IO00		0x1b0b0
+			MX6QDL_PAD_GPIO_0__GPIO1_IO00			0x1b0b0
 		>;
 	};
 
 	pinctrl_pmic: pmicgrp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_8__GPIO1_IO08		0x0001b0b0 /* PMIC_IRQ# */
+			MX6QDL_PAD_GPIO_8__GPIO1_IO08			0x0001b0b0 /* PMIC_IRQ# */
 		>;
 	};
 
 	pinctrl_pps: ppsgrp {
 		fsl,pins = <
-			MX6QDL_PAD_ENET_RXD1__GPIO1_IO26	0x1b0b1
+			MX6QDL_PAD_ENET_RXD1__GPIO1_IO26		0x1b0b1
 		>;
 	};
 
 	pinctrl_pwm2: pwm2grp {
 		fsl,pins = <
-			MX6QDL_PAD_SD1_DAT2__PWM2_OUT		0x1b0b1
+			MX6QDL_PAD_SD1_DAT2__PWM2_OUT			0x1b0b1
 		>;
 	};
 
 	pinctrl_pwm3: pwm3grp {
 		fsl,pins = <
-			MX6QDL_PAD_SD1_DAT1__PWM3_OUT		0x1b0b1
+			MX6QDL_PAD_SD1_DAT1__PWM3_OUT			0x1b0b1
 		>;
 	};
 
 	pinctrl_pwm4: pwm4grp {
 		fsl,pins = <
-			MX6QDL_PAD_SD1_CMD__PWM4_OUT		0x1b0b1
+			MX6QDL_PAD_SD1_CMD__PWM4_OUT			0x1b0b1
 		>;
 	};
 
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
-			MX6QDL_PAD_SD3_DAT7__UART1_TX_DATA	0x1b0b1
-			MX6QDL_PAD_SD3_DAT6__UART1_RX_DATA	0x1b0b1
+			MX6QDL_PAD_SD3_DAT7__UART1_TX_DATA		0x1b0b1
+			MX6QDL_PAD_SD3_DAT6__UART1_RX_DATA		0x1b0b1
 		>;
 	};
 
 	pinctrl_uart2: uart2grp {
 		fsl,pins = <
-			MX6QDL_PAD_SD4_DAT7__UART2_TX_DATA	0x1b0b1
-			MX6QDL_PAD_SD4_DAT4__UART2_RX_DATA	0x1b0b1
+			MX6QDL_PAD_SD4_DAT7__UART2_TX_DATA		0x1b0b1
+			MX6QDL_PAD_SD4_DAT4__UART2_RX_DATA		0x1b0b1
 		>;
 	};
 
 	pinctrl_uart3: uart3grp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_D24__UART3_TX_DATA	0x1b0b1
-			MX6QDL_PAD_EIM_D25__UART3_RX_DATA	0x1b0b1
+			MX6QDL_PAD_EIM_D24__UART3_TX_DATA		0x1b0b1
+			MX6QDL_PAD_EIM_D25__UART3_RX_DATA		0x1b0b1
 		>;
 	};
 
 	pinctrl_uart5: uart5grp {
 		fsl,pins = <
-			MX6QDL_PAD_KEY_COL1__UART5_TX_DATA	0x1b0b1
-			MX6QDL_PAD_KEY_ROW1__UART5_RX_DATA	0x1b0b1
+			MX6QDL_PAD_KEY_COL1__UART5_TX_DATA		0x1b0b1
+			MX6QDL_PAD_KEY_ROW1__UART5_RX_DATA		0x1b0b1
 		>;
 	};
 
 	pinctrl_usbotg: usbotggrp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_1__USB_OTG_ID		0x17059
-			MX6QDL_PAD_EIM_D22__GPIO3_IO22		0x1b0b0 /* OTG_PWR_EN */
+			MX6QDL_PAD_GPIO_1__USB_OTG_ID			0x17059
+			MX6QDL_PAD_EIM_D22__GPIO3_IO22			0x1b0b0 /* OTG_PWR_EN */
 		>;
 	};
 
 	pinctrl_wdog: wdoggrp {
 		fsl,pins = <
-			MX6QDL_PAD_DISP0_DAT8__WDOG1_B		0x1b0b0
+			MX6QDL_PAD_DISP0_DAT8__WDOG1_B			0x1b0b0
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
index 2ff377d..b7ecdef 100644
--- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
@@ -430,7 +430,7 @@
 			MX6QDL_PAD_SD2_DAT3__AUD4_TXC		0x130b0
 			MX6QDL_PAD_SD2_DAT2__AUD4_TXD		0x110b0
 			MX6QDL_PAD_SD2_DAT1__AUD4_TXFS		0x130b0
-			MX6QDL_PAD_GPIO_0__CCM_CLKO1	0x130b0 /* AUD4_MCK */
+			MX6QDL_PAD_GPIO_0__CCM_CLKO1		0x130b0 /* AUD4_MCK */
 		>;
 	};
 
@@ -475,9 +475,9 @@
 
 	pinctrl_gpio_leds: gpioledsgrp {
 		fsl,pins = <
-			MX6QDL_PAD_KEY_COL0__GPIO4_IO06  0x1b0b0
-			MX6QDL_PAD_KEY_ROW0__GPIO4_IO07  0x1b0b0
-			MX6QDL_PAD_KEY_ROW4__GPIO4_IO15  0x1b0b0
+			MX6QDL_PAD_KEY_COL0__GPIO4_IO06		0x1b0b0
+			MX6QDL_PAD_KEY_ROW0__GPIO4_IO07		0x1b0b0
+			MX6QDL_PAD_KEY_ROW4__GPIO4_IO15		0x1b0b0
 		>;
 	};
 
@@ -583,7 +583,7 @@
 	pinctrl_usbotg: usbotggrp {
 		fsl,pins = <
 			MX6QDL_PAD_GPIO_1__USB_OTG_ID		0x17059
-			MX6QDL_PAD_EIM_D22__GPIO3_IO22	0x1b0b0 /* OTG_PWR_EN */
+			MX6QDL_PAD_EIM_D22__GPIO3_IO22		0x1b0b0 /* OTG_PWR_EN */
 		>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
index 68ab543..7e9535c 100644
--- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
@@ -457,9 +457,9 @@
 
 	pinctrl_gpio_leds: gpioledsgrp {
 		fsl,pins = <
-			MX6QDL_PAD_KEY_COL0__GPIO4_IO06   0x1b0b0
-			MX6QDL_PAD_KEY_ROW0__GPIO4_IO07   0x1b0b0
-			MX6QDL_PAD_KEY_ROW4__GPIO4_IO15   0x1b0b0
+			MX6QDL_PAD_KEY_COL0__GPIO4_IO06		0x1b0b0
+			MX6QDL_PAD_KEY_ROW0__GPIO4_IO07		0x1b0b0
+			MX6QDL_PAD_KEY_ROW4__GPIO4_IO15		0x1b0b0
 		>;
 	};
 
@@ -506,8 +506,8 @@
 
 	pinctrl_pcie: pciegrp {
 		fsl,pins = <
-			MX6QDL_PAD_ENET_TX_EN__GPIO1_IO28 0x1b0b0 /* PCIE IRQ */
-			MX6QDL_PAD_ENET_TXD1__GPIO1_IO29  0x1b0b0 /* PCIE RST */
+			MX6QDL_PAD_ENET_TX_EN__GPIO1_IO28	0x1b0b0 /* PCIE IRQ */
+			MX6QDL_PAD_ENET_TXD1__GPIO1_IO29	0x1b0b0 /* PCIE RST */
 		>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
index 81b2fcf..675a8e2 100644
--- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
@@ -502,10 +502,10 @@
 
 	pinctrl_ecspi2: escpi2grp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_CS0__ECSPI2_SCLK	0x100b1
-			MX6QDL_PAD_EIM_CS1__ECSPI2_MOSI	0x100b1
-			MX6QDL_PAD_EIM_OE__ECSPI2_MISO	0x100b1
-			MX6QDL_PAD_EIM_RW__GPIO2_IO26	0x100b1
+			MX6QDL_PAD_EIM_CS0__ECSPI2_SCLK		0x100b1
+			MX6QDL_PAD_EIM_CS1__ECSPI2_MOSI		0x100b1
+			MX6QDL_PAD_EIM_OE__ECSPI2_MISO		0x100b1
+			MX6QDL_PAD_EIM_RW__GPIO2_IO26		0x100b1
 		>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw551x.dtsi b/arch/arm/boot/dts/imx6qdl-gw551x.dtsi
index 8e46a80..100ed13 100644
--- a/arch/arm/boot/dts/imx6qdl-gw551x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw551x.dtsi
@@ -331,7 +331,7 @@
 
 	pinctrl_gpio_leds: gpioledsgrp {
 		fsl,pins = <
-			MX6QDL_PAD_KEY_ROW0__GPIO4_IO07   0x1b0b0
+			MX6QDL_PAD_KEY_ROW0__GPIO4_IO07		0x1b0b0
 		>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-gw553x.dtsi b/arch/arm/boot/dts/imx6qdl-gw553x.dtsi
index a106689..d1cd8b6 100644
--- a/arch/arm/boot/dts/imx6qdl-gw553x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw553x.dtsi
@@ -374,195 +374,195 @@
 &iomuxc {
 	pinctrl_adv7180: adv7180grp {
 		fsl,pins = <
-			MX6QDL_PAD_CSI0_DAT5__GPIO5_IO23        0x0001b0b0
-			MX6QDL_PAD_CSI0_DATA_EN__GPIO5_IO20     0x4001b0b0
+			MX6QDL_PAD_CSI0_DAT5__GPIO5_IO23		0x0001b0b0
+			MX6QDL_PAD_CSI0_DATA_EN__GPIO5_IO20		0x4001b0b0
 		>;
 	};
 
 	pinctrl_gpmi_nand: gpminandgrp {
 		fsl,pins = <
-			MX6QDL_PAD_NANDF_CLE__NAND_CLE		0xb0b1
-			MX6QDL_PAD_NANDF_ALE__NAND_ALE		0xb0b1
-			MX6QDL_PAD_NANDF_WP_B__NAND_WP_B	0xb0b1
-			MX6QDL_PAD_NANDF_RB0__NAND_READY_B	0xb000
-			MX6QDL_PAD_NANDF_CS0__NAND_CE0_B	0xb0b1
-			MX6QDL_PAD_SD4_CMD__NAND_RE_B		0xb0b1
-			MX6QDL_PAD_SD4_CLK__NAND_WE_B		0xb0b1
-			MX6QDL_PAD_NANDF_D0__NAND_DATA00	0xb0b1
-			MX6QDL_PAD_NANDF_D1__NAND_DATA01	0xb0b1
-			MX6QDL_PAD_NANDF_D2__NAND_DATA02	0xb0b1
-			MX6QDL_PAD_NANDF_D3__NAND_DATA03	0xb0b1
-			MX6QDL_PAD_NANDF_D4__NAND_DATA04	0xb0b1
-			MX6QDL_PAD_NANDF_D5__NAND_DATA05	0xb0b1
-			MX6QDL_PAD_NANDF_D6__NAND_DATA06	0xb0b1
-			MX6QDL_PAD_NANDF_D7__NAND_DATA07	0xb0b1
+			MX6QDL_PAD_NANDF_CLE__NAND_CLE			0xb0b1
+			MX6QDL_PAD_NANDF_ALE__NAND_ALE			0xb0b1
+			MX6QDL_PAD_NANDF_WP_B__NAND_WP_B		0xb0b1
+			MX6QDL_PAD_NANDF_RB0__NAND_READY_B		0xb000
+			MX6QDL_PAD_NANDF_CS0__NAND_CE0_B		0xb0b1
+			MX6QDL_PAD_SD4_CMD__NAND_RE_B			0xb0b1
+			MX6QDL_PAD_SD4_CLK__NAND_WE_B			0xb0b1
+			MX6QDL_PAD_NANDF_D0__NAND_DATA00		0xb0b1
+			MX6QDL_PAD_NANDF_D1__NAND_DATA01		0xb0b1
+			MX6QDL_PAD_NANDF_D2__NAND_DATA02		0xb0b1
+			MX6QDL_PAD_NANDF_D3__NAND_DATA03		0xb0b1
+			MX6QDL_PAD_NANDF_D4__NAND_DATA04		0xb0b1
+			MX6QDL_PAD_NANDF_D5__NAND_DATA05		0xb0b1
+			MX6QDL_PAD_NANDF_D6__NAND_DATA06		0xb0b1
+			MX6QDL_PAD_NANDF_D7__NAND_DATA07		0xb0b1
 		>;
 	};
 
 	pinctrl_hdmi: hdmigrp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_A25__HDMI_TX_CEC_LINE	0x1f8b0
+			MX6QDL_PAD_EIM_A25__HDMI_TX_CEC_LINE		0x1f8b0
 		>;
 	};
 
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_D21__I2C1_SCL		0x4001b8b1
-			MX6QDL_PAD_EIM_D28__I2C1_SDA		0x4001b8b1
+			MX6QDL_PAD_EIM_D21__I2C1_SCL			0x4001b8b1
+			MX6QDL_PAD_EIM_D28__I2C1_SDA			0x4001b8b1
 		>;
 	};
 
 	pinctrl_i2c2: i2c2grp {
 		fsl,pins = <
-			MX6QDL_PAD_KEY_COL3__I2C2_SCL		0x4001b8b1
-			MX6QDL_PAD_KEY_ROW3__I2C2_SDA		0x4001b8b1
+			MX6QDL_PAD_KEY_COL3__I2C2_SCL			0x4001b8b1
+			MX6QDL_PAD_KEY_ROW3__I2C2_SDA			0x4001b8b1
 		>;
 	};
 
 	pinctrl_i2c3: i2c3grp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_3__I2C3_SCL		0x4001b8b1
-			MX6QDL_PAD_GPIO_6__I2C3_SDA		0x4001b8b1
+			MX6QDL_PAD_GPIO_3__I2C3_SCL			0x4001b8b1
+			MX6QDL_PAD_GPIO_6__I2C3_SDA			0x4001b8b1
 		>;
 	};
 
 	pinctrl_ipu1_csi0: ipu1csi0grp {
 		fsl,pins = <
-			MX6QDL_PAD_CSI0_DAT12__IPU1_CSI0_DATA12    0x1b0b0
-			MX6QDL_PAD_CSI0_DAT13__IPU1_CSI0_DATA13    0x1b0b0
-			MX6QDL_PAD_CSI0_DAT14__IPU1_CSI0_DATA14    0x1b0b0
-			MX6QDL_PAD_CSI0_DAT15__IPU1_CSI0_DATA15    0x1b0b0
-			MX6QDL_PAD_CSI0_DAT16__IPU1_CSI0_DATA16    0x1b0b0
-			MX6QDL_PAD_CSI0_DAT17__IPU1_CSI0_DATA17    0x1b0b0
-			MX6QDL_PAD_CSI0_DAT18__IPU1_CSI0_DATA18    0x1b0b0
-			MX6QDL_PAD_CSI0_DAT19__IPU1_CSI0_DATA19    0x1b0b0
-			MX6QDL_PAD_CSI0_MCLK__IPU1_CSI0_HSYNC      0x1b0b0
-			MX6QDL_PAD_CSI0_VSYNC__IPU1_CSI0_VSYNC     0x1b0b0
-			MX6QDL_PAD_CSI0_PIXCLK__IPU1_CSI0_PIXCLK   0x1b0b0
+			MX6QDL_PAD_CSI0_DAT12__IPU1_CSI0_DATA12		0x1b0b0
+			MX6QDL_PAD_CSI0_DAT13__IPU1_CSI0_DATA13		0x1b0b0
+			MX6QDL_PAD_CSI0_DAT14__IPU1_CSI0_DATA14		0x1b0b0
+			MX6QDL_PAD_CSI0_DAT15__IPU1_CSI0_DATA15		0x1b0b0
+			MX6QDL_PAD_CSI0_DAT16__IPU1_CSI0_DATA16		0x1b0b0
+			MX6QDL_PAD_CSI0_DAT17__IPU1_CSI0_DATA17		0x1b0b0
+			MX6QDL_PAD_CSI0_DAT18__IPU1_CSI0_DATA18		0x1b0b0
+			MX6QDL_PAD_CSI0_DAT19__IPU1_CSI0_DATA19		0x1b0b0
+			MX6QDL_PAD_CSI0_MCLK__IPU1_CSI0_HSYNC		0x1b0b0
+			MX6QDL_PAD_CSI0_VSYNC__IPU1_CSI0_VSYNC		0x1b0b0
+			MX6QDL_PAD_CSI0_PIXCLK__IPU1_CSI0_PIXCLK	0x1b0b0
 		>;
 	};
 
 	pinctrl_gpio_leds: gpioledsgrp {
 		fsl,pins = <
-			MX6QDL_PAD_KEY_COL2__GPIO4_IO10		0x1b0b0
-			MX6QDL_PAD_KEY_ROW2__GPIO4_IO11		0x1b0b0
+			MX6QDL_PAD_KEY_COL2__GPIO4_IO10			0x1b0b0
+			MX6QDL_PAD_KEY_ROW2__GPIO4_IO11			0x1b0b0
 		>;
 	};
 
 	pinctrl_pcie: pciegrp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_0__GPIO1_IO00		0x1b0b0
-			MX6QDL_PAD_GPIO_17__GPIO7_IO12		0x4001b0b0 /* PCIESKT_WDIS# */
+			MX6QDL_PAD_GPIO_0__GPIO1_IO00			0x1b0b0
+			MX6QDL_PAD_GPIO_17__GPIO7_IO12			0x4001b0b0 /* PCIESKT_WDIS# */
 		>;
 	};
 
 	pinctrl_pmic: pmicgrp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_8__GPIO1_IO08		0x0001b0b0 /* PMIC_IRQ# */
+			MX6QDL_PAD_GPIO_8__GPIO1_IO08			0x0001b0b0 /* PMIC_IRQ# */
 		>;
 	};
 
 	pinctrl_pps: ppsgrp {
 		fsl,pins = <
-			MX6QDL_PAD_ENET_RXD1__GPIO1_IO26	0x1b0b1
+			MX6QDL_PAD_ENET_RXD1__GPIO1_IO26		0x1b0b1
 		>;
 	};
 
 	pinctrl_pwm2: pwm2grp {
 		fsl,pins = <
-			MX6QDL_PAD_SD1_DAT2__PWM2_OUT		0x1b0b1
+			MX6QDL_PAD_SD1_DAT2__PWM2_OUT			0x1b0b1
 		>;
 	};
 
 	pinctrl_pwm3: pwm3grp {
 		fsl,pins = <
-			MX6QDL_PAD_SD4_DAT1__PWM3_OUT		0x1b0b1
+			MX6QDL_PAD_SD4_DAT1__PWM3_OUT			0x1b0b1
 		>;
 	};
 
 	pinctrl_pwm4: pwm4grp {
 		fsl,pins = <
-			MX6QDL_PAD_SD1_CMD__PWM4_OUT		0x1b0b1
+			MX6QDL_PAD_SD1_CMD__PWM4_OUT			0x1b0b1
 		>;
 	};
 
 	pinctrl_uart2: uart2grp {
 		fsl,pins = <
-			MX6QDL_PAD_SD4_DAT7__UART2_TX_DATA	0x1b0b1
-			MX6QDL_PAD_SD4_DAT4__UART2_RX_DATA	0x1b0b1
+			MX6QDL_PAD_SD4_DAT7__UART2_TX_DATA		0x1b0b1
+			MX6QDL_PAD_SD4_DAT4__UART2_RX_DATA		0x1b0b1
 		>;
 	};
 
 	pinctrl_uart3: uart3grp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_D24__UART3_TX_DATA	0x1b0b1
-			MX6QDL_PAD_EIM_D25__UART3_RX_DATA	0x1b0b1
+			MX6QDL_PAD_EIM_D24__UART3_TX_DATA		0x1b0b1
+			MX6QDL_PAD_EIM_D25__UART3_RX_DATA		0x1b0b1
 		>;
 	};
 
 	pinctrl_uart4: uart4grp {
 		fsl,pins = <
-			MX6QDL_PAD_KEY_COL0__UART4_TX_DATA	0x1b0b1
-			MX6QDL_PAD_KEY_ROW0__UART4_RX_DATA	0x1b0b1
+			MX6QDL_PAD_KEY_COL0__UART4_TX_DATA		0x1b0b1
+			MX6QDL_PAD_KEY_ROW0__UART4_RX_DATA		0x1b0b1
 		>;
 	};
 
 	pinctrl_uart5: uart5grp {
 		fsl,pins = <
-			MX6QDL_PAD_KEY_COL1__UART5_TX_DATA	0x1b0b1
-			MX6QDL_PAD_KEY_ROW1__UART5_RX_DATA	0x1b0b1
+			MX6QDL_PAD_KEY_COL1__UART5_TX_DATA		0x1b0b1
+			MX6QDL_PAD_KEY_ROW1__UART5_RX_DATA		0x1b0b1
 		>;
 	};
 
 	pinctrl_usbotg: usbotggrp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_1__USB_OTG_ID		0x17059
-			MX6QDL_PAD_EIM_D22__GPIO3_IO22		0x1b0b0 /* OTG_PWR_EN */
+			MX6QDL_PAD_GPIO_1__USB_OTG_ID			0x17059
+			MX6QDL_PAD_EIM_D22__GPIO3_IO22			0x1b0b0 /* OTG_PWR_EN */
 		>;
 	};
 
 	pinctrl_usdhc3: usdhc3grp {
 		fsl,pins = <
-			MX6QDL_PAD_SD3_CMD__SD3_CMD		0x17059
-			MX6QDL_PAD_SD3_CLK__SD3_CLK		0x10059
-			MX6QDL_PAD_SD3_DAT0__SD3_DATA0		0x17059
-			MX6QDL_PAD_SD3_DAT1__SD3_DATA1		0x17059
-			MX6QDL_PAD_SD3_DAT2__SD3_DATA2		0x17059
-			MX6QDL_PAD_SD3_DAT3__SD3_DATA3		0x17059
-			MX6QDL_PAD_SD3_DAT5__GPIO7_IO00		0x17059 /* CD */
-			MX6QDL_PAD_NANDF_CS1__SD3_VSELECT	0x17059
+			MX6QDL_PAD_SD3_CMD__SD3_CMD			0x17059
+			MX6QDL_PAD_SD3_CLK__SD3_CLK			0x10059
+			MX6QDL_PAD_SD3_DAT0__SD3_DATA0			0x17059
+			MX6QDL_PAD_SD3_DAT1__SD3_DATA1			0x17059
+			MX6QDL_PAD_SD3_DAT2__SD3_DATA2			0x17059
+			MX6QDL_PAD_SD3_DAT3__SD3_DATA3			0x17059
+			MX6QDL_PAD_SD3_DAT5__GPIO7_IO00			0x17059 /* CD */
+			MX6QDL_PAD_NANDF_CS1__SD3_VSELECT		0x17059
 		>;
 	};
 
 	pinctrl_usdhc3_100mhz: usdhc3grp100mhz {
 		fsl,pins = <
-			MX6QDL_PAD_SD3_CMD__SD3_CMD		0x170b9
-			MX6QDL_PAD_SD3_CLK__SD3_CLK		0x100b9
-			MX6QDL_PAD_SD3_DAT0__SD3_DATA0		0x170b9
-			MX6QDL_PAD_SD3_DAT1__SD3_DATA1		0x170b9
-			MX6QDL_PAD_SD3_DAT2__SD3_DATA2		0x170b9
-			MX6QDL_PAD_SD3_DAT3__SD3_DATA3		0x170b9
-			MX6QDL_PAD_SD3_DAT5__GPIO7_IO00		0x170b9 /* CD */
-			MX6QDL_PAD_NANDF_CS1__SD3_VSELECT	0x170b9
+			MX6QDL_PAD_SD3_CMD__SD3_CMD			0x170b9
+			MX6QDL_PAD_SD3_CLK__SD3_CLK			0x100b9
+			MX6QDL_PAD_SD3_DAT0__SD3_DATA0			0x170b9
+			MX6QDL_PAD_SD3_DAT1__SD3_DATA1			0x170b9
+			MX6QDL_PAD_SD3_DAT2__SD3_DATA2			0x170b9
+			MX6QDL_PAD_SD3_DAT3__SD3_DATA3			0x170b9
+			MX6QDL_PAD_SD3_DAT5__GPIO7_IO00			0x170b9 /* CD */
+			MX6QDL_PAD_NANDF_CS1__SD3_VSELECT		0x170b9
 		>;
 	};
 
 	pinctrl_usdhc3_200mhz: usdhc3grp200mhz {
 		fsl,pins = <
-			MX6QDL_PAD_SD3_CMD__SD3_CMD		0x170f9
-			MX6QDL_PAD_SD3_CLK__SD3_CLK		0x100f9
-			MX6QDL_PAD_SD3_DAT0__SD3_DATA0		0x170f9
-			MX6QDL_PAD_SD3_DAT1__SD3_DATA1		0x170f9
-			MX6QDL_PAD_SD3_DAT2__SD3_DATA2		0x170f9
-			MX6QDL_PAD_SD3_DAT3__SD3_DATA3		0x170f9
-			MX6QDL_PAD_SD3_DAT5__GPIO7_IO00		0x170f9 /* CD */
-			MX6QDL_PAD_NANDF_CS1__SD3_VSELECT	0x170f9
+			MX6QDL_PAD_SD3_CMD__SD3_CMD			0x170f9
+			MX6QDL_PAD_SD3_CLK__SD3_CLK			0x100f9
+			MX6QDL_PAD_SD3_DAT0__SD3_DATA0			0x170f9
+			MX6QDL_PAD_SD3_DAT1__SD3_DATA1			0x170f9
+			MX6QDL_PAD_SD3_DAT2__SD3_DATA2			0x170f9
+			MX6QDL_PAD_SD3_DAT3__SD3_DATA3			0x170f9
+			MX6QDL_PAD_SD3_DAT5__GPIO7_IO00			0x170f9 /* CD */
+			MX6QDL_PAD_NANDF_CS1__SD3_VSELECT		0x170f9
 		>;
 	};
 
 	pinctrl_wdog: wdoggrp {
 		fsl,pins = <
-			MX6QDL_PAD_DISP0_DAT8__WDOG1_B		0x1b0b0
+			MX6QDL_PAD_DISP0_DAT8__WDOG1_B			0x1b0b0
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6qdl-gw5904.dtsi b/arch/arm/boot/dts/imx6qdl-gw5904.dtsi
index 6d21cc6..3a1549a 100644
--- a/arch/arm/boot/dts/imx6qdl-gw5904.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw5904.dtsi
@@ -553,19 +553,19 @@
 
 	pinctrl_uart3: uart3grp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_D23__UART3_CTS_B         0x1b0b1
-			MX6QDL_PAD_EIM_D24__UART3_TX_DATA       0x1b0b1
-			MX6QDL_PAD_EIM_D25__UART3_RX_DATA       0x1b0b1
-			MX6QDL_PAD_EIM_D31__UART3_RTS_B         0x1b0b1
+			MX6QDL_PAD_EIM_D23__UART3_CTS_B		0x1b0b1
+			MX6QDL_PAD_EIM_D24__UART3_TX_DATA	0x1b0b1
+			MX6QDL_PAD_EIM_D25__UART3_RX_DATA	0x1b0b1
+			MX6QDL_PAD_EIM_D31__UART3_RTS_B		0x1b0b1
 		>;
 	};
 
 	pinctrl_uart4: uart4grp {
 		fsl,pins = <
-			MX6QDL_PAD_CSI0_DAT12__UART4_TX_DATA    0x1b0b1
-			MX6QDL_PAD_CSI0_DAT13__UART4_RX_DATA    0x1b0b1
-			MX6QDL_PAD_CSI0_DAT16__UART4_RTS_B      0x1b0b1
-			MX6QDL_PAD_CSI0_DAT17__UART4_CTS_B      0x1b0b1
+			MX6QDL_PAD_CSI0_DAT12__UART4_TX_DATA	0x1b0b1
+			MX6QDL_PAD_CSI0_DAT13__UART4_RX_DATA	0x1b0b1
+			MX6QDL_PAD_CSI0_DAT16__UART4_RTS_B	0x1b0b1
+			MX6QDL_PAD_CSI0_DAT17__UART4_CTS_B	0x1b0b1
 		>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
index 2ffb21d..e7f75a2 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
@@ -216,95 +216,95 @@
 	hummingboard {
 		pinctrl_hummingboard_flexcan1: hummingboard-flexcan1 {
 			fsl,pins = <
-				MX6QDL_PAD_SD3_CLK__FLEXCAN1_RX 0x80000000
-				MX6QDL_PAD_SD3_CMD__FLEXCAN1_TX 0x80000000
+				MX6QDL_PAD_SD3_CLK__FLEXCAN1_RX		0x80000000
+				MX6QDL_PAD_SD3_CMD__FLEXCAN1_TX		0x80000000
 			>;
 		};
 
 		pinctrl_hummingboard_gpio3_5: hummingboard-gpio3_5 {
 			fsl,pins = <
-				MX6QDL_PAD_EIM_DA5__GPIO3_IO05 0x1b0b1
+				MX6QDL_PAD_EIM_DA5__GPIO3_IO05		0x1b0b1
 			>;
 		};
 
 		pinctrl_hummingboard_hdmi: hummingboard-hdmi {
 			fsl,pins = <
-				MX6QDL_PAD_KEY_ROW2__HDMI_TX_CEC_LINE 0x1f8b0
+				MX6QDL_PAD_KEY_ROW2__HDMI_TX_CEC_LINE	0x1f8b0
 			>;
 		};
 
 		pinctrl_hummingboard_i2c1: hummingboard-i2c1 {
 			fsl,pins = <
-				MX6QDL_PAD_EIM_D21__I2C1_SCL 0x4001b8b1
-				MX6QDL_PAD_EIM_D28__I2C1_SDA 0x4001b8b1
+				MX6QDL_PAD_EIM_D21__I2C1_SCL		0x4001b8b1
+				MX6QDL_PAD_EIM_D28__I2C1_SDA		0x4001b8b1
 			>;
 		};
 
 		pinctrl_hummingboard_i2c2: hummingboard-i2c2 {
 			fsl,pins = <
-				MX6QDL_PAD_KEY_COL3__I2C2_SCL 0x4001b8b1
-				MX6QDL_PAD_KEY_ROW3__I2C2_SDA 0x4001b8b1
+				MX6QDL_PAD_KEY_COL3__I2C2_SCL		0x4001b8b1
+				MX6QDL_PAD_KEY_ROW3__I2C2_SDA		0x4001b8b1
 			>;
 		};
 
 		pinctrl_hummingboard_pcie_reset: hummingboard-pcie-reset {
 			fsl,pins = <
-				MX6QDL_PAD_EIM_DA4__GPIO3_IO04 0x1b0b1
+				MX6QDL_PAD_EIM_DA4__GPIO3_IO04		0x1b0b1
 			>;
 		};
 
 		pinctrl_hummingboard_pwm1: pwm1grp {
-			fsl,pins = <MX6QDL_PAD_DISP0_DAT8__PWM1_OUT 0x1b0b1>;
+			fsl,pins = <MX6QDL_PAD_DISP0_DAT8__PWM1_OUT	0x1b0b1>;
 		};
 
 		pinctrl_hummingboard_sgtl5000: hummingboard-sgtl5000 {
 			fsl,pins = <
-				MX6QDL_PAD_DISP0_DAT19__AUD5_RXD 0x130b0
-				MX6QDL_PAD_KEY_COL0__AUD5_TXC 0x130b0
-				MX6QDL_PAD_KEY_ROW0__AUD5_TXD 0x110b0
-				MX6QDL_PAD_KEY_COL1__AUD5_TXFS 0x130b0
-				MX6QDL_PAD_GPIO_5__CCM_CLKO1 0x130b0
+				MX6QDL_PAD_DISP0_DAT19__AUD5_RXD	0x130b0
+				MX6QDL_PAD_KEY_COL0__AUD5_TXC		0x130b0
+				MX6QDL_PAD_KEY_ROW0__AUD5_TXD		0x110b0
+				MX6QDL_PAD_KEY_COL1__AUD5_TXFS		0x130b0
+				MX6QDL_PAD_GPIO_5__CCM_CLKO1		0x130b0
 			>;
 		};
 
 		pinctrl_hummingboard_spdif: hummingboard-spdif {
-			fsl,pins = <MX6QDL_PAD_GPIO_17__SPDIF_OUT 0x13091>;
+			fsl,pins = <MX6QDL_PAD_GPIO_17__SPDIF_OUT	0x13091>;
 		};
 
 		pinctrl_hummingboard_usbh1_vbus: hummingboard-usbh1-vbus {
-			fsl,pins = <MX6QDL_PAD_GPIO_0__GPIO1_IO00 0x1b0b0>;
+			fsl,pins = <MX6QDL_PAD_GPIO_0__GPIO1_IO00	0x1b0b0>;
 		};
 
 		pinctrl_hummingboard_usbotg_id: hummingboard-usbotg-id {
 			/*
 			 * We want it pulled down for a fixed host connection.
 			 */
-			fsl,pins = <MX6QDL_PAD_ENET_RX_ER__USB_OTG_ID 0x13059>;
+			fsl,pins = <MX6QDL_PAD_ENET_RX_ER__USB_OTG_ID	0x13059>;
 		};
 
 		pinctrl_hummingboard_usbotg_vbus: hummingboard-usbotg-vbus {
-			fsl,pins = <MX6QDL_PAD_EIM_D22__GPIO3_IO22 0x1b0b0>;
+			fsl,pins = <MX6QDL_PAD_EIM_D22__GPIO3_IO22	0x1b0b0>;
 		};
 
 		pinctrl_hummingboard_usdhc2_aux: hummingboard-usdhc2-aux {
 			fsl,pins = <
-				MX6QDL_PAD_GPIO_4__GPIO1_IO04    0x1f071
+				MX6QDL_PAD_GPIO_4__GPIO1_IO04		0x1f071
 			>;
 		};
 
 		pinctrl_hummingboard_usdhc2: hummingboard-usdhc2 {
 			fsl,pins = <
-				MX6QDL_PAD_SD2_CMD__SD2_CMD    0x17059
-				MX6QDL_PAD_SD2_CLK__SD2_CLK    0x10059
-				MX6QDL_PAD_SD2_DAT0__SD2_DATA0 0x17059
-				MX6QDL_PAD_SD2_DAT1__SD2_DATA1 0x17059
-				MX6QDL_PAD_SD2_DAT2__SD2_DATA2 0x17059
-				MX6QDL_PAD_SD2_DAT3__SD2_DATA3 0x13059
+				MX6QDL_PAD_SD2_CMD__SD2_CMD		0x17059
+				MX6QDL_PAD_SD2_CLK__SD2_CLK		0x10059
+				MX6QDL_PAD_SD2_DAT0__SD2_DATA0		0x17059
+				MX6QDL_PAD_SD2_DAT1__SD2_DATA1		0x17059
+				MX6QDL_PAD_SD2_DAT2__SD2_DATA2		0x17059
+				MX6QDL_PAD_SD2_DAT3__SD2_DATA3		0x13059
 			>;
 		};
 		pinctrl_hummingboard_vmmc: hummingboard-vmmc {
 			fsl,pins = <
-				MX6QDL_PAD_DISP0_DAT9__GPIO4_IO30 0x1b0b0
+				MX6QDL_PAD_DISP0_DAT9__GPIO4_IO30	0x1b0b0
 			>;
 		};
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard2-emmc.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard2-emmc.dtsi
index f400405..449e9cb 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard2-emmc.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard2-emmc.dtsi
@@ -45,17 +45,17 @@
 	hummingboard2 {
 		pinctrl_hummingboard2_usdhc3: hummingboard2-usdhc3 {
 			fsl,pins = <
-				MX6QDL_PAD_SD3_CMD__SD3_CMD    0x17059
-				MX6QDL_PAD_SD3_CLK__SD3_CLK    0x10059
-				MX6QDL_PAD_SD3_DAT0__SD3_DATA0 0x17059
-				MX6QDL_PAD_SD3_DAT1__SD3_DATA1 0x17059
-				MX6QDL_PAD_SD3_DAT2__SD3_DATA2 0x17059
-				MX6QDL_PAD_SD3_DAT3__SD3_DATA3 0x17059
-				MX6QDL_PAD_SD3_DAT4__SD3_DATA4 0x17059
-				MX6QDL_PAD_SD3_DAT5__SD3_DATA5 0x17059
-				MX6QDL_PAD_SD3_DAT6__SD3_DATA6 0x17059
-				MX6QDL_PAD_SD3_DAT7__SD3_DATA7 0x17059
-				MX6QDL_PAD_SD3_RST__SD3_RESET  0x17059
+				MX6QDL_PAD_SD3_CMD__SD3_CMD	0x17059
+				MX6QDL_PAD_SD3_CLK__SD3_CLK	0x10059
+				MX6QDL_PAD_SD3_DAT0__SD3_DATA0	0x17059
+				MX6QDL_PAD_SD3_DAT1__SD3_DATA1	0x17059
+				MX6QDL_PAD_SD3_DAT2__SD3_DATA2	0x17059
+				MX6QDL_PAD_SD3_DAT3__SD3_DATA3	017059
+				MX6QDL_PAD_SD3_DAT4__SD3_DATA4	0x17059
+				MX6QDL_PAD_SD3_DAT5__SD3_DATA5	0x17059
+				MX6QDL_PAD_SD3_DAT6__SD3_DATA6	0x17059
+				MX6QDL_PAD_SD3_DAT7__SD3_DATA7	0x17059
+				MX6QDL_PAD_SD3_RST__SD3_RESET	0x17059
 			>;
 		};
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
index e423133..b8dc3ed1 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
@@ -284,172 +284,172 @@
 				 * number is : gpio number = (X-1) * 32 + Y
 				 */
 				/* DI1_PIN15 */
-				MX6QDL_PAD_EIM_DA10__GPIO3_IO10 0x400130b1
+				MX6QDL_PAD_EIM_DA10__GPIO3_IO10		0x400130b1
 				/* DI1_PIN02 */
-				MX6QDL_PAD_EIM_DA11__GPIO3_IO11 0x400130b1
+				MX6QDL_PAD_EIM_DA11__GPIO3_IO11		0x400130b1
 				/* DISP1_DATA00 */
-				MX6QDL_PAD_EIM_DA9__GPIO3_IO09 0x400130b1
+				MX6QDL_PAD_EIM_DA9__GPIO3_IO09		0x400130b1
 				/* DISP1_DATA01 */
-				MX6QDL_PAD_EIM_DA8__GPIO3_IO08 0x400130b1
+				MX6QDL_PAD_EIM_DA8__GPIO3_IO08		0x400130b1
 				/* DISP1_DATA02 */
-				MX6QDL_PAD_EIM_DA7__GPIO3_IO07 0x400130b1
+				MX6QDL_PAD_EIM_DA7__GPIO3_IO07		0x400130b1
 				/* DISP1_DATA03 */
-				MX6QDL_PAD_EIM_DA6__GPIO3_IO06 0x400130b1
+				MX6QDL_PAD_EIM_DA6__GPIO3_IO06		0x400130b1
 				/* DISP1_DATA04 */
-				MX6QDL_PAD_EIM_DA5__GPIO3_IO05 0x400130b1
+				MX6QDL_PAD_EIM_DA5__GPIO3_IO05		0x400130b1
 				/* DISP1_DATA05 */
-				MX6QDL_PAD_EIM_DA4__GPIO3_IO04 0x400130b1
+				MX6QDL_PAD_EIM_DA4__GPIO3_IO04		0x400130b1
 				/* DISP1_DATA06 */
-				MX6QDL_PAD_EIM_DA3__GPIO3_IO03 0x400130b1
+				MX6QDL_PAD_EIM_DA3__GPIO3_IO03		0x400130b1
 				/* DISP1_DATA07 */
-				MX6QDL_PAD_EIM_DA2__GPIO3_IO02 0x400130b1
+				MX6QDL_PAD_EIM_DA2__GPIO3_IO02		0x400130b1
 				/* DI1_D0_CS */
-				MX6QDL_PAD_EIM_DA13__GPIO3_IO13 0x400130b1
+				MX6QDL_PAD_EIM_DA13__GPIO3_IO13		0x400130b1
 				/* DI1_D1_CS */
-				MX6QDL_PAD_EIM_DA14__GPIO3_IO14 0x400130b1
+				MX6QDL_PAD_EIM_DA14__GPIO3_IO14		0x400130b1
 				/* DI1_PIN01 */
-				MX6QDL_PAD_EIM_DA15__GPIO3_IO15 0x400130b1
+				MX6QDL_PAD_EIM_DA15__GPIO3_IO15		0x400130b1
 				/* DI1_PIN03 */
-				MX6QDL_PAD_EIM_DA12__GPIO3_IO12 0x400130b1
+				MX6QDL_PAD_EIM_DA12__GPIO3_IO12		0x400130b1
 				/* DISP1_DATA08 */
-				MX6QDL_PAD_EIM_DA1__GPIO3_IO01 0x400130b1
+				MX6QDL_PAD_EIM_DA1__GPIO3_IO01		0x400130b1
 				/* DISP1_DATA09 */
-				MX6QDL_PAD_EIM_DA0__GPIO3_IO00 0x400130b1
+				MX6QDL_PAD_EIM_DA0__GPIO3_IO00		0x400130b1
 				/* DISP1_DATA10 */
-				MX6QDL_PAD_EIM_EB1__GPIO2_IO29 0x400130b1
+				MX6QDL_PAD_EIM_EB1__GPIO2_IO29		0x400130b1
 				/* DISP1_DATA11 */
-				MX6QDL_PAD_EIM_EB0__GPIO2_IO28 0x400130b1
+				MX6QDL_PAD_EIM_EB0__GPIO2_IO28		0x400130b1
 				/* DISP1_DATA12 */
-				MX6QDL_PAD_EIM_A17__GPIO2_IO21 0x400130b1
+				MX6QDL_PAD_EIM_A17__GPIO2_IO21		0x400130b1
 				/* DISP1_DATA13 */
-				MX6QDL_PAD_EIM_A18__GPIO2_IO20 0x400130b1
+				MX6QDL_PAD_EIM_A18__GPIO2_IO20		0x400130b1
 				/* DISP1_DATA14 */
-				MX6QDL_PAD_EIM_A19__GPIO2_IO19 0x400130b1
+				MX6QDL_PAD_EIM_A19__GPIO2_IO19		0x400130b1
 				/* DISP1_DATA15 */
-				MX6QDL_PAD_EIM_A20__GPIO2_IO18 0x400130b1
+				MX6QDL_PAD_EIM_A20__GPIO2_IO18		0x400130b1
 				/* DISP1_DATA16 */
-				MX6QDL_PAD_EIM_A21__GPIO2_IO17 0x400130b1
+				MX6QDL_PAD_EIM_A21__GPIO2_IO17		0x400130b1
 				/* DISP1_DATA17 */
-				MX6QDL_PAD_EIM_A22__GPIO2_IO16 0x400130b1
+				MX6QDL_PAD_EIM_A22__GPIO2_IO16		0x400130b1
 				/* DISP1_DATA18 */
-				MX6QDL_PAD_EIM_A23__GPIO6_IO06 0x400130b1
+				MX6QDL_PAD_EIM_A23__GPIO6_IO06		0x400130b1
 				/* DISP1_DATA19 */
-				MX6QDL_PAD_EIM_A24__GPIO5_IO04 0x400130b1
+				MX6QDL_PAD_EIM_A24__GPIO5_IO04		0x400130b1
 				/* DISP1_DATA20 */
-				MX6QDL_PAD_EIM_D31__GPIO3_IO31 0x400130b1
+				MX6QDL_PAD_EIM_D31__GPIO3_IO31		0x400130b1
 				/* DISP1_DATA21 */
-				MX6QDL_PAD_EIM_D30__GPIO3_IO30 0x400130b1
+				MX6QDL_PAD_EIM_D30__GPIO3_IO30		0x400130b1
 				/* DISP1_DATA22 */
-				MX6QDL_PAD_EIM_D26__GPIO3_IO26 0x400130b1
+				MX6QDL_PAD_EIM_D26__GPIO3_IO26		0x400130b1
 				/* DISP1_DATA23 */
-				MX6QDL_PAD_EIM_D27__GPIO3_IO27 0x400130b1
+				MX6QDL_PAD_EIM_D27__GPIO3_IO27		0x400130b1
 				/* DI1_DISP_CLK */
-				MX6QDL_PAD_EIM_A16__GPIO2_IO22 0x400130b1
+				MX6QDL_PAD_EIM_A16__GPIO2_IO22		0x400130b1
 				/* SPDIF_IN */
-				MX6QDL_PAD_ENET_RX_ER__GPIO1_IO24 0x400130b1
+				MX6QDL_PAD_ENET_RX_ER__GPIO1_IO24	0x400130b1
 				/* SPDIF_OUT */
-				MX6QDL_PAD_GPIO_17__GPIO7_IO12 0x400130b1
+				MX6QDL_PAD_GPIO_17__GPIO7_IO12		0x400130b1
 
 				/* MikroBUS GPIO pin number 10 */
-				MX6QDL_PAD_EIM_LBA__GPIO2_IO27 0x400130b1
+				MX6QDL_PAD_EIM_LBA__GPIO2_IO27		0x400130b1
 			>;
 		};
 
 		pinctrl_hummingboard2_ecspi2: hummingboard2-ecspi2grp {
 			fsl,pins = <
-				MX6QDL_PAD_EIM_OE__ECSPI2_MISO	0x100b1
-				MX6QDL_PAD_EIM_CS1__ECSPI2_MOSI	0x100b1
-				MX6QDL_PAD_EIM_CS0__ECSPI2_SCLK	0x100b1
-				MX6QDL_PAD_EIM_RW__GPIO2_IO26	0x000b1 /* CS */
+				MX6QDL_PAD_EIM_OE__ECSPI2_MISO		0x100b1
+				MX6QDL_PAD_EIM_CS1__ECSPI2_MOSI		0x100b1
+				MX6QDL_PAD_EIM_CS0__ECSPI2_SCLK		0x100b1
+				MX6QDL_PAD_EIM_RW__GPIO2_IO26		0x000b1 /* CS */
 			>;
 		};
 
 		pinctrl_hummingboard2_gpio7_9: hummingboard2-gpio7_9 {
 			fsl,pins = <
-				MX6QDL_PAD_SD4_CMD__GPIO7_IO09 0x80000000
+				MX6QDL_PAD_SD4_CMD__GPIO7_IO09		0x80000000
 			>;
 		};
 
 		pinctrl_hummingboard2_hdmi: hummingboard2-hdmi {
 			fsl,pins = <
-				MX6QDL_PAD_KEY_ROW2__HDMI_TX_CEC_LINE 0x1f8b0
+				MX6QDL_PAD_KEY_ROW2__HDMI_TX_CEC_LINE	0x1f8b0
 			>;
 		};
 
 		pinctrl_hummingboard2_i2c1: hummingboard2-i2c1 {
 			fsl,pins = <
-				MX6QDL_PAD_EIM_D21__I2C1_SCL 0x4001b8b1
-				MX6QDL_PAD_EIM_D28__I2C1_SDA 0x4001b8b1
+				MX6QDL_PAD_EIM_D21__I2C1_SCL		0x4001b8b1
+				MX6QDL_PAD_EIM_D28__I2C1_SDA		0x4001b8b1
 			>;
 		};
 
 		pinctrl_hummingboard2_i2c2: hummingboard2-i2c2 {
 			fsl,pins = <
-				MX6QDL_PAD_KEY_COL3__I2C2_SCL 0x4001b8b1
-				MX6QDL_PAD_KEY_ROW3__I2C2_SDA 0x4001b8b1
+				MX6QDL_PAD_KEY_COL3__I2C2_SCL		0x4001b8b1
+				MX6QDL_PAD_KEY_ROW3__I2C2_SDA		0x4001b8b1
 			>;
 		};
 
 		pinctrl_hummingboard2_i2c3: hummingboard2-i2c3 {
 			fsl,pins = <
-				MX6QDL_PAD_EIM_D17__I2C3_SCL 0x4001b8b1
-				MX6QDL_PAD_EIM_D18__I2C3_SDA 0x4001b8b1
+				MX6QDL_PAD_EIM_D17__I2C3_SCL		0x4001b8b1
+				MX6QDL_PAD_EIM_D18__I2C3_SDA		0x4001b8b1
 			>;
 		};
 
 		pinctrl_hummingboard2_mipi: hummingboard2_mipi {
 			fsl,pins = <
-				MX6QDL_PAD_SD4_DAT2__GPIO2_IO10 0x4001b8b1
-				MX6QDL_PAD_KEY_COL4__GPIO4_IO14 0x4001b8b1
-				MX6QDL_PAD_NANDF_CS2__CCM_CLKO2 0x130b0
+				MX6QDL_PAD_SD4_DAT2__GPIO2_IO10		0x4001b8b1
+				MX6QDL_PAD_KEY_COL4__GPIO4_IO14		0x4001b8b1
+				MX6QDL_PAD_NANDF_CS2__CCM_CLKO2		0x130b0
 			>;
 		};
 
 		pinctrl_hummingboard2_pcie_reset: hummingboard2-pcie-reset {
 			fsl,pins = <
-				MX6QDL_PAD_SD4_DAT3__GPIO2_IO11 0x1b0b1
+				MX6QDL_PAD_SD4_DAT3__GPIO2_IO11		0x1b0b1
 			>;
 		};
 
 		pinctrl_hummingboard2_pwm1: pwm1grp {
 			fsl,pins = <
-				MX6QDL_PAD_DISP0_DAT8__PWM1_OUT 0x1b0b1
+				MX6QDL_PAD_DISP0_DAT8__PWM1_OUT		0x1b0b1
 			>;
 		};
 
 		pinctrl_hummingboard2_pwm3: pwm3grp {
 			fsl,pins = <
-				MX6QDL_PAD_SD4_DAT1__PWM3_OUT 0x1b0b1
+				MX6QDL_PAD_SD4_DAT1__PWM3_OUT		0x1b0b1
 			>;
 		};
 
 		pinctrl_hummingboard2_sgtl5000: hummingboard2-sgtl5000 {
 			fsl,pins = <
-				MX6QDL_PAD_DISP0_DAT19__AUD5_RXD 0x130b0
-				MX6QDL_PAD_KEY_COL0__AUD5_TXC 0x130b0
-				MX6QDL_PAD_KEY_ROW0__AUD5_TXD 0x110b0
-				MX6QDL_PAD_KEY_COL1__AUD5_TXFS 0x130b0
-				MX6QDL_PAD_GPIO_5__CCM_CLKO1 0x130b0
+				MX6QDL_PAD_DISP0_DAT19__AUD5_RXD	0x130b0
+				MX6QDL_PAD_KEY_COL0__AUD5_TXC		0x130b0
+				MX6QDL_PAD_KEY_ROW0__AUD5_TXD		0x110b0
+				MX6QDL_PAD_KEY_COL1__AUD5_TXFS		0x130b0
+				MX6QDL_PAD_GPIO_5__CCM_CLKO1		0x130b0
 			>;
 		};
 
 		pinctrl_hummingboard2_usbh1_vbus: hummingboard2-usbh1-vbus {
-			fsl,pins = <MX6QDL_PAD_GPIO_0__GPIO1_IO00 0x1b0b0>;
+			fsl,pins = <MX6QDL_PAD_GPIO_0__GPIO1_IO00	0x1b0b0>;
 		};
 
 		pinctrl_hummingboard2_usbh2_vbus: hummingboard2-usbh2-vbus {
-			fsl,pins = <MX6QDL_PAD_SD4_DAT5__GPIO2_IO13 0x1b0b0>;
+			fsl,pins = <MX6QDL_PAD_SD4_DAT5__GPIO2_IO13	0x1b0b0>;
 		};
 
 		pinctrl_hummingboard2_usbh3_vbus: hummingboard2-usbh3-vbus {
-			fsl,pins = <MX6QDL_PAD_SD4_CLK__GPIO7_IO10 0x1b0b0>;
+			fsl,pins = <MX6QDL_PAD_SD4_CLK__GPIO7_IO10	0x1b0b0>;
 		};
 
 		pinctrl_hummingboard2_usbotg_id: hummingboard2-usbotg-id {
 			/*
 			 * We want it pulled down for a fixed host connection.
 			 */
-			fsl,pins = <MX6QDL_PAD_GPIO_1__USB_OTG_ID 0x13059>;
+			fsl,pins = <MX6QDL_PAD_GPIO_1__USB_OTG_ID	0x13059>;
 		};
 
 		pinctrl_hummingboard2_usbotg_vbus: hummingboard2-usbotg-vbus {
@@ -458,47 +458,47 @@
 
 		pinctrl_hummingboard2_usdhc2_aux: hummingboard2-usdhc2-aux {
 			fsl,pins = <
-				MX6QDL_PAD_GPIO_4__GPIO1_IO04    0x1f071
-				MX6QDL_PAD_KEY_ROW1__SD2_VSELECT 0x1b071
+				MX6QDL_PAD_GPIO_4__GPIO1_IO04		0x1f071
+				MX6QDL_PAD_KEY_ROW1__SD2_VSELECT	0x1b071
 			>;
 		};
 
 		pinctrl_hummingboard2_usdhc2: hummingboard2-usdhc2 {
 			fsl,pins = <
-				MX6QDL_PAD_SD2_CMD__SD2_CMD    0x17059
-				MX6QDL_PAD_SD2_CLK__SD2_CLK    0x10059
-				MX6QDL_PAD_SD2_DAT0__SD2_DATA0 0x17059
-				MX6QDL_PAD_SD2_DAT1__SD2_DATA1 0x17059
-				MX6QDL_PAD_SD2_DAT2__SD2_DATA2 0x17059
-				MX6QDL_PAD_SD2_DAT3__SD2_DATA3 0x13059
+				MX6QDL_PAD_SD2_CMD__SD2_CMD		0x17059
+				MX6QDL_PAD_SD2_CLK__SD2_CLK		0x10059
+				MX6QDL_PAD_SD2_DAT0__SD2_DATA0		0x17059
+				MX6QDL_PAD_SD2_DAT1__SD2_DATA1		0x17059
+				MX6QDL_PAD_SD2_DAT2__SD2_DATA2		0x17059
+				MX6QDL_PAD_SD2_DAT3__SD2_DATA3		0x13059
 			>;
 		};
 
 		pinctrl_hummingboard2_usdhc2_100mhz: hummingboard2-usdhc2-100mhz {
 			fsl,pins = <
-				MX6QDL_PAD_SD2_CMD__SD2_CMD    0x170b9
-				MX6QDL_PAD_SD2_CLK__SD2_CLK    0x100b9
-				MX6QDL_PAD_SD2_DAT0__SD2_DATA0 0x170b9
-				MX6QDL_PAD_SD2_DAT1__SD2_DATA1 0x170b9
-				MX6QDL_PAD_SD2_DAT2__SD2_DATA2 0x170b9
-				MX6QDL_PAD_SD2_DAT3__SD2_DATA3 0x130b9
+				MX6QDL_PAD_SD2_CMD__SD2_CMD		0x170b9
+				MX6QDL_PAD_SD2_CLK__SD2_CLK		0x100b9
+				MX6QDL_PAD_SD2_DAT0__SD2_DATA0		0x170b9
+				MX6QDL_PAD_SD2_DAT1__SD2_DATA1		0x170b9
+				MX6QDL_PAD_SD2_DAT2__SD2_DATA2		0x170b9
+				MX6QDL_PAD_SD2_DAT3__SD2_DATA3		0x130b9
 			>;
 		};
 
 		pinctrl_hummingboard2_usdhc2_200mhz: hummingboard2-usdhc2-200mhz {
 			fsl,pins = <
-				MX6QDL_PAD_SD2_CMD__SD2_CMD    0x170f9
-				MX6QDL_PAD_SD2_CLK__SD2_CLK    0x100f9
-				MX6QDL_PAD_SD2_DAT0__SD2_DATA0 0x170f9
-				MX6QDL_PAD_SD2_DAT1__SD2_DATA1 0x170f9
-				MX6QDL_PAD_SD2_DAT2__SD2_DATA2 0x170f9
-				MX6QDL_PAD_SD2_DAT3__SD2_DATA3 0x130f9
+				MX6QDL_PAD_SD2_CMD__SD2_CMD		0x170f9
+				MX6QDL_PAD_SD2_CLK__SD2_CLK		0x100f9
+				MX6QDL_PAD_SD2_DAT0__SD2_DATA0		0x170f9
+				MX6QDL_PAD_SD2_DAT1__SD2_DATA1		0x170f9
+				MX6QDL_PAD_SD2_DAT2__SD2_DATA2		0x170f9
+				MX6QDL_PAD_SD2_DAT3__SD2_DATA3		0x130f9
 			>;
 		};
 
 		pinctrl_hummingboard2_vmmc: hummingboard2-vmmc {
 			fsl,pins = <
-				MX6QDL_PAD_DISP0_DAT9__GPIO4_IO30 0x1b0b0
+				MX6QDL_PAD_DISP0_DAT9__GPIO4_IO30	0x1b0b0
 			>;
 		};
 
diff --git a/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi b/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
index 1d1b4bd..91ef4fb 100644
--- a/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
@@ -284,183 +284,183 @@
 &iomuxc {
 	pinctrl_audmux: audmuxgrp {
 		fsl,pins = <
-			MX6QDL_PAD_DISP0_DAT20__AUD4_TXC  0x130b0
-			MX6QDL_PAD_DISP0_DAT21__AUD4_TXD  0x110b0
-			MX6QDL_PAD_DISP0_DAT22__AUD4_TXFS 0x130b0
-			MX6QDL_PAD_DISP0_DAT23__AUD4_RXD  0x130b0
+			MX6QDL_PAD_DISP0_DAT20__AUD4_TXC	0x130b0
+			MX6QDL_PAD_DISP0_DAT21__AUD4_TXD	0x110b0
+			MX6QDL_PAD_DISP0_DAT22__AUD4_TXFS	0x130b0
+			MX6QDL_PAD_DISP0_DAT23__AUD4_RXD	0x130b0
 		>;
 	};
 
 	pinctrl_enet: enetgrp {
 		fsl,pins = <
-			MX6QDL_PAD_ENET_MDIO__ENET_MDIO       0x1b0b0
-			MX6QDL_PAD_ENET_MDC__ENET_MDC         0x1b0b0
-			MX6QDL_PAD_RGMII_TXC__RGMII_TXC       0x1b030
-			MX6QDL_PAD_RGMII_TD0__RGMII_TD0       0x1b030
-			MX6QDL_PAD_RGMII_TD1__RGMII_TD1       0x1b030
-			MX6QDL_PAD_RGMII_TD2__RGMII_TD2       0x1b030
-			MX6QDL_PAD_RGMII_TD3__RGMII_TD3       0x1b030
-			MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL 0x1b030
-			MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK  0x1b0b0
-			MX6QDL_PAD_RGMII_RXC__RGMII_RXC       0x1b030
-			MX6QDL_PAD_RGMII_RD0__RGMII_RD0       0x1b030
-			MX6QDL_PAD_RGMII_RD1__RGMII_RD1       0x1b030
-			MX6QDL_PAD_RGMII_RD2__RGMII_RD2       0x1b030
-			MX6QDL_PAD_RGMII_RD3__RGMII_RD3       0x1b030
-			MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL 0x1b030
-			MX6QDL_PAD_ENET_TX_EN__ENET_TX_EN     0x1b0b0
+			MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x1b0b0
+			MX6QDL_PAD_ENET_MDC__ENET_MDC		0x1b0b0
+			MX6QDL_PAD_RGMII_TXC__RGMII_TXC		0x1b030
+			MX6QDL_PAD_RGMII_TD0__RGMII_TD0		0x1b030
+			MX6QDL_PAD_RGMII_TD1__RGMII_TD1		0x1b030
+			MX6QDL_PAD_RGMII_TD2__RGMII_TD2		0x1b030
+			MX6QDL_PAD_RGMII_TD3__RGMII_TD3		0x1b030
+			MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL	0x1b030
+			MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK	0x1b0b0
+			MX6QDL_PAD_RGMII_RXC__RGMII_RXC		0x1b030
+			MX6QDL_PAD_RGMII_RD0__RGMII_RD0		0x1b030
+			MX6QDL_PAD_RGMII_RD1__RGMII_RD1		0x1b030
+			MX6QDL_PAD_RGMII_RD2__RGMII_RD2		0x1b030
+			MX6QDL_PAD_RGMII_RD3__RGMII_RD3		0x1b030
+			MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL	0x1b030
+			MX6QDL_PAD_ENET_TX_EN__ENET_TX_EN	0x1b0b0
 		>;
 	};
 
 	pinctrl_can1: can1grp {
 		fsl,pins = <
-			MX6QDL_PAD_KEY_ROW2__FLEXCAN1_RX 0x1b020
-			MX6QDL_PAD_KEY_COL2__FLEXCAN1_TX 0x1b020
+			MX6QDL_PAD_KEY_ROW2__FLEXCAN1_RX	0x1b020
+			MX6QDL_PAD_KEY_COL2__FLEXCAN1_TX	0x1b020
 		>;
 	};
 
 	pinctrl_can2: can2grp {
 		fsl,pins = <
-			MX6QDL_PAD_KEY_COL4__FLEXCAN2_TX 0x1b020
-			MX6QDL_PAD_KEY_ROW4__FLEXCAN2_RX 0x1b020
+			MX6QDL_PAD_KEY_COL4__FLEXCAN2_TX	0x1b020
+			MX6QDL_PAD_KEY_ROW4__FLEXCAN2_RX	0x1b020
 		>;
 	};
 
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_D21__I2C1_SCL 0x4001b8b1
-			MX6QDL_PAD_EIM_D28__I2C1_SDA 0x4001b8b1
+			MX6QDL_PAD_EIM_D21__I2C1_SCL		0x4001b8b1
+			MX6QDL_PAD_EIM_D28__I2C1_SDA		0x4001b8b1
 		>;
 	};
 
 	pinctrl_i2c2: i2c2grp {
 		fsl,pins = <
-			MX6QDL_PAD_KEY_COL3__I2C2_SCL 0x4001b8b1
-			MX6QDL_PAD_KEY_ROW3__I2C2_SDA 0x4001b8b1
+			MX6QDL_PAD_KEY_COL3__I2C2_SCL		0x4001b8b1
+			MX6QDL_PAD_KEY_ROW3__I2C2_SDA		0x4001b8b1
 		>;
 	};
 
 	pinctrl_i2c3: i2c3grp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_5__I2C3_SCL  0x4001b8b1
-			MX6QDL_PAD_EIM_D18__I2C3_SDA 0x4001b8b1
-			MX6QDL_PAD_GPIO_0__CCM_CLKO1    0x130b0
+			MX6QDL_PAD_GPIO_5__I2C3_SCL		0x4001b8b1
+			MX6QDL_PAD_EIM_D18__I2C3_SDA		0x4001b8b1
+			MX6QDL_PAD_GPIO_0__CCM_CLKO1		0x130b0
 		>;
 	};
 
 	pinctrl_pcie: pciegrp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_D29__GPIO3_IO29 0x1f059	/* PCIe Reset */
+			MX6QDL_PAD_EIM_D29__GPIO3_IO29		0x1f059 /* PCIe Reset */
 		>;
 	};
 
 	pinctrl_uart4: uart4grp {
 		fsl,pins = <
-			MX6QDL_PAD_KEY_COL0__UART4_TX_DATA 0x1b0b1
-			MX6QDL_PAD_KEY_ROW0__UART4_RX_DATA 0x1b0b1
+			MX6QDL_PAD_KEY_COL0__UART4_TX_DATA	0x1b0b1
+			MX6QDL_PAD_KEY_ROW0__UART4_RX_DATA	0x1b0b1
 		>;
 	};
 
 	pinctrl_usbhub: usbhubgrp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_6__GPIO1_IO06  0x1f059	/* HUB USB Reset */
+			MX6QDL_PAD_GPIO_6__GPIO1_IO06		0x1f059 /* HUB USB Reset */
 		>;
 	};
 
 	pinctrl_usbotg: usbotggrp {
 		fsl,pins = <
-			MX6QDL_PAD_ENET_RX_ER__USB_OTG_ID 0x17059
+			MX6QDL_PAD_ENET_RX_ER__USB_OTG_ID	0x17059
 		>;
 	};
 
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
-			MX6QDL_PAD_SD1_CMD__SD1_CMD    0x17071
-			MX6QDL_PAD_SD1_CLK__SD1_CLK    0x10071
-			MX6QDL_PAD_SD1_DAT0__SD1_DATA0 0x17071
-			MX6QDL_PAD_SD1_DAT1__SD1_DATA1 0x17071
-			MX6QDL_PAD_SD1_DAT2__SD1_DATA2 0x17071
-			MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x17071
+			MX6QDL_PAD_SD1_CMD__SD1_CMD		0x17071
+			MX6QDL_PAD_SD1_CLK__SD1_CLK		0x10071
+			MX6QDL_PAD_SD1_DAT0__SD1_DATA0		0x17071
+			MX6QDL_PAD_SD1_DAT1__SD1_DATA1		0x17071
+			MX6QDL_PAD_SD1_DAT2__SD1_DATA2		0x17071
+			MX6QDL_PAD_SD1_DAT3__SD1_DATA3		0x17071
 		>;
 	};
 
 	pinctrl_usdhc3: usdhc3grp {
 		fsl,pins = <
-			MX6QDL_PAD_SD3_CMD__SD3_CMD    0x17070
-			MX6QDL_PAD_SD3_CLK__SD3_CLK    0x10070
-			MX6QDL_PAD_SD3_DAT0__SD3_DATA0 0x17070
-			MX6QDL_PAD_SD3_DAT1__SD3_DATA1 0x17070
-			MX6QDL_PAD_SD3_DAT2__SD3_DATA2 0x17070
-			MX6QDL_PAD_SD3_DAT3__SD3_DATA3 0x17070
-			MX6QDL_PAD_GPIO_1__GPIO1_IO01  0x1f059	/* CD */
-			MX6QDL_PAD_GPIO_4__GPIO1_IO04  0x1f059	/* PWR */
+			MX6QDL_PAD_SD3_CMD__SD3_CMD		0x17070
+			MX6QDL_PAD_SD3_CLK__SD3_CLK		0x10070
+			MX6QDL_PAD_SD3_DAT0__SD3_DATA0		0x17070
+			MX6QDL_PAD_SD3_DAT1__SD3_DATA1		0x17070
+			MX6QDL_PAD_SD3_DAT2__SD3_DATA2		0x17070
+			MX6QDL_PAD_SD3_DAT3__SD3_DATA3		0x17070
+			MX6QDL_PAD_GPIO_1__GPIO1_IO01		0x1f059 /* CD */
+			MX6QDL_PAD_GPIO_4__GPIO1_IO04		0x1f059 /* PWR */
 		>;
 	};
 
 	pinctrl_usdhc3_100mhz: usdhc3grp_100mhz {
 		fsl,pins = <
-			MX6QDL_PAD_SD3_CMD__SD3_CMD    0x170B1
-			MX6QDL_PAD_SD3_CLK__SD3_CLK    0x100B1
-			MX6QDL_PAD_SD3_DAT0__SD3_DATA0 0x170B1
-			MX6QDL_PAD_SD3_DAT1__SD3_DATA1 0x170B1
-			MX6QDL_PAD_SD3_DAT2__SD3_DATA2 0x170B1
-			MX6QDL_PAD_SD3_DAT3__SD3_DATA3 0x170B1
+			MX6QDL_PAD_SD3_CMD__SD3_CMD		0x170B1
+			MX6QDL_PAD_SD3_CLK__SD3_CLK		0x100B1
+			MX6QDL_PAD_SD3_DAT0__SD3_DATA0		0x170B1
+			MX6QDL_PAD_SD3_DAT1__SD3_DATA1		0x170B1
+			MX6QDL_PAD_SD3_DAT2__SD3_DATA2		0x170B1
+			MX6QDL_PAD_SD3_DAT3__SD3_DATA3		0x170B1
 		>;
 	};
 
 	pinctrl_usdhc3_200mhz: usdhc3grp_200mhz {
 		fsl,pins = <
-			MX6QDL_PAD_SD3_CMD__SD3_CMD    0x170F9
-			MX6QDL_PAD_SD3_CLK__SD3_CLK    0x100F9
-			MX6QDL_PAD_SD3_DAT0__SD3_DATA0 0x170F9
-			MX6QDL_PAD_SD3_DAT1__SD3_DATA1 0x170F9
-			MX6QDL_PAD_SD3_DAT2__SD3_DATA2 0x170F9
-			MX6QDL_PAD_SD3_DAT3__SD3_DATA3 0x170F9
+			MX6QDL_PAD_SD3_CMD__SD3_CMD		0x170F9
+			MX6QDL_PAD_SD3_CLK__SD3_CLK		0x100F9
+			MX6QDL_PAD_SD3_DAT0__SD3_DATA0		0x170F9
+			MX6QDL_PAD_SD3_DAT1__SD3_DATA1		0x170F9
+			MX6QDL_PAD_SD3_DAT2__SD3_DATA2		0x170F9
+			MX6QDL_PAD_SD3_DAT3__SD3_DATA3		0x170F9
 		>;
 	};
 
 	pinctrl_usdhc4: usdhc4grp {
 		fsl,pins = <
-			MX6QDL_PAD_SD4_CMD__SD4_CMD    0x17070
-			MX6QDL_PAD_SD4_CLK__SD4_CLK    0x10070
-			MX6QDL_PAD_SD4_DAT0__SD4_DATA0 0x17070
-			MX6QDL_PAD_SD4_DAT1__SD4_DATA1 0x17070
-			MX6QDL_PAD_SD4_DAT2__SD4_DATA2 0x17070
-			MX6QDL_PAD_SD4_DAT3__SD4_DATA3 0x17070
-			MX6QDL_PAD_SD4_DAT4__SD4_DATA4 0x17070
-			MX6QDL_PAD_SD4_DAT5__SD4_DATA5 0x17070
-			MX6QDL_PAD_SD4_DAT6__SD4_DATA6 0x17070
-			MX6QDL_PAD_SD4_DAT7__SD4_DATA7 0x17070
+			MX6QDL_PAD_SD4_CMD__SD4_CMD		0x17070
+			MX6QDL_PAD_SD4_CLK__SD4_CLK		0x10070
+			MX6QDL_PAD_SD4_DAT0__SD4_DATA0		0x17070
+			MX6QDL_PAD_SD4_DAT1__SD4_DATA1		0x17070
+			MX6QDL_PAD_SD4_DAT2__SD4_DATA2		0x17070
+			MX6QDL_PAD_SD4_DAT3__SD4_DATA3		0x17070
+			MX6QDL_PAD_SD4_DAT4__SD4_DATA4		0x17070
+			MX6QDL_PAD_SD4_DAT5__SD4_DATA5		0x17070
+			MX6QDL_PAD_SD4_DAT6__SD4_DATA6		0x17070
+			MX6QDL_PAD_SD4_DAT7__SD4_DATA7		0x17070
 		>;
 	};
 
 	pinctrl_usdhc4_100mhz: usdhc4grp_100mhz {
 		fsl,pins = <
-			MX6QDL_PAD_SD4_CMD__SD4_CMD    0x170B1
-			MX6QDL_PAD_SD4_CLK__SD4_CLK    0x100B1
-			MX6QDL_PAD_SD4_DAT0__SD4_DATA0 0x170B1
-			MX6QDL_PAD_SD4_DAT1__SD4_DATA1 0x170B1
-			MX6QDL_PAD_SD4_DAT2__SD4_DATA2 0x170B1
-			MX6QDL_PAD_SD4_DAT3__SD4_DATA3 0x170B1
-			MX6QDL_PAD_SD4_DAT4__SD4_DATA4 0x170B1
-			MX6QDL_PAD_SD4_DAT5__SD4_DATA5 0x170B1
-			MX6QDL_PAD_SD4_DAT6__SD4_DATA6 0x170B1
-			MX6QDL_PAD_SD4_DAT7__SD4_DATA7 0x170B1
+			MX6QDL_PAD_SD4_CMD__SD4_CMD		0x170B1
+			MX6QDL_PAD_SD4_CLK__SD4_CLK		0x100B1
+			MX6QDL_PAD_SD4_DAT0__SD4_DATA0		0x170B1
+			MX6QDL_PAD_SD4_DAT1__SD4_DATA1		0x170B1
+			MX6QDL_PAD_SD4_DAT2__SD4_DATA2		0x170B1
+			MX6QDL_PAD_SD4_DAT3__SD4_DATA3		0x170B1
+			MX6QDL_PAD_SD4_DAT4__SD4_DATA4		0x170B1
+			MX6QDL_PAD_SD4_DAT5__SD4_DATA5		0x170B1
+			MX6QDL_PAD_SD4_DAT6__SD4_DATA6		0x170B1
+			MX6QDL_PAD_SD4_DAT7__SD4_DATA7		0x170B1
 		>;
 	};
 
 	pinctrl_usdhc4_200mhz: usdhc4grp_200mhz {
 		fsl,pins = <
-			MX6QDL_PAD_SD4_CMD__SD4_CMD    0x170F9
-			MX6QDL_PAD_SD4_CLK__SD4_CLK    0x100F9
-			MX6QDL_PAD_SD4_DAT0__SD4_DATA0 0x170F9
-			MX6QDL_PAD_SD4_DAT1__SD4_DATA1 0x170F9
-			MX6QDL_PAD_SD4_DAT2__SD4_DATA2 0x170F9
-			MX6QDL_PAD_SD4_DAT3__SD4_DATA3 0x170F9
-			MX6QDL_PAD_SD4_DAT4__SD4_DATA4 0x170F9
-			MX6QDL_PAD_SD4_DAT5__SD4_DATA5 0x170F9
-			MX6QDL_PAD_SD4_DAT6__SD4_DATA6 0x170F9
-			MX6QDL_PAD_SD4_DAT7__SD4_DATA7 0x170F9
+			MX6QDL_PAD_SD4_CMD__SD4_CMD		0x170F9
+			MX6QDL_PAD_SD4_CLK__SD4_CLK		0x100F9
+			MX6QDL_PAD_SD4_DAT0__SD4_DATA0		0x170F9
+			MX6QDL_PAD_SD4_DAT1__SD4_DATA1		0x170F9
+			MX6QDL_PAD_SD4_DAT2__SD4_DATA2		0x170F9
+			MX6QDL_PAD_SD4_DAT3__SD4_DATA3		0x170F9
+			MX6QDL_PAD_SD4_DAT4__SD4_DATA4		0x170F9
+			MX6QDL_PAD_SD4_DAT5__SD4_DATA5		0x170F9
+			MX6QDL_PAD_SD4_DAT6__SD4_DATA6		0x170F9
+			MX6QDL_PAD_SD4_DAT7__SD4_DATA7		0x170F9
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6qdl-icore.dtsi b/arch/arm/boot/dts/imx6qdl-icore.dtsi
index 7814f1e..f8df079 100644
--- a/arch/arm/boot/dts/imx6qdl-icore.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-icore.dtsi
@@ -281,10 +281,10 @@
 &iomuxc {
 	pinctrl_audmux: audmuxgrp {
 		fsl,pins = <
-			MX6QDL_PAD_DISP0_DAT20__AUD4_TXC  0x130b0
-			MX6QDL_PAD_DISP0_DAT21__AUD4_TXD  0x110b0
-			MX6QDL_PAD_DISP0_DAT22__AUD4_TXFS 0x130b0
-			MX6QDL_PAD_DISP0_DAT23__AUD4_RXD  0x130b0
+			MX6QDL_PAD_DISP0_DAT20__AUD4_TXC	0x130b0
+			MX6QDL_PAD_DISP0_DAT21__AUD4_TXD	0x110b0
+			MX6QDL_PAD_DISP0_DAT22__AUD4_TXFS	0x130b0
+			MX6QDL_PAD_DISP0_DAT23__AUD4_RXD	0x130b0
 		>;
 	};
 
@@ -306,111 +306,111 @@
 
 	pinctrl_flexcan1: flexcan1grp {
 		fsl,pins = <
-			MX6QDL_PAD_KEY_ROW2__FLEXCAN1_RX 0x1b020
-			MX6QDL_PAD_KEY_COL2__FLEXCAN1_TX 0x1b020
+			MX6QDL_PAD_KEY_ROW2__FLEXCAN1_RX	0x1b020
+			MX6QDL_PAD_KEY_COL2__FLEXCAN1_TX	0x1b020
 		>;
 	};
 
 	pinctrl_flexcan2: flexcan2grp {
 		fsl,pins = <
-			MX6QDL_PAD_KEY_COL4__FLEXCAN2_TX 0x1b020
-			MX6QDL_PAD_KEY_ROW4__FLEXCAN2_RX 0x1b020
+			MX6QDL_PAD_KEY_COL4__FLEXCAN2_TX	0x1b020
+			MX6QDL_PAD_KEY_ROW4__FLEXCAN2_RX	0x1b020
 		>;
 	};
 
 	pinctrl_gpmi_nand: gpminandgrp {
 		fsl,pins = <
-			MX6QDL_PAD_NANDF_CLE__NAND_CLE     0xb0b1
-			MX6QDL_PAD_NANDF_ALE__NAND_ALE     0xb0b1
-			MX6QDL_PAD_NANDF_WP_B__NAND_WP_B   0xb0b1
-			MX6QDL_PAD_NANDF_RB0__NAND_READY_B 0xb000
-			MX6QDL_PAD_NANDF_CS0__NAND_CE0_B   0xb0b1
-			MX6QDL_PAD_NANDF_CS1__NAND_CE1_B   0xb0b1
-			MX6QDL_PAD_SD4_CMD__NAND_RE_B      0xb0b1
-			MX6QDL_PAD_SD4_CLK__NAND_WE_B      0xb0b1
-			MX6QDL_PAD_NANDF_D0__NAND_DATA00   0xb0b1
-			MX6QDL_PAD_NANDF_D1__NAND_DATA01   0xb0b1
-			MX6QDL_PAD_NANDF_D2__NAND_DATA02   0xb0b1
-			MX6QDL_PAD_NANDF_D3__NAND_DATA03   0xb0b1
-			MX6QDL_PAD_NANDF_D4__NAND_DATA04   0xb0b1
-			MX6QDL_PAD_NANDF_D5__NAND_DATA05   0xb0b1
-			MX6QDL_PAD_NANDF_D6__NAND_DATA06   0xb0b1
-			MX6QDL_PAD_NANDF_D7__NAND_DATA07   0xb0b1
-			MX6QDL_PAD_SD4_DAT0__NAND_DQS      0x00b1
+			MX6QDL_PAD_NANDF_CLE__NAND_CLE		0xb0b1
+			MX6QDL_PAD_NANDF_ALE__NAND_ALE		0xb0b1
+			MX6QDL_PAD_NANDF_WP_B__NAND_WP_B	0xb0b1
+			MX6QDL_PAD_NANDF_RB0__NAND_READY_B	0xb000
+			MX6QDL_PAD_NANDF_CS0__NAND_CE0_B	0xb0b1
+			MX6QDL_PAD_NANDF_CS1__NAND_CE1_B	0xb0b1
+			MX6QDL_PAD_SD4_CMD__NAND_RE_B		0xb0b1
+			MX6QDL_PAD_SD4_CLK__NAND_WE_B		0xb0b1
+			MX6QDL_PAD_NANDF_D0__NAND_DATA00	0xb0b1
+			MX6QDL_PAD_NANDF_D1__NAND_DATA01	0xb0b1
+			MX6QDL_PAD_NANDF_D2__NAND_DATA02	0xb0b1
+			MX6QDL_PAD_NANDF_D3__NAND_DATA03	0xb0b1
+			MX6QDL_PAD_NANDF_D4__NAND_DATA04	0xb0b1
+			MX6QDL_PAD_NANDF_D5__NAND_DATA05	0xb0b1
+			MX6QDL_PAD_NANDF_D6__NAND_DATA06	0xb0b1
+			MX6QDL_PAD_NANDF_D7__NAND_DATA07	0xb0b1
+			MX6QDL_PAD_SD4_DAT0__NAND_DQS		0x00b1
 		>;
 	};
 
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_D21__I2C1_SCL 0x4001b8b1
-			MX6QDL_PAD_EIM_D28__I2C1_SDA 0x4001b8b1
+			MX6QDL_PAD_EIM_D21__I2C1_SCL		0x4001b8b1
+			MX6QDL_PAD_EIM_D28__I2C1_SDA		0x4001b8b1
 		>;
 	};
 
 	pinctrl_i2c2: i2c2grp {
 		fsl,pins = <
-			MX6QDL_PAD_EIM_EB2__I2C2_SCL  0x4001b8b1
-			MX6QDL_PAD_KEY_ROW3__I2C2_SDA 0x4001b8b1
+			MX6QDL_PAD_EIM_EB2__I2C2_SCL		0x4001b8b1
+			MX6QDL_PAD_KEY_ROW3__I2C2_SDA		0x4001b8b1
 		>;
 	};
 
 	pinctrl_i2c3: i2c3grp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_5__I2C3_SCL  0x4001b8b1
-			MX6QDL_PAD_EIM_D18__I2C3_SDA 0x4001b8b1
+			MX6QDL_PAD_GPIO_5__I2C3_SCL		0x4001b8b1
+			MX6QDL_PAD_EIM_D18__I2C3_SDA		0x4001b8b1
 		>;
 	};
 
 	pinctrl_ov5640: ov5640grp {
 		fsl,pins = <
-			MX6QDL_PAD_CSI0_DAT12__GPIO5_IO30 0x1b0b0
-			MX6QDL_PAD_CSI0_DAT13__GPIO5_IO31 0x1b0b0
-			MX6QDL_PAD_GPIO_0__CCM_CLKO1	  0x130b0
+			MX6QDL_PAD_CSI0_DAT12__GPIO5_IO30	0x1b0b0
+			MX6QDL_PAD_CSI0_DAT13__GPIO5_IO31	0x1b0b0
+			MX6QDL_PAD_GPIO_0__CCM_CLKO1		0x130b0
 		>;
 	};
 
 	pinctrl_uart4: uart4grp {
 		fsl,pins = <
-			MX6QDL_PAD_KEY_COL0__UART4_TX_DATA 0x1b0b1
-			MX6QDL_PAD_KEY_ROW0__UART4_RX_DATA 0x1b0b1
+			MX6QDL_PAD_KEY_COL0__UART4_TX_DATA	0x1b0b1
+			MX6QDL_PAD_KEY_ROW0__UART4_RX_DATA	0x1b0b1
 		>;
 	};
 
 	pinctrl_pwm3: pwm3grp {
 		fsl,pins = <
-			MX6QDL_PAD_SD4_DAT1__PWM3_OUT 0x1b0b1
+			MX6QDL_PAD_SD4_DAT1__PWM3_OUT		0x1b0b1
 		>;
 	};
 
 	pinctrl_usbotg: usbotggrp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_1__USB_OTG_ID 0x17059
+			MX6QDL_PAD_GPIO_1__USB_OTG_ID		0x17059
 		>;
 	};
 
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
-			MX6QDL_PAD_SD1_CMD__SD1_CMD    0x17070
-			MX6QDL_PAD_SD1_CLK__SD1_CLK    0x10070
-			MX6QDL_PAD_SD1_DAT0__SD1_DATA0 0x17070
-			MX6QDL_PAD_SD1_DAT1__SD1_DATA1 0x17070
-			MX6QDL_PAD_SD1_DAT2__SD1_DATA2 0x17070
-			MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x17070
+			MX6QDL_PAD_SD1_CMD__SD1_CMD		0x17070
+			MX6QDL_PAD_SD1_CLK__SD1_CLK		0x10070
+			MX6QDL_PAD_SD1_DAT0__SD1_DATA0		0x17070
+			MX6QDL_PAD_SD1_DAT1__SD1_DATA1		0x17070
+			MX6QDL_PAD_SD1_DAT2__SD1_DATA2		0x17070
+			MX6QDL_PAD_SD1_DAT3__SD1_DATA3		0x17070
 		>;
 	};
 
 	pinctrl_usdhc3: usdhc3grp {
 		fsl,pins = <
-			MX6QDL_PAD_SD3_CMD__SD3_CMD    0x17059
-			MX6QDL_PAD_SD3_CLK__SD3_CLK    0x10059
-			MX6QDL_PAD_SD3_DAT0__SD3_DATA0 0x17059
-			MX6QDL_PAD_SD3_DAT1__SD3_DATA1 0x17059
-			MX6QDL_PAD_SD3_DAT2__SD3_DATA2 0x17059
-			MX6QDL_PAD_SD3_DAT3__SD3_DATA3 0x17059
-			MX6QDL_PAD_SD3_DAT4__SD3_DATA4 0x17059
-			MX6QDL_PAD_SD3_DAT5__SD3_DATA5 0x17059
-			MX6QDL_PAD_SD3_DAT6__SD3_DATA6 0x17059
-			MX6QDL_PAD_SD3_DAT7__SD3_DATA7 0x17059
+			MX6QDL_PAD_SD3_CMD__SD3_CMD		0x17059
+			MX6QDL_PAD_SD3_CLK__SD3_CLK		0x10059
+			MX6QDL_PAD_SD3_DAT0__SD3_DATA0		0x17059
+			MX6QDL_PAD_SD3_DAT1__SD3_DATA1		0x17059
+			MX6QDL_PAD_SD3_DAT2__SD3_DATA2		0x17059
+			MX6QDL_PAD_SD3_DAT3__SD3_DATA3		0x17059
+			MX6QDL_PAD_SD3_DAT4__SD3_DATA4		0x17059
+			MX6QDL_PAD_SD3_DAT5__SD3_DATA5		0x17059
+			MX6QDL_PAD_SD3_DAT6__SD3_DATA6		0x17059
+			MX6QDL_PAD_SD3_DAT7__SD3_DATA7		0x17059
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi b/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi
index 7a85116..f575068 100644
--- a/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi
@@ -328,28 +328,28 @@
 
 		pinctrl_i2c1: i2c1grp {
 			fsl,pins = <
-				MX6QDL_PAD_EIM_D21__I2C1_SCL	0x4001b8b1
-				MX6QDL_PAD_EIM_D28__I2C1_SDA	0x4001b8b1
+				MX6QDL_PAD_EIM_D21__I2C1_SCL		0x4001b8b1
+				MX6QDL_PAD_EIM_D28__I2C1_SDA		0x4001b8b1
 			>;
 		};
 
 		pinctrl_i2c2: i2c2grp {
 			fsl,pins = <
-				MX6QDL_PAD_KEY_COL3__I2C2_SCL	0x4001b8b1
-				MX6QDL_PAD_KEY_ROW3__I2C2_SDA	0x4001b8b1
+				MX6QDL_PAD_KEY_COL3__I2C2_SCL		0x4001b8b1
+				MX6QDL_PAD_KEY_ROW3__I2C2_SDA		0x4001b8b1
 			>;
 		};
 
 		pinctrl_i2c3: i2c3grp {
 			fsl,pins = <
-				MX6QDL_PAD_GPIO_5__I2C3_SCL	0x4001b8b1
-				MX6QDL_PAD_GPIO_16__I2C3_SDA	0x4001b8b1
+				MX6QDL_PAD_GPIO_5__I2C3_SCL		0x4001b8b1
+				MX6QDL_PAD_GPIO_16__I2C3_SDA		0x4001b8b1
 				/* Touch IRQ: J7 pin 4 */
-				MX6QDL_PAD_GPIO_9__GPIO1_IO09	0x1b0b0
+				MX6QDL_PAD_GPIO_9__GPIO1_IO09		0x1b0b0
 				/* tcs2004 IRQ */
-				MX6QDL_PAD_EIM_LBA__GPIO2_IO27	0x1b0b0
+				MX6QDL_PAD_EIM_LBA__GPIO2_IO27		0x1b0b0
 				/* tsc2004 reset */
-				MX6QDL_PAD_KEY_COL2__GPIO4_IO10	0x0b0b0
+				MX6QDL_PAD_KEY_COL2__GPIO4_IO10		0x0b0b0
 			>;
 		};
 
diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
index c3415aa..feb79b1 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
@@ -488,152 +488,152 @@
 
 		pinctrl_i2c1: i2c1grp {
 			fsl,pins = <
-				MX6QDL_PAD_EIM_D21__I2C1_SCL	0x4001b8b1
-				MX6QDL_PAD_EIM_D28__I2C1_SDA	0x4001b8b1
+				MX6QDL_PAD_EIM_D21__I2C1_SCL		0x4001b8b1
+				MX6QDL_PAD_EIM_D28__I2C1_SDA		0x4001b8b1
 			>;
 		};
 
 		pinctrl_i2c2: i2c2grp {
 			fsl,pins = <
-				MX6QDL_PAD_KEY_COL3__I2C2_SCL	0x4001b8b1
-				MX6QDL_PAD_KEY_ROW3__I2C2_SDA	0x4001b8b1
+				MX6QDL_PAD_KEY_COL3__I2C2_SCL		0x4001b8b1
+				MX6QDL_PAD_KEY_ROW3__I2C2_SDA		0x4001b8b1
 			>;
 		};
 
 		pinctrl_i2c2mux: i2c2muxgrp {
 			fsl,pins = <
 				/* ov5642 camera i2c enable */
-				MX6QDL_PAD_EIM_D20__GPIO3_IO20	0x000b0
+				MX6QDL_PAD_EIM_D20__GPIO3_IO20		0x000b0
 				/* ov5640_mipi camera i2c enable */
-				MX6QDL_PAD_KEY_ROW4__GPIO4_IO15	0x000b0
+				MX6QDL_PAD_KEY_ROW4__GPIO4_IO15		0x000b0
 			>;
 		};
 
 		pinctrl_i2c3: i2c3grp {
 			fsl,pins = <
-				MX6QDL_PAD_GPIO_5__I2C3_SCL	0x4001b8b1
-				MX6QDL_PAD_GPIO_16__I2C3_SDA	0x4001b8b1
-				MX6QDL_PAD_GPIO_9__GPIO1_IO09	0x1b0b0
+				MX6QDL_PAD_GPIO_5__I2C3_SCL		0x4001b8b1
+				MX6QDL_PAD_GPIO_16__I2C3_SDA		0x4001b8b1
+				MX6QDL_PAD_GPIO_9__GPIO1_IO09		0x1b0b0
 			>;
 		};
 
 		pinctrl_i2c3mux: i2c3muxgrp {
 			fsl,pins = <
 				/* PCIe I2C enable */
-				MX6QDL_PAD_EIM_OE__GPIO2_IO25	0x000b0
+				MX6QDL_PAD_EIM_OE__GPIO2_IO25		0x000b0
 			>;
 		};
 
 		pinctrl_j15: j15grp {
 			fsl,pins = <
-				MX6QDL_PAD_DI0_DISP_CLK__IPU1_DI0_DISP_CLK 0x10
-				MX6QDL_PAD_DI0_PIN15__IPU1_DI0_PIN15       0x10
-				MX6QDL_PAD_DI0_PIN2__IPU1_DI0_PIN02        0x10
-				MX6QDL_PAD_DI0_PIN3__IPU1_DI0_PIN03        0x10
-				MX6QDL_PAD_DISP0_DAT0__IPU1_DISP0_DATA00   0x10
-				MX6QDL_PAD_DISP0_DAT1__IPU1_DISP0_DATA01   0x10
-				MX6QDL_PAD_DISP0_DAT2__IPU1_DISP0_DATA02   0x10
-				MX6QDL_PAD_DISP0_DAT3__IPU1_DISP0_DATA03   0x10
-				MX6QDL_PAD_DISP0_DAT4__IPU1_DISP0_DATA04   0x10
-				MX6QDL_PAD_DISP0_DAT5__IPU1_DISP0_DATA05   0x10
-				MX6QDL_PAD_DISP0_DAT6__IPU1_DISP0_DATA06   0x10
-				MX6QDL_PAD_DISP0_DAT7__IPU1_DISP0_DATA07   0x10
-				MX6QDL_PAD_DISP0_DAT8__IPU1_DISP0_DATA08   0x10
-				MX6QDL_PAD_DISP0_DAT9__IPU1_DISP0_DATA09   0x10
-				MX6QDL_PAD_DISP0_DAT10__IPU1_DISP0_DATA10  0x10
-				MX6QDL_PAD_DISP0_DAT11__IPU1_DISP0_DATA11  0x10
-				MX6QDL_PAD_DISP0_DAT12__IPU1_DISP0_DATA12  0x10
-				MX6QDL_PAD_DISP0_DAT13__IPU1_DISP0_DATA13  0x10
-				MX6QDL_PAD_DISP0_DAT14__IPU1_DISP0_DATA14  0x10
-				MX6QDL_PAD_DISP0_DAT15__IPU1_DISP0_DATA15  0x10
-				MX6QDL_PAD_DISP0_DAT16__IPU1_DISP0_DATA16  0x10
-				MX6QDL_PAD_DISP0_DAT17__IPU1_DISP0_DATA17  0x10
-				MX6QDL_PAD_DISP0_DAT18__IPU1_DISP0_DATA18  0x10
-				MX6QDL_PAD_DISP0_DAT19__IPU1_DISP0_DATA19  0x10
-				MX6QDL_PAD_DISP0_DAT20__IPU1_DISP0_DATA20  0x10
-				MX6QDL_PAD_DISP0_DAT21__IPU1_DISP0_DATA21  0x10
-				MX6QDL_PAD_DISP0_DAT22__IPU1_DISP0_DATA22  0x10
-				MX6QDL_PAD_DISP0_DAT23__IPU1_DISP0_DATA23  0x10
+				MX6QDL_PAD_DI0_DISP_CLK__IPU1_DI0_DISP_CLK	0x10
+				MX6QDL_PAD_DI0_PIN15__IPU1_DI0_PIN15		0x10
+				MX6QDL_PAD_DI0_PIN2__IPU1_DI0_PIN02		0x10
+				MX6QDL_PAD_DI0_PIN3__IPU1_DI0_PIN03		0x10
+				MX6QDL_PAD_DISP0_DAT0__IPU1_DISP0_DATA00	0x10
+				MX6QDL_PAD_DISP0_DAT1__IPU1_DISP0_DATA01	0x10
+				MX6QDL_PAD_DISP0_DAT2__IPU1_DISP0_DATA02	0x10
+				MX6QDL_PAD_DISP0_DAT3__IPU1_DISP0_DATA03	0x10
+				MX6QDL_PAD_DISP0_DAT4__IPU1_DISP0_DATA04	0x10
+				MX6QDL_PAD_DISP0_DAT5__IPU1_DISP0_DATA05	0x10
+				MX6QDL_PAD_DISP0_DAT6__IPU1_DISP0_DATA06	0x10
+				MX6QDL_PAD_DISP0_DAT7__IPU1_DISP0_DATA07	0x10
+				MX6QDL_PAD_DISP0_DAT8__IPU1_DISP0_DATA08	0x10
+				MX6QDL_PAD_DISP0_DAT9__IPU1_DISP0_DATA09	0x10
+				MX6QDL_PAD_DISP0_DAT10__IPU1_DISP0_DATA10	0x10
+				MX6QDL_PAD_DISP0_DAT11__IPU1_DISP0_DATA11	0x10
+				MX6QDL_PAD_DISP0_DAT12__IPU1_DISP0_DATA12	0x10
+				MX6QDL_PAD_DISP0_DAT13__IPU1_DISP0_DATA13	0x10
+				MX6QDL_PAD_DISP0_DAT14__IPU1_DISP0_DATA14	0x10
+				MX6QDL_PAD_DISP0_DAT15__IPU1_DISP0_DATA15	0x10
+				MX6QDL_PAD_DISP0_DAT16__IPU1_DISP0_DATA16	0x10
+				MX6QDL_PAD_DISP0_DAT17__IPU1_DISP0_DATA17	0x10
+				MX6QDL_PAD_DISP0_DAT18__IPU1_DISP0_DATA18	0x10
+				MX6QDL_PAD_DISP0_DAT19__IPU1_DISP0_DATA19	0x10
+				MX6QDL_PAD_DISP0_DAT20__IPU1_DISP0_DATA20	0x10
+				MX6QDL_PAD_DISP0_DAT21__IPU1_DISP0_DATA21	0x10
+				MX6QDL_PAD_DISP0_DAT22__IPU1_DISP0_DATA22	0x10
+				MX6QDL_PAD_DISP0_DAT23__IPU1_DISP0_DATA23	0x10
 			>;
 		};
 
 		pinctrl_pcie: pciegrp {
 			fsl,pins = <
 				/* PCIe reset */
-				MX6QDL_PAD_EIM_BCLK__GPIO6_IO31	0x000b0
+				MX6QDL_PAD_EIM_BCLK__GPIO6_IO31			0x000b0
 			>;
 		};
 
 		pinctrl_pwm1: pwm1grp {
 			fsl,pins = <
-				MX6QDL_PAD_SD1_DAT3__PWM1_OUT	0x1b0b1
+				MX6QDL_PAD_SD1_DAT3__PWM1_OUT			0x1b0b1
 			>;
 		};
 
 		pinctrl_pwm2: pwm2grp {
 			fsl,pins = <
-				MX6QDL_PAD_SD1_DAT2__PWM2_OUT	0x1b0b1
+				MX6QDL_PAD_SD1_DAT2__PWM2_OUT			0x1b0b1
 			>;
 		};
 
 		pinctrl_pwm3: pwm3grp {
 			fsl,pins = <
-				MX6QDL_PAD_SD1_DAT1__PWM3_OUT	0x1b0b1
+				MX6QDL_PAD_SD1_DAT1__PWM3_OUT			0x1b0b1
 			>;
 		};
 
 		pinctrl_pwm4: pwm4grp {
 			fsl,pins = <
-				MX6QDL_PAD_SD1_CMD__PWM4_OUT	0x1b0b1
+				MX6QDL_PAD_SD1_CMD__PWM4_OUT			0x1b0b1
 			>;
 		};
 
 		pinctrl_rv4162: rv4162grp {
 			fsl,pins = <
-				MX6QDL_PAD_KEY_COL0__GPIO4_IO06	0x1b0b0
+				MX6QDL_PAD_KEY_COL0__GPIO4_IO06			0x1b0b0
 			>;
 		};
 
 		pinctrl_sgtl5000: sgtl5000grp {
 			fsl,pins = <
-				MX6QDL_PAD_GPIO_0__CCM_CLKO1		0x000b0
-				MX6QDL_PAD_EIM_A25__GPIO5_IO02		0x1b0b0
-				MX6QDL_PAD_ENET_TXD1__GPIO1_IO29	0x1b0b0
+				MX6QDL_PAD_GPIO_0__CCM_CLKO1			0x000b0
+				MX6QDL_PAD_EIM_A25__GPIO5_IO02			0x1b0b0
+				MX6QDL_PAD_ENET_TXD1__GPIO1_IO29		0x1b0b0
 			>;
 		};
 
 		pinctrl_uart1: uart1grp {
 			fsl,pins = <
-				MX6QDL_PAD_SD3_DAT7__UART1_TX_DATA	0x1b0b1
-				MX6QDL_PAD_SD3_DAT6__UART1_RX_DATA	0x1b0b1
+				MX6QDL_PAD_SD3_DAT7__UART1_TX_DATA		0x1b0b1
+				MX6QDL_PAD_SD3_DAT6__UART1_RX_DATA		0x1b0b1
 			>;
 		};
 
 		pinctrl_uart2: uart2grp {
 			fsl,pins = <
-				MX6QDL_PAD_EIM_D26__UART2_TX_DATA	0x1b0b1
-				MX6QDL_PAD_EIM_D27__UART2_RX_DATA	0x1b0b1
+				MX6QDL_PAD_EIM_D26__UART2_TX_DATA		0x1b0b1
+				MX6QDL_PAD_EIM_D27__UART2_RX_DATA		0x1b0b1
 			>;
 		};
 
 		pinctrl_uart5: uart5grp {
 			fsl,pins = <
-				MX6QDL_PAD_KEY_ROW1__UART5_RX_DATA	0x130b1
-				MX6QDL_PAD_KEY_COL1__UART5_TX_DATA	0x030b1
+				MX6QDL_PAD_KEY_ROW1__UART5_RX_DATA		0x130b1
+				MX6QDL_PAD_KEY_COL1__UART5_TX_DATA		0x030b1
 				/* RS485 RX Enable: pull up */
-				MX6QDL_PAD_NANDF_RB0__GPIO6_IO10	0x1b0b1
+				MX6QDL_PAD_NANDF_RB0__GPIO6_IO10		0x1b0b1
 				/* RS485 DEN: pull down */
-				MX6QDL_PAD_NANDF_CLE__GPIO6_IO07	0x030b1
+				MX6QDL_PAD_NANDF_CLE__GPIO6_IO07		0x030b1
 				/* RS485/!RS232 Select: pull down (rs232) */
-				MX6QDL_PAD_EIM_CS1__GPIO2_IO24		0x030b1
+				MX6QDL_PAD_EIM_CS1__GPIO2_IO24			0x030b1
 				/* ON: pull down */
-				MX6QDL_PAD_NANDF_ALE__GPIO6_IO08	0x030b1
+				MX6QDL_PAD_NANDF_ALE__GPIO6_IO08		0x030b1
 			>;
 		};
 
 		pinctrl_usbh1: usbh1grp {
 			fsl,pins = <
-				MX6QDL_PAD_GPIO_17__GPIO7_IO12		0x0b0b0
+				MX6QDL_PAD_GPIO_17__GPIO7_IO12			0x0b0b0
 			>;
 		};
 
diff --git a/arch/arm/boot/dts/wm8750.dtsi b/arch/arm/boot/dts/wm8750.dtsi
index 54d8f7d..6bd56f5 100644
--- a/arch/arm/boot/dts/wm8750.dtsi
+++ b/arch/arm/boot/dts/wm8750.dtsi
@@ -168,37 +168,37 @@
 					enable-bit = <25>;
 				};
 
-                                clkuart2: uart2 {
-                                        #clock-cells = <0>;
-                                        compatible = "via,vt8500-device-clock";
-                                        clocks = <&ref24>;
-                                        enable-reg = <0x254>;
-                                        enable-bit = <26>;
-                                };
-
-                                clkuart3: uart3 {
-                                        #clock-cells = <0>;
-                                        compatible = "via,vt8500-device-clock";
-                                        clocks = <&ref24>;
-                                        enable-reg = <0x254>;
-                                        enable-bit = <27>;
-                                };
-
-                                clkuart4: uart4 {
-                                        #clock-cells = <0>;
-                                        compatible = "via,vt8500-device-clock";
-                                        clocks = <&ref24>;
-                                        enable-reg = <0x254>;
-                                        enable-bit = <28>;
-                                };
-
-                                clkuart5: uart5 {
-                                        #clock-cells = <0>;
-                                        compatible = "via,vt8500-device-clock";
-                                        clocks = <&ref24>;
-                                        enable-reg = <0x254>;
-                                        enable-bit = <29>;
-                                };
+				clkuart2: uart2 {
+					#clock-cells = <0>;
+					compatible = "via,vt8500-device-clock";
+					clocks = <&ref24>;
+					enable-reg = <0x254>;
+					enable-bit = <26>;
+				};
+
+				clkuart3: uart3 {
+					#clock-cells = <0>;
+					compatible = "via,vt8500-device-clock";
+					clocks = <&ref24>;
+					enable-reg = <0x254>;
+					enable-bit = <27>;
+				};
+
+				clkuart4: uart4 {
+					#clock-cells = <0>;
+					compatible = "via,vt8500-device-clock";
+					clocks = <&ref24>;
+					enable-reg = <0x254>;
+					enable-bit = <28>;
+				};
+
+				clkuart5: uart5 {
+					#clock-cells = <0>;
+					compatible = "via,vt8500-device-clock";
+					clocks = <&ref24>;
+					enable-reg = <0x254>;
+					enable-bit = <29>;
+				};
 
 				clkpwm: pwm {
 					#clock-cells = <0>;
@@ -286,37 +286,37 @@
 			status = "disabled";
 		};
 
-                uart2: serial@d8210000 {
-                        compatible = "via,vt8500-uart";
-                        reg = <0xd8210000 0x1040>;
-                        interrupts = <47>;
-                        clocks = <&clkuart2>;
+		uart2: serial@d8210000 {
+			compatible = "via,vt8500-uart";
+			reg = <0xd8210000 0x1040>;
+			interrupts = <47>;
+			clocks = <&clkuart2>;
 			status = "disabled";
-                };
+		};
 
-                uart3: serial@d82c0000 {
-                        compatible = "via,vt8500-uart";
-                        reg = <0xd82c0000 0x1040>;
-                        interrupts = <50>;
-                        clocks = <&clkuart3>;
+		uart3: serial@d82c0000 {
+			compatible = "via,vt8500-uart";
+			reg = <0xd82c0000 0x1040>;
+			interrupts = <50>;
+			clocks = <&clkuart3>;
 			status = "disabled";
-                };
+		};
 
-                uart4: serial@d8370000 {
-                        compatible = "via,vt8500-uart";
-                        reg = <0xd8370000 0x1040>;
-                        interrupts = <30>;
-                        clocks = <&clkuart4>;
+		uart4: serial@d8370000 {
+			compatible = "via,vt8500-uart";
+			reg = <0xd8370000 0x1040>;
+			interrupts = <30>;
+			clocks = <&clkuart4>;
 			status = "disabled";
-                };
+		};
 
-                uart5: serial@d8380000 {
-                        compatible = "via,vt8500-uart";
-                        reg = <0xd8380000 0x1040>;
-                        interrupts = <43>;
-                        clocks = <&clkuart5>;
+		uart5: serial@d8380000 {
+			compatible = "via,vt8500-uart";
+			reg = <0xd8380000 0x1040>;
+			interrupts = <43>;
+			clocks = <&clkuart5>;
 			status = "disabled";
-                };
+		};
 
 		rtc@d8100000 {
 			compatible = "via,vt8500-rtc";
diff --git a/arch/arm/boot/dts/wm8850.dtsi b/arch/arm/boot/dts/wm8850.dtsi
index c572d77..a331398 100644
--- a/arch/arm/boot/dts/wm8850.dtsi
+++ b/arch/arm/boot/dts/wm8850.dtsi
@@ -179,21 +179,21 @@
 					enable-bit = <25>;
 				};
 
-                                clkuart2: uart2 {
-                                        #clock-cells = <0>;
-                                        compatible = "via,vt8500-device-clock";
-                                        clocks = <&ref24>;
-                                        enable-reg = <0x254>;
-                                        enable-bit = <26>;
-                                };
-
-                                clkuart3: uart3 {
-                                        #clock-cells = <0>;
-                                        compatible = "via,vt8500-device-clock";
-                                        clocks = <&ref24>;
-                                        enable-reg = <0x254>;
-                                        enable-bit = <27>;
-                                };
+				clkuart2: uart2 {
+					#clock-cells = <0>;
+					compatible = "via,vt8500-device-clock";
+					clocks = <&ref24>;
+					enable-reg = <0x254>;
+					enable-bit = <26>;
+				};
+
+				clkuart3: uart3 {
+					#clock-cells = <0>;
+					compatible = "via,vt8500-device-clock";
+					clocks = <&ref24>;
+					enable-reg = <0x254>;
+					enable-bit = <27>;
+				};
 
 				clkpwm: pwm {
 					#clock-cells = <0>;
@@ -273,21 +273,21 @@
 			status = "disabled";
 		};
 
-                uart2: serial@d8210000 {
-                        compatible = "via,vt8500-uart";
-                        reg = <0xd8210000 0x1040>;
-                        interrupts = <47>;
-                        clocks = <&clkuart2>;
+		uart2: serial@d8210000 {
+			compatible = "via,vt8500-uart";
+			reg = <0xd8210000 0x1040>;
+			interrupts = <47>;
+			clocks = <&clkuart2>;
 			status = "disabled";
-                };
+		};
 
-                uart3: serial@d82c0000 {
-                        compatible = "via,vt8500-uart";
-                        reg = <0xd82c0000 0x1040>;
-                        interrupts = <50>;
-                        clocks = <&clkuart3>;
+		uart3: serial@d82c0000 {
+			compatible = "via,vt8500-uart";
+			reg = <0xd82c0000 0x1040>;
+			interrupts = <50>;
+			clocks = <&clkuart3>;
 			status = "disabled";
-                };
+		};
 
 		rtc@d8100000 {
 			compatible = "via,vt8500-rtc";
-- 
1.9.1

