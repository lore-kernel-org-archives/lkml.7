Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB604C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 06:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92802215F2
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 06:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfK1Ggt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 01:36:49 -0500
Received: from mail-eopbgr790072.outbound.protection.outlook.com ([40.107.79.72]:38496
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726438AbfK1Ggs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 01:36:48 -0500
Received: from SN6PR02CA0015.namprd02.prod.outlook.com (2603:10b6:805:a2::28)
 by CH2PR02MB7013.namprd02.prod.outlook.com (2603:10b6:610:5c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.20; Thu, 28 Nov
 2019 06:36:44 +0000
Received: from BL2NAM02FT013.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::209) by SN6PR02CA0015.outlook.office365.com
 (2603:10b6:805:a2::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.23 via Frontend
 Transport; Thu, 28 Nov 2019 06:36:44 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.83 as permitted sender)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT013.mail.protection.outlook.com (10.152.77.19) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Thu, 28 Nov 2019 06:36:44 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iaDPv-0007Xh-JM; Wed, 27 Nov 2019 22:36:43 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iaDPq-0005C2-Fl; Wed, 27 Nov 2019 22:36:38 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xAS6abgT004569;
        Wed, 27 Nov 2019 22:36:37 -0800
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iaDPo-00059i-QD; Wed, 27 Nov 2019 22:36:37 -0800
From:   shubhrajyoti.datta@gmail.com
To:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Cc:     gregkh@linuxfoundation.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        shubhrajyoti.datta@gmail.com, devicetree@vger.kernel.org,
        soren.brinkmann@xilinx.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v3 03/10] clk: clock-wizard: Fix kernel-doc warning
Date:   Thu, 28 Nov 2019 12:06:10 +0530
Message-Id: <5f8a1c4fee04db1c01abfba88bec223c1c6b76f5.1574922435.git.shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <cover.1574922435.git.shubhrajyoti.datta@xilinx.com>
References: <cover.1574922435.git.shubhrajyoti.datta@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--1.567-7.0-31-1
X-imss-scan-details: No--1.567-7.0-31-1;No--1.567-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 132193966044023644;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(396003)(39860400002)(189003)(199004)(76176011)(426003)(7696005)(51416003)(446003)(73392003)(26005)(11346002)(316002)(16586007)(336012)(6666004)(356004)(86362001)(9686003)(14444005)(498600001)(82202003)(2906002)(8936002)(8676002)(107886003)(81156014)(81166006)(9786002)(450100002)(4326008)(118296001)(50466002)(50226002)(48376002)(305945005)(4744005)(36756003)(76482006)(5660300002)(70206006)(70586007)(47776003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB7013;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e56264d7-c452-4f3e-7e21-08d773cd55ef
X-MS-TrafficTypeDiagnostic: CH2PR02MB7013:
X-Microsoft-Antispam-PRVS: <CH2PR02MB701357894B0905723926E6CA87470@CH2PR02MB7013.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-Forefront-PRVS: 0235CBE7D0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ApNWUxq46xOV3UN1udrIyJUgnr/bMj7RjjgbyOnzd9EQNa4SrcysTxQT+KgVJM/39IXILafI38niDxbYy3Qtqz7QNetFskO31VbbOT9bw2t7sVJhoiYh57XkaHu73eOaa3YR6cURwSpFf4m0ZBhFrYnB8ZngYFRxFevdtGAwWyBEOEIMuTsFGcP+VZgpAFXvbNVEWkSeLW2O3rl9SUwHlpe8liZ+Tn4tkFhQSEI21D0LUJKDxQ6hGbOY9YHeudU4mDV35zzAAXjWyh+tH7Pq/mSqkEHMoxK/pJay/skL86Y6m9vwYG2Us4vZMJKf87Nn3+lkHrDdwEUn41TjR7qZy9MJxsoSgRsvaBiRmZPzkBQo5UABKQoC5nbtj+FxSDeJ4FB3wP+UR4633MK4jmFKPb/uoE/0g4zSCxq8OnQz/z5tN54E7gLCLH1PIJIKGOEI
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2019 06:36:44.2082
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e56264d7-c452-4f3e-7e21-08d773cd55ef
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB7013
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Update description for the clocking wizard structure

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/clk/clk-xlnx-clock-wizard.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-xlnx-clock-wizard.c b/drivers/clk/clk-xlnx-clock-wizard.c
index 15b7a82..ef9125d 100644
--- a/drivers/clk/clk-xlnx-clock-wizard.c
+++ b/drivers/clk/clk-xlnx-clock-wizard.c
@@ -38,7 +38,8 @@ enum clk_wzrd_int_clks {
 };
 
 /**
- * struct clk_wzrd:
+ * struct clk_wzrd - Clock wizard private data structure
+ *
  * @clk_data:		Clock data
  * @nb:			Notifier block
  * @base:		Memory base
-- 
2.1.1

