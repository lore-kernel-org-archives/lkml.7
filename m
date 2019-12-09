Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B30CC2BD09
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 06:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B0822071E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 06:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfLIGUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 01:20:07 -0500
Received: from mail-bn8nam12on2053.outbound.protection.outlook.com ([40.107.237.53]:14529
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726270AbfLIGUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 01:20:06 -0500
Received: from CY4PR02CA0023.namprd02.prod.outlook.com (2603:10b6:903:18::33)
 by DM6PR02MB4713.namprd02.prod.outlook.com (2603:10b6:5:13::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.22; Mon, 9 Dec
 2019 06:20:04 +0000
Received: from SN1NAM02FT031.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by CY4PR02CA0023.outlook.office365.com
 (2603:10b6:903:18::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.13 via Frontend
 Transport; Mon, 9 Dec 2019 06:20:04 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.83 as permitted sender)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT031.mail.protection.outlook.com (10.152.72.116) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2495.26
 via Frontend Transport; Mon, 9 Dec 2019 06:20:04 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1ieCGg-0004SE-Ql; Sun, 08 Dec 2019 22:11:38 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1ieCGb-0002d4-MK; Sun, 08 Dec 2019 22:11:33 -0800
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xB96BWOM029704;
        Sun, 8 Dec 2019 22:11:32 -0800
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1ieCGa-0002co-9a; Sun, 08 Dec 2019 22:11:32 -0800
From:   shubhrajyoti.datta@gmail.com
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de, michal.simek@xilinx.com,
        robh+dt@kernel.org, shubhrajyoti.datta@gmail.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v2 1/3] dt-bindings: misc: Add dt bindings for traffic generator
Date:   Mon,  9 Dec 2019 11:41:26 +0530
Message-Id: <8b3a446fc60cdd7d085203ce00c3f6bfba642437.1575871828.git.shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--5.340-7.0-31-1
X-imss-scan-details: No--5.340-7.0-31-1;No--5.340-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 132203460042138298;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(39850400004)(396003)(346002)(199004)(189003)(6666004)(356004)(305945005)(107886003)(81156014)(81166006)(8936002)(50226002)(8676002)(70586007)(316002)(70206006)(9686003)(5660300002)(450100002)(82202003)(48376002)(50466002)(9786002)(118296001)(86362001)(2906002)(426003)(498600001)(4326008)(7696005)(73392003)(336012)(76482006)(51416003)(36756003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4713;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b08127a-4f85-4a7f-001a-08d77c6fd453
X-MS-TrafficTypeDiagnostic: DM6PR02MB4713:
X-Microsoft-Antispam-PRVS: <DM6PR02MB4713857BAB0074F84DEFDC1087580@DM6PR02MB4713.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 02462830BE
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wwHHjshntirVcT8JzxppteOw1XoIQK/GmKnzHjA4tW1svffO473niwMNZQtniFoNlStvcPGTq+kFz0wfhD9Ye6+jspNGwjGQrwVpmsTU38cnk4yM5RaEtq1FtPXQVyHXSxxrz+38KCKYYtr37o5zSA+Vi7qvqeiwC05EJbRvu8uBAe5QvRckBiZkjy0Kl4iU4ycUh5zFrjeCduU0NWkGac6+I2jgSS2PuFDNIJHisD6Lsnfc3AF3mrZdzx7H2MnehT2wyZ7PnQqEiNcZ2Pm34TR+1bMOq+oV/HogkVzHsFWaSONo0n1AsCd7WQ7HMdK4XobDVMY8Pn10n6lgjvEMMkMJaY6Chz1vhQGNj8sv0ktMYMZnkRFa9qcIKPXJ5qz3/SBZNPJObrA1ZWZOcSQEFNrEIj3HdekqqQEgXhD0y+pacx3F6xJr2D6hCHuRX9FM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2019 06:20:04.0506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b08127a-4f85-4a7f-001a-08d77c6fd453
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4713
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

