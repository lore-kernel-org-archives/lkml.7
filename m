Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B782C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 09:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EA0326678
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 09:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="MtgyKXpn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfEaJKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 05:10:09 -0400
Received: from mta-01.yadro.com ([89.207.88.251]:46506 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbfEaJKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 05:10:08 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 742CE41908;
        Fri, 31 May 2019 09:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received:received; s=mta-01; t=1559293805; x=
        1561108206; bh=XdggJuNI87v3norq47XBx2lNXy+o2Et1QZHyTn+TLOE=; b=M
        tgyKXpn4aZ21VFsCF1YEWjRswBh1RxApo6mOV9N1lkTj9JQKygGqzSJvFMI69Ii9
        ZiWbQ6EgRTWddP3PzrptQBC2+EUr6cTK6gwyxT3pNF0GRjEziSIy3uTxqbzsoZxN
        k+2dZo7KODYNwLjUWyTRs5LCsKcQ0g8J0HaPAj6Qyo=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Etf4PeSS29vb; Fri, 31 May 2019 12:10:05 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id D390241860;
        Fri, 31 May 2019 12:10:03 +0300 (MSK)
Received: from bbwork.com (172.17.14.115) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 31
 May 2019 12:10:03 +0300
From:   Alexander Filippov <a.filippov@yadro.com>
To:     <linux-aspeed@lists.ozlabs.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
        Joel Stanley <joel@jms.id.au>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Alexander Filippov <a.filippov@yadro.com>
Subject: [PATCH v4] ARM: dts: aspeed: Add YADRO VESNIN BMC
Date:   Fri, 31 May 2019 12:09:50 +0300
Message-ID: <20190531090950.13466-1-a.filippov@yadro.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.14.115]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VESNIN is an OpenPower machine with an Aspeed 2400 BMC SoC manufactured
by YADRO.

Signed-off-by: Alexander Filippov <a.filippov@yadro.com>
---
 arch/arm/boot/dts/Makefile                  |   1 +
 arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts | 224 ++++++++++++++++++++
 2 files changed, 225 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index dab2914fa293..64a956372fe1 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1272,6 +1272,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-opp-lanyang.dtb \
 	aspeed-bmc-opp-palmetto.dtb \
 	aspeed-bmc-opp-romulus.dtb \
+	aspeed-bmc-opp-vesnin.dtb \
 	aspeed-bmc-opp-witherspoon.dtb \
 	aspeed-bmc-opp-zaius.dtb \
 	aspeed-bmc-portwell-neptune.dtb \
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts b/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts
new file mode 100644
index 000000000000..0b9e29c3212e
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts
@@ -0,0 +1,224 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright 2019 YADRO
+/dts-v1/;
+
+#include "aspeed-g4.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+
+/ {
+	model = "Vesnin BMC";
+	compatible = "yadro,vesnin-bmc", "aspeed,ast2400";
+
+	chosen {
+		stdout-path = &uart5;
+		bootargs = "console=ttyS4,115200 earlyprintk";
+	};
+
+	memory {
+		reg = <0x40000000 0x20000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		vga_memory: framebuffer@5f000000 {
+			no-map;
+			reg = <0x5f000000 0x01000000>; /* 16MB */
+		};
+		flash_memory: region@5c000000 {
+			no-map;
+			reg = <0x5c000000 0x02000000>; /* 32M */
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		heartbeat {
+			gpios = <&gpio ASPEED_GPIO(R, 4) GPIO_ACTIVE_LOW>;
+		};
+		power_red {
+			gpios = <&gpio ASPEED_GPIO(N, 1) GPIO_ACTIVE_LOW>;
+		};
+
+		id_blue {
+			gpios = <&gpio ASPEED_GPIO(O, 0) GPIO_ACTIVE_LOW>;
+		};
+
+		alarm_red {
+			gpios = <&gpio ASPEED_GPIO(N, 6) GPIO_ACTIVE_LOW>;
+		};
+
+		alarm_yel {
+			gpios = <&gpio ASPEED_GPIO(N, 7) GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		button_checkstop {
+			label = "checkstop";
+			linux,code = <74>;
+			gpios = <&gpio ASPEED_GPIO(P, 5) GPIO_ACTIVE_LOW>;
+		};
+
+		button_identify {
+			label = "identify";
+			linux,code = <152>;
+			gpios = <&gpio ASPEED_GPIO(O, 7) GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+&fmc {
+	status = "okay";
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+        label = "bmc";
+#include "openbmc-flash-layout.dtsi"
+	};
+};
+
+&spi {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi1debug_default>;
+
+	flash@0 {
+		status = "okay";
+		label = "pnor";
+		m25p,fast-read;
+	};
+};
+
+&mac0 {
+	status = "okay";
+
+	use-ncsi;
+	no-hw-checksum;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii1_default>;
+};
+
+
+&uart5 {
+	status = "okay";
+};
+
+&lpc_ctrl {
+	status = "okay";
+	memory-region = <&flash_memory>;
+	flash = <&spi>;
+};
+
+&ibt {
+	status = "okay";
+};
+
+&uart3 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd2_default &pinctrl_rxd2_default>;
+};
+
+&i2c0 {
+	status = "okay";
+
+	eeprom@50 {
+		compatible = "atmel,24c256";
+		reg = <0x50>;
+		pagesize = <64>;
+	};
+};
+
+&i2c1 {
+	status = "okay";
+
+	tmp75@49 {
+		compatible = "ti,tmp75";
+		reg = <0x49>;
+	};
+};
+
+&i2c2 {
+	status = "okay";
+};
+
+&i2c3 {
+	status = "okay";
+};
+
+&i2c4 {
+	status = "okay";
+
+	occ-hwmon@50 {
+		compatible = "ibm,p8-occ-hwmon";
+		reg = <0x50>;
+	};
+};
+
+&i2c5 {
+	status = "okay";
+
+	occ-hwmon@51 {
+		compatible = "ibm,p8-occ-hwmon";
+		reg = <0x51>;
+	};
+};
+
+&i2c6 {
+	status = "okay";
+
+	w83795g@2f {
+		compatible = "nuvoton,w83795g";
+		reg = <0x2f>;
+	};
+};
+
+&i2c7 {
+	status = "okay";
+
+	occ-hwmon@56 {
+		compatible = "ibm,p8-occ-hwmon";
+		reg = <0x56>;
+	};
+};
+
+&i2c9 {
+	status = "okay";
+};
+
+&i2c10 {
+	status = "okay";
+};
+
+&i2c11 {
+	status = "okay";
+
+	occ-hwmon@57 {
+		compatible = "ibm,p8-occ-hwmon";
+		reg = <0x57>;
+	};
+};
+
+&i2c12 {
+	status = "okay";
+
+	rtc@68 {
+		compatible = "maxim,ds3231";
+		reg = <0x68>;
+	};
+};
+
+&i2c13 {
+	status = "okay";
+};
+
+&vuart {
+	status = "okay";
+};
-- 
2.20.1

