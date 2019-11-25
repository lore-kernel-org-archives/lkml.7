Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7BAC43215
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 11:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 825F72082F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 11:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbfKYLAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 06:00:08 -0500
Received: from mail-eopbgr800085.outbound.protection.outlook.com ([40.107.80.85]:10193
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727278AbfKYLAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 06:00:08 -0500
Received: from DM6PR02CA0065.namprd02.prod.outlook.com (2603:10b6:5:177::42)
 by SN6PR02MB4670.namprd02.prod.outlook.com (2603:10b6:805:8f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.19; Mon, 25 Nov
 2019 11:00:05 +0000
Received: from SN1NAM02FT034.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::204) by DM6PR02CA0065.outlook.office365.com
 (2603:10b6:5:177::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17 via Frontend
 Transport; Mon, 25 Nov 2019 11:00:05 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.83 as permitted sender)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT034.mail.protection.outlook.com (10.152.72.141) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Mon, 25 Nov 2019 11:00:04 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iZC2E-00077C-OW; Mon, 25 Nov 2019 02:56:02 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iZC29-0000fp-DV; Mon, 25 Nov 2019 02:55:57 -0800
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xAPAtu8s025518;
        Mon, 25 Nov 2019 02:55:56 -0800
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iZC27-0000fS-Pj; Mon, 25 Nov 2019 02:55:56 -0800
From:   shubhrajyoti.datta@gmail.com
To:     linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        corbet@lwn.net, gregkh@linuxfoundation.org, arnd@arndb.de,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH 1/3] dt-bindings: Add dt bindings for flex noc Performance Monitor
Date:   Mon, 25 Nov 2019 16:25:50 +0530
Message-Id: <1574679352-2989-1-git-send-email-shubhrajyoti.datta@gmail.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--4.118-7.0-31-1
X-imss-scan-details: No--4.118-7.0-31-1;No--4.118-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 132191532049817285;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(136003)(396003)(189003)(199004)(2616005)(107886003)(8936002)(316002)(426003)(966005)(6916009)(9686003)(70586007)(86362001)(50466002)(82202003)(450100002)(70206006)(4326008)(48376002)(36756003)(6306002)(9786002)(51416003)(55446002)(498600001)(50226002)(2351001)(2361001)(305945005)(2906002)(6666004)(356004)(61266001)(26005)(16586007)(47776003)(5660300002)(76482006)(81166006)(73392003)(8676002)(81156014)(336012);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4670;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd56b19f-1c42-4e46-3c22-08d77196a094
X-MS-TrafficTypeDiagnostic: SN6PR02MB4670:
X-MS-Exchange-PUrlCount: 2
X-Microsoft-Antispam-PRVS: <SN6PR02MB4670E75D91CB9915514074EC874A0@SN6PR02MB4670.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-Forefront-PRVS: 0232B30BBC
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?v0VmIqfjQ45mm+OPDOIuHwkXcGUWooiNiM+ncj9A7GYUVYcTlUWTqmokfuUs?=
 =?us-ascii?Q?NHNs522PeTLKQfyRba7NXY7fsMhkNRVlybEOaPAcrCyCeMJwpAWlRqL7hkLG?=
 =?us-ascii?Q?cETKZPpl6VeRiHpogKGKIA9ZghxZIqA1yx6GBhPZqv/mvsE/WtRl8VQOa67r?=
 =?us-ascii?Q?SyXOojSai2s9v+eSEhT0hI8cQ2MP++yvH7Q0j2pj32iO5lYE9T53V8ImZKLy?=
 =?us-ascii?Q?FKzjNMwKVIm/jQXwUZKEqdB0IAmPWLJb6N8Wpzunxpmu+kqgPRNxx6Obr2yW?=
 =?us-ascii?Q?nJSywzNQ5tiuX6aU1VcLQBf8gnlh9NAh4246I048qvwwXPHTUprU4oxF+jEQ?=
 =?us-ascii?Q?WAu5uZXaqBlhfRw0mOYYdTw4iEerOfD8aEnmuNTsZTFCn4BXctOgnonBdee0?=
 =?us-ascii?Q?KmesuD3owmnuYpahIgnovXS6T3sHN2of+AEbh4LQxM4Pf5B4X6EWm7RORnLv?=
 =?us-ascii?Q?TLb6x+K8dJjTyIm7TUptj5GJx+HCbUYRlooVQTqhf/cY+/RCbbVcME8wZvi1?=
 =?us-ascii?Q?2dLshHxA+fHqI6oJh1w5CVRzlTNtKiNavo2Ja3zJ8R+RM2oLBW1g1C8Lw7Ui?=
 =?us-ascii?Q?MdMaCWrhIQthXzswPIviSXScmGVEs65tjYGgh6T4aTNxV8tvI9aGPC0M472/?=
 =?us-ascii?Q?EL7OBYWXCcsjNOF7xs4mzcnVsqeZnSjxAnkk6PyLYX3umIjdXGsuXGGt53L1?=
 =?us-ascii?Q?e4mXrZ2ngrZyPfeex48p04uNsGvsoF7BkYHahJpEYl5QORLfzlj66RCQBvUm?=
 =?us-ascii?Q?Ltr7ViTzildJSACM2W6JzLniWTwcl6kk7tN1kt0p8MP/2NvTxV80M0FhSyen?=
 =?us-ascii?Q?opMoOKLQNZTTbgCwr3O4bfEk5lE7DSgn77cNQQL4iBsKT8uU9b/DgFEhM5hu?=
 =?us-ascii?Q?TFmHR8SdDNheBgixFZVNbjTZlAQMQ+8kiAcT+OeHecCKXQ15/ZErMfW7PCes?=
 =?us-ascii?Q?SG/XZvKNv1Zs+nmxxSurRDGvdPzHxCpqJN5nAC9BohnmNQbOCNIkx48dZb0W?=
 =?us-ascii?Q?SIXAma3iwrr8ZqCELFUpw8wh3hUCOz3W71GnbTsOGp0wW4UqCaKAHkbo1pPp?=
 =?us-ascii?Q?IVMpdnEIBFm0Ym5knCPVFuzK9bf35mjuKVxK9Sp85wcaPB4wW2KmHxxf/caE?=
 =?us-ascii?Q?KT+Xx72d+COQnsgj55xlsxmR0Rbyv7nCcb7J8XjqIKOLvCxCNQGW4RKgoVMA?=
 =?us-ascii?Q?kXXR1Bn4ZOJt9dPaYMHuN9CLxpDOqUcSUNC4qOeNxjLrPzrih/8Bvz4aFVwz?=
 =?us-ascii?Q?UnpoVaaG4Bpfv7MR0Ma+RY9TtS4IaanBFzUSS7zvJYO5/AW4VOEIZbYgWJFS?=
 =?us-ascii?Q?SWWjLbmSb//g72Hgrvr60veNwPo3i7HsfPhcggHB2hmR2B2rL9nRQ/Ye6P7a?=
 =?us-ascii?Q?QqmqNzv3bnFbRTfzE/Ln/nwawaFzzaqFYeqq+OVzs6RUgkPmPm1N1N715ef1?=
 =?us-ascii?Q?6jQ/oeqN+Q7T7GJDwUZYhtQgPNOiT4MvtpjntUIJwyFB3mMPsTw439Q/mr9E?=
 =?us-ascii?Q?VcpWWTkT2wWWO6M25K5OjqFE/eKGPaJgY7JndoUnzmCZXDGF6BV/bTwO1MOT?=
 =?us-ascii?Q?/gm8Nbg8KFg/ICcEj+E=3D?=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2019 11:00:04.8196
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd56b19f-1c42-4e46-3c22-08d77196a094
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4670
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

 .../devicetree/bindings/perf/xlnx-flexnoc-pm.yaml  | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/xlnx-flexnoc-pm.yaml

diff --git a/Documentation/devicetree/bindings/perf/xlnx-flexnoc-pm.yaml b/Documentation/devicetree/bindings/perf/xlnx-flexnoc-pm.yaml
new file mode 100644
index 0000000..bd0f345
--- /dev/null
+++ b/Documentation/devicetree/bindings/perf/xlnx-flexnoc-pm.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/perf/xlnx-flexnoc-pm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx flexnoc Performance Monitor device tree bindings
+
+maintainers:
+  - Arnd Bergmann <arnd@arndb.de>
+  - Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

