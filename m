Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F500C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 05:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6125F2146E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 05:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392203AbfIZFZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 01:25:40 -0400
Received: from mail-eopbgr800053.outbound.protection.outlook.com ([40.107.80.53]:13952
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731361AbfIZFZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 01:25:39 -0400
Received: from MWHPR0201CA0047.namprd02.prod.outlook.com
 (2603:10b6:301:73::24) by CH2PR02MB6423.namprd02.prod.outlook.com
 (2603:10b6:610:3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.26; Thu, 26 Sep
 2019 05:25:38 +0000
Received: from BL2NAM02FT013.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::204) by MWHPR0201CA0047.outlook.office365.com
 (2603:10b6:301:73::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.23 via Frontend
 Transport; Thu, 26 Sep 2019 05:25:37 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.100)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.100 as permitted sender)
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT013.mail.protection.outlook.com (10.152.77.19) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2284.20
 via Frontend Transport; Thu, 26 Sep 2019 05:25:36 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:46839 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iDMFR-0007cQ-2G; Wed, 25 Sep 2019 22:23:25 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iDMFM-00019a-4M; Wed, 25 Sep 2019 22:23:20 -0700
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x8Q5NJ83008794;
        Wed, 25 Sep 2019 22:23:19 -0700
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iDMFK-00018B-Oi; Wed, 25 Sep 2019 22:23:19 -0700
From:   shubhrajyoti.datta@gmail.com
To:     linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org, michal.simek@xilinx.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [RFC PATCHv3 3/3] Documentation: short descriptions for Flexnoc Performance Monitor driver
Date:   Thu, 26 Sep 2019 10:53:09 +0530
Message-Id:
 <81f9de9559d248be498cac1ee0e3ab15c7a2696c.1569474867.git.shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <2de75a74ef4086090c532d3b80b7d6dcd115e45e.1569474867.git.shubhrajyoti.datta@xilinx.com>
References: <2de75a74ef4086090c532d3b80b7d6dcd115e45e.1569474867.git.shubhrajyoti.datta@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--8.169-7.0-31-1
X-imss-scan-details: No--8.169-7.0-31-1;No--8.169-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 132139491372363672;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(136003)(39860400002)(199004)(189003)(8676002)(50226002)(81156014)(47776003)(8936002)(336012)(316002)(81166006)(426003)(14444005)(11346002)(2361001)(356004)(6666004)(118296001)(9786002)(446003)(16586007)(2906002)(486006)(2351001)(476003)(76176011)(82202003)(126002)(5660300002)(9686003)(4326008)(107886003)(7696005)(36756003)(51416003)(70586007)(6916009)(76482006)(70206006)(48376002)(450100002)(73392003)(26005)(86362001)(498600001)(305945005)(50466002)(42866002)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB6423;H:xsj-pvapsmtpgw02;FPR:;SPF:SoftFail;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9cfda153-003e-486b-b456-08d74241f679
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(5600167)(711020)(4605104)(1401327)(2017052603328);SRVR:CH2PR02MB6423;
X-MS-TrafficTypeDiagnostic: CH2PR02MB6423:
X-Microsoft-Antispam-PRVS: <CH2PR02MB64233A9D7C3778766287A6BE87860@CH2PR02MB6423.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:569;
X-Forefront-PRVS: 0172F0EF77
X-Microsoft-Antispam-Message-Info: QQKUBdZv3sbDakq7DXi4lnGS1+fpieOuGxYf4ENFesopX8bImmN/d2DL2oE8OlNaSMS85hDFZ8VZTx/fuiFiYvyFjPbfsIaRfay8E0lNkoLP3PQvH+05AtbAKrpWG88BQel9jDg5sbQ2h9yjmrd1gW0THqPBnEUMrR+jPfk5mgNeIPqBhte02ZiloiiuooIOnvliYxYWEPMwHwByxJrpn6NNVRUSglp5ieXwXNlD3QXnDcdOJsENz9oRJk8h4RnFdY3yjI0ihOjj8s6QOu5ieM8+pi0faml0BhbT0b5XBXEWY4N1R6oKgfKpH+0FQnmUx8+9OyLZVfqJAWaaare3NnK+U16zOaVqys0acpR3a68KGqBEvAgQgrfJxIRnzdWV3ywmIfvrDrFvwOGvrtzLYEiJZ1gDNO5cCyUqKKKxZ3U=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2019 05:25:36.9301
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cfda153-003e-486b-b456-08d74241f679
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6423
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20190926052309.mD2VfJOSNAWC3XAg3C4AfGRt1AP_wWBeW9pAmh7s22A@z>

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Add short documentation for FlexNoc Performance Monitor driver.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
v2:
patch added

 Documentation/misc-devices/xilinx_flex.txt | 66 ++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/misc-devices/xilinx_flex.txt

diff --git a/Documentation/misc-devices/xilinx_flex.txt b/Documentation/misc-devices/xilinx_flex.txt
new file mode 100644
index 0000000..c075934
--- /dev/null
+++ b/Documentation/misc-devices/xilinx_flex.txt
@@ -0,0 +1,66 @@
+Kernel driver xilinx_flex
+============================
+
+Supported chips:
+Versal SOC
+
+Author:
+	Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
+
+Description
+-----------
+
+Versal uses the Arteris FlexNoC interconnect instead of the ARM NIC. FlexNoC
+provides the capability to integrate performance counters in the interconnect.
+It has configurable probe points to monitor the packet and forwards it to
+observer for logging. It supports read and write transaction counts for
+request and response.
+
+Features:
+---> Run-time programmable selection of packet probe points.
+---> Recording of traffic and link statistics.
+---> Separate read and write response and request count.
+
+SYSFS:
+
+counteridfpd
+	RW - shows the counter number selected for the FPD Flexnoc.
+
+counterfpd_rdreq
+	RO - shows the read request count for the FPD counters.
+
+counterfpdsrc
+	WO - sets the source of the FPD counter.
+
+counterfpd_wrrsp
+	RO - shows the write response count for the FPD counters.
+
+counterfpd_rdrsp
+	RO - shows the read response count for the FPD counters.
+
+counterfpd_wrreq
+	RO - shows the write request count for the FPD counters.
+
+counterfpdport
+	WO - sets the port number selected for the FPD Flexnoc.
+
+counteridlpd
+	RW - shows the counter number selected for the LPD Flexnoc.
+
+counterlpdport
+	WO - sets the port number selected for the LPD Flexnoc.
+
+counterlpd_rdreq
+	RO - shows the read request count for the LPD counters.
+
+counterlpd_wrreq
+	RO - shows the write request count for the LPD counters.
+
+counterlpd_wrrsp
+	RO - shows the write response count for the LPD counters.
+
+counterlpdsrc
+	WO - sets the source of the LPD counter.
+
+counterlpd_rdrsp
+	RO - shows the read response count for the LPD counters.
-- 
2.1.1

