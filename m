Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49417C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 23:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34E72146E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 23:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="2xf5JX+K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbfIZX23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 19:28:29 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:46921 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728849AbfIZX22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 19:28:28 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id F201E891AA;
        Fri, 27 Sep 2019 11:28:26 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1569540506;
        bh=4ZTWevuQnd7Huoj4HJWGkNONefcT65iGcIwvwGxT6J0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=2xf5JX+KItvUrgLEZanjB/QkhF3PI97gop1qwmbDEMCacg4VdFbzzk87lJwvzfP6l
         ZLiZx1lp6PFuQc0omHj9pFcemICnpEY5D53/CAfkijBtIrQ999PDnw+aAZOKnAGKKb
         z7RemHNABn/2pGq+0biHVYA2gPYQQSznz2tMcQH+0pL066nHlT6+QWKX3OnNWXwcpc
         CMr9ougKK1KbbDo5Z2iTmf5MqUJo+Yw7+je4KPZg5xCoV9A3eWKCXgDx/wKOgsceei
         3oqR3WpnQ0XCGd8myw91A6YyvyJ55WSJFe8D1sLUlBJlBw8ursqrAeqm3LQIgUV30H
         xs/HxdSUzYccA==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5d8d49980003>; Fri, 27 Sep 2019 11:28:26 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 777DC13EF9B;
        Fri, 27 Sep 2019 11:28:28 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id C03DA28003E; Fri, 27 Sep 2019 11:28:24 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     jason@lakedaemon.net, andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 3/3] ARM: dts: armada-xp: add label to sdram-controller node
Date:   Fri, 27 Sep 2019 11:28:20 +1200
Message-Id: <20190926232820.27676-4-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190926232820.27676-1-chris.packham@alliedtelesis.co.nz>
References: <20190926232820.27676-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the label "sdramc" to the sdram-controller nodes for the Armada-XP
and 98dx3236 SoCs.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 arch/arm/boot/dts/armada-xp-98dx3236.dtsi | 2 +-
 arch/arm/boot/dts/armada-xp.dtsi          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi b/arch/arm/boot/dt=
s/armada-xp-98dx3236.dtsi
index 267d0c178e55..654648b05c7c 100644
--- a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
+++ b/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
@@ -90,7 +90,7 @@
 		};
=20
 		internal-regs {
-			sdramc@1400 {
+			sdramc: sdramc@1400 {
 				compatible =3D "marvell,armada-xp-sdram-controller";
 				reg =3D <0x1400 0x500>;
 			};
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-=
xp.dtsi
index ee15c77d3689..6c19984d668e 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -36,7 +36,7 @@
 		};
=20
 		internal-regs {
-			sdramc@1400 {
+			sdramc: sdramc@1400 {
 				compatible =3D "marvell,armada-xp-sdram-controller";
 				reg =3D <0x1400 0x500>;
 			};
--=20
2.23.0

