Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D76C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D5482146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="PJ/tDqaq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbfCSPZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 11:25:13 -0400
Received: from mout.gmx.net ([212.227.17.22]:54837 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726763AbfCSPZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 11:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553009082;
        bh=iy1HeJKrBaK5knQav7qNjyQVAG7l2LLwYy4SPtwYkZA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=PJ/tDqaqg7vO1Obz1CRycZVjfZrGOTnmw/jstN2JW8+dq337RxC81GvbHhzzGDSHr
         Ekmd8vSkqZmXGnXpzl7/jg4qacmhbuGFbNA8IGUizEdO+J54Md9/ZjPv81YSjn4Tc7
         jompOjGZc5LKgqOBjR6TWd1FnFsr34a6fJRC8aAQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MWgND-1hUqx83GQ7-00XpmJ; Tue, 19
 Mar 2019 16:24:41 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thierry Reding <treding@nvidia.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH 2/5] ARM: dts: imx50: Add Kobo Aura DTS
Date:   Tue, 19 Mar 2019 16:24:17 +0100
Message-Id: <20190319152421.16179-3-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190319152421.16179-1-j.neuschaefer@gmx.net>
References: <20190319152421.16179-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aRAOxBpX4NqXsUQHHtCHrY9uf58GecUbuCxTzlaAExPLIliXwxH
 oVm6xtva/K5SqrylhBSs6+aRtNbJtc/IVjIqHUfa56BoMOUggRK6zup7glWsdlTCbap/63d
 4e+FmCoMw1FDt/r/3fnrq1Vo0bPRJnAt2JhnbvQMr78KzouusSrLLZ+tWh47tu4WAUT1UzA
 V/D1vICe4lEATpQx64skg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qgFm2pe7RH0=:LokpW1+CHU0j6DFPqwFfYD
 ruFOMz5H6lf/KUfuUlysNPCFlj1K684oQIDPLU5YMZahAcF96NghFi5QbMJnxve4gNxxlo3Ij
 +SGtVcv2TwAPmVr2ycld5n+qNDHrqKo88zrsE0e66KNdkHWVuHytYkwGxmSZwPlvoTMlgkfKX
 LTFjhgB7IUZVw5cL581RaereuOtHBB4obKjH0zZh1cc0mX3dyd8FUkW8bdyl6VKLFK/IdHjM+
 TnBjkbL53Oe4rf0f5galtfaJa3e6Pfiw7GCZABSLg1zesz+PuJ7Dsn+qsgN+QLX5C6Ml7oHUw
 RMPoPSOSUN5XfnKdOLH//XXlK1JoBZJYaU/rcK/QMQkRwiGzmsKT+7jRVjIiXyXtmM4do0wi0
 Lm+W6uaEn2QgFIIaOzZ1gpBHc6S/OXiWMlrgGmo7Igjggl4jtyhBMnnlXiUJCc8iPRydpVagH
 sbKyoQhks9iGqqkUBcCrrKx1XcJrBxrtWK8HH94G1qSuIPDTuS0xbvPoHFDYERxz3IDwix7cw
 4xIK+4oxW9SChUW0ek5sKa7yYctQ5PqAC/Y5cvJbDTU8QMGY1J0mp8mBbqtjSSTPrYmrGIs3i
 CsEiqd7ADBSkQigT8ti/XNdZe22KJFuzDp9DrGtwuAXBRfukPy5+lc3xyw0/N2Iw/7vNgEExJ
 O06+iLFyX0RO9/pjqAr52FQbkq7JXbfTZ7wFVMmWyts83Hs2dG6V/3MFlBDL0ve2U92DomPLt
 +DtqEHXFQ9GQFsfEQ1pVAEE52fY+H7DlPj7HPF4lboq3Gem2oKrjeeQuscyCO4qb8StHHYh5g
 xApf9c1FZx9Ab1I4Vvw9OBidf5eEzOV+ZVT4cZAhgKjZ8q7B7spvs5aIQxe8vrF3rN0rimCl3
 rTAFl2Qa0JYQV4v8AUO5iQaO5xnJ+6WHNPpA5Z/H3PwT8nUcFJysFZapr9lynOvc4EmzAIBlK
 nYGHaMQwJnA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kobo Aura is an e-book reader released in 2013.

With the devicetree in its current state, the kernel will boot and run
for about ten seconds. To solve this, the embedded controller needs to
be told that the system should stay powered on. This will be done in a
later patchset.

- The IOMUXC mode bits for the SD interfaces were taken from the
  vendor's U-Boot fork.
- The bus width of the eMMC is 4 bits in the vendor kernel, but I
  achieved better performance with 8 bits.
- The SDIO clock frequency for the WiFi chip is 25MHz in the vendor
  kernel, but the WiFi chip (BCM43362) supports 50MHz, which works
  reliably on this board and gives slightly better performance.
- The I2C pins' IOMUXC settings come from the vendor's U-Boot fork.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 arch/arm/boot/dts/Makefile            |   3 +-
 arch/arm/boot/dts/imx50-kobo-aura.dts | 245 ++++++++++++++++++++++++++
 2 files changed, 247 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/imx50-kobo-aura.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index f4f5aeaf3298..0c85156c552b 100644
=2D-- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -363,7 +363,8 @@ dtb-$(CONFIG_SOC_IMX35) +=3D \
 	imx35-eukrea-mbimxsd35-baseboard.dtb \
 	imx35-pdk.dtb
 dtb-$(CONFIG_SOC_IMX50) +=3D \
-	imx50-evk.dtb
+	imx50-evk.dtb \
+	imx50-kobo-aura.dtb
 dtb-$(CONFIG_SOC_IMX51) +=3D \
 	imx51-apf51.dtb \
 	imx51-apf51dev.dtb \
diff --git a/arch/arm/boot/dts/imx50-kobo-aura.dts b/arch/arm/boot/dts/imx=
50-kobo-aura.dts
new file mode 100644
index 000000000000..e778a677c752
=2D-- /dev/null
+++ b/arch/arm/boot/dts/imx50-kobo-aura.dts
@@ -0,0 +1,245 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright 2019 Jonathan Neusch=C3=A4fer
+//
+// The Kobo Aura e-book reader, model N514. The mainboard is marked as E6=
06F0B.
+
+/dts-v1/;
+#include "imx50.dtsi"
+#include <dt-bindings/input/input.h>
+
+/ {
+	model =3D "Kobo Aura (N514)";
+	compatible =3D "kobo,aura", "fsl,imx50";
+
+	chosen {
+		stdout-path =3D "serial1:115200n8";
+	};
+
+	memory@70000000 {
+		device_type =3D "memory";
+		reg =3D <0x70000000 0x10000000>;
+	};
+
+	gpio-leds {
+		compatible =3D "gpio-leds";
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl_leds>;
+
+		on {
+			label =3D "kobo_aura:orange:on";
+			gpios =3D <&gpio6 24 GPIO_ACTIVE_LOW>;
+			panic-indicator;
+		};
+	};
+
+	gpio-keys {
+		compatible =3D "gpio-keys";
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl_gpiokeys>;
+
+		power {
+			label =3D "Power Button";
+			gpios =3D <&gpio4 10 GPIO_ACTIVE_LOW>;
+			linux,code =3D <KEY_POWER>;
+		};
+
+		hallsensor {
+			label =3D "Hallsensor";
+			gpios =3D <&gpio5 15 GPIO_ACTIVE_LOW>;
+			linux,code =3D <0>;
+			linux,input-type =3D <5>;
+		};
+
+		frontlight {
+			label =3D "Frontlight";
+			gpios =3D <&gpio4 1 GPIO_ACTIVE_LOW>;
+			linux,code =3D <KEY_DISPLAYTOGGLE>;
+		};
+	};
+
+	sd2_pwrseq: pwrseq {
+		compatible =3D "mmc-pwrseq-simple";
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl_sd2_reset>;
+
+		reset-gpios =3D <&gpio4 17 GPIO_ACTIVE_LOW>;
+	};
+
+	sd2_vmmc: gpio-regulator {
+		compatible =3D "regulator-gpio";
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl_sd2_vmmc>;
+
+		regulator-name =3D "vmmc";
+		states =3D <3300000 0>;
+		regulator-min-microvolt =3D <3300000>;
+		regulator-max-microvolt =3D <3300000>;
+		enable-gpio =3D <&gpio4 12 GPIO_ACTIVE_LOW>;
+		startup-delay-us =3D <100000>;
+	};
+};
+
+&iomuxc {
+	pinctrl_uart2: uart2 {
+		fsl,pins =3D <
+			MX50_PAD_UART2_TXD__UART2_TXD_MUX	0x1e4
+			MX50_PAD_UART2_RXD__UART2_RXD_MUX	0x1e4
+		>;
+	};
+
+	pinctrl_i2c1: i2c1 {
+		fsl,pins =3D <
+			MX50_PAD_I2C1_SCL__I2C1_SCL		0x400001fd
+			MX50_PAD_I2C1_SDA__I2C1_SDA		0x400001fd
+		>;
+	};
+
+	pinctrl_i2c2: i2c2 {
+		fsl,pins =3D <
+			MX50_PAD_I2C2_SCL__I2C2_SCL		0x400001fd
+			MX50_PAD_I2C2_SDA__I2C2_SDA		0x400001fd
+		>;
+	};
+
+	pinctrl_i2c3: i2c3 {
+		fsl,pins =3D <
+			MX50_PAD_I2C3_SCL__I2C3_SCL		0x400001fd
+			MX50_PAD_I2C3_SDA__I2C3_SDA		0x400001fd
+		>;
+	};
+
+	pinctrl_leds: leds {
+		fsl,pins =3D <
+			MX50_PAD_PWM1__GPIO6_24			0x0
+		>;
+	};
+
+	pinctrl_gpiokeys: gpiokeys {
+		fsl,pins =3D <
+			MX50_PAD_CSPI_MISO__GPIO4_10		0x0
+			MX50_PAD_SD2_D7__GPIO5_15		0x0
+			MX50_PAD_KEY_ROW0__GPIO4_1		0x0
+		>;
+	};
+
+	pinctrl_sd1: sd1 {
+		fsl,pins =3D <
+			MX50_PAD_SD1_CMD__ESDHC1_CMD		0x1e4
+			MX50_PAD_SD1_CLK__ESDHC1_CLK		0xd4
+			MX50_PAD_SD1_D0__ESDHC1_DAT0		0x1d4
+			MX50_PAD_SD1_D1__ESDHC1_DAT1		0x1d4
+			MX50_PAD_SD1_D2__ESDHC1_DAT2		0x1d4
+			MX50_PAD_SD1_D3__ESDHC1_DAT3		0x1d4
+
+			MX50_PAD_SD2_CD__GPIO5_17		0x0
+		>;
+	};
+
+	pinctrl_sd2: sd2 {
+		fsl,pins =3D <
+			MX50_PAD_SD2_CMD__ESDHC2_CMD		0x1e4
+			MX50_PAD_SD2_CLK__ESDHC2_CLK		0xd4
+			MX50_PAD_SD2_D0__ESDHC2_DAT0		0x1d4
+			MX50_PAD_SD2_D1__ESDHC2_DAT1		0x1d4
+			MX50_PAD_SD2_D2__ESDHC2_DAT2		0x1d4
+			MX50_PAD_SD2_D3__ESDHC2_DAT3		0x1d4
+		>;
+	};
+
+	pinctrl_sd2_reset: sd2-reset {
+		fsl,pins =3D <
+			MX50_PAD_ECSPI2_MOSI__GPIO4_17		0x0
+		>;
+	};
+
+	pinctrl_sd2_vmmc: sd2-vmmc {
+		fsl,pins =3D <
+			MX50_PAD_ECSPI1_SCLK__GPIO4_12		0x0
+		>;
+	};
+
+	pinctrl_sd3: sd3 {
+		fsl,pins =3D <
+			MX50_PAD_SD3_CMD__ESDHC3_CMD		0x1e4
+			MX50_PAD_SD3_CLK__ESDHC3_CLK		0xd4
+			MX50_PAD_SD3_D0__ESDHC3_DAT0		0x1d4
+			MX50_PAD_SD3_D1__ESDHC3_DAT1		0x1d4
+			MX50_PAD_SD3_D2__ESDHC3_DAT2		0x1d4
+			MX50_PAD_SD3_D3__ESDHC3_DAT3		0x1d4
+			MX50_PAD_SD3_D4__ESDHC3_DAT4		0x1d4
+			MX50_PAD_SD3_D5__ESDHC3_DAT5		0x1d4
+			MX50_PAD_SD3_D6__ESDHC3_DAT6		0x1d4
+			MX50_PAD_SD3_D7__ESDHC3_DAT7		0x1d4
+		>;
+	};
+};
+
+&uart2 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_uart2>;
+	status =3D "okay";
+};
+
+&i2c1 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_i2c1>;
+	status =3D "okay";
+
+	/* TODO: ektf2132 touch controller at 0x15 */
+};
+
+&i2c2 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_i2c2>;
+	status =3D "okay";
+
+	/* TODO: TPS65185 PMIC for E Ink at 0x68 */
+};
+
+&i2c3 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_i2c3>;
+	status =3D "okay";
+
+	/* TODO: embedded controller at 0x43 */
+};
+
+&esdhc1 {
+	status =3D "okay";
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_sd1>;
+
+	max-frequency =3D <50000000>;
+	bus-width =3D <4>;
+	cd-gpios =3D <&gpio5 17 GPIO_ACTIVE_LOW>;
+	disable-wp;
+
+	/* External =C2=B5SD card */
+};
+
+&esdhc2 {
+	status =3D "okay";
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_sd2>;
+
+	bus-width =3D <4>;
+	max-frequency =3D <50000000>;
+	disable-wp;
+	mmc-pwrseq =3D <&sd2_pwrseq>;
+	vmmc-supply =3D <&sd2_vmmc>;
+
+	/* CyberTan WC121 SDIO WiFi (BCM43362) */
+};
+
+&esdhc3 {
+	status =3D "okay";
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_sd3>;
+
+	bus-width =3D <8>;
+	non-removable;
+	max-frequency =3D <50000000>;
+	disable-wp;
+
+	/* Internal eMMC */
+};
=2D-
2.20.1

