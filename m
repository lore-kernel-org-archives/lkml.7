Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590C6C33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 12:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EF13207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 12:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="K6aijNLS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgAGMi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 07:38:57 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:56162 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727996AbgAGMiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 07:38:55 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 007CXWXU009241;
        Tue, 7 Jan 2020 13:38:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=Gl5KmXNG2w7uS8tnORu0C/Hg/4r5BCu7bXX9xOiA5PQ=;
 b=K6aijNLSuUamGm+rbmZIVhI+sLCRdGwReuoVUtWif9/jgsJrEoMBP6NRd/uwH6ao0lTa
 uuu1PpD1jwHerN/zSyz5G4libFhIOvnsfobszLUfP1jFKqpkkxqdOx6ls9K+VJ3oh1aN
 5LQ8fUyz256Kutw73vDx1apmII+yMOdjSRF/jfit4NTI7yzXDXfeykRfz2k9W1PAGnfQ
 ek8szGEdy66ECAhQdmNBhLg0WLGEAsjxIsJUn7SbY+XjV8kkB8dSSObhKIossdMo9SBw
 CBf8momSvxIsYTy8S1o0SQi7yC0/v66M7GHqNSD7C+BnvD/c3PesgjRXi0Uh1s0uyzrO hw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xakm5e5mc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jan 2020 13:38:35 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 23D3110002A;
        Tue,  7 Jan 2020 13:38:32 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node3.st.com [10.75.127.18])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 13A0C2AFAB4;
        Tue,  7 Jan 2020 13:38:32 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG6NODE3.st.com (10.75.127.18)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 Jan 2020 13:38:31
 +0100
From:   <patrice.chotard@st.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <patrice.chotard@st.com>
Subject: [PATCH 1/2] ARM: dts: stih410-b2260: Fix ethernet phy DT node
Date:   Tue, 7 Jan 2020 13:38:27 +0100
Message-ID: <20200107123828.6586-2-patrice.chotard@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200107123828.6586-1-patrice.chotard@st.com>
References: <20200107123828.6586-1-patrice.chotard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-07_03:2020-01-06,2020-01-07 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

Since 'd3e014ec7d5e ("net: stmmac: platform: Fix MDIO init for platforms without PHY")'
we got the following kernel Oops :

Unable to handle kernel NULL pointer dereference at virtual address 00000260
pgd = (ptrval)
[00000260] *pgd=79a79831
Internal error: Oops: 17 [#1] SMP ARM
Modules linked in:
CPU: 0 PID: 201 Comm: ip Not tainted 5.5.0-rc5 #13
Hardware name: STi SoC with Flattened Device Tree
PC is at mdiobus_get_phy+0x4/0x20
LR is at stmmac_open+0x278/0xaa8
pc : [<c0a7e41c>]    lr : [<c0b1755c>]    psr: a0070013
sp : ed663930  ip : 00000000  fp : c110079c
r10: ed663d4c  r9 : ed663d4c  r8 : ee774028
r7 : ee22ad00  r6 : ee776000  r5 : 00000000  r4 : ee774000
r3 : ee775000  r2 : ca451a07  r1 : 00000098  r0 : 00000000
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 6d75404a  DAC: 00000051
Process ip (pid: 201, stack limit = 0x(ptrval))

This is due to lack of mdio DT subnode, so add it.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/boot/dts/stih410-b2260.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/stih410-b2260.dts b/arch/arm/boot/dts/stih410-b2260.dts
index 4fbd8e9eb5b7..1df2c37eb3a7 100644
--- a/arch/arm/boot/dts/stih410-b2260.dts
+++ b/arch/arm/boot/dts/stih410-b2260.dts
@@ -176,6 +176,7 @@
 
 		ethernet0: dwmac@9630000 {
 			phy-mode = "rgmii";
+			phy-handle = <&phy0>;
 			pinctrl-0 = <&pinctrl_rgmii1 &pinctrl_rgmii1_mdio_1>;
 
 			snps,phy-bus-name = "stmmac";
@@ -186,6 +187,15 @@
 			snps,reset-delays-us = <0 10000 1000000>;
 
 			status = "okay";
+
+			mdio0 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "snps,dwmac-mdio";
+				phy0: ethernet-phy@0 {
+					reg = <0>;
+				};
+			};
 		};
 
 		sti_uni_player0: sti-uni-player@8d80000 {
-- 
2.17.1

