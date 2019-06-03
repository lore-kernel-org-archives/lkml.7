Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCF2C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F24D275D6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbfFCRJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 13:09:32 -0400
Received: from gloria.sntech.de ([185.11.138.130]:38284 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbfFCRJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 13:09:32 -0400
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hXqSf-0004ZW-Bn; Mon, 03 Jun 2019 19:09:29 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     broonie@kernel.org, lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        tony.xie@rock-chips.com, zhangqing@rock-chips.com,
        huangtao@rock-chips.com, Rob Herring <robh@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v8 RESEND 3/5] dt-bindings: mfd: rk808: Add binding information for RK809 and RK817.
Date:   Mon,  3 Jun 2019 19:08:58 +0200
Message-Id: <20190603170900.5195-4-heiko@sntech.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190603170900.5195-1-heiko@sntech.de>
References: <20190603170900.5195-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Xie <tony.xie@rock-chips.com>

Add device tree bindings documentation for Rockchip's RK809 & RK817 PMIC.

Signed-off-by: Tony Xie <tony.xie@rock-chips.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../devicetree/bindings/mfd/rk808.txt         | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/rk808.txt b/Documentation/devicetree/bindings/mfd/rk808.txt
index 1683ec3245bc..04df07f6f793 100644
--- a/Documentation/devicetree/bindings/mfd/rk808.txt
+++ b/Documentation/devicetree/bindings/mfd/rk808.txt
@@ -3,11 +3,15 @@ RK8XX Power Management Integrated Circuit
 The rk8xx family current members:
 rk805
 rk808
+rk809
+rk817
 rk818
 
 Required properties:
 - compatible: "rockchip,rk805"
 - compatible: "rockchip,rk808"
+- compatible: "rockchip,rk809"
+- compatible: "rockchip,rk817"
 - compatible: "rockchip,rk818"
 - reg: I2C slave address
 - interrupts: the interrupt outputs of the controller.
@@ -45,6 +49,23 @@ Optional RK808 properties:
   the gpio controller. If DVS GPIOs aren't present, voltage changes will happen
   very quickly with no slow ramp time.
 
+Optional shared RK809 and RK817 properties:
+- vcc1-supply:  The input supply for DCDC_REG1
+- vcc2-supply:  The input supply for DCDC_REG2
+- vcc3-supply:  The input supply for DCDC_REG3
+- vcc4-supply:  The input supply for DCDC_REG4
+- vcc5-supply:  The input supply for LDO_REG1, LDO_REG2, LDO_REG3
+- vcc6-supply:  The input supply for LDO_REG4, LDO_REG5, LDO_REG6
+- vcc7-supply:  The input supply for LDO_REG7, LDO_REG8, LDO_REG9
+
+Optional RK809 properties:
+- vcc8-supply:  The input supply for SWITCH_REG1
+- vcc9-supply:  The input supply for DCDC_REG5, SWITCH_REG2
+
+Optional RK817 properties:
+- vcc8-supply:  The input supply for BOOST
+- vcc9-supply:  The input supply for OTG_SWITCH
+
 Optional RK818 properties:
 - vcc1-supply:  The input supply for DCDC_REG1
 - vcc2-supply:  The input supply for DCDC_REG2
@@ -86,6 +107,21 @@ number as described in RK808 datasheet.
 	- SWITCH_REGn
 		- valid values for n are 1 to 2
 
+Following regulators of the RK809 and RK817 PMIC blocks are supported. Note that
+the 'n' in regulator name, as in DCDC_REGn or LDOn, represents the DCDC or LDO
+number as described in RK809 and RK817 datasheets.
+
+	- DCDC_REGn
+		- valid values for n are 1 to 5 for RK809.
+		- valid values for n are 1 to 4 for RK817.
+	- LDO_REGn
+		- valid values for n are 1 to 9 for RK809.
+		- valid values for n are 1 to 9 for RK817.
+	- SWITCH_REGn
+		- valid values for n are 1 to 2 for RK809.
+	- BOOST for RK817
+	- OTG_SWITCH for RK817
+
 Following regulators of the RK818 PMIC block are supported. Note that
 the 'n' in regulator name, as in DCDC_REGn or LDOn, represents the DCDC or LDO
 number as described in RK818 datasheet.
@@ -98,6 +134,14 @@ number as described in RK818 datasheet.
 	- HDMI_SWITCH
 	- OTG_SWITCH
 
+It is necessary to configure three pins for both the RK809 and RK817, the three
+pins are "gpio_ts" "gpio_gt" "gpio_slp".
+	The gpio_gt and gpio_ts pins support the gpio function.
+	The gpio_slp pin is for controlling the pmic states, as below:
+		- reset
+		- power down
+		- sleep
+
 Standard regulator bindings are used inside regulator subnodes. Check
   Documentation/devicetree/bindings/regulator/regulator.txt
 for more details
-- 
2.20.1

