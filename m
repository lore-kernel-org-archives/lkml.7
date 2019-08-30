Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9E1C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 22:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06D1323777
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 22:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbfH3WQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 18:16:19 -0400
Received: from shell.v3.sk ([90.176.6.54]:56357 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728180AbfH3WQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 18:16:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 2A90DD880F;
        Sat, 31 Aug 2019 00:08:33 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id S9MhM_I0F1f3; Sat, 31 Aug 2019 00:08:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 4E6C0D87F9;
        Sat, 31 Aug 2019 00:07:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id I3jYT7iCk-jZ; Sat, 31 Aug 2019 00:07:55 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 13918D87E7;
        Sat, 31 Aug 2019 00:07:50 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     "To : Olof Johansson" <olof@lixom.net>
Cc:     "Cc : Rob Herring" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 05/16] dt-bindings: phy-mmp3-usb: Add bindings
Date:   Sat, 31 Aug 2019 00:07:32 +0200
Message-Id: <20190830220743.439670-6-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190830220743.439670-1-lkundrak@v3.sk>
References: <20190830220743.439670-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the PHY chip for USB OTG on MMP3 platform.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Reviewed-by: Rob Herring <robh@kernel.org>

---
Changes since v2:
- Add Rob's Reviewed-by tag

Changes since v1:
- s/usbphy@/usb-phy@/
- Dropped a reference to Documentation/phy.txt

 .../devicetree/bindings/phy/phy-mmp3-usb.txt        | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-mmp3-usb.tx=
t

diff --git a/Documentation/devicetree/bindings/phy/phy-mmp3-usb.txt b/Doc=
umentation/devicetree/bindings/phy/phy-mmp3-usb.txt
new file mode 100644
index 0000000000000..7183b9102f917
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-mmp3-usb.txt
@@ -0,0 +1,13 @@
+Marvell MMP3 USB PHY
+--------------------
+
+Required properties:
+- compatible: must be "marvell,mmp3-usb-phy"
+- #phy-cells: must be 0
+
+Example:
+	usb-phy: usb-phy@d4207000 {
+		compatible =3D "marvell,mmp3-usb-phy";
+		reg =3D <0xd4207000 0x40>;
+		#phy-cells =3D <0>;
+	};
--=20
2.21.0

