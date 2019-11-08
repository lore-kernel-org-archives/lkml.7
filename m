Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AB6FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 20:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32EF20869
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 20:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbfKHUS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 15:18:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56464 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727794AbfKHUS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 15:18:57 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA8KHjlR063157;
        Fri, 8 Nov 2019 15:18:42 -0500
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w5bec01tg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Nov 2019 15:18:41 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xA8KGL6v010730;
        Fri, 8 Nov 2019 20:18:40 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma03wdc.us.ibm.com with ESMTP id 2w41ujw5m3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Nov 2019 20:18:40 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA8KId8051970372
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Nov 2019 20:18:39 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A11E22805E;
        Fri,  8 Nov 2019 20:18:39 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C88A628058;
        Fri,  8 Nov 2019 20:18:38 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.103.158])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  8 Nov 2019 20:18:38 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-aspeed@lists.ozlabs.org, andrew@aj.id.au, joel@jms.id.au,
        maz@kernel.org, jason@lakedaemon.net, tglx@linutronix.de,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Subject: [PATCH 05/12] dt-bindings: soc: Add Aspeed XDMA Engine
Date:   Fri,  8 Nov 2019 14:18:26 -0600
Message-Id: <1573244313-9190-6-git-send-email-eajames@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1573244313-9190-1-git-send-email-eajames@linux.ibm.com>
References: <1573244313-9190-1-git-send-email-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-08_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=748 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911080195
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the bindings for the Aspeed AST25XX and AST26XX XDMA engine.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 .../devicetree/bindings/soc/aspeed/xdma.txt        | 24 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 ++++++
 2 files changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/aspeed/xdma.txt

diff --git a/Documentation/devicetree/bindings/soc/aspeed/xdma.txt b/Documentation/devicetree/bindings/soc/aspeed/xdma.txt
new file mode 100644
index 0000000..b6053e0
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/aspeed/xdma.txt
@@ -0,0 +1,24 @@
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
+ - resets		: reset specifier for the syscon reset associated with
+			  the XDMA engine
+ - interrupts-extended	: two interrupt nodes; the first specifies the global
+			  interrupt for the XDMA engine and the second
+			  specifies the PCI-E reset or PERST interrupt.
+
+Example:
+
+    xdma@1e6e7000 {
+        compatible = "aspeed,ast2500-xdma";
+        reg = <0x1e6e7000 0x100>;
+        resets = <&syscon ASPEED_RESET_XDMA>;
+        interrupts-extended = <&vic 6>, <&scu_ic ASPEED_AST2500_SCU_IC_PCIE_RESET_LO_TO_HI>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index c46181c..540bd45 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2691,6 +2691,12 @@ S:	Maintained
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
1.8.3.1

