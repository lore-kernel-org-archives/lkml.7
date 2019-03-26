Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669B7C10F05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3620120866
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="cPC9bU9i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730587AbfCZKPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 06:15:22 -0400
Received: from mail-eopbgr820074.outbound.protection.outlook.com ([40.107.82.74]:10624
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726302AbfCZKPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 06:15:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2iwUTOOQ9y0NzvntoObphi6OLDUNjH9/dS3RVNr/Dg=;
 b=cPC9bU9ipZcVpUlhv6rFbzvUtVoIefTRphMqO+CKwG2FF0BqtxnnDpUbUbkMxoRGP2AGSYQqsB9TIN6n9xDoIECgFySpyIhNIP/U0eJKEWDDbI+2rPJeZ1zm5ZEVCvoea0HdNcKQyHh/ze3V6eYMr0WVaZWBdkzGhDiZFy+ZSBs=
Received: from BL0PR03CA0023.namprd03.prod.outlook.com (20.177.146.100) by
 BN3PR03MB2258.namprd03.prod.outlook.com (10.167.4.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Tue, 26 Mar 2019 10:15:19 +0000
Received: from CY1NAM02FT035.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::205) by BL0PR03CA0023.outlook.office365.com
 (2603:10b6:208:2d::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1730.16 via Frontend
 Transport; Tue, 26 Mar 2019 10:15:19 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; davemloft.net; dkim=none (message not signed)
 header.d=none;davemloft.net; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT035.mail.protection.outlook.com (10.152.75.186) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1750.11
 via Frontend Transport; Tue, 26 Mar 2019 10:15:18 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x2QAFGud021904
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 26 Mar 2019 03:15:16 -0700
Received: from linux.ad.analog.com (10.32.224.122) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Tue, 26 Mar 2019 06:15:16 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <davem@davemloft.net>,
        <mchehab+samsung@kernel.org>, <gregkh@linuxfoundation.org>,
        <robh@kernel.org>, <joe@perches.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Stefan Popa <stefan.popa@analog.com>
Subject: [PATCH] MAINTAINERS: Fix the link to ad7606 dt-bindings
Date:   Tue, 26 Mar 2019 12:14:57 +0200
Message-ID: <1553595297-30806-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(39860400002)(396003)(2980300002)(189003)(199004)(16586007)(8936002)(2906002)(47776003)(14444005)(51416003)(2351001)(106466001)(44832011)(106002)(126002)(426003)(2616005)(6306002)(476003)(336012)(48376002)(7696005)(54906003)(36756003)(316002)(77096007)(50466002)(26005)(8676002)(4744005)(966005)(72206003)(478600001)(6916009)(246002)(186003)(486006)(305945005)(4326008)(107886003)(7636002)(6666004)(356004)(50226002)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR03MB2258;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fd758f9-2b86-4f91-266e-08d6b1d3f2b1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4709054)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:BN3PR03MB2258;
X-MS-TrafficTypeDiagnostic: BN3PR03MB2258:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <BN3PR03MB225867D50B78E6A62885C1EE9D5F0@BN3PR03MB2258.namprd03.prod.outlook.com>
X-Forefront-PRVS: 09888BC01D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: Khbreyg7BqltEMOIW7QPh1i8KeV/1HRsb3kB7asuFlEyBV2R/Ml5QwEYEnUa7z5UZuaXSGrQvd8KPeBTMKrV/C1ami8ac1ck/sfTUNM8m/A5+qezoDDY9O+K/IG6mKui0ozA4rWP6lM0stKFfL81yiAMmjus46PWZi2XKe+i/wzFG3M4GOHuKdKjniN3vBrhnePYwzduURgPFhk/dw9dnpVjE5BMwaDNIHO/3RBWjzb0A8KsVMmhhSd9Ei3MmYplT2cr4trh/T/cI7FYBjTJE0lmydz3u4yQF9frzuUD9RS7RPOsp8ynT8nE6IQ6bSQ+a64zgM10DT6d07o+3JSdwdVAu1+V9+l9z+4PajVjh5h2qQ6yZb92ArHl97OACEKv+msil13j8RTnHMGErso0ofsQ3gwvrtXvnnKZO7e0mjo=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2019 10:15:18.1981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd758f9-2b86-4f91-266e-08d6b1d3f2b1
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR03MB2258
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devicetree bindings documentation for ad7606 should also include
the vendor prefix: ad7606.txt -> adi,ad7606.txt

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ff2c2f2..4f81cdc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -860,7 +860,7 @@ L:	linux-iio@vger.kernel.org
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
 F:	drivers/iio/adc/ad7606.c
-F:	Documentation/devicetree/bindings/iio/adc/ad7606.txt
+F:	Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt
 
 ANALOG DEVICES INC AD7768-1 DRIVER
 M:	Stefan Popa <stefan.popa@analog.com>
-- 
2.7.4

