Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DE8C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 17:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10EBD20859
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 17:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="O1YSYu+F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfFDRWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 13:22:12 -0400
Received: from mail.z3ntu.xyz ([128.199.32.197]:49660 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfFDRWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 13:22:12 -0400
Received: from localhost.localdomain (80-110-121-20.cgn.dynamic.surfer.at [80.110.121.20])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 4C04BC62EF;
        Tue,  4 Jun 2019 17:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1559668929; bh=cSocZErgHFfym8KO8Z5rspnCN1hcPRcdht1ciFTlVhE=;
        h=From:To:Cc:Subject:Date;
        b=O1YSYu+F5veWrPj/0ckhF8FFjnzZdHt2Izv9JJOKnYa8IUkEpfT3nlpp94xD8O3zv
         IDoK0r4PDmCrwazCNfg40Z0G4L98LSaqpDJUvr9dM3qLZw0X1y4Az+5QUZP0HJ61sL
         WhTpWOANLHN4Et6lbYu3NNdmhVNZA2NMGLlm0lxI=
From:   Luca Weiss <luca@z3ntu.xyz>
Cc:     Luca Weiss <luca@z3ntu.xyz>, Hans de Goede <hdegoede@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-input@vger.kernel.org (open list:SUN4I LOW RES ADC ATTACHED
        TABLET KEYS DRIVER),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support), linux-kernel@vger.kernel.org (open list),
        ~martijnbraam/pmos-upstream@lists.sr.ht
Subject: [PATCH v2 1/2] dt-bindings: input: sun4i-lradc-keys: Add A64 compatible
Date:   Tue,  4 Jun 2019 19:21:53 +0200
Message-Id: <20190604172154.25472-1-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the A64 compatible with a fallback to the A83T compatible.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Changes from v1:
 - New patch. Document new compatible string.

 Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt b/Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt
index 496125c6bfb7..507b737612ea 100644
--- a/Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt
+++ b/Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt
@@ -5,6 +5,7 @@ Required properties:
  - compatible: should be one of the following string:
 		"allwinner,sun4i-a10-lradc-keys"
 		"allwinner,sun8i-a83t-r-lradc"
+		"allwinner,sun50i-a64-lradc", "allwinner,sun8i-a83t-r-lradc"
  - reg: mmio address range of the chip
  - interrupts: interrupt to which the chip is connected
  - vref-supply: powersupply for the lradc reference voltage
-- 
2.21.0

