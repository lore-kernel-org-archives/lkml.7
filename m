Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB89C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E13120823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="H26/VzTM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731464AbfCZNMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 09:12:19 -0400
Received: from mail-eopbgr770052.outbound.protection.outlook.com ([40.107.77.52]:64386
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726177AbfCZNMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 09:12:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XaOlykCUB/H1G987miN8d7W13ECzjXeoMbEOrGLixa8=;
 b=H26/VzTMyaN0UPVunA00qIZ252fkADXgFc4UfWUUbsPtdVwnuFY53HTitRrP1Sb8KqEL1tKlEyyuvVpkgZeBoYqWknonOpDVDbNI9HGGG63ReXwzB8rh0k4Z/jL+o4JmgTmKwKaxzjGEgwNUpnEAxj1WAcxpDosCZeaLDKMegAw=
Received: from BN8PR03CA0023.namprd03.prod.outlook.com (2603:10b6:408:94::36)
 by BN3PR03MB2258.namprd03.prod.outlook.com (2a01:111:e400:7bbf::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1730.18; Tue, 26 Mar
 2019 13:12:16 +0000
Received: from BL2NAM02FT008.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by BN8PR03CA0023.outlook.office365.com
 (2603:10b6:408:94::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1750.15 via Frontend
 Transport; Tue, 26 Mar 2019 13:12:16 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT008.mail.protection.outlook.com (10.152.76.162) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1730.9
 via Frontend Transport; Tue, 26 Mar 2019 13:12:16 +0000
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x2QDCE6p006358
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 26 Mar 2019 06:12:14 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by NWD2HUBCAS8.ad.analog.com
 (10.64.69.108) with Microsoft SMTP Server id 14.3.408.0; Tue, 26 Mar 2019
 09:12:14 -0400
Received: from localhost.localdomain ([10.44.3.40])     by zeus.spd.analog.com
 (8.15.1/8.15.1) with ESMTP id x2QDCCCW020993;  Tue, 26 Mar 2019 09:12:13 -0400
From:   <michael.hennerich@analog.com>
To:     <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <robin.getz@analog.com>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] mfd: Kconfig: Fix typo in PMIC_ADP5520 help text
Date:   Tue, 26 Mar 2019 14:16:58 +0100
Message-ID: <1553606218-28391-1-git-send-email-michael.hennerich@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(39860400002)(396003)(2980300002)(189003)(199004)(8936002)(16586007)(2906002)(47776003)(14444005)(51416003)(106466001)(2351001)(106002)(126002)(426003)(86152003)(2616005)(476003)(336012)(48376002)(2876002)(54906003)(36756003)(77096007)(316002)(50466002)(26005)(8676002)(4744005)(72206003)(6916009)(478600001)(86362001)(5660300002)(246002)(186003)(486006)(305945005)(4326008)(49486002)(107886003)(7636002)(356004)(50226002)(6666004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR03MB2258;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c6e58da-fa45-4547-8efe-08d6b1ecab71
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4709054)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:BN3PR03MB2258;
X-MS-TrafficTypeDiagnostic: BN3PR03MB2258:
X-Microsoft-Antispam-PRVS: <BN3PR03MB225865F907BC2753795981A98E5F0@BN3PR03MB2258.namprd03.prod.outlook.com>
X-Forefront-PRVS: 09888BC01D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: MNqmQHFINnAtssUd4oTSPValwwhKUa6vaBYRpCzAfVRD1LLDUU8EMziwoOmJJiVnK/GLfjYjToU7cYpu04yWePaNqH7g0FgThWB59VrHp8kURA2FZ8PllgZ0YgsAX3UV99p3GfaDR8kIvCGjoIYa2nu6uhVrN6s4w5IZ5MoRpXMFY32XXlm5UYCcdyc4vE/HbEqlKeuQ5tJ2D3fwOxDacLbiRUt/BuPpHzvXR6ciQHSvm+ENmNRRaySpbUrFWCCpuwkGv9fC59JbwH2pXzwdy/8621gbsvUuEtU5Jn0fx49lJ/4DJ7QLnMpEIROSJEjfm31v7MMAn4SCWe0xSs+YzpelVRo8gQZSb8lUvX1mEBhcrMIrssJm2EDidyradnNZyTPyCYXBv7iH7DHj4Gn3BRvWyL4o2252cT6r5B+qdYw=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2019 13:12:16.0693
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c6e58da-fa45-4547-8efe-08d6b1ecab71
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR03MB2258
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

No functional changes. This fixes a simple typo in the help text.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/mfd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 0ce2d8d..5660d48 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -82,7 +82,7 @@ config PMIC_ADP5520
 	bool "Analog Devices ADP5520/01 MFD PMIC Core Support"
 	depends on I2C=y
 	help
-	  Say yes here to add support for Analog Devices AD5520 and ADP5501,
+	  Say yes here to add support for Analog Devices ADP5520 and ADP5501,
 	  Multifunction Power Management IC. This includes
 	  the I2C driver and the core APIs _only_, you have to select
 	  individual components like LCD backlight, LEDs, GPIOs and Kepad
-- 
2.7.4

