Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB6CC33CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 20:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01EFB2072E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 20:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbgAIU7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 15:59:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16106 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728140AbgAIU73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 15:59:29 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 009Kw67S010900;
        Thu, 9 Jan 2020 15:59:15 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xe00x1fg9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jan 2020 15:59:15 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 009KvP3f004471;
        Thu, 9 Jan 2020 20:59:14 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma03dal.us.ibm.com with ESMTP id 2xajb855m9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jan 2020 20:59:14 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 009KxDYY48431508
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Jan 2020 20:59:13 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3261AAC05F;
        Thu,  9 Jan 2020 20:59:13 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E0AF8AC059;
        Thu,  9 Jan 2020 20:59:11 +0000 (GMT)
Received: from ghost4.ibm.com (unknown [9.211.92.233])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  9 Jan 2020 20:59:11 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-aspeed@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, jason@lakedaemon.net, maz@kernel.org,
        robh+dt@kernel.org, tglx@linutronix.de, joel@jms.id.au,
        andrew@aj.id.au, eajames@linux.ibm.com
Subject: [PATCH v5 05/12] dt-bindings: soc: Add Aspeed XDMA Engine
Date:   Thu,  9 Jan 2020 14:58:56 -0600
Message-Id: <20200109205903.27036-6-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200109205903.27036-1-eajames@linux.ibm.com>
References: <20200109205903.27036-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-09_05:2020-01-09,2020-01-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1 mlxscore=0
 adultscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001090173
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the bindings for the Aspeed AST25XX and AST26XX XDMA engine.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/soc/aspeed/xdma.txt   | 40 +++++++++++++++++++
 MAINTAINERS                                   |  6 +++
 2 files changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/aspeed/xdma.txt

diff --git a/Documentation/devicetree/bindings/soc/aspeed/xdma.txt b/Documentation/devicetree/bindings/soc/aspeed/xdma.txt
new file mode 100644
index 000000000000..074bda546e2b
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/aspeed/xdma.txt
@@ -0,0 +1,40 @@
+Aspeed AST25XX and AST26XX XDMA Engine
+
+The XDMA Engine embedded in the AST2500 and AST2600 SOCs can perform automatic
+DMA operations over PCI between the SOC (acting as a BMC) and a host processor.
+
+Required properties:
+ - compatible		: must be "aspeed,ast2500-xdma" or
+			  "aspeed,ast2600-xdma"
+ - reg			: contains the address and size of the memory region
+			  associated with the XDMA engine registers
+ - clocks		: clock specifier for the clock associated with the
+			  XDMA engine
+ - resets		: reset specifier for the syscon reset associated with
+			  the XDMA engine
+ - interrupts-extended	: two interrupt cells; the first specifies the global
+			  interrupt for the XDMA engine and the second
+			  specifies the PCI-E reset or PERST interrupt.
+ - aspeed,scu		: a phandle to the syscon node for the system control
+			  unit of the SOC
+ - memory		: contains the address and size of the memory area to
+			  be used by the XDMA engine for DMA operations
+
+Optional properties:
+ - pcie-device		: should be either "bmc" or "vga", corresponding to
+			  which device should be used by the XDMA engine for
+			  DMA operations. If this property is not set, the XDMA
+			  engine will use the BMC PCI-E device.
+
+Example:
+
+    xdma@1e6e7000 {
+        compatible = "aspeed,ast2500-xdma";
+        reg = <0x1e6e7000 0x100>;
+        clocks = <&syscon ASPEED_CLK_GATE_BCLK>;
+        resets = <&syscon ASPEED_RESET_XDMA>;
+        interrupts-extended = <&vic 6>, <&scu_ic ASPEED_AST2500_SCU_IC_PCIE_RESET_LO_TO_HI>;
+        aspeed,scu = <&syscon>;
+        pcie-device = "bmc";
+        memory = <0x9f000000 0x01000000>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 651c99fdeb9d..e9ddf6d8d1be 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2720,6 +2720,12 @@ S:	Maintained
 F:	drivers/media/platform/aspeed-video.c
 F:	Documentation/devicetree/bindings/media/aspeed-video.txt
 
+ASPEED XDMA ENGINE DRIVER
+M:	Eddie James <eajames@linux.ibm.com>
+L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/soc/aspeed/xdma.txt
+
 ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS
 M:	Corentin Chary <corentin.chary@gmail.com>
 L:	acpi4asus-user@lists.sourceforge.net
-- 
2.24.0

