Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB5FC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 06:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D9332071E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 06:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfLIGUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 01:20:14 -0500
Received: from mail-eopbgr760048.outbound.protection.outlook.com ([40.107.76.48]:3934
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726270AbfLIGUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 01:20:10 -0500
Received: from MWHPR02CA0021.namprd02.prod.outlook.com (2603:10b6:300:4b::31)
 by BN6PR02MB2754.namprd02.prod.outlook.com (2603:10b6:404:fe::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.17; Mon, 9 Dec
 2019 06:20:06 +0000
Received: from SN1NAM02FT044.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::203) by MWHPR02CA0021.outlook.office365.com
 (2603:10b6:300:4b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.14 via Frontend
 Transport; Mon, 9 Dec 2019 06:20:06 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.83 as permitted sender)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT044.mail.protection.outlook.com (10.152.72.173) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2495.26
 via Frontend Transport; Mon, 9 Dec 2019 06:20:06 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1ieCGq-0004SM-Pw; Sun, 08 Dec 2019 22:11:48 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1ieCGl-0002eo-Ks; Sun, 08 Dec 2019 22:11:43 -0800
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xB96BfbU029825;
        Sun, 8 Dec 2019 22:11:42 -0800
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1ieCGj-0002co-CA; Sun, 08 Dec 2019 22:11:41 -0800
From:   shubhrajyoti.datta@gmail.com
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de, michal.simek@xilinx.com,
        robh+dt@kernel.org, shubhrajyoti.datta@gmail.com,
        Kedareswara rao Appana <appana.durga.rao@xilinx.com>,
        Kedareswara rao Appana <appanad@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v2 3/3] trafgen: Document sysfs entries
Date:   Mon,  9 Dec 2019 11:41:28 +0530
Message-Id: <d8921f9b2406a276cc5064725aa28eb2757f923b.1575871828.git.shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <8b3a446fc60cdd7d085203ce00c3f6bfba642437.1575871828.git.shubhrajyoti.datta@xilinx.com>
References: <8b3a446fc60cdd7d085203ce00c3f6bfba642437.1575871828.git.shubhrajyoti.datta@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No-1.037-7.0-31-1
X-imss-scan-details: No-1.037-7.0-31-1;No-1.037-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 132203460065069038;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(39860400002)(376002)(189003)(199004)(305945005)(76482006)(70586007)(450100002)(7696005)(2906002)(4326008)(51416003)(966005)(8676002)(81166006)(107886003)(498600001)(70206006)(81156014)(76176011)(316002)(426003)(8936002)(336012)(36756003)(26005)(86362001)(54906003)(50226002)(118296001)(50466002)(9786002)(5660300002)(9686003)(6666004)(73392003)(356004)(48376002)(82202003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB2754;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 382b3af5-3478-4579-e537-08d77c6fd5b0
X-MS-TrafficTypeDiagnostic: BN6PR02MB2754:
X-Microsoft-Antispam-PRVS: <BN6PR02MB2754E768B44DC42DDFEEBC5B87580@BN6PR02MB2754.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 02462830BE
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WLNSK7IruUD3lrUf277wXroBm/F7WYHgez/CS11nBM5FCieAjK3ZD8OfniiaDKSHGQQtI6BqVSHFlm4/ks4oSV8bHQIdVGGg6osYBP4YSvmyWyWfYToshSdMtb07Sm2NoiT+4EewW0woixlu415jBQNMOGDVVfNTJxAx3cCZJt9443Sg7rlQ/B9at2niSrPR8BqGmLVqLB/b+jHzJRofM5J3Tc9YoGc0G0L69XMB+cdO4nWFiCbRIbwiUlVAH7zJrz9Psk83mkpLO+jdjn0hdGqjB9Dlzmn3xNAALduP8PPo/leHy76W9sLUawaLND4Z4XLiW92fjefto0pexbvicQ5tVdMWDSXhjQ+Q34XvnxQeIyFsmxGDUtUd/rFuCSyzZ8yUMo0Up57KNSrXcyEjNqx1+/xXXgk4is45E3o1KSBGPlVoRbZy6gILUgde1/qvpJ2K6nP+V964jgex8snscbSUhHwQ/wqDQLOegOXHvM4=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2019 06:20:06.3089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 382b3af5-3478-4579-e537-08d77c6fd5b0
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2754
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kedareswara rao Appana <appana.durga.rao@xilinx.com>

This patch adds the documentaion for the sysfs entries in the driver.

Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
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

