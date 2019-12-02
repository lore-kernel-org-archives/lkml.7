Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83D0C43215
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 14:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DBE720833
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 14:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="P2B78HtG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfLBO4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 09:56:23 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:51380 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727362AbfLBO4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 09:56:23 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB2EqXHC018717;
        Mon, 2 Dec 2019 15:56:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=sSH4hYZyJ+fBuXPL7aX02qrszJdNB5CLd0reHrC4urg=;
 b=P2B78HtGWevh/e/1NZPL45ZzeOwIKlzmMdv06ho3x/wLHZXyX09QFV82aNPLFWXDH5O2
 9bu3CwHSDJPwfvB6zEd4P+7aA62gD9hCUExPyp4R8rsgreBbitV+n3e//SlQXhCNo7gi
 vpqDAXayotOQr4TBNAS8UvoKfmoqWQJKg92XykaC+Grx9v2DTjbTkAY4kBQJdAQrx3eP
 mXWzjz+16yLI3wyGGi9ujoF8ojuYPHJ5G+I+hYbGc6LFMHq2Kkg4o1B9uF+4m9q4BBzw
 76+MsEcFnajFOUa/0ISDeRJ6Si7oDbnTXsTeGp4bn2Z6EkLpNOSxonrSlaKhE+2sAy/G xg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2wkg6ka6fe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Dec 2019 15:56:10 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 566F910002A;
        Mon,  2 Dec 2019 15:56:10 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 42C582B1897;
        Mon,  2 Dec 2019 15:56:10 +0100 (CET)
Received: from localhost (10.75.127.49) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 2 Dec 2019 15:56:09
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <alexandre.torgue@st.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 1/3] ARM: dts: stm32: remove useless clock-names from RTC node on stm32f429
Date:   Mon, 2 Dec 2019 15:56:03 +0100
Message-ID: <20191202145604.28872-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG5NODE2.st.com (10.75.127.14) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-02_02:2019-11-29,2019-12-02 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On stm32f4 family RTC node doesn't need clock-names property.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 arch/arm/boot/dts/stm32f429.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index 5c8a826b3195..ac9caaf4cf51 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -318,7 +318,6 @@
 			compatible = "st,stm32-rtc";
 			reg = <0x40002800 0x400>;
 			clocks = <&rcc 1 CLK_RTC>;
-			clock-names = "ck_rtc";
 			assigned-clocks = <&rcc 1 CLK_RTC>;
 			assigned-clock-parents = <&rcc 1 CLK_LSE>;
 			interrupt-parent = <&exti>;
-- 
2.15.0

