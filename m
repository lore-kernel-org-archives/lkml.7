Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823F0C43215
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 14:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C052084F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 14:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Xo8s9up8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfLBO4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 09:56:25 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:27556 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727431AbfLBO4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 09:56:23 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB2EqgfL006872;
        Mon, 2 Dec 2019 15:56:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=gI924+1fX/eN9VvvjEAM5fscU0gZdxA9JU52y8s8fgE=;
 b=Xo8s9up8sEF7wBPbyVen2UUCYA+puQb0tyNztxpRQnv4PwgJeM7F4itfjyXHW7QbSHOr
 DcrGbKlpdWHyr1awMPTPc5QeF3gTpQQsCiuqwt0sk8eNBwtjtUplrnzcYiIbVPrUf1gC
 aP5+ZgnjDuw1Xr458A1ebvr0mZJOPU8Zf3xBM4YFz1VjZ+gLj1pwIlXPcLR/g2ZnRgNs
 TIj6vwBygsAeElyQPBlgFFLf62nvaSb8ABGkZ1fdQJDMLJq6gjqYmKZkEoEIxX1VeCT2
 7Y/QGRFo/O2HSFVMGH7rgOE3uYBi8gmHmMRStWOMYA7RgdvBUy0Zr3G0jAorjIK26zPO SA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2wkee9they-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Dec 2019 15:56:11 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F0D28100034;
        Mon,  2 Dec 2019 15:56:10 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E253E2B1897;
        Mon,  2 Dec 2019 15:56:10 +0100 (CET)
Received: from localhost (10.75.127.48) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 2 Dec 2019 15:56:10
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <alexandre.torgue@st.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 2/3] ARM: dts: stm32: remove useless clock-names from RTC node on stm32f746
Date:   Mon, 2 Dec 2019 15:56:04 +0100
Message-ID: <20191202145604.28872-2-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20191202145604.28872-1-benjamin.gaignard@st.com>
References: <20191202145604.28872-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG4NODE3.st.com (10.75.127.12) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-02_02:2019-11-29,2019-12-02 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On stm32f7 family RTC node doesn't need clock-names property.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 arch/arm/boot/dts/stm32f746.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
index d26f93f8b9c2..3a8e2dc1978c 100644
--- a/arch/arm/boot/dts/stm32f746.dtsi
+++ b/arch/arm/boot/dts/stm32f746.dtsi
@@ -300,7 +300,6 @@
 			compatible = "st,stm32-rtc";
 			reg = <0x40002800 0x400>;
 			clocks = <&rcc 1 CLK_RTC>;
-			clock-names = "ck_rtc";
 			assigned-clocks = <&rcc 1 CLK_RTC>;
 			assigned-clock-parents = <&rcc 1 CLK_LSE>;
 			interrupt-parent = <&exti>;
-- 
2.15.0

