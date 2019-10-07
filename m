Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B53C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9368F21D7A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="bVMn4hxE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbfJGOeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 10:34:22 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:38291 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726334AbfJGOeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 10:34:21 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x97EVf8O022005;
        Mon, 7 Oct 2019 16:34:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=Zh2dMsrr5p5iHfSIvb+HPhylnIwxzh9ThANxonYp9Ew=;
 b=bVMn4hxERWmfUuOCQk9yZOGkCTZKyyVT1Cbmkdih64yxAa1+Z163zBdSQyMwZywQ4VHU
 4ddvXeMOSZ70t3DDw/Jjkydae+DBlZH6gTZ84I7LKtvMva7muRIHOj0XcsKUUok+3CCB
 LCBb/jgGr2w4SeTiqX4PRbzBLEq7L8Jzg1XO2N7U8aPXaSR1zY834mXMoeQZ3ra07E6W
 Nmma2rMtJCvTqCEmGkFe5tm7W3Cp7yDMbiaCg1Cui/6ZvAzytzeT3NDTm4lz5w+QcjXv
 xEJthJDl5FyWAaMWwpWsX4fjCZebcGRUh7+SsgDvBwxJ4sQ1NTmgz+Sa1ScQi5wjlbNU bw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2vegxvjtj7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Oct 2019 16:34:07 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id ECB4E10002A;
        Mon,  7 Oct 2019 16:34:06 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E03B92AC883;
        Mon,  7 Oct 2019 16:34:06 +0200 (CEST)
Received: from localhost (10.75.127.47) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 7 Oct 2019 16:34:06
 +0200
From:   Alexandre Torgue <alexandre.torgue@st.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>, <arnd@arndb.de>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/4] ARM: dts: stm32: remove usb phy-names entries on stm32mp157c-ev1
Date:   Mon, 7 Oct 2019 16:34:01 +0200
Message-ID: <20191007143402.13266-4-alexandre.torgue@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191007143402.13266-1-alexandre.torgue@st.com>
References: <20191007143402.13266-1-alexandre.torgue@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-07_02:2019-10-07,2019-10-07 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"phy-names" entries are not used. To be compliant with DT validation
tool, those entries have to be remove.

Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>

diff --git a/arch/arm/boot/dts/stm32mp157c-ev1.dts b/arch/arm/boot/dts/stm32mp157c-ev1.dts
index 6287db532e7d..2baae5f25e2c 100644
--- a/arch/arm/boot/dts/stm32mp157c-ev1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ev1.dts
@@ -343,14 +343,12 @@
 
 &usbh_ehci {
 	phys = <&usbphyc_port0>;
-	phy-names = "usb";
 	status = "okay";
 };
 
 &usbotg_hs {
 	dr_mode = "peripheral";
 	phys = <&usbphyc_port1 0>;
-	phy-names = "usb2-phy";
 	status = "okay";
 };
 
-- 
2.17.1

