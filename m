Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC63FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 20:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF96214DA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 20:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbfKHUS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 15:18:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43590 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727168AbfKHUS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 15:18:57 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA8KHvaS124308;
        Fri, 8 Nov 2019 15:18:44 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w5bjm0328-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Nov 2019 15:18:44 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xA8KGKl7008665;
        Fri, 8 Nov 2019 20:18:43 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma03dal.us.ibm.com with ESMTP id 2w41uktf1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Nov 2019 20:18:43 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA8KIgnR50594118
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Nov 2019 20:18:42 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 986882805C;
        Fri,  8 Nov 2019 20:18:42 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1A7E2805E;
        Fri,  8 Nov 2019 20:18:41 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.103.158])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  8 Nov 2019 20:18:41 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-aspeed@lists.ozlabs.org, andrew@aj.id.au, joel@jms.id.au,
        maz@kernel.org, jason@lakedaemon.net, tglx@linutronix.de,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Subject: [PATCH 08/12] ARM: dts: aspeed: ast2500: Add XDMA Engine
Date:   Fri,  8 Nov 2019 14:18:29 -0600
Message-Id: <1573244313-9190-9-git-send-email-eajames@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1573244313-9190-1-git-send-email-eajames@linux.ibm.com>
References: <1573244313-9190-1-git-send-email-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-08_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=868 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911080195
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a node for the XDMA engine with all the necessary information.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed-g5.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 4579c78..5fa2744 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 #include <dt-bindings/clock/aspeed-clock.h>
+#include <dt-bindings/interrupt-controller/aspeed-scu-ic.h>
 
 / {
 	model = "Aspeed BMC";
@@ -259,6 +260,15 @@
 				interrupts = <0x19>;
 			};
 
+			xdma: xdma@1e6e7000 {
+				compatible = "aspeed,ast2500-xdma";
+				reg = <0x1e6e7000 0x100>;
+				clocks = <&syscon ASPEED_CLK_GATE_BCLK>;
+				resets = <&syscon ASPEED_RESET_XDMA>;
+				interrupts-extended = <&vic 6>, <&scu_ic ASPEED_AST2500_SCU_IC_PCIE_RESET_LO_TO_HI>;
+				status = "disabled";
+			};
+
 			adc: adc@1e6e9000 {
 				compatible = "aspeed,ast2500-adc";
 				reg = <0x1e6e9000 0xb0>;
-- 
1.8.3.1

