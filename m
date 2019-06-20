Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5735C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 11:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 942F32080D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 11:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731450AbfFTLqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 07:46:50 -0400
Received: from shell.v3.sk ([90.176.6.54]:51057 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbfFTLqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 07:46:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id E7608CC073;
        Thu, 20 Jun 2019 13:46:46 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id OJ88IFTDgdTW; Thu, 20 Jun 2019 13:46:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 723AACC103;
        Thu, 20 Jun 2019 13:46:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8XT0FZvErvnb; Thu, 20 Jun 2019 13:46:41 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 44A83CC073;
        Thu, 20 Jun 2019 13:46:41 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH v2] dt-bindings: phy-pxa-usb: add bindings
Date:   Thu, 20 Jun 2019 13:46:36 +0200
Message-Id: <20190620114636.1387509-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the PHY chip for USB OTG on PXA platforms.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>

---
This remained unapplied, despite the driver being in already.

Changes since v1:
- Cosmetic and wording fixes

 .../devicetree/bindings/phy/phy-pxa-usb.txt    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-pxa-usb.txt

diff --git a/Documentation/devicetree/bindings/phy/phy-pxa-usb.txt b/Docu=
mentation/devicetree/bindings/phy/phy-pxa-usb.txt
new file mode 100644
index 000000000000..93fc09c12954
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-pxa-usb.txt
@@ -0,0 +1,18 @@
+Marvell PXA USB PHY
+-------------------
+
+Required properties:
+- compatible: one of: "marvell,mmp2-usb-phy", "marvell,pxa910-usb-phy",
+	"marvell,pxa168-usb-phy",
+- #phy-cells: must be 0
+
+Example:
+	usb-phy: usbphy@d4207000 {
+		compatible =3D "marvell,mmp2-usb-phy";
+		reg =3D <0xd4207000 0x40>;
+		#phy-cells =3D <0>;
+		status =3D "okay";
+	};
+
+This document explains the device tree binding. For general
+information about PHY subsystem refer to Documentation/phy.txt
--=20
2.21.0

