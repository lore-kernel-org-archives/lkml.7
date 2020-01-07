Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5B1C33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 12:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B29207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 12:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="ZaBhwiwA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgAGMjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 07:39:04 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:6398 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727834AbgAGMi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 07:38:56 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 007CbXhP018532;
        Tue, 7 Jan 2020 13:38:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=LrRlBaLDFuffLqD4z5yxGzk/G0cLADgnwc3XsTVfoCs=;
 b=ZaBhwiwAYjyhKoeGI1D5iaFSenhCJ//B7at1Dr1vWILK/nKLgw55tevPMqmFFDWyHsIm
 ILyUukFobhhD3lOOu6ziqtJnMtEDSV9dS3V+3CO+DJOomdOyarqc4jqWpO7cFxi1zaNr
 PdhXOPLxfxc69hsziqcdzAyi+Dt7Jn2nH/2l6RjFyIkULo00qUWCWq3LwadiL23Gg2rW
 ZqS9p3Rl3Byv2Q77XyMWaamgZq7koAlg9JJhs6AqZ0UT3rARH2DVG1iGhQTT00lbLA5M
 stIzk0fl9K8ouEx/5CwEC3FkDVEEdP7zTMFpZqc95Hn1ZH0jHgO5TzIiA5NiV2qzL6zs 1w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xakuqp4c3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jan 2020 13:38:35 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B91ED10003A;
        Tue,  7 Jan 2020 13:38:32 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node3.st.com [10.75.127.18])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AEA2A2AFAB3;
        Tue,  7 Jan 2020 13:38:32 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG6NODE3.st.com (10.75.127.18)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 Jan 2020 13:38:32
 +0100
From:   <patrice.chotard@st.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <patrice.chotard@st.com>
Subject: [PATCH 2/2] ARM: dts: stih410-b2260: Remove deprecated snps PHY properties
Date:   Tue, 7 Jan 2020 13:38:28 +0100
Message-ID: <20200107123828.6586-3-patrice.chotard@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200107123828.6586-1-patrice.chotard@st.com>
References: <20200107123828.6586-1-patrice.chotard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-07_03:2020-01-06,2020-01-07 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

Remove "snps,phy-bus-name", "snps,phy-bus-id" and "snps,phy-addr"
properties.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/boot/dts/stih410-b2260.dts | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/stih410-b2260.dts b/arch/arm/boot/dts/stih410-b2260.dts
index 1df2c37eb3a7..3dd7f4b18856 100644
--- a/arch/arm/boot/dts/stih410-b2260.dts
+++ b/arch/arm/boot/dts/stih410-b2260.dts
@@ -179,9 +179,6 @@
 			phy-handle = <&phy0>;
 			pinctrl-0 = <&pinctrl_rgmii1 &pinctrl_rgmii1_mdio_1>;
 
-			snps,phy-bus-name = "stmmac";
-			snps,phy-bus-id = <0>;
-			snps,phy-addr = <0>;
 			snps,reset-gpio = <&pio0 7 0>;
 			snps,reset-active-low;
 			snps,reset-delays-us = <0 10000 1000000>;
-- 
2.17.1

