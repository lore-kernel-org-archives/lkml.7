Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08254C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 05:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D938920721
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 05:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfLIFxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 00:53:36 -0500
Received: from mail-dm6nam12on2048.outbound.protection.outlook.com ([40.107.243.48]:6099
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726038AbfLIFxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 00:53:36 -0500
Received: from DM6PR02CA0055.namprd02.prod.outlook.com (2603:10b6:5:177::32)
 by MN2PR02MB6255.namprd02.prod.outlook.com (2603:10b6:208:1b9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.12; Mon, 9 Dec
 2019 05:53:33 +0000
Received: from SN1NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by DM6PR02CA0055.outlook.office365.com
 (2603:10b6:5:177::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.14 via Frontend
 Transport; Mon, 9 Dec 2019 05:53:33 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.83 as permitted sender)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT032.mail.protection.outlook.com (10.152.72.126) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2495.26
 via Frontend Transport; Mon, 9 Dec 2019 05:53:33 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1ieBzB-0004Ml-2w; Sun, 08 Dec 2019 21:53:33 -0800
Received: from localhost ([127.0.0.1] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1ieBz5-00010W-VC; Sun, 08 Dec 2019 21:53:28 -0800
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1ieBz5-0000yR-79; Sun, 08 Dec 2019 21:53:27 -0800
From:   shubhrajyoti.datta@gmail.com
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de, michal.simek@xilinx.com,
        robh+dt@kernel.org, shubhrajyoti.datta@gmail.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH 1/3] dt-bindings: misc: Add dt bindings for traffic generator
Date:   Mon,  9 Dec 2019 11:23:18 +0530
Message-Id: <1575870800-7369-1-git-send-email-shubhrajyoti.datta@gmail.com>
X-Mailer: git-send-email 2.1.1
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--5.340-7.0-31-1
X-imss-scan-details: No--5.340-7.0-31-1;No--5.340-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 132203444136109666;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(396003)(39860400002)(189003)(199004)(70206006)(82202003)(73392003)(70586007)(81166006)(76482006)(2616005)(2906002)(26005)(5660300002)(336012)(48376002)(426003)(50466002)(86362001)(81156014)(8936002)(8676002)(316002)(498600001)(6666004)(51416003)(55446002)(4326008)(50226002)(450100002)(107886003)(305945005)(356004)(36756003)(9786002)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR02MB6255;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc5ebbfc-1249-40d9-b086-08d77c6c2040
X-MS-TrafficTypeDiagnostic: MN2PR02MB6255:
X-Microsoft-Antispam-PRVS: <MN2PR02MB6255864F593CF8FBFB78315A87580@MN2PR02MB6255.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 02462830BE
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D2HoYpjhVmfDo+nXsOPBHGdBA7Xm4E/x3za5ZLkf3h/FZM797GSMFNCkaWTgATz37WqRZAasBu536ZugSQqu3ReRYyMyqDi4Hfugcy/8BHGjvr+/qNmclEHXBSaJtpckAWYYDLbI5uDUdGH33bW949eLlEbiFVZjh9Avzbnhq3Xh2l2k0Gyp1ES8EVXiAl3P06UDEgzeNWaE+aBXfpCRC1WiWgCYIHrdmvMi5Ag4LCK5A9zuZ8Pr4mtn6gKzmMvGGGiFQFJrl0szNVOmZOKpvGz+A+fELq9nczrN1Tcef7S6Zf5rmsgBqHsqBDq1YQcHOuae3Rlsld5GSrWGxxMwyC0g8s4BjSlSiVUFBsEJcimwefAE4IUz4LbPEtT46Ppy9QXZHl66J+yhzSx+bu0Pp/bt3PDovl8S7PEJz0yM2V5qDfZHNMFPjJhIBzjhDLWO
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2019 05:53:33.4506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc5ebbfc-1249-40d9-b086-08d77c6c2040
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6255
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

