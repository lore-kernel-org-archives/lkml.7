Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6E0C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 05:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D011222C3
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 05:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392240AbfIZFZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 01:25:42 -0400
Received: from mail-eopbgr740081.outbound.protection.outlook.com ([40.107.74.81]:54448
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392201AbfIZFZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 01:25:41 -0400
Received: from BN6PR02CA0036.namprd02.prod.outlook.com (2603:10b6:404:5f::22)
 by DM6PR02MB6426.namprd02.prod.outlook.com (2603:10b6:5:1d6::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.20; Thu, 26 Sep
 2019 05:25:39 +0000
Received: from SN1NAM02FT024.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by BN6PR02CA0036.outlook.office365.com
 (2603:10b6:404:5f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2284.20 via Frontend
 Transport; Thu, 26 Sep 2019 05:25:39 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.83 as permitted sender)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT024.mail.protection.outlook.com (10.152.72.127) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2284.25
 via Frontend Transport; Thu, 26 Sep 2019 05:25:38 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iDMFL-00067x-3j; Wed, 25 Sep 2019 22:23:19 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iDMFF-00018V-Vj; Wed, 25 Sep 2019 22:23:14 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x8Q5ND41008768;
        Wed, 25 Sep 2019 22:23:13 -0700
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iDMFE-00018B-Hr; Wed, 25 Sep 2019 22:23:12 -0700
From:   shubhrajyoti.datta@gmail.com
To:     linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org, michal.simek@xilinx.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [RFC PATCHv3 1/3] dt-bindings: misc: Add dt bindings for flex noc Performance Monitor
Date:   Thu, 26 Sep 2019 10:53:07 +0530
Message-Id:
 <2de75a74ef4086090c532d3b80b7d6dcd115e45e.1569474867.git.shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--4.954-7.0-31-1
X-imss-scan-details: No--4.954-7.0-31-1;No--4.954-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 132139491389450880;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(376002)(346002)(189003)(199004)(81166006)(8936002)(107886003)(8676002)(81156014)(2351001)(73392003)(486006)(4326008)(76482006)(450100002)(126002)(7696005)(118296001)(51416003)(476003)(47776003)(316002)(26005)(16586007)(336012)(6916009)(9686003)(9786002)(86362001)(2361001)(50226002)(305945005)(5660300002)(356004)(6666004)(36756003)(50466002)(2906002)(498600001)(82202003)(48376002)(70206006)(70586007)(426003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB6426;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 415f2439-e005-482c-4951-08d74241f773
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(5600167)(711020)(4605104)(1401327)(2017052603328);SRVR:DM6PR02MB6426;
X-MS-TrafficTypeDiagnostic: DM6PR02MB6426:
X-Microsoft-Antispam-PRVS: <DM6PR02MB6426FF4CFC2876FFCE120B7F87860@DM6PR02MB6426.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0172F0EF77
X-Microsoft-Antispam-Message-Info: tPFq0WVoLnWFcplSRKIIsXo5JSmRUK+AIf9HllAcvDfgEzZXJCqkM2SxfxzfWZCpLIV+JCMPD1BnVAqUv1fLrtQ50/mj9w1KhnXHI3CuBkDFHqXdkq08rTnIAHFiVN1V99SnJzAFHwlU5iFljKJbBKI0+PB0qqkJymo88/dNbTtg4R8WLFPLARUNqTfOkM+0knYPlvCXq1sHNOeHdVq4p6grtE9mVqAoz71lqXlQMDH2GMjMvObf6SMVl4tF4GpqP52KjWrHt6MokuFKcVawfYkXOE3ioWNXW9CQ3XHr+Wo130Rt3T34xkRu1i2bI0zbnV0lVPr6vMHYUVOntOY/FV0kZ6+ZRoC1ksd+b1tOYdHhimZ7pstyXNhsn47CJBaOk2nW6hOjjeDsUySnl2f6aYrNxCH3AnDdYAsfqkE/+k0=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2019 05:25:38.6938
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 415f2439-e005-482c-4951-08d74241f773
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6426
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20190926052307.7ZgA9MG-q-FDwjEGO9_ixOzHkZpoy_c6CdAszfSvLTc@z>

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Add dt bindings for flexnoc Performance Monitor.
The flexnoc counters for read and write response and requests are
supported.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 .../devicetree/bindings/misc/xlnx,flexnoc.txt      | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/xlnx,flexnoc.txt

diff --git a/Documentation/devicetree/bindings/misc/xlnx,flexnoc.txt b/Documentation/devicetree/bindings/misc/xlnx,flexnoc.txt
new file mode 100644
index 0000000..6b533bc
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/xlnx,flexnoc.txt
@@ -0,0 +1,24 @@
+* Xilinx Flexnoc Performance Monitor driver
+
+The FlexNoc Performance Monitor has counters for monitoring
+the read and the write transaction counter.
+
+Required properties:
+- compatible: "xlnx,flexnoc-pm-2.7"
+- reg : Address and length of register sets for each device in
+	"reg-names"
+- reg-names : The names of the register addresses corresponding to the
+		registers filled in "reg"
+		- funnel: base address of the funnel registers
+		- baselpd: base address of the LPD PM registers
+		- basefpd: base address FPD PM registers
+
+Example:
+++++++++
+performance-monitor@f0920000 {
+		compatible = "xlnx,flexnoc-pm-2.7";
+		reg-names = "funnel", "baselpd", "basefpd";
+		reg = <0x0 0xf0920000 0x0 0x1000>,
+			<0x0 0xf0980000 0x0 0x9000>,
+			<0x0 0xf0b80000 0x0 0x9000>;
+};
-- 
2.1.1

