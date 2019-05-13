Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E596C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 12:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5738421019
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 12:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557750662;
	bh=+AiYxs7eFp3wKBEUIwxdyoO9sla4edlKtCgPcDFs3KA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=aSu3Df1Z2AgFkSoPzaYZYbJhAQKzvZnTFbKaMW41nMAxIbT3NGStiw2OvMGMj/YlW
	 NQBWr+Zs1bF0LkoRw3xDAgnwlQZVz9GdfDJsdub62Zw85HJL4D3NvJ8F6IaLAMVsMH
	 4qok00tnRNP/RwsnB3dlHV95l5BG8KooA2X3gnCs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729755AbfEMMbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 08:31:01 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57256 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729405AbfEMMa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 08:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=/3uaFWuGvx6/YjFe85ifhISJWg7Voqrl/AA6bg8Ckho=; b=wWSrzRB0IjPf
        IkwrW3+2fhEt6n6KyRwlBds0w2ctldxJw4cC+Xz6S72prumc2Pb6cSDgRJqzkrFviJKIULfdSAw+X
        880br0xu9eiOVaxCDmR2GJyalxMQe3e5ZWaTm5f7StMlgZy6j99n9sP+GJ6XmdTMI8E0xuTMgm6IK
        Cr4og=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hQA6U-0006Zl-1r; Mon, 13 May 2019 12:30:50 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id ADDDD1129232; Mon, 13 May 2019 13:30:48 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Eric Jeong <eric.jeong.opensource@diasemi.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "dt-bindings: regulator: add document bindings for slg51000" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190513123048.ADDDD1129232@debutante.sirena.org.uk>
Date:   Mon, 13 May 2019 13:30:48 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   dt-bindings: regulator: add document bindings for slg51000

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 977bfde5d4cbb9d2eb1969eb2eb671cdb9b9fcbf Mon Sep 17 00:00:00 2001
From: Eric Jeong <eric.jeong.opensource@diasemi.com>
Date: Thu, 18 Apr 2019 15:09:44 +0900
Subject: [PATCH] dt-bindings: regulator: add document bindings for slg51000

Add device tree binding information for slg51000 regulator driver.
Example bindings for SLG51000 are added.

Signed-off-by: Eric Jeong <eric.jeong.opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/regulator/slg51000.txt           | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/slg51000.txt

diff --git a/Documentation/devicetree/bindings/regulator/slg51000.txt b/Documentation/devicetree/bindings/regulator/slg51000.txt
new file mode 100644
index 000000000000..aa0733e49b90
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/slg51000.txt
@@ -0,0 +1,88 @@
+* Dialog Semiconductor SLG51000 Voltage Regulator
+
+Required properties:
+- compatible : Should be "dlg,slg51000" for SLG51000
+- reg : Specifies the I2C slave address.
+- xxx-supply: Input voltage supply regulator for ldo3 to ldo7.
+  These entries are required if regulators are enabled for a device.
+  An absence of these properties can cause the regulator registration to fail.
+  If some of input supply is powered through battery or always-on supply then
+  also it is required to have these parameters with proper node handle of always
+  on power supply.
+    vin3-supply: Input supply for ldo3
+    vin4-supply: Input supply for ldo4
+    vin5-supply: Input supply for ldo5
+    vin6-supply: Input supply for ldo6
+    vin7-supply: Input supply for ldo7
+
+Optional properties:
+- interrupt-parent : Specifies the reference to the interrupt controller.
+- interrupts : IRQ line information.
+- dlg,cs-gpios : Specify a valid GPIO for chip select
+
+Sub-nodes:
+- regulators : This node defines the settings for the regulators.
+  The content of the sub-node is defined by the standard binding
+  for regulators; see regulator.txt.
+
+  The SLG51000 regulators are bound using their names listed below:
+    ldo1
+    ldo2
+    ldo3
+    ldo4
+    ldo5
+    ldo6
+    ldo7
+
+Optional properties for regulators:
+- enable-gpios : Specify a valid GPIO for platform control of the regulator.
+
+Example:
+	pmic: slg51000@75 {
+		compatible = "dlg,slg51000";
+		reg = <0x75>;
+
+		regulators {
+			ldo1 {
+			        regulator-name = "ldo1";
+			        regulator-min-microvolt = <2400000>;
+			        regulator-max-microvolt = <3300000>;
+			};
+
+			ldo2 {
+			        regulator-name = "ldo2";
+			        regulator-min-microvolt = <2400000>;
+			        regulator-max-microvolt = <3300000>;
+			};
+
+			ldo3 {
+			        regulator-name = "ldo3";
+			        regulator-min-microvolt = <1200000>;
+			        regulator-max-microvolt = <3750000>;
+			};
+
+			ldo4 {
+			        regulator-name = "ldo4";
+			        regulator-min-microvolt = <1200000>;
+			        regulator-max-microvolt = <3750000>;
+			};
+
+			ldo5 {
+			        regulator-name = "ldo5";
+			        regulator-min-microvolt = <500000>;
+			        regulator-max-microvolt = <1200000>;
+			};
+
+			ldo6 {
+			        regulator-name = "ldo6";
+			        regulator-min-microvolt = <500000>;
+			        regulator-max-microvolt = <1200000>;
+			};
+
+			ldo7 {
+			        regulator-name = "ldo7";
+			        regulator-min-microvolt = <1200000>;
+			        regulator-max-microvolt = <3750000>;
+			};
+		};
+	};
-- 
2.20.1

