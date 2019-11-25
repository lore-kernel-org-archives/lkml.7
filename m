Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC4FC432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 11:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 144602068E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 11:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfKYLAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 06:00:17 -0500
Received: from mail-eopbgr740081.outbound.protection.outlook.com ([40.107.74.81]:3776
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727278AbfKYLAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 06:00:16 -0500
Received: from BN7PR02CA0023.namprd02.prod.outlook.com (2603:10b6:408:20::36)
 by BN7PR02MB5012.namprd02.prod.outlook.com (2603:10b6:408:22::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17; Mon, 25 Nov
 2019 11:00:10 +0000
Received: from SN1NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by BN7PR02CA0023.outlook.office365.com
 (2603:10b6:408:20::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17 via Frontend
 Transport; Mon, 25 Nov 2019 11:00:10 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.83 as permitted sender)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT064.mail.protection.outlook.com (10.152.72.143) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Mon, 25 Nov 2019 11:00:10 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iZC2v-00077Q-NL; Mon, 25 Nov 2019 02:56:45 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iZC2q-0000m2-CY; Mon, 25 Nov 2019 02:56:40 -0800
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xAPAudeD025781;
        Mon, 25 Nov 2019 02:56:39 -0800
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iZC2p-0000fS-Ae; Mon, 25 Nov 2019 02:56:39 -0800
From:   shubhrajyoti.datta@gmail.com
To:     linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        corbet@lwn.net, gregkh@linuxfoundation.org, arnd@arndb.de,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH 3/3] Documentation: short descriptions for Flexnoc Performance Monitor driver
Date:   Mon, 25 Nov 2019 16:25:52 +0530
Message-Id: <1574679352-2989-3-git-send-email-shubhrajyoti.datta@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1574679352-2989-1-git-send-email-shubhrajyoti.datta@gmail.com>
References: <1574679352-2989-1-git-send-email-shubhrajyoti.datta@gmail.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--8.169-7.0-31-1
X-imss-scan-details: No--8.169-7.0-31-1;No--8.169-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 132191532101927929;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39860400002)(136003)(189003)(199004)(76482006)(107886003)(4326008)(73392003)(450100002)(26005)(11346002)(36756003)(2616005)(446003)(336012)(426003)(2361001)(81166006)(47776003)(50226002)(82202003)(2351001)(8676002)(9686003)(61266001)(81156014)(70206006)(498600001)(48376002)(55446002)(50466002)(9786002)(2906002)(356004)(305945005)(16586007)(5660300002)(316002)(6916009)(51416003)(76176011)(8936002)(70586007)(14444005)(6666004)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR02MB5012;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b114997a-bccc-4707-6139-08d77196a3af
X-MS-TrafficTypeDiagnostic: BN7PR02MB5012:
X-Microsoft-Antispam-PRVS: <BN7PR02MB5012EF291861E705225B2C52874A0@BN7PR02MB5012.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:569;
X-Forefront-PRVS: 0232B30BBC
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tAyeaUfSO9mPat3akCuJ6JM8UeV9q0YOkCDnYEnYbC5vEoviwshxYkssfqgZ+1OjJGzqFMpAB5ZdF5XyU1ntMT9LPh8Uh/1IHmHMvoHeZAb9/NqOSOlkbkKv9ZXR2jmYjzdwIfKCCT0LkFjPsnja6ojwTw+xzlzP0VX59EX7G7yRXF3lqNb2W24ZapBvjj9X79mj+i9spxNtd5yGh4upDFAwAkvdRbXFazigoBX9AaEaf2ZWxrI2wqmliLeu13A5M1pfrR4bVjxxNYtLODRDxy1Sl9e1kzO7Zja0i5hB9mn5VVIYK8vZC5OHK1eV5BHHCcVvoHgwusOGCwM37q0gJ4JOhmInkzGciWu7OKjDj5FQz+l6cvijtYb+mOyH39NMdbbVjz9hO4C71jS7dQ8Tg38PRtEBKfG7IV+0sLGUmIdfs6qgoZb3aHnB4sT32Lgr
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2019 11:00:10.0296
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b114997a-bccc-4707-6139-08d77196a3af
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5012
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

