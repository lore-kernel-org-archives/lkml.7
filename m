Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997ACC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 08:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 721842087E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 08:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387522AbfCAIsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 03:48:53 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:21729 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726957AbfCAIsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 03:48:17 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x218lESg021269;
        Fri, 1 Mar 2019 09:48:08 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qtv6dajg6-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 01 Mar 2019 09:48:08 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8B41F38;
        Fri,  1 Mar 2019 08:48:07 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 43BBB2B18;
        Fri,  1 Mar 2019 08:48:07 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 1 Mar 2019
 09:48:07 +0100
Received: from lmecxl0923.lme.st.com (10.48.0.237) by webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 1 Mar 2019
 09:48:06 +0100
From:   Ludovic Barre <ludovic.Barre@st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH  7/7] ARM: dts: stm32: add sdmmc1 support on stm32mp157a dk1 board
Date:   Fri, 1 Mar 2019 09:47:48 +0100
Message-ID: <1551430068-9456-8-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551430068-9456-1-git-send-email-ludovic.Barre@st.com>
References: <1551430068-9456-1-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-01_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds sdmmc1 support on stm32mp157a dk1 board.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 arch/arm/boot/dts/stm32mp157a-dk1.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157a-dk1.dts b/arch/arm/boot/dts/stm32mp157a-dk1.dts
index 873a80e..e774a34 100644
--- a/arch/arm/boot/dts/stm32mp157a-dk1.dts
+++ b/arch/arm/boot/dts/stm32mp157a-dk1.dts
@@ -36,6 +36,14 @@
 			default-state = "off";
 		};
 	};
+
+	v3v3: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "v3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
 };
 
 &ethernet0 {
@@ -70,6 +78,18 @@
 	status = "okay";
 };
 
+&sdmmc1 {
+	pinctrl-names = "default", "opendrain", "sleep";
+	pinctrl-0 = <&sdmmc1_b4_pins_a>;
+	pinctrl-1 = <&sdmmc1_b4_od_pins_a>;
+	pinctrl-2 = <&sdmmc1_b4_sleep_pins_a>;
+	broken-cd;
+	st,neg-edge;
+	bus-width = <4>;
+	vmmc-supply = <&v3v3>;
+	status = "okay";
+};
+
 &uart4 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart4_pins_a>;
-- 
2.7.4

