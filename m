Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101A7C3A5A6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 08:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E250E205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 08:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfH1IAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 04:00:04 -0400
Received: from shell.v3.sk ([90.176.6.54]:40580 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbfH1IAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 04:00:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id BC4C7D832D;
        Wed, 28 Aug 2019 09:59:57 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id S8cKjMhYL0Ji; Wed, 28 Aug 2019 09:59:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 9A0F4D833A;
        Wed, 28 Aug 2019 09:59:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ih7jdCbCCXrQ; Wed, 28 Aug 2019 09:59:42 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 88E7FD832D;
        Wed, 28 Aug 2019 09:59:41 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v4 2/5] dt-bindings: display: armada: Rename the binding doc file
Date:   Wed, 28 Aug 2019 09:59:35 +0200
Message-Id: <20190828075938.318028-3-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190828075938.318028-1-lkundrak@v3.sk>
References: <20190828075938.318028-1-lkundrak@v3.sk>
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
index 3d824ecf96229..d379acd4f69ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9620,7 +9620,7 @@ T:	git git://git.armlinux.org.uk/~rmk/linux-arm.git=
 drm-armada-devel
 T:	git git://git.armlinux.org.uk/~rmk/linux-arm.git drm-armada-fixes
 F:	drivers/gpu/drm/armada/
 F:	include/uapi/drm/armada_drm.h
-F:	Documentation/devicetree/bindings/display/armada/
+F:	Documentation/devicetree/bindings/display/marvell,armada-lcdc.txt
 F:	Documentation/devicetree/bindings/reserved-memory/marvell,armada-fram=
ebuffer.txt
=20
 MARVELL ARMADA 3700 PHY DRIVERS
--=20
2.21.0

