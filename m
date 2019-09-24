Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6C8C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5322920673
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632807AbfIXQPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 12:15:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55758 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388230AbfIXQPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 12:15:06 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8OG8Ste103654;
        Tue, 24 Sep 2019 12:14:45 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v7n2vmmaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Sep 2019 12:14:45 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8OGAX24009034;
        Tue, 24 Sep 2019 16:14:44 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma01wdc.us.ibm.com with ESMTP id 2v5bg6x0sk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Sep 2019 16:14:44 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8OGEgKu44892472
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Sep 2019 16:14:42 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0A86BE061;
        Tue, 24 Sep 2019 16:14:42 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EFC35BE04F;
        Tue, 24 Sep 2019 16:14:41 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.179.222])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 24 Sep 2019 16:14:41 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        andrew@aj.id.au, joel@jms.id.au, mark.rutland@arm.com,
        robh+dt@kernel.org, maz@kernel.org, jason@lakedaemon.net,
        tglx@linutronix.de, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 4/4] ARM: dts: aspeed: ast2600: Add SCU interrupt controllers
Date:   Tue, 24 Sep 2019 11:14:32 -0500
Message-Id: <1569341672-27632-5-git-send-email-eajames@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1569341672-27632-1-git-send-email-eajames@linux.ibm.com>
References: <1569341672-27632-1-git-send-email-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-24_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=664 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909240147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes for the interrupt controllers provided by the SCU.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed-g6.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index 3a1422f..d89f1e6 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -159,6 +159,24 @@
 					compatible = "aspeed,ast2600-smpmem";
 					reg = <0x180 0x40>;
 				};
+
+				scu_ic0: interrupt-controller@0 {
+					#interrupt-cells = <1>;
+					compatible = "aspeed,ast2600-scu-ic0";
+					reg = <0x560 0x4>;
+					interrupt-parent = <&gic>;
+					interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+					interrupt-controller;
+				};
+
+				scu_ic1: interrupt-controller@1 {
+					#interrupt-cells = <1>;
+					compatible = "aspeed,ast2600-scu-ic1";
+					reg = <0x570 0x4>;
+					interrupt-parent = <&gic>;
+					interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+					interrupt-controller;
+				};
 			};
 
 			rng: hwrng@1e6e2524 {
-- 
1.8.3.1

