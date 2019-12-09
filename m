Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5793C2BD09
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 06:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D32206E0
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 06:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfLIGFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 01:05:14 -0500
Received: from mail-bn8nam12on2054.outbound.protection.outlook.com ([40.107.237.54]:6270
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727060AbfLIGFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 01:05:14 -0500
Received: from BN6PR02CA0048.namprd02.prod.outlook.com (2603:10b6:404:5f::34)
 by DM6PR02MB6495.namprd02.prod.outlook.com (2603:10b6:5:20b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.14; Mon, 9 Dec
 2019 06:05:11 +0000
Received: from BL2NAM02FT046.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by BN6PR02CA0048.outlook.office365.com
 (2603:10b6:404:5f::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.14 via Frontend
 Transport; Mon, 9 Dec 2019 06:05:11 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.83 as permitted sender)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT046.mail.protection.outlook.com (10.152.76.118) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2495.26
 via Frontend Transport; Mon, 9 Dec 2019 06:05:10 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1ieC1s-0004Nm-DJ; Sun, 08 Dec 2019 21:56:20 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1ieC1m-0002E6-PR; Sun, 08 Dec 2019 21:56:14 -0800
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xB95uDeQ024455;
        Sun, 8 Dec 2019 21:56:13 -0800
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1ieC1k-00027p-Ve; Sun, 08 Dec 2019 21:56:13 -0800
From:   shubhrajyoti.datta@gmail.com
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de, michal.simek@xilinx.com,
        robh+dt@kernel.org, shubhrajyoti.datta@gmail.com, git@xilinx.com,
        Kedareswara rao Appana <appana.durga.rao@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH 3/3] trafgen: Document sysfs entries
Date:   Mon,  9 Dec 2019 11:25:59 +0530
Message-Id: <1575870959-11703-3-git-send-email-shubhrajyoti.datta@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1575870959-11703-1-git-send-email-shubhrajyoti.datta@gmail.com>
References: <1575870959-11703-1-git-send-email-shubhrajyoti.datta@gmail.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No-1.037-7.0-31-1
X-imss-scan-details: No-1.037-7.0-31-1;No-1.037-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 132203451111137312;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(376002)(346002)(189003)(199004)(2616005)(107886003)(356004)(9686003)(26005)(6666004)(426003)(54906003)(2906002)(36756003)(76176011)(51416003)(336012)(73392003)(450100002)(4326008)(76482006)(966005)(498600001)(70206006)(70586007)(82202003)(81156014)(8936002)(50226002)(81166006)(305945005)(5660300002)(9786002)(48376002)(55446002)(50466002)(86362001)(8676002)(316002)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB6495;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 678e9e9e-aa3b-4353-fdb0-08d77c6dbffb
X-MS-TrafficTypeDiagnostic: DM6PR02MB6495:
X-Microsoft-Antispam-PRVS: <DM6PR02MB6495534E4E315FE43EF4DB4087580@DM6PR02MB6495.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 02462830BE
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9g6peM8P4y0PiDszL4sGH9cftCqVDXJfBhuGSJEiQut7s+T8ncIQ6bUM5bTbE/pKkyKFNs+neb3V8YUnumJbhSyyMxP4wSRKTF/5Gbp8j63n6X5ni/DnkA9+ZjH/l6q656FEDSmWvldO7BSXPh3iEBWqu2cia1XvaudqewxDMTcwcnAjawFD/DetlPme6WdQbZn06u3Zh51VKNr5v4fRtzrwXCdh64pRnkSofX5gdtRlCDjxFFLsdtYYFyc5VaeQIVeArg0QRehuPWtZtf6SHddDgWTFg42Q6k163xCbmfA3ib96EuLYvIZIoT6m7p6Ml2h3NYxnX/Rh4BW1cAuop3RBd8/hJPCe4T7ZFZaTSiZ//mK80lEa7PgVKDS1MOEMGhM2Y2rRWZGPGZsmh0nJGziJlwYA7+d1l2o3jDdwo8khbgc0DMYPCVUyO9iu+/vwy6hwRHvx/+G/szjmWbn9Ca3b/Nt7SzuUezk38uVvX71I/igshHVA9DgWLuI7shRlCRoBwK1RG6H903iwPKr3cQ==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2019 06:05:10.8044
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 678e9e9e-aa3b-4353-fdb0-08d77c6dbffb
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6495
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kedareswara rao Appana <appana.durga.rao@xilinx.com>

This patch adds the documentaion for the sysfs entries in the driver.

Signed-off-by: Kedareswara rao Appana <appana.durga.rao@xilinx.com>
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 Documentation/misc-devices/xilinx_trafgen.txt | 97 +++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 Documentation/misc-devices/xilinx_trafgen.txt

diff --git a/Documentation/misc-devices/xilinx_trafgen.txt b/Documentation/misc-devices/xilinx_trafgen.txt
new file mode 100644
index 0000000..dadcdad
--- /dev/null
+++ b/Documentation/misc-devices/xilinx_trafgen.txt
@@ -0,0 +1,97 @@
+Kernel driver xilinx_trafgen
+============================
+
+Supported chips:
+Zynq SOC, Xilinx 7 series fpga's (Virtex,Kintex,Artix)
+
+Data Sheet:
+	http://www.xilinx.com/support/documentation/ip_documentation/axi_traffic_gen/v2_0/pg125-axi-traffic-gen.pdf
+
+Author:
+        Kedareswara Rao Appana <appanad@xilinx.com>
+
+Description
+-----------
+
+AXI Traffic Generator IP is a core that stresses the AXI4 interconnect and other
+AXI4 peripherals in the system. It generates a wide variety of AXI4 transactions
+based on the core programming.
+
+Features:
+---> Configurable option to generate and accept data according to different
+traffic profiles.
+---> Supports dependent/independent transaction between read/write master port
+with configurable delays.
+---> Programmable repeat count for each transaction with
+constant/increment/random address.
+---> External start/stop to generate traffic without processor intervention.
+---> Generates IP-specific traffic on AXI interface for pre-defined protocols.
+
+SYSFS:
+
+id
+	RO - shows the trafgen id.
+
+resource
+	RO - shows the baseaddress for the trafgen.
+
+master_start_stop
+	RW - monitors the master start logic.
+
+config_slave_status
+	RW - configure and monitors the slave status.
+
+err_sts
+	RW - get the error statistics/clear the errors.
+
+err_en
+	WO - enable the errors.
+
+intr_en
+	WO - enable the interrupts.
+
+last_valid_index
+	RW - gets the last valid index value.
+
+config_sts_show
+	RO - show the config status value.
+
+mram_clear
+	WO - clears the master ram.
+
+cram_clear
+	WO - clears the command ram.
+
+pram_clear
+	WO - clears the parameter ram.
+
+static_enable
+	RO - enables the static mode.
+
+static_burst_len
+	RW - gets/sets the static burst length.
+
+static_transferdone
+	RW - monitors the static transfer done status.
+
+reset_static_transferdone
+	RO - resets the static transferdone bit.
+
+stream_cfg
+	RW - sets the stream configuration parameters like delay.
+
+stream_tktsn
+	RW - TSTRB/TKEEP value for the last beat of the
+transfer set n. N can be 1 to 4.
+
+stream_enable
+	RO - enables the streaming mode.
+
+stream_transferlen
+	RW - get/set the streaming mode transfer length.
+
+stream_transfercnt
+	RW - get/set the streaming mode transfer count.
+
+loop_enable
+	RW - get/set loop enable value.
-- 
2.1.1

