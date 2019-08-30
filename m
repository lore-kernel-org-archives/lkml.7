Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39B4C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2B7523427
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbfH3QK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 12:10:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57370 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727959AbfH3QK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 12:10:26 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7UG7uYP141711;
        Fri, 30 Aug 2019 12:09:52 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uq3waqh1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Aug 2019 12:09:51 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7UG5B1h004279;
        Fri, 30 Aug 2019 16:09:50 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma02wdc.us.ibm.com with ESMTP id 2ujvv73m92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Aug 2019 16:09:50 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7UG9nUN49807816
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Aug 2019 16:09:49 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5995E6A04D;
        Fri, 30 Aug 2019 16:09:49 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E3B06A047;
        Fri, 30 Aug 2019 16:09:48 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.179.222])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 30 Aug 2019 16:09:48 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux@roeck-us.net, andrew@aj.id.au,
        joel@jms.id.au, mark.rutland@arm.com, robh+dt@kernel.org,
        jdelvare@suse.com, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 1/3] dt-bindings: hwmon: Document ibm,cffps2 compatible string
Date:   Fri, 30 Aug 2019 11:09:43 -0500
Message-Id: <1567181385-22129-2-git-send-email-eajames@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1567181385-22129-1-git-send-email-eajames@linux.ibm.com>
References: <1567181385-22129-1-git-send-email-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-30_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908300160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the compatible string for version 2 of the IBM CFFPS PSU.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 Documentation/devicetree/bindings/hwmon/ibm,cffps1.txt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/ibm,cffps1.txt b/Documentation/devicetree/bindings/hwmon/ibm,cffps1.txt
index f68a0a6..1036f65 100644
--- a/Documentation/devicetree/bindings/hwmon/ibm,cffps1.txt
+++ b/Documentation/devicetree/bindings/hwmon/ibm,cffps1.txt
@@ -1,8 +1,10 @@
-Device-tree bindings for IBM Common Form Factor Power Supply Version 1
-----------------------------------------------------------------------
+Device-tree bindings for IBM Common Form Factor Power Supply Versions 1 and 2
+-----------------------------------------------------------------------------
 
 Required properties:
- - compatible = "ibm,cffps1";
+ - compatible				: Must be one of the following:
+						"ibm,cffps1"
+						"ibm,cffps2"
  - reg = < I2C bus address >;		: Address of the power supply on the
 					  I2C bus.
 
-- 
1.8.3.1

