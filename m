Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8159C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 08:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA2B822CF8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 08:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfH1IAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 04:00:03 -0400
Received: from shell.v3.sk ([90.176.6.54]:40575 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbfH1IAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 04:00:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 13EF8D8342;
        Wed, 28 Aug 2019 09:59:57 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Wf4FgNoHJtlJ; Wed, 28 Aug 2019 09:59:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 7A19FD8339;
        Wed, 28 Aug 2019 09:59:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id MvqCNWhhuC-D; Wed, 28 Aug 2019 09:59:42 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id BCCC5D832F;
        Wed, 28 Aug 2019 09:59:41 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 3/5] dt-bindings: display: armada: Improve the LCDC documentation
Date:   Wed, 28 Aug 2019 09:59:36 +0200
Message-Id: <20190828075938.318028-4-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190828075938.318028-1-lkundrak@v3.sk>
References: <20190828075938.318028-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The port is a child, not a property. And should be accompanied by an
example. Plus a pair of cosmetic changes that don't seem to deserve a
separate commit.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Reviewed-by: Rob Herring <robh@kernel.org>

---
Changes since v3:
- Actually collected the Reviewed-by tag

Changes since v2:
- Collected the Reviewed-by tag

Changes since v1:
- Minor adjustments to the commit message wording.

 .../bindings/display/marvell,armada-lcdc.txt     | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/marvell,armada-lcd=
c.txt b/Documentation/devicetree/bindings/display/marvell,armada-lcdc.txt
index 46525ea3e646e..2606a8efc9568 100644
--- a/Documentation/devicetree/bindings/display/marvell,armada-lcdc.txt
+++ b/Documentation/devicetree/bindings/display/marvell,armada-lcdc.txt
@@ -1,10 +1,11 @@
-Device Tree bindings for Armada DRM CRTC driver
+Marvell Armada LCD controller
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
=20
 Required properties:
+
  - compatible: value should be "marvell,dove-lcd".
  - reg: base address and size of the LCD controller
  - interrupts: single interrupt number for the LCD controller
- - port: video output port with endpoints, as described by graph.txt
=20
 Optional properties:
=20
@@ -19,6 +20,11 @@ Note: all clocks are optional but at least one must be=
 specified.
 Further clocks may be added in the future according to requirements of
 different SoCs.
=20
+Required child nodes:
+
+- port: video output port with endpoints, as described by
+  Documentation/devicetree/bindings/graph.txt
+
 Example:
=20
 	lcd0: lcd-controller@820000 {
@@ -27,4 +33,10 @@ Example:
 		interrupts =3D <47>;
 		clocks =3D <&si5351 0>;
 		clock-names =3D "ext_ref_clk_1";
+
+		lcd0_port: port {
+			lcd0_rgb_out: endpoint {
+				remote-endpoint =3D <&encoder_rgb_in>;
+			};
+		};
 	};
--=20
2.21.0

