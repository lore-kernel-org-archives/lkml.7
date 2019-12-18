Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6C7C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB1824689
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="pTC9JZ6C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfLROtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:49:09 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:46675 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727135AbfLROtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:49:02 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBIEmKDJ016029;
        Wed, 18 Dec 2019 15:48:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=sYclvs3hTaLkH1aPSdNgdAO6bhgIGop8dGr694cnD4I=;
 b=pTC9JZ6Cyw+S37W3ygLPbq+RoMpDWmjqDCHeHelBPnPd3aTIMFoiGyZk6Z6+yjJiKF35
 F+aa5sUao/YmRhzWaCeeWqgAWKVQr/3BrguNkBx3vYzXjEwNaL8xslxTXPCCBVBlZzn5
 QIkTQvmXMKSXFNp10Gge/jZ1PWksN50dAWqQqaqVLDHxOzclr7iFi3Kc6Weg8McLe1mn
 aLMGNz0KJf3J/7SyHBoBgM5xb0767/JuJuoM9xLcT1pBK6ITs6wMCd87OHdvpwzqKWQv
 O0BUN5fvYJg7U2XW+aJyYFF6lGGAX8VDxlMFsj2cOvmxPogA6y6unkozrUWf2Cwj2QX8 dw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2wvpd1mv2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Dec 2019 15:48:52 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3EF70100039;
        Wed, 18 Dec 2019 15:48:48 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 33E11207547;
        Wed, 18 Dec 2019 15:48:48 +0100 (CET)
Received: from localhost (10.75.127.48) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 18 Dec 2019 15:48:47
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v2 3/3] ARM: dts: stm32: fix dma controller node name on stm32mp157c
Date:   Wed, 18 Dec 2019 15:48:44 +0100
Message-ID: <20191218144844.7481-4-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20191218144844.7481-1-benjamin.gaignard@st.com>
References: <20191218144844.7481-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-18_04:2019-12-17,2019-12-18 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify dma controller nodes name to fit with the standard naming.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
version 2:
- rebased on top of stm32-next after DT diversity patches
  
 arch/arm/boot/dts/stm32mp151.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
index b0f3fa564967..3dd570b10181 100644
--- a/arch/arm/boot/dts/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/stm32mp151.dtsi
@@ -947,7 +947,7 @@
 			};
 		};
 
-		dma1: dma@48000000 {
+		dma1: dma-controller@48000000 {
 			compatible = "st,stm32-dma";
 			reg = <0x48000000 0x400>;
 			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
@@ -964,7 +964,7 @@
 			dma-requests = <8>;
 		};
 
-		dma2: dma@48001000 {
+		dma2: dma-controller@48001000 {
 			compatible = "st,stm32-dma";
 			reg = <0x48001000 0x400>;
 			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
@@ -1275,7 +1275,7 @@
 			status = "disabled";
 		};
 
-		mdma1: dma@58000000 {
+		mdma1: dma-controller@58000000 {
 			compatible = "st,stm32h7-mdma";
 			reg = <0x58000000 0x1000>;
 			interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.15.0

