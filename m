Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FBEC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 06:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A50CA20643
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 06:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730787AbfDQGWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 02:22:18 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45311 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729331AbfDQGWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 02:22:15 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1hGdxN-0006Et-Fd; Wed, 17 Apr 2019 08:22:05 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92-RC6)
        (envelope-from <ore@pengutronix.de>)
        id 1hGdxK-00047x-VO; Wed, 17 Apr 2019 08:22:02 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jay Cliburn <jcliburn@gmail.com>,
        Chris Snook <chris.snook@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, John Crispin <john@phrozen.org>,
        Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org
Subject: [PATCH v1 1/3] dt-bindings: net: add qca,ar71xx.txt documentation
Date:   Wed, 17 Apr 2019 08:21:59 +0200
Message-Id: <20190417062201.15745-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190417062201.15745-1-o.rempel@pengutronix.de>
References: <20190417062201.15745-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for Atheros/QCA networking IP core used
in many routers.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 .../devicetree/bindings/net/qca,ar71xx.txt    | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/qca,ar71xx.txt

diff --git a/Documentation/devicetree/bindings/net/qca,ar71xx.txt b/Documentation/devicetree/bindings/net/qca,ar71xx.txt
new file mode 100644
index 000000000000..1ab7dffc0ea1
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/qca,ar71xx.txt
@@ -0,0 +1,45 @@
+Required properties:
+- compatible:	Should be "qca,<soc>-eth". Currently support compatibles are:
+		qca,ar7100-eth - Atheros AR7100
+		qca,ar7240-eth - Atheros AR7240
+		qca,ar7241-eth - Atheros AR7241
+		qca,ar7242-eth - Atheros AR7242
+		qca,ar9130-eth - Atheros AR9130
+		qca,ar9330-eth - Atheros AR9330
+		qca,ar9340-eth - Atheros AR9340
+		qca,qca9530-eth - Qualcomm Atheros QCA9530
+		qca,qca9550-eth - Qualcomm Atheros QCA9550
+		qca,qca9560-eth - Qualcomm Atheros QCA9560
+
+- reg : Address and length of the register set for the device
+- interrupts : Should contain eth interrupt
+- phy-mode : See ethernet.txt file in the same directory
+- clocks: the clock used by the core
+- clock-names: the names of the clock listed in the clocks property. These are
+	"mdio".
+- resets: Should contain phandles to the reset signals
+- reset-names: Should contain the names of reset signal listed in the resets
+		property. These are "mac" and "mdio"
+
+Optional properties:
+- phy-handle : phandle to the PHY device connected to this device.
+- fixed-link : Assume a fixed link. See fixed-link.txt in the same directory.
+  Use instead of phy-handle.
+
+Optional subnodes:
+- mdio : specifies the mdio bus, used as a container for phy nodes
+  according to phy.txt in the same directory
+
+Example:
+
+eth1: eth@1a000000 {
+	compatible = "qca,ar9330-eth";
+	reg = <0x1a000000 0x200>;
+	interrupts = <5>;
+	resets = <&rst 13>, <&rst 23>;
+	reset-names = "mac", "mdio";
+	clocks = <&pll ATH79_CLK_MDIO>;
+	clock-names = "mdio";
+	phy-mode = "gmii";
+};
+
-- 
2.20.1

