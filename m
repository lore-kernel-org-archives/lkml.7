Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F706C3A5A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F26F233FF
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732112AbfHVJ1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 05:27:54 -0400
Received: from shell.v3.sk ([90.176.6.54]:35655 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730111AbfHVJ1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 05:27:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id EE25C493E8;
        Thu, 22 Aug 2019 11:27:47 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id CZa7DHZpvi9T; Thu, 22 Aug 2019 11:27:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id E05C2D7570;
        Thu, 22 Aug 2019 11:27:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4-csVm1jD4TM; Thu, 22 Aug 2019 11:26:47 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id E9547D79C8;
        Thu, 22 Aug 2019 11:26:46 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 02/20] dt-bindings: arm: Convert Marvell MMP board/soc bindings to json-schema
Date:   Thu, 22 Aug 2019 11:26:25 +0200
Message-Id: <20190822092643.593488-3-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822092643.593488-1-lkundrak@v3.sk>
References: <20190822092643.593488-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Marvell MMP SoC bindings to DT schema format using json-schema.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v1:
- Added this patch

 .../devicetree/bindings/arm/mrvl/mrvl.txt     | 14 ---------
 .../devicetree/bindings/arm/mrvl/mrvl.yaml    | 31 +++++++++++++++++++
 2 files changed, 31 insertions(+), 14 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/mrvl/mrvl.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mrvl/mrvl.yaml

diff --git a/Documentation/devicetree/bindings/arm/mrvl/mrvl.txt b/Docume=
ntation/devicetree/bindings/arm/mrvl/mrvl.txt
deleted file mode 100644
index 951687528efb0..0000000000000
--- a/Documentation/devicetree/bindings/arm/mrvl/mrvl.txt
+++ /dev/null
@@ -1,14 +0,0 @@
-Marvell Platforms Device Tree Bindings
-----------------------------------------------------
-
-PXA168 Aspenite Board
-Required root node properties:
-	- compatible =3D "mrvl,pxa168-aspenite", "mrvl,pxa168";
-
-PXA910 DKB Board
-Required root node properties:
-	- compatible =3D "mrvl,pxa910-dkb";
-
-MMP2 Brownstone Board
-Required root node properties:
-	- compatible =3D "mrvl,mmp2-brownstone", "mrvl,mmp2";
diff --git a/Documentation/devicetree/bindings/arm/mrvl/mrvl.yaml b/Docum=
entation/devicetree/bindings/arm/mrvl/mrvl.yaml
new file mode 100644
index 0000000000000..dc9de506ac6e3
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mrvl/mrvl.yaml
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/mrvl/mrvl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell Platforms Device Tree Bindings
+
+maintainers:
+  - Lubomir Rintel <lkundrak@v3.sk>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: PXA168 Aspenite Board
+        items:
+          - enum:
+              - mrvl,pxa168-aspenite
+          - const: mrvl,pxa168
+      - description: PXA910 DKB Board
+        items:
+          - enum:
+              - mrvl,pxa910-dkb
+      - description: MMP2 Brownstone Board
+        items:
+          - enum:
+              - mrvl,mmp2-brownstone
+          - const: mrvl,mmp2
+...
--=20
2.21.0

