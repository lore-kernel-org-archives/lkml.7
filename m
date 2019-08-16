Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BE1C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 08:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABE43205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 08:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kde.org header.i=@kde.org header.b="N249T6Mm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfHPIoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 04:44:21 -0400
Received: from letterbox.kde.org ([46.43.1.242]:39518 "EHLO letterbox.kde.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726810AbfHPIoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 04:44:18 -0400
Received: from archbox.localdomain (unknown [203.187.238.17])
        (Authenticated sender: bshah)
        by letterbox.kde.org (Postfix) with ESMTPSA id B068A287B59;
        Fri, 16 Aug 2019 09:44:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kde.org; s=users;
        t=1565945057; bh=LhSaj2Wrav0bh3x+ATV1e3H8mqMrzwJ+KYcnBJnUEqg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=N249T6Mm6GsclAsGLypNLsYd2Zxo40RcZtnfKomveedfFiRvnSKu8juzl07ijUVuH
         kbM1mLahMimlAgC/lToDwRI8feFpleu+2KBjMUCatZArdG78/B4QGZiDollNI6Hww+
         SF77VbIeA1QyOB1lESkXI9y4zhiyqpZHQ4FpifIoPJmupc2vauWm3/zirCDfRnSOM7
         VDtZzZreie+sJEGX4e5dmAYffk5TgFWy1JTSMV7TG9aPD6AddNdZCnLFV3CXNZzoUz
         EL68X8LZ9yu1jYr3y9VSkluQl6ti4rZE38vFXZE3qpRp6pwbJsTkJmYQPAjhjp8XfO
         7Bp3ulN6LlPyQ==
From:   Bhushan Shah <bshah@kde.org>
To:     Icenowy Zheng <icenowy@aosc.io>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Wolfram Sang <wsa@the-dreams.de>, Bhushan Shah <bshah@kde.org>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 1/2] dt-bindings: i2c: mv64xxx: Add compatible for the H6 i2c node.
Date:   Fri, 16 Aug 2019 14:13:08 +0530
Message-Id: <20190816084309.27440-2-bshah@kde.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190816084309.27440-1-bshah@kde.org>
References: <20190816064710.18280-1-bshah@kde.org>
 <20190816084309.27440-1-bshah@kde.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner H6 have a mv64xxx i2c interface available to be used.

Signed-off-by: Bhushan Shah <bshah@kde.org>
---

 Documentation/devicetree/bindings/i2c/marvell,mv64xxx-i2c.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/marvell,mv64xxx-i2c.yaml b/Documentation/devicetree/bindings/i2c/marvell,mv64xxx-i2c.yaml
index 001f2b7abad0..c779000515d6 100644
--- a/Documentation/devicetree/bindings/i2c/marvell,mv64xxx-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/marvell,mv64xxx-i2c.yaml
@@ -26,6 +26,9 @@ properties:
       - items:
           - const: allwinner,sun50i-a64-i2c
           - const: allwinner,sun6i-a31-i2c
+      - items:
+          - const: allwinner,sun50i-h6-i2c
+          - const: allwinner,sun6i-a31-i2c
 
       - const: marvell,mv64xxx-i2c
       - const: marvell,mv78230-i2c
-- 
2.17.1

