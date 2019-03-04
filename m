Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45175C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18D2E206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfCDUUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:20:39 -0500
Received: from shell.v3.sk ([90.176.6.54]:53464 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbfCDUUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:20:34 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id DC7C0102981;
        Mon,  4 Mar 2019 21:20:31 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id dekCZFaTQUdb; Mon,  4 Mar 2019 21:20:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id AD55F10297D;
        Mon,  4 Mar 2019 21:20:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id c_bYG3i9-xQd; Mon,  4 Mar 2019 21:20:16 +0100 (CET)
Received: from nedofet.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 6ABCC102980;
        Mon,  4 Mar 2019 21:20:16 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 2/5] dt-bindings: display: armada: Rename the binding doc file
Date:   Mon,  4 Mar 2019 21:20:03 +0100
Message-Id: <20190304202006.3863-3-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190304202006.3863-1-lkundrak@v3.sk>
References: <20190304202006.3863-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a more generic name, since it will document more compatible LCD
controllers than just that of Dove. Also, there's no point putting it in
a separate directory.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v1:
- Choose a better name than armada/marvell-armada-drm.txt, since
  there will be no display-subsystem master node and thus it will
  only document just the LCDC.

 .../{armada/marvell,dove-lcd.txt =3D> marvell,armada-lcdc.txt}    | 0
 MAINTAINERS                                                     | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/display/{armada/marvell,dove-lc=
d.txt =3D> marvell,armada-lcdc.txt} (100%)

diff --git a/Documentation/devicetree/bindings/display/armada/marvell,dov=
e-lcd.txt b/Documentation/devicetree/bindings/display/marvell,armada-lcdc=
.txt
similarity index 100%
rename from Documentation/devicetree/bindings/display/armada/marvell,dove=
-lcd.txt
rename to Documentation/devicetree/bindings/display/marvell,armada-lcdc.t=
xt
diff --git a/MAINTAINERS b/MAINTAINERS
index e71aa05fef29..890cbd6e0b7b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8966,7 +8966,7 @@ T:	git git://git.armlinux.org.uk/~rmk/linux-arm.git=
 drm-armada-devel
 T:	git git://git.armlinux.org.uk/~rmk/linux-arm.git drm-armada-fixes
 F:	drivers/gpu/drm/armada/
 F:	include/uapi/drm/armada_drm.h
-F:	Documentation/devicetree/bindings/display/armada/
+F:	Documentation/devicetree/bindings/display/marvell,armada-lcdc.txt
 F:	Documentation/devicetree/bindings/reserved-memory/marvell,armada-fram=
ebuffer.txt
=20
 MARVELL CRYPTO DRIVER
--=20
2.20.1

