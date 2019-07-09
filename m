Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D19C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 07:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6E9621743
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 07:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=temperror (0-bit key) header.d=phytec.de header.i=@phytec.de header.b="VLEeK/E5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfGIHep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 03:34:45 -0400
Received: from mickerik.phytec.de ([195.145.39.210]:61850 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfGIHeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 03:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a1; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1562656768; x=1565248768;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gHD7ubzNG2RKZFBDvA+A4Pf1yRHu2u+2z8XxFtTJI1M=;
        b=VLEeK/E5E3T/sjGXL8NsyAyoQq+t76dKKlbz8NwZcVzBchBu/aeugtdWl7JSMY8V
        +V8D4g0RCLM3alDMZ5vd6/m6hlO+iSnl7CRFCeseVZGKjA6qK5riLHS8XUH0BwHZ
        jBGwa2BgSgHIdtG1z+LQLi3FDd2eSetvFhQvBadG/Q4=;
X-AuditID: c39127d2-193ff70000001aee-02-5d2440001c90
Received: from idefix.phytec.de (idefix.phytec.de [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 59.B0.06894.000442D5; Tue,  9 Jul 2019 09:19:28 +0200 (CEST)
Received: from augenblix2.phytec.de ([172.16.21.122])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2019070909192802-309706 ;
          Tue, 9 Jul 2019 09:19:28 +0200 
From:   Stefan Riedmueller <s.riedmueller@phytec.de>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, martyn.welch@collabora.com,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com
Subject: [PATCH 03/10] ARM: dts: imx6ul: segin: Reduce eth drive strength
Date:   Tue, 9 Jul 2019 09:19:20 +0200
Message-Id: <1562656767-273566-4-git-send-email-s.riedmueller@phytec.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562656767-273566-1-git-send-email-s.riedmueller@phytec.de>
References: <1562656767-273566-1-git-send-email-s.riedmueller@phytec.de>
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 09.07.2019 09:19:28,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 09.07.2019 09:19:28,
        Serialize complete at 09.07.2019 09:19:28
X-TNEFEvaluated: 1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPLMWRmVeSWpSXmKPExsWyRoCBS5fBQSXWoHOPhMX8I+dYLR5e9bdY
        NXUni8Wmx9dYLbp+rWS2uLxrDpvF0usXmSweXOxisWjde4Td4u/2TSwWL7aIO3B7rJm3htFj
        x90ljB47Z91l99i0qpPNY/OSeo+N73YwefT/NfD4vEkugCOKyyYlNSezLLVI3y6BK2Nl2zy2
        gjvCFec7PjE1MHYKdjFyckgImEhc/72KqYuRi0NIYAejxM8VXxhBEkICFxgldvYWg9hsAkYS
        C6Y1MoHYIgKREu+2/2YHaWAW2MMoMe36dbAGYQFPictbprGC2CwCKhJbP71jBrF5BTwknvW8
        ZofYJidx81wnWJwTqP7oxV/MEMs8JC4vmMYCMlRCoJFJYvGj04wQDUISpxefZZ7AyLeAkWEV
        o1BuZnJ2alFmtl5BRmVJarJeSuomRmCgHp6ofmkHY98cj0OMTByMhxglOJiVRHj3uSvHCvGm
        JFZWpRblxxeV5qQWH2KU5mBREufdwFsSJiSQnliSmp2aWpBaBJNl4uCUamC0WlGhnFw3X0lZ
        54zTRcXvKxomGU932ay7bPX+rnn2v1Nn75lp2r/lPXfaoi07lXWuC/w/eGDOnzNZqd9WpnUc
        Panm4S+u9J+vSlGOi/0Fo6GYqMnhnX67WqO5Ox+ah4c2C7od2ZA17+KzM0VbnNQqDIwfiG0N
        iDgy8UjUG82guO0z55vUPdusxFKckWioxVxUnAgA5DZ+2kICAAA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce the drive strength for the MDC, MDIO and TX pins of FEC1 and FEC2
on the phyBOARD-Segin to improve signal quality and EMC. Also disable
internal pull-ups on the MDC and MDIO pins.

Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>
---
 arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi | 12 ++++++------
 arch/arm/boot/dts/imx6ul-phytec-segin.dtsi       |  8 ++++----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi b/arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi
index bff13d0eb064..1b745582911c 100644
--- a/arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi
+++ b/arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi
@@ -93,16 +93,16 @@
 &iomuxc {
 	pinctrl_enet1: enet1grp {
 		fsl,pins = <
-			MX6UL_PAD_GPIO1_IO07__ENET1_MDC		0x1b0b0
-			MX6UL_PAD_GPIO1_IO06__ENET1_MDIO	0x1b0b0
+			MX6UL_PAD_GPIO1_IO07__ENET1_MDC		0x10010
+			MX6UL_PAD_GPIO1_IO06__ENET1_MDIO	0x10010
 			MX6UL_PAD_ENET1_RX_EN__ENET1_RX_EN	0x1b0b0
 			MX6UL_PAD_ENET1_RX_ER__ENET1_RX_ER	0x1b0b0
 			MX6UL_PAD_ENET1_RX_DATA0__ENET1_RDATA00	0x1b0b0
 			MX6UL_PAD_ENET1_RX_DATA1__ENET1_RDATA01	0x1b0b0
-			MX6UL_PAD_ENET1_TX_EN__ENET1_TX_EN	0x1b0b0
-			MX6UL_PAD_ENET1_TX_DATA0__ENET1_TDATA00	0x1b0b0
-			MX6UL_PAD_ENET1_TX_DATA1__ENET1_TDATA01	0x1b0b0
-			MX6UL_PAD_ENET1_TX_CLK__ENET1_REF_CLK1	0x4001b031
+			MX6UL_PAD_ENET1_TX_EN__ENET1_TX_EN	0x1b010
+			MX6UL_PAD_ENET1_TX_DATA0__ENET1_TDATA00	0x1b010
+			MX6UL_PAD_ENET1_TX_DATA1__ENET1_TDATA01	0x1b010
+			MX6UL_PAD_ENET1_TX_CLK__ENET1_REF_CLK1	0x4001b010
 			MX6UL_PAD_GPIO1_IO02__GPIO1_IO02	0x17059
 		>;
 	};
diff --git a/arch/arm/boot/dts/imx6ul-phytec-segin.dtsi b/arch/arm/boot/dts/imx6ul-phytec-segin.dtsi
index 78425c3290a1..28ba3a4c4c74 100644
--- a/arch/arm/boot/dts/imx6ul-phytec-segin.dtsi
+++ b/arch/arm/boot/dts/imx6ul-phytec-segin.dtsi
@@ -230,10 +230,10 @@
 			MX6UL_PAD_ENET2_RX_ER__ENET2_RX_ER	0x1b0b0
 			MX6UL_PAD_ENET2_RX_DATA0__ENET2_RDATA00	0x1b0b0
 			MX6UL_PAD_ENET2_RX_DATA1__ENET2_RDATA01	0x1b0b0
-			MX6UL_PAD_ENET2_TX_EN__ENET2_TX_EN	0x1b0b0
-			MX6UL_PAD_ENET2_TX_DATA0__ENET2_TDATA00	0x1b0b0
-			MX6UL_PAD_ENET2_TX_DATA1__ENET2_TDATA01	0x1b0b0
-			MX6UL_PAD_ENET2_TX_CLK__ENET2_REF_CLK2	0x4001b031
+			MX6UL_PAD_ENET2_TX_EN__ENET2_TX_EN	0x1b010
+			MX6UL_PAD_ENET2_TX_DATA0__ENET2_TDATA00	0x1b010
+			MX6UL_PAD_ENET2_TX_DATA1__ENET2_TDATA01	0x1b010
+			MX6UL_PAD_ENET2_TX_CLK__ENET2_REF_CLK2	0x4001b010
 		>;
 	};
 
-- 
2.7.4

