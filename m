Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E678AC2D0B1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 05:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB31C24683
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 05:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfLFFqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 00:46:46 -0500
Received: from mail-bn8nam11on2078.outbound.protection.outlook.com ([40.107.236.78]:19873
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726043AbfLFFqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 00:46:46 -0500
Received: from BL0PR02CA0055.namprd02.prod.outlook.com (2603:10b6:207:3d::32)
 by DM6PR02MB6233.namprd02.prod.outlook.com (2603:10b6:5:1d6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.14; Fri, 6 Dec
 2019 05:46:43 +0000
Received: from SN1NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by BL0PR02CA0055.outlook.office365.com
 (2603:10b6:207:3d::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.14 via Frontend
 Transport; Fri, 6 Dec 2019 05:46:43 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.83 as permitted sender)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT053.mail.protection.outlook.com (10.152.72.102) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Fri, 6 Dec 2019 05:46:43 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1id6Ld-0000Ll-RX; Thu, 05 Dec 2019 21:40:13 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1id6LY-00044a-9q; Thu, 05 Dec 2019 21:40:08 -0800
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xB65e49k006773;
        Thu, 5 Dec 2019 21:40:05 -0800
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1id6LU-0003rO-4g; Thu, 05 Dec 2019 21:40:04 -0800
From:   shubhrajyoti.datta@gmail.com
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org, robh+dt@kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v2 1/3] dt-bindings: Add dt bindings for flex noc Performance Monitor
Date:   Fri,  6 Dec 2019 11:09:56 +0530
Message-Id: <19bb1ad0783e66aef45b140ccf409917ef94e63b.1575609926.git.shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--5.130-7.0-31-1
X-imss-scan-details: No--5.130-7.0-31-1;No--5.130-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 132200848033218437;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39860400002)(396003)(199004)(189003)(70206006)(70586007)(9686003)(73392003)(8936002)(5660300002)(336012)(426003)(86362001)(107886003)(50466002)(48376002)(36756003)(26005)(450100002)(356004)(305945005)(4326008)(14444005)(16586007)(51416003)(316002)(7696005)(8676002)(50226002)(498600001)(76482006)(966005)(81156014)(81166006)(9786002)(118296001)(82202003)(6666004)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB6233;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fe86c2e-6e0f-4553-2af5-08d77a0fac76
X-MS-TrafficTypeDiagnostic: DM6PR02MB6233:
X-Microsoft-Antispam-PRVS: <DM6PR02MB623370CB6683946D1D49E925875F0@DM6PR02MB6233.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 0243E5FD68
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RT1JFYb3WCoa9xQ/JdwLnL6QdE8sIvasaH+5zHQxNuD0r3NPveZgMj8fShBwETByvazpRzbyCsUoSw6cCbdhqXyATtruyKNteQAOfvrtEGCP/11W1fhJt1+uJqBfNFaIaPIciQJVloKW1ZHEDWLeorhAmTgqRe0X4cVlLIHIZLSc3AM1vSQHXfWk2+5wugban+4mp4NPgzmc6eohFmccxnPUSwMmfjZJ455quvBC9sEVy8v31X14BUOu6BTMkye0B7jx80B2LSq8WlbuaCRvvHO203HfHfrPX6WZkoTqFb5QmmD/EwcTknfWI6LOkP6g24q0dpScydG+SXmR1FxMw8nzZOtFAMLQdeqnXlkYqf97p8iRFhH/cKQFR/EykPv2oxsG2DC4S6HIkzXddj1GYQo1cu0fSWZsRnEVUwBsPJYYdpDrRfo54MNMS36q7z33KcPPaKQM07WJobh/MCtQczUDf628jsMA+JabrQX8A9Y=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2019 05:46:43.1617
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe86c2e-6e0f-4553-2af5-08d77a0fac76
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6233
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Add dt bindings for flexnoc Performance Monitor.
The flexnoc counters for read and write response and requests are
supported.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
changes from RFC:
moved to schema / yaml
v2:
Add additionalProperties
Update the License

 .../devicetree/bindings/perf/xlnx-flexnoc-pm.yaml  | 46 ++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/xlnx-flexnoc-pm.yaml

diff --git a/Documentation/devicetree/bindings/perf/xlnx-flexnoc-pm.yaml b/Documentation/devicetree/bindings/perf/xlnx-flexnoc-pm.yaml
new file mode 100644
index 0000000..39c54c7
--- /dev/null
+++ b/Documentation/devicetree/bindings/perf/xlnx-flexnoc-pm.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/perf/xlnx-flexnoc-pm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx flexnoc Performance Monitor device tree bindings
+
+maintainers:
+  - Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
+
+properties:
+  compatible:
+    # Versal SoC based boards
+    items:
+      - enum:
+          - xlnx,flexnoc-pm-2.7
+
+  reg:
+    items:
+      - description: funnel registers
+      - description: baselpd registers
+      - description: basefpd registers
+
+  reg-names:
+    # The core schema enforces this is a string array
+    items:
+      - const: funnel
+      - const: baselpd
+      - const: basefpd
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    performance-monitor@f0920000 {
+        compatible = "xlnx,flexnoc-pm-2.7";
+        reg-names = "funnel", "baselpd", "basefpd";
+        reg = <0x0 0xf0920000 0x0 0x1000>,
+              <0x0 0xf0980000 0x0 0x9000>,
+              <0x0 0xf0b80000 0x0 0x9000>;
+    };
-- 
2.1.1

