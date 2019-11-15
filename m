Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629ACC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 316BA2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="RlX/2J9v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbfKOKHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 05:07:08 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:43115 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727202AbfKOKHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 05:07:08 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAFA35GI000658;
        Fri, 15 Nov 2019 11:06:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=OxkWESTDCuWJPuN/T1e/uwJDxCVtuMpIBWb6nhwzVuw=;
 b=RlX/2J9v8jnIWum7rEMg4s/TKA34ehxKUiQWb9aa4nIJkAKr0OR1pure9q6QL9K7iaAS
 VRrEo7CO980V6KMPvUOVZsJba96wOT2zRGXLeXlye2vkBzf+NfIa0sxHcuoazmW/GqU7
 R10P9iCBIa7keb7R0OLNmTxFzTJVTYdsO6m1ujmUc5gAhYaIIiMHfFKKq+3WmkhiRS0X
 hGtKqrvn47NiBgCCakALrISQc5PmxSiCA3Co0MGLItOipvAs7Eu0HghUfzFvYd2Q9Wnb
 KVzW8KD7JaZFKVMXqa02oUm5IXQ3O8+vxFA6vc2bmQ2LArDUoRdsg4MQ4/2b7VDuMWE5 IQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2w7psbkasr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Nov 2019 11:06:55 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A3D5910003D;
        Fri, 15 Nov 2019 11:06:54 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 70FE02B189B;
        Fri, 15 Nov 2019 11:06:54 +0100 (CET)
Received: from localhost (10.75.127.49) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 15 Nov 2019 11:06:54
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <alexandre.torgue@st.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <lionel.debieve@st.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH] ARM: dts: stm32: remove unused rng interrupt
Date:   Fri, 15 Nov 2019 11:06:51 +0100
Message-ID: <20191115100651.17754-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG5NODE2.st.com (10.75.127.14) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-15_02:2019-11-15,2019-11-15 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Interrupt has never be used in rng driver so remove it from DT.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 arch/arm/boot/dts/stm32f429.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index 5c8a826b3195..196817da0c1d 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -789,7 +789,6 @@
 		rng: rng@50060800 {
 			compatible = "st,stm32-rng";
 			reg = <0x50060800 0x400>;
-			interrupts = <80>;
 			clocks = <&rcc 0 STM32F4_AHB2_CLOCK(RNG)>;
 
 		};
-- 
2.15.0

