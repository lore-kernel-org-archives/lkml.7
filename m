Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2ACC43141
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 11:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1E9B2075E
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 11:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="hcsmH2AL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfKXLkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 06:40:43 -0500
Received: from mo4-p03-ob.smtp.rzone.de ([81.169.146.173]:28116 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfKXLkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 06:40:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574595640;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=V/olKegmrCAC7GOTukiQ4j+2l5AjTWcogVSnbAhVyfw=;
        b=hcsmH2ALZENPsfzyXnedzKrxjZGH8wjipIbzdf5MDJY+Jimi7rQI0vTfPz2GSI5rmb
        WI+/Bn9U3WejBrwT3p5s392EQgilExa05jkDyZIX6M26DGfEzCafN1Wui5oTnNUNuMQG
        XtGbWuQ1YY/4xE6yoRlewCq9MfyJUFQzmAbNbZqR9HO7VlkFN7PDuUHULvxgjEiiBauB
        8O2C9thgyy9q50Tkiq1578UE9tu/v1iorKKpRiQ9AE4ytjx+5SraV2wtTdWsrqNvPLJ/
        /QEZ08yYCsKWkRGJX6V0jvmCjbzBAk7yq3FO9P1TclRUEb4mdl4KdXWnHTOJmc/obiFa
        FFSQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1mfYzBGHXH4HEaKeuIV"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.29.0 DYNA|AUTH)
        with ESMTPSA id L09db3vAOBeVwEW
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sun, 24 Nov 2019 12:40:31 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        James Hogan <jhogan@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        openpvrsgx-devgroup@letux.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com, linux-mips@vger.kernel.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v3 5/8] ARM: DTS: omap36xx: add sgx gpu child node
Date:   Sun, 24 Nov 2019 12:40:25 +0100
Message-Id: <8469ff540cd03ab5d94d26a28ba2ef51617242ef.1574595627.git.hns@goldelico.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1574595627.git.hns@goldelico.com>
References: <cover.1574595627.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

and add interrupt.

Tested-by: H. Nikolaus Schaller <hns@goldelico.com> # GTA04, BeagleBoard XM
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap36xx.dtsi | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36xx.dtsi
index 1e552f08f120..851d4abb943b 100644
--- a/arch/arm/boot/dts/omap36xx.dtsi
+++ b/arch/arm/boot/dts/omap36xx.dtsi
@@ -145,7 +145,7 @@
 		 * "ti,sysc-omap4" type register with just sidle and midle bits
 		 * available while omap34xx has "ti,sysc-omap2" type sysconfig.
 		 */
-		sgx_module: target-module@50000000 {
+		target-module@50000000 {
 			compatible = "ti,sysc-omap4", "ti,sysc";
 			reg = <0x5000fe00 0x4>,
 			      <0x5000fe10 0x4>;
@@ -162,10 +162,11 @@
 			#size-cells = <1>;
 			ranges = <0 0x50000000 0x2000000>;
 
-			/*
-			 * Closed source PowerVR driver, no child device
-			 * binding or driver in mainline
-			 */
+			sgx: gpu@0 {
+				compatible = "ti,omap3-sgx530-125", "img,sgx530-125", "img,sgx530";
+				reg = <0x0 0x10000>;	/* 64kB */
+				interrupts = <21>;
+			};
 		};
 	};
 
-- 
2.23.0

