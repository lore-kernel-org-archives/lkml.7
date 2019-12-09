Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B285C04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1A0206E0
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfLIOZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 09:25:07 -0500
Received: from mail-eopbgr770077.outbound.protection.outlook.com ([40.107.77.77]:49230
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727359AbfLIOZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 09:25:07 -0500
Received: from SN4PR0201CA0020.namprd02.prod.outlook.com
 (2603:10b6:803:2b::30) by BN6PR02MB2482.namprd02.prod.outlook.com
 (2603:10b6:404:55::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.12; Mon, 9 Dec
 2019 14:25:05 +0000
Received: from SN1NAM02FT063.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by SN4PR0201CA0020.outlook.office365.com
 (2603:10b6:803:2b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.12 via Frontend
 Transport; Mon, 9 Dec 2019 14:25:05 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.83 as permitted sender)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT063.mail.protection.outlook.com (10.152.72.213) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2495.26
 via Frontend Transport; Mon, 9 Dec 2019 14:25:05 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1ieJwo-0007qK-FV; Mon, 09 Dec 2019 06:23:38 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1ieJwj-0006oW-B1; Mon, 09 Dec 2019 06:23:33 -0800
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xB9ENWdJ017866;
        Mon, 9 Dec 2019 06:23:32 -0800
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1ieJwi-0006nz-2F; Mon, 09 Dec 2019 06:23:32 -0800
From:   shubhrajyoti.datta@gmail.com
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     michal.simek@xilinx.com, gregkh@linuxfoundation.org,
        robh+dt@kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v2 2/2] devicetree: bindings: Add the binding doc for xilinx APM
Date:   Mon,  9 Dec 2019 19:53:25 +0530
Message-Id: <1575901405-3084-2-git-send-email-shubhrajyoti.datta@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1575901405-3084-1-git-send-email-shubhrajyoti.datta@gmail.com>
References: <1575901405-3084-1-git-send-email-shubhrajyoti.datta@gmail.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--6.273-7.0-31-1
X-imss-scan-details: No--6.273-7.0-31-1;No--6.273-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 132203751052549827;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(39860400002)(136003)(189003)(199004)(9686003)(107886003)(81156014)(82202003)(4326008)(8936002)(86362001)(81166006)(70586007)(70206006)(8676002)(450100002)(316002)(2906002)(55446002)(36756003)(6666004)(356004)(498600001)(26005)(305945005)(9786002)(76482006)(2616005)(73392003)(336012)(5660300002)(426003)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB2482;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f39353d-0110-4d57-7c11-08d77cb395e5
X-MS-TrafficTypeDiagnostic: BN6PR02MB2482:
X-Microsoft-Antispam-PRVS: <BN6PR02MB248243FD0D3BFD1E278061CC87580@BN6PR02MB2482.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 02462830BE
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ko+LpF7lVln+qf+9OCdrEQb8bT729BaPUuevIqd2Q6P7Y//d5dAXKO1dFbMjFJZTn0jHNVxK1ex4g6Hgymb/ttq8OA5SdVFBQuGbv5cW3cZaocrFHd5+wKkc3hzq8OtJEB1VuSgwNHX5clqEp51CH1PgBeRvNSHZsDi84lC5RnJ4LVsnihirsSvtKOFxl5kL47HqGeW/xanPKNaXSJulw51lVGjvqp4rq+VXmEY6FF1aSC06bhV9CBdnMqwsFVOceRmGxYul36Gj7vPo/V5JfwkaQfEsVjP8VXbkymw+ES9U+4uijv+vtftK4ey3dWxuFwkOqNq8k2p4VY2o7FP+UCEt3wrc3D4VSvNhWEdSQdGR6PDITEi2t8bcwtaWOqbw9i3X/ZLvh5XnRDEEMpBwYl8YXtE3Ca9FcGcGghsYLgzdYTWa7OYsKGUFbsafy48sPJIeYMm1qinVOtwzGpV7vnoBlQyKy/BwUsxK5wSum+0Y2Iw4OmkRoZACta9cZm5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2019 14:25:05.0928
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f39353d-0110-4d57-7c11-08d77cb395e5
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2482
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Add the devicetree binding for xilinx APM.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
v2:
patch added

 .../devicetree/bindings/perf/xilinx_apm.txt        | 44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/xilinx_apm.txt

diff --git a/Documentation/devicetree/bindings/perf/xilinx_apm.txt b/Documentation/devicetree/bindings/perf/xilinx_apm.txt
new file mode 100644
index 0000000..a11c82e
--- /dev/null
+++ b/Documentation/devicetree/bindings/perf/xilinx_apm.txt
@@ -0,0 +1,44 @@
+* Xilinx AXI Performance monitor IP
+
+Required properties:
+- compatible: "xlnx,axi-perf-monitor"
+- interrupts: Should contain APM interrupts.
+- interrupt-parent: Must be core interrupt controller.
+- reg: Should contain APM registers location and length.
+- xlnx,enable-profile: Enables the profile mode.
+- xlnx,enable-trace: Enables trace mode.
+- xlnx,num-monitor-slots: Maximum number of slots in APM.
+- xlnx,enable-event-count: Enable event count.
+- xlnx,enable-event-log: Enable event logging.
+- xlnx,have-sampled-metric-cnt:Sampled metric counters enabled in APM.
+- xlnx,num-of-counters: Number of counters in APM
+- xlnx,metric-count-width: Metric Counter width (32/64)
+- xlnx,metrics-sample-count-width: Sampled metric counter width
+- xlnx,global-count-width: Global Clock counter width
+- clocks: Input clock specifier.
+
+Optional properties:
+- xlnx,id-filter-32bit: APM is in 32-bit mode
+
+Example:
+++++++++
+
+apm: apm@44a00000 {
+    compatible = "xlnx,axi-perf-monitor";
+    interrupt-parent = <&axi_intc_1>;
+    interrupts = <1 2>;
+    reg = <0x44a00000 0x1000>;
+    clocks = <&clkc 15>;
+    xlnx,enable-profile = <0>;
+    xlnx,enable-trace = <0>;
+    xlnx,num-monitor-slots = <4>;
+    xlnx,enable-event-count = <1>;
+    xlnx,enable-event-log = <1>;
+    xlnx,have-sampled-metric-cnt = <1>;
+    xlnx,num-of-counters = <8>;
+    xlnx,metric-count-width = <32>;
+    xlnx,metrics-sample-count-width = <32>;
+    xlnx,global-count-width = <32>;
+    xlnx,metric-count-scale = <1>;
+    xlnx,id-filter-32bit;
+};
-- 
2.1.1

