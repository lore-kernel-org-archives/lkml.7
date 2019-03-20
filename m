Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D52C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D31720657
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbfCTIVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 04:21:19 -0400
Received: from shell.v3.sk ([90.176.6.54]:52084 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbfCTIVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 04:21:17 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 94C391032FD;
        Wed, 20 Mar 2019 09:21:14 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id rJHbMHvfQnry; Wed, 20 Mar 2019 09:21:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 1BD95103302;
        Wed, 20 Mar 2019 09:21:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XqQ-Uw1Rv0dd; Wed, 20 Mar 2019 09:21:00 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 9AC391032F9;
        Wed, 20 Mar 2019 09:21:00 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/5] dt-bindings: reserved-memory: Add binding for Armada framebuffer
Date:   Wed, 20 Mar 2019 09:20:53 +0100
Message-Id: <20190320082057.856943-2-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190320082057.856943-1-lkundrak@v3.sk>
References: <20190320082057.856943-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the binding for memory that is set aside for allocation of Marvel=
l
Armada framebuffer objects.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Reviewed-by: Rob Herring <robh@kernel.org>

---
Changes since v2:
- Collected the Reviewed-by tag

Changes since v1:
- Moved from bindings/display/armada/
- Removed the marvell,dove-framebuffer string
- Added to the MAINTAINERS entry

 .../marvell,armada-framebuffer.txt            | 22 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/mar=
vell,armada-framebuffer.txt

diff --git a/Documentation/devicetree/bindings/reserved-memory/marvell,ar=
mada-framebuffer.txt b/Documentation/devicetree/bindings/reserved-memory/=
marvell,armada-framebuffer.txt
new file mode 100644
index 000000000000..ab243e2bad45
--- /dev/null
+++ b/Documentation/devicetree/bindings/reserved-memory/marvell,armada-fr=
amebuffer.txt
@@ -0,0 +1,22 @@
+Marvell Armada framebuffer reserved memory
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Memory set aside for allocation of Marvell Armada framebuffer objects.
+
+Required properties:
+
+ - compatible: must be "marvell,armada-framebuffer"
+
+Please refer to Documentation/devicetree/bindings/reserved-memory/reserv=
ed-memory.txt
+for common reserved memory binding usage.
+
+Example:
+
+	reserved-memory {
+		display_reserved: framebuffer {
+			compatible =3D "marvell,armada-framebuffer";
+			size =3D <0x02000000>;
+			alignment =3D <0x02000000>;
+			no-map;
+		};
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index f3a5c97e3419..e71aa05fef29 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8967,6 +8967,7 @@ T:	git git://git.armlinux.org.uk/~rmk/linux-arm.git=
 drm-armada-fixes
 F:	drivers/gpu/drm/armada/
 F:	include/uapi/drm/armada_drm.h
 F:	Documentation/devicetree/bindings/display/armada/
+F:	Documentation/devicetree/bindings/reserved-memory/marvell,armada-fram=
ebuffer.txt
=20
 MARVELL CRYPTO DRIVER
 M:	Boris Brezillon <boris.brezillon@bootlin.com>
--=20
2.20.1

