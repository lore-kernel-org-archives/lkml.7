Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CC8C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 06:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19D49206E0
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 06:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfLIGFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 01:05:09 -0500
Received: from mail-mw2nam12on2067.outbound.protection.outlook.com ([40.107.244.67]:6940
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726132AbfLIGFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 01:05:08 -0500
Received: from BL0PR02CA0036.namprd02.prod.outlook.com (2603:10b6:207:3c::49)
 by BYAPR02MB5318.namprd02.prod.outlook.com (2603:10b6:a03:6e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.13; Mon, 9 Dec
 2019 06:05:06 +0000
Received: from SN1NAM02FT037.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::203) by BL0PR02CA0036.outlook.office365.com
 (2603:10b6:207:3c::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.12 via Frontend
 Transport; Mon, 9 Dec 2019 06:05:05 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.83 as permitted sender)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT037.mail.protection.outlook.com (10.152.72.89) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2495.26
 via Frontend Transport; Mon, 9 Dec 2019 06:05:05 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1ieC1j-0004Ne-HR; Sun, 08 Dec 2019 21:56:11 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1ieC1d-0002BM-OZ; Sun, 08 Dec 2019 21:56:05 -0800
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xB95u4FH024366;
        Sun, 8 Dec 2019 21:56:05 -0800
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1ieC1c-00027p-CO; Sun, 08 Dec 2019 21:56:04 -0800
From:   shubhrajyoti.datta@gmail.com
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de, michal.simek@xilinx.com,
        robh+dt@kernel.org, shubhrajyoti.datta@gmail.com, git@xilinx.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH 1/3] dt-bindings: misc: Add dt bindings for traffic generator
Date:   Mon,  9 Dec 2019 11:25:57 +0530
Message-Id: <1575870959-11703-1-git-send-email-shubhrajyoti.datta@gmail.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--5.340-7.0-31-1
X-imss-scan-details: No--5.340-7.0-31-1;No--5.340-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 132203451052968904;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(136003)(396003)(199004)(189003)(9686003)(8936002)(8676002)(2906002)(305945005)(81156014)(50226002)(498600001)(81166006)(9786002)(356004)(6666004)(5660300002)(51416003)(36756003)(76482006)(55446002)(450100002)(316002)(426003)(26005)(48376002)(2616005)(70206006)(50466002)(70586007)(86362001)(4326008)(107886003)(336012)(73392003)(82202003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5318;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98de82db-9cd9-4e40-290f-08d77c6dbc87
X-MS-TrafficTypeDiagnostic: BYAPR02MB5318:
X-Microsoft-Antispam-PRVS: <BYAPR02MB53181FB99D277FEB1D70638F87580@BYAPR02MB5318.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 02462830BE
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bIkYRqIF3jvaA7QCM6Maih28kPabrEES4rI8b1fhXrCQsX6bG7T7Um0pykgo7dMMjhUado2kuXp9mjD+k+Q7dHALoMptDjP7YLPAtoPauixEcv6Emptbcs4+5TfhO+DLlBdwXOuCphgT1UUm54TyMc/X5k8d2sK1+yjn3UKO9S/k/Ao0tIKz0tneIfLB8j4mHU1scOm/QuSqFEtMUX+9U1z+OYhfGauUJbJcbC6r4JE862eb3VHYMqMfPr1A+hc+3wV6cyCpFWLsYYGg1Jo3+Y7y6icrjR8Wv7MbuqOZuF3AqgbZskRStp+gufiyMa68NVnzOyQNHoL1Q6qKVfgI/nyMOc6no44N30c4VqWHGwHXeDt+259H32HaEEOrZtyr+Qv7C7ghaKrz7Tbx6Zyn6DGvY9sMnfj7JWeROrAniCeH8LRwWOunIWTyr0qHrF40
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2019 06:05:05.1347
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98de82db-9cd9-4e40-290f-08d77c6dbc87
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5318
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Add dt bindings for xilinx traffic generator IP.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 .../bindings/misc/xlnx,axi-traffic-gen.txt         | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/xlnx,axi-traffic-gen.txt

diff --git a/Documentation/devicetree/bindings/misc/xlnx,axi-traffic-gen.txt b/Documentation/devicetree/bindings/misc/xlnx,axi-traffic-gen.txt
new file mode 100644
index 0000000..6edb8f6
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/xlnx,axi-traffic-gen.txt
@@ -0,0 +1,25 @@
+* Xilinx AXI Traffic generator IP
+
+Required properties:
+- compatible: "xlnx,axi-traffic-gen"
+- interrupts: Should contain AXI Traffic Generator interrupts.
+- interrupt-parent: Must be core interrupt controller.
+- reg: Should contain AXI Traffic Generator registers location and length.
+- interrupt-names: Should contain both the intr names of device - error
+		   and completion.
+- xlnx,device-id: Device instance Id.
+
+Optional properties:
+- clocks: Input clock specifier. Refer to common clock bindings.
+
+Example:
+++++++++
+axi_traffic_gen_1: axi-traffic-gen@76000000 {
+	compatible = "xlnx,axi-traffic-gen-1.0", "xlnx,axi-traffic-gen";
+	clocks = <&clkc 15>;
+	interrupts = <0 2 2 2>;
+	interrupt-parent = <&axi_intc_1>;
+	interrupt-names = "err-out", "irq-out";
+	reg = <0x76000000 0x800000>;
+	xlnx,device-id = <0x0>;
+} ;
-- 
2.1.1

