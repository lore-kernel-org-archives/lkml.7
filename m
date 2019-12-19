Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC30C2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 14:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B26024676
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 14:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="pivPKPDA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfLSOlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 09:41:44 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:26602 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726701AbfLSOln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 09:41:43 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBJEaUs2014020;
        Thu, 19 Dec 2019 15:41:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=4w2ShoR7xwVF0wnOQZIXhRopSNfU1RmvtACz1IZSq24=;
 b=pivPKPDAsmSlxywUl2qBLLWzbiUw8lh/4aWPzNYh0h+XpFJ/gTs1/t7G+UvSFCVlLe6Z
 g19MJMhmGqPE36afaXAyE6sfAy7HKU8uMG2tPPBSKoF8iVIsoVzluCfPRGSNN6vIRYr3
 ToTp23Ql8+Ehgi/vpaVf4h1T55ibG1aJ606oDrh3Nt3e4whoNd6fX8i+hGPzCIkVNoCb
 jxV4bF35F8WRZHxZgp47NtsDKlO1BtntAN98Ei36eadIpz1p6b53cb4nz4iUbh8r+I7S
 NvRAcOcNz7839roTATzmN/RlFsKnrt5yOgCkCmWkiNd0CdI+M/f7ac61LeHDilng6l8s 0g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2wvp37a8h6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Dec 2019 15:41:29 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1C85D100042;
        Thu, 19 Dec 2019 15:41:21 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 022D62C6B65;
        Thu, 19 Dec 2019 15:41:21 +0100 (CET)
Received: from localhost (10.75.127.49) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 19 Dec 2019 15:41:20
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <fabrice.gasnier@st.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 3/3] ARM: dts: stm32: change nvmem node name on stm32mp1
Date:   Thu, 19 Dec 2019 15:41:17 +0100
Message-ID: <20191219144117.21527-4-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20191219144117.21527-1-benjamin.gaignard@st.com>
References: <20191219144117.21527-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-19_01:2019-12-17,2019-12-19 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change non volatile node name from nvmem to efuse to be compliant
with yaml schema.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 arch/arm/boot/dts/stm32mp151.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
index 3dd570b10181..c157d122b0f0 100644
--- a/arch/arm/boot/dts/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/stm32mp151.dtsi
@@ -1485,7 +1485,7 @@
 			status = "disabled";
 		};
 
-		bsec: nvmem@5c005000 {
+		bsec: efuse@5c005000 {
 			compatible = "st,stm32mp15-bsec";
 			reg = <0x5c005000 0x400>;
 			#address-cells = <1>;
-- 
2.15.0

