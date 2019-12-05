Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAC3C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 17:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2451E2464E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 17:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbfLERQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 12:16:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61336 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730099AbfLERPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 12:15:37 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB5H8dPO034943;
        Thu, 5 Dec 2019 12:15:17 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wq2tuttm6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Dec 2019 12:15:17 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xB5HFGPF007197;
        Thu, 5 Dec 2019 17:15:16 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma03dal.us.ibm.com with ESMTP id 2wkg27mku6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Dec 2019 17:15:16 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB5HFEPA48693560
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Dec 2019 17:15:15 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E02206E04C;
        Thu,  5 Dec 2019 17:15:14 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E463E6E05B;
        Thu,  5 Dec 2019 17:15:13 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.103.158])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  5 Dec 2019 17:15:13 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, jason@lakedaemon.net,
        linux-aspeed@lists.ozlabs.org, maz@kernel.org, robh+dt@kernel.org,
        tglx@linutronix.de, mark.rutland@arm.com, joel@jms.id.au,
        andrew@aj.id.au
Subject: [PATCH v2 01/12] dt-bindings: interrupt-controller: Add Aspeed SCU interrupt controller
Date:   Thu,  5 Dec 2019 11:15:01 -0600
Message-Id: <1575566112-11658-2-git-send-email-eajames@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1575566112-11658-1-git-send-email-eajames@linux.ibm.com>
References: <1575566112-11658-1-git-send-email-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-05_05:2019-12-04,2019-12-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=825 clxscore=1015 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 suspectscore=1 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912050144
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the Aspeed SCU interrupt controller and add an include file
for the interrupts it provides.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes since v1:
 - Remove 'reg' required property.

 .../interrupt-controller/aspeed,ast2xxx-scu-ic.txt | 23 ++++++++++++++++++++++
 MAINTAINERS                                        |  7 +++++++
 .../interrupt-controller/aspeed-scu-ic.h           | 23 ++++++++++++++++++++++
 3 files changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2xxx-scu-ic.txt
 create mode 100644 include/dt-bindings/interrupt-controller/aspeed-scu-ic.h

diff --git a/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2xxx-scu-ic.txt b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2xxx-scu-ic.txt
new file mode 100644
index 0000000..251ed44
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2xxx-scu-ic.txt
@@ -0,0 +1,23 @@
+Aspeed AST25XX and AST26XX SCU Interrupt Controller
+
+Required Properties:
+ - #interrupt-cells		: must be 1
+ - compatible			: must be "aspeed,ast2500-scu-ic",
+				  "aspeed,ast2600-scu-ic0" or
+				  "aspeed,ast2600-scu-ic1"
+ - interrupts			: interrupt from the parent controller
+ - interrupt-controller		: indicates that the controller receives and
+				  fires new interrupts for child busses
+
+Example:
+
+    syscon@1e6e2000 {
+        ranges = <0 0x1e6e2000 0x1a8>;
+
+        scu_ic: interrupt-controller@18 {
+            #interrupt-cells = <1>;
+            compatible = "aspeed,ast2500-scu-ic";
+            interrupts = <21>;
+            interrupt-controller;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 18c1137..6bbb194 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2691,6 +2691,13 @@ S:	Maintained
 F:	drivers/pinctrl/aspeed/
 F:	Documentation/devicetree/bindings/pinctrl/aspeed,*
 
+ASPEED SCU INTERRUPT CONTROLLER DRIVER
+M:	Eddie James <eajames@linux.ibm.com>
+L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2xxx-scu-ic.txt
+F:	include/dt-bindings/interrupt-controller/aspeed-scu-ic.h
+
 ASPEED VIDEO ENGINE DRIVER
 M:	Eddie James <eajames@linux.ibm.com>
 L:	linux-media@vger.kernel.org
diff --git a/include/dt-bindings/interrupt-controller/aspeed-scu-ic.h b/include/dt-bindings/interrupt-controller/aspeed-scu-ic.h
new file mode 100644
index 0000000..f315d5a
--- /dev/null
+++ b/include/dt-bindings/interrupt-controller/aspeed-scu-ic.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef _DT_BINDINGS_INTERRUPT_CONTROLLER_ASPEED_SCU_IC_H_
+#define _DT_BINDINGS_INTERRUPT_CONTROLLER_ASPEED_SCU_IC_H_
+
+#define ASPEED_SCU_IC_VGA_CURSOR_CHANGE			0
+#define ASPEED_SCU_IC_VGA_SCRATCH_REG_CHANGE		1
+
+#define ASPEED_AST2500_SCU_IC_PCIE_RESET_LO_TO_HI	2
+#define ASPEED_AST2500_SCU_IC_PCIE_RESET_HI_TO_LO	3
+#define ASPEED_AST2500_SCU_IC_LPC_RESET_LO_TO_HI	4
+#define ASPEED_AST2500_SCU_IC_LPC_RESET_HI_TO_LO	5
+#define ASPEED_AST2500_SCU_IC_ISSUE_MSI			6
+
+#define ASPEED_AST2600_SCU_IC0_PCIE_PERST_LO_TO_HI	2
+#define ASPEED_AST2600_SCU_IC0_PCIE_PERST_HI_TO_LO	3
+#define ASPEED_AST2600_SCU_IC0_PCIE_RCRST_LO_TO_HI	4
+#define ASPEED_AST2600_SCU_IC0_PCIE_RCRST_HI_TO_LO	5
+
+#define ASPEED_AST2600_SCU_IC1_LPC_RESET_LO_TO_HI	0
+#define ASPEED_AST2600_SCU_IC1_LPC_RESET_HI_TO_LO	1
+
+#endif /* _DT_BINDINGS_INTERRUPT_CONTROLLER_ASPEED_SCU_IC_H_ */
-- 
1.8.3.1

