Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF599C2D0BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 23:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C737620659
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 23:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfLEXZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 18:25:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22932 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726174AbfLEXZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 18:25:55 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB5NMfOD030150;
        Thu, 5 Dec 2019 18:25:29 -0500
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wq2t3bpnp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Dec 2019 18:25:29 -0500
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xB5NKH3R030724;
        Thu, 5 Dec 2019 23:25:34 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma01wdc.us.ibm.com with ESMTP id 2wkg26tttm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Dec 2019 23:25:34 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB5NPSDS57803070
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Dec 2019 23:25:28 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11DE56A054;
        Thu,  5 Dec 2019 23:25:28 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 79A576A047;
        Thu,  5 Dec 2019 23:25:27 +0000 (GMT)
Received: from wrightj-ThinkPad-W520.rchland.ibm.com (unknown [9.10.101.53])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  5 Dec 2019 23:25:27 +0000 (GMT)
From:   Jim Wright <wrightj@linux.vnet.ibm.com>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net, wrightj@linux.vnet.ibm.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: hwmon/pmbus: Add ti,ucd90320 power sequencer
Date:   Thu,  5 Dec 2019 17:24:10 -0600
Message-Id: <20191205232411.21492-2-wrightj@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191205232411.21492-1-wrightj@linux.vnet.ibm.com>
References: <20191205232411.21492-1-wrightj@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-05_10:2019-12-04,2019-12-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=999 mlxscore=0 impostorscore=0 clxscore=1015 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912050191
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the UCD90320 device tree binding.

Signed-off-by: Jim Wright <wrightj@linux.vnet.ibm.com>

---
Changes since v1:
- Replace .txt file version with YAML schema.
---
 .../bindings/hwmon/pmbus/ti,ucd90320.yaml     | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/pmbus/ti,ucd90320.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/pmbus/ti,ucd90320.yaml b/Documentation/devicetree/bindings/hwmon/pmbus/ti,ucd90320.yaml
new file mode 100644
index 000000000000..5d42e1304202
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/pmbus/ti,ucd90320.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/hwmon/pmbus/ti,ucd90320.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: UCD90320 power sequencer
+
+maintainers:
+  - Jim Wright <wrightj@linux.vnet.ibm.com>
+
+description: |
+  The UCD90320 is a 32-rail PMBus/I2C addressable power-supply sequencer and
+  monitor. The 24 integrated ADC channels (AMONx) monitor the power supply
+  voltage, current, and temperature. Of the 84 GPIO pins, 8 can be used as
+  digital monitors (DMONx), 32 to enable the power supply (ENx), 24 for
+  margining (MARx), 16 for logical GPO, and 32 GPIs for cascading, and system
+  function.
+
+  http://focus.ti.com/lit/ds/symlink/ucd90320.pdf
+
+properties:
+  compatible:
+    enum:
+      - ti,ucd90320
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ucd90320@11 {
+            compatible = "ti,ucd90320";
+            reg = <0x11>;
+        };
+    };
-- 
2.17.1

