Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D28C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 21:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC5BC20663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 21:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfCDVhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 16:37:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58070 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726412AbfCDVhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 16:37:15 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x24LWSAA125576
        for <linux-kernel@vger.kernel.org>; Mon, 4 Mar 2019 16:37:12 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r17e7auyq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 16:37:11 -0500
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.ibm.com>;
        Mon, 4 Mar 2019 21:37:11 -0000
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 4 Mar 2019 21:37:06 -0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x24Lb5OV63766670
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Mar 2019 21:37:05 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 79A31136051;
        Mon,  4 Mar 2019 21:37:05 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5009136055;
        Mon,  4 Mar 2019 21:37:04 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.179.222])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  4 Mar 2019 21:37:04 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, joel@jms.id.au,
        andrew@aj.id.au, arnd@arndb.de, gregkh@linuxfoundation.org,
        jk@ozlabs.org, openbmc@lists.ozlabs.org,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 1/6] dt-bindings: misc: Add Aspeed XDMA engine binding documentation
Date:   Mon,  4 Mar 2019 15:36:55 -0600
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1551735420-16202-1-git-send-email-eajames@linux.ibm.com>
References: <1551735420-16202-1-git-send-email-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19030421-0016-0000-0000-0000098BE570
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010705; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01169658; UDB=6.00611233; IPR=6.00950286;
 MB=3.00025831; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-04 21:37:09
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19030421-0017-0000-0000-000042587885
Message-Id: <1551735420-16202-2-git-send-email-eajames@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-04_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903040151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the bindings.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 .../devicetree/bindings/misc/aspeed,xdma.txt       | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/aspeed,xdma.txt

diff --git a/Documentation/devicetree/bindings/misc/aspeed,xdma.txt b/Documentation/devicetree/bindings/misc/aspeed,xdma.txt
new file mode 100644
index 0000000..85e82ea
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/aspeed,xdma.txt
@@ -0,0 +1,23 @@
+* Device tree bindings for the Aspeed XDMA engine
+
+The XDMA Engine embedded in the AST2500 SOC can perform automatic DMA
+operations over PCI between the AST2500 (acting as a BMC) and a host processor.
+
+Required properties:
+
+ - compatible		"aspeed,ast2500-xdma"
+ - reg			contains the offset and length of the memory region
+			assigned to the XDMA registers
+ - resets		reset specifier for the syscon reset associated with
+			the XDMA engine
+ - interrupts		the interrupt associated with the XDMA engine on this
+			platform
+
+Example:
+
+    xdma@1e6e7000 {
+        compatible = "aspeed,ast2500-xdma";
+        reg = <0x1e6e7000 0x100>;
+        resets = <&syscon ASPEED_RESET_XDMA>;
+        interrupts = <6>;
+    };
-- 
1.8.3.1

