Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAD1C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D1A221D7D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Lmf4l/51"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfLSKgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 05:36:11 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:21162 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726891AbfLSKgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 05:36:08 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBJAWcHA023188;
        Thu, 19 Dec 2019 11:35:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=vChJ5etL9fvswVVKX5yEE7E0ExcPkC92Uak/3fYaeRY=;
 b=Lmf4l/51V/pXGjoOU2FOehmY7DTc2Bo1Fmto/fk10QI61Sdzl6EosapWEnJdL+kqR1l3
 bW+JkB+v0n4sBQOVH/tRC1VaQRyeuvMPBnIWoFW0sgricJt6Gtp7KNt643Ld475r7h7w
 uvteyurzvNVL3cr0Cx0eyA+2uRe2F9Ra6ds5OAQc2AO7XcgCCgJ7p8wSz01L5T05/3uK
 RLxgWL8k4OWziKro6wd4va7j8bm/2FfCUQ90Ywxu4M3WMnl1j6jEnCnC8NIQXcuEsecs
 TW9h7jVD7FeAWTmstp/lWrMPB06rBQr3h3IbHywZa+nET0dBJxSp7sPdP4HfScCXgtks mw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2wvpd1s21d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Dec 2019 11:35:50 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 56DC4100049;
        Thu, 19 Dec 2019 11:35:43 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AD90D2B6A19;
        Thu, 19 Dec 2019 11:35:42 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 19 Dec 2019 11:35:42
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <kgene@kernel.org>, <krzk@kernel.org>,
        <hminas@synopsys.com>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <m.szyprowski@samsung.com>,
        <amelie.delaunay@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v2 2/2] ARM: dts: exynos: Remove unneeded "snps,dwc2" from hsotg node
Date:   Thu, 19 Dec 2019 11:35:36 +0100
Message-ID: <20191219103536.25485-3-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20191219103536.25485-1-benjamin.gaignard@st.com>
References: <20191219103536.25485-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-19_01:2019-12-17,2019-12-19 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove "snps,dwc2" from hsotg@12480000 node compatible list because
"samsung,s3c6400-hsotg" should be enough.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 arch/arm/boot/dts/exynos3250.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index b016b0b68306..d4866269f4ee 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -362,7 +362,7 @@
 		};
 
 		hsotg: hsotg@12480000 {
-			compatible = "samsung,s3c6400-hsotg", "snps,dwc2";
+			compatible = "samsung,s3c6400-hsotg";
 			reg = <0x12480000 0x20000>;
 			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_USBOTG>;
-- 
2.15.0

