Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56EBC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 06:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A417424682
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 06:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbfLTGx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 01:53:29 -0500
Received: from [167.172.186.51] ([167.172.186.51]:59208 "EHLO shell.v3.sk"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727084AbfLTGxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 01:53:24 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id A823ADFC5E;
        Fri, 20 Dec 2019 06:53:24 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ZmMWJCslQbtS; Fri, 20 Dec 2019 06:53:22 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 77D76DFCA5;
        Fri, 20 Dec 2019 06:53:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JWHcIwLs_Dk3; Fri, 20 Dec 2019 06:53:21 +0000 (UTC)
Received: from furthur.lan (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 6140EDFC5E;
        Fri, 20 Dec 2019 06:53:21 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Olof Johansson <olof@lixom.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        soc@kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 3/5] dt-bindings: phy: Add binding for marvell,mmp3-hsic-phy
Date:   Fri, 20 Dec 2019 07:53:12 +0100
Message-Id: <20191220065314.237624-4-lkundrak@v3.sk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191220065314.237624-1-lkundrak@v3.sk>
References: <20191220065314.237624-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the PHY chip for USB HSIC on MMP3 platform.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 .../bindings/phy/marvell,mmp3-hsic-phy.yaml   | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/marvell,mmp3-hs=
ic-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/marvell,mmp3-hsic-phy.=
yaml b/Documentation/devicetree/bindings/phy/marvell,mmp3-hsic-phy.yaml
new file mode 100644
index 0000000000000..7917a95cda78d
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/marvell,mmp3-hsic-phy.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright 2019 Lubomir Rintel <lkundrak@v3.sk>
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/phy/marvell,mmp3-hsic-phy.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Marvell MMP3 HSIC PHY
+
+maintainers:
+  - Lubomir Rintel <lkundrak@v3.sk>
+
+properties:
+  compatible:
+    const: marvell,mmp3-hsic-phy
+
+  reg:
+    maxItems: 1
+    description: base address of the device
+
+  reset-gpios:
+    maxItems: 1
+    description: GPIO connected to reset
+
+  "#phy-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+  - "#phy-cells"
+
+examples:
+  - |
+    hsic-phy@f0001800 {
+            compatible =3D "marvell,mmp3-hsic-phy";
+            reg =3D <0xf0001800 0x40>;
+            reset-gpios =3D <&gpio 63 GPIO_ACTIVE_HIGH>;
+            #phy-cells =3D <0>;
+    };
--=20
2.24.1

