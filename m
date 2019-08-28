Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A195BC3A5A6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A32F22CF5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfH1H76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 03:59:58 -0400
Received: from shell.v3.sk ([90.176.6.54]:40563 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbfH1H76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 03:59:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 3DDE6D833F;
        Wed, 28 Aug 2019 09:59:54 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 0PrU-wBeZB85; Wed, 28 Aug 2019 09:59:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 01FBCD833B;
        Wed, 28 Aug 2019 09:59:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AS_XgI9h5Oul; Wed, 28 Aug 2019 09:59:42 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id F20B3D8332;
        Wed, 28 Aug 2019 09:59:41 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 4/5] dt-bindings: display: armada: Add more compatible strings
Date:   Wed, 28 Aug 2019 09:59:37 +0200
Message-Id: <20190828075938.318028-5-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190828075938.318028-1-lkundrak@v3.sk>
References: <20190828075938.318028-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a generic compatible string and the driver will work on a MMP2 as
well, using the same binding.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Reviewed-by: Rob Herring <robh@kernel.org>

---
Changes since v3:
- Collected Rob's Reviewed-by tag

Changes since v2:
- Order marvell,armada-lcdc after the model-specific strings.

Changes since v1:
- Added marvell,armada-lcdc compatible string.

 .../devicetree/bindings/display/marvell,armada-lcdc.txt        | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/marvell,armada-lcd=
c.txt b/Documentation/devicetree/bindings/display/marvell,armada-lcdc.txt
index 2606a8efc9568..0ea4cbe5a32ee 100644
--- a/Documentation/devicetree/bindings/display/marvell,armada-lcdc.txt
+++ b/Documentation/devicetree/bindings/display/marvell,armada-lcdc.txt
@@ -3,7 +3,8 @@ Marvell Armada LCD controller
=20
 Required properties:
=20
- - compatible: value should be "marvell,dove-lcd".
+ - compatible: value should be "marvell,dove-lcd" or "marvell,mmp2-lcd",
+   depending on the exact SoC model, along with "marvell,armada-lcdc"
  - reg: base address and size of the LCD controller
  - interrupts: single interrupt number for the LCD controller
=20
--=20
2.21.0

