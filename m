Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA01C2D0B1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 05:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7320724677
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 05:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfLFFq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 00:46:57 -0500
Received: from mail-eopbgr760057.outbound.protection.outlook.com ([40.107.76.57]:62791
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726214AbfLFFqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 00:46:54 -0500
Received: from BL0PR02CA0086.namprd02.prod.outlook.com (2603:10b6:208:51::27)
 by CY4PR02MB3288.namprd02.prod.outlook.com (2603:10b6:910:7d::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.22; Fri, 6 Dec
 2019 05:46:51 +0000
Received: from CY1NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::205) by BL0PR02CA0086.outlook.office365.com
 (2603:10b6:208:51::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.13 via Frontend
 Transport; Fri, 6 Dec 2019 05:46:51 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.83 as permitted sender)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT062.mail.protection.outlook.com (10.152.75.60) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Fri, 6 Dec 2019 05:46:51 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1id6Lv-0000Nd-LN; Thu, 05 Dec 2019 21:40:31 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1id6Lq-0004Sm-HD; Thu, 05 Dec 2019 21:40:26 -0800
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xB65ePR1007317;
        Thu, 5 Dec 2019 21:40:25 -0800
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1id6Lp-0003rO-8o; Thu, 05 Dec 2019 21:40:25 -0800
From:   shubhrajyoti.datta@gmail.com
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org, robh+dt@kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v2 3/3] Documentation: short descriptions for Flexnoc Performance Monitor driver
Date:   Fri,  6 Dec 2019 11:09:58 +0530
Message-Id: <b3ff8f0fe3cb758c6b385465ad44580553e011b0.1575609926.git.shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <19bb1ad0783e66aef45b140ccf409917ef94e63b.1575609926.git.shubhrajyoti.datta@xilinx.com>
References: <19bb1ad0783e66aef45b140ccf409917ef94e63b.1575609926.git.shubhrajyoti.datta@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--8.169-7.0-31-1
X-imss-scan-details: No--8.169-7.0-31-1;No--8.169-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 132200848112472141;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39860400002)(136003)(189003)(199004)(450100002)(305945005)(81166006)(426003)(50226002)(336012)(118296001)(48376002)(73392003)(8676002)(36756003)(5660300002)(70206006)(70586007)(16586007)(81156014)(50466002)(82202003)(14444005)(8936002)(316002)(76482006)(2906002)(86362001)(11346002)(7696005)(51416003)(9686003)(356004)(76176011)(6666004)(26005)(4326008)(107886003)(9786002)(498600001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR02MB3288;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b43dfab-04b0-4720-e5bd-08d77a0fb135
X-MS-TrafficTypeDiagnostic: CY4PR02MB3288:
X-Microsoft-Antispam-PRVS: <CY4PR02MB3288B73AB272C9D8A593C312875F0@CY4PR02MB3288.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:569;
X-Forefront-PRVS: 0243E5FD68
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BcS8DySAQA1wuhzJLAfnhnSwevorsgfNTmK6tpjlXxPWTusKhCuZX/DcwB77jFAYGekk80dFZvwYbWtAd7DGVyAbrzlM38hbuzJQjODVrw9dMaLvSkF+iu1lPwIEtflrkKtkFM5zYMP1TFM0rL6rgS1CqTL8f0n7e6yHz4BgYIE+x+chQSpfOKSWoBN5YxHo8JBIZkHq+p0LxQ9y8CcNj2FZFxpKisZppKN42/2fYDn0rGjMaY01eZZVSVjVVWrPlP+eTbqSOVxUxlENPDRzUSq59GSSznR6rgj7LmwtWB978K0vbmRey9tQ6F/JHBnflmi6nBc5hVQqjHLpD3nfORx32VlWI3Fif2IB6EEH/YFQmHR2wZeH/te9c4v/86DrubUS83Cdptcis38fSo6KvXuc81jM7EMfLhJuqRV3wRi9K7gOt3QXqDm1JXr6UB6O
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2019 05:46:51.0690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b43dfab-04b0-4720-e5bd-08d77a0fb135
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB3288
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Add short documentation for FlexNoc Performance Monitor driver.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
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

