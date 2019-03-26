Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E326EC10F05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2ED32084B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="nviiNkcS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfCZLAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 07:00:09 -0400
Received: from mail-eopbgr690057.outbound.protection.outlook.com ([40.107.69.57]:28060
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725776AbfCZLAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 07:00:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ky0e4sonZr7HmYYqoY6/1ukkyUoR2/qreWOxohL1FE=;
 b=nviiNkcSodTtVFldEig3YHUPbK+M27k7Gqq7qHb7WmQ+w0+C4P43Ceg/AIxNUbN8EgvXGJSZgBqgmkRsAHKw+O0LEwJGzCdiLRtkx64Li9HpyFA0DDKEQCwVjEW47Dr5N3oC/6+XwirGa8Wn38RGIx8uDTRaRZaKYHIC5Zdx0Yc=
Received: from BN6PR03CA0087.namprd03.prod.outlook.com (2603:10b6:405:6f::25)
 by CY4PR03MB3127.namprd03.prod.outlook.com (2603:10b6:910:53::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1730.18; Tue, 26 Mar
 2019 11:00:05 +0000
Received: from SN1NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::205) by BN6PR03CA0087.outlook.office365.com
 (2603:10b6:405:6f::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1730.18 via Frontend
 Transport; Tue, 26 Mar 2019 11:00:04 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; davemloft.net; dkim=none (message not signed)
 header.d=none;davemloft.net; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT007.mail.protection.outlook.com (10.152.72.88) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1730.9
 via Frontend Transport; Tue, 26 Mar 2019 11:00:04 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x2QB03Lu032243
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 26 Mar 2019 04:00:03 -0700
Received: from linux.ad.analog.com (10.32.224.122) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Tue, 26 Mar 2019 07:00:02 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <davem@davemloft.net>,
        <mchehab+samsung@kernel.org>, <gregkh@linuxfoundation.org>,
        <robh@kernel.org>, <joe@perches.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Stefan Popa <stefan.popa@analog.com>
Subject: [PATCH v2] MAINTAINERS: Fix the link to ad7606 dt-bindings
Date:   Tue, 26 Mar 2019 12:59:52 +0200
Message-ID: <1553597992-31693-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(346002)(376002)(2980300002)(199004)(189003)(246002)(51416003)(7696005)(305945005)(14444005)(5660300002)(26005)(4326008)(8676002)(7636002)(36756003)(486006)(186003)(106466001)(47776003)(966005)(6306002)(107886003)(50226002)(77096007)(476003)(8936002)(126002)(2616005)(426003)(336012)(44832011)(6666004)(356004)(478600001)(4744005)(72206003)(2906002)(16586007)(2351001)(106002)(54906003)(50466002)(6916009)(48376002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB3127;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9409487-2e87-4cf0-7480-08d6b1da3387
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4709054)(2017052603328)(7153060);SRVR:CY4PR03MB3127;
X-MS-TrafficTypeDiagnostic: CY4PR03MB3127:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <CY4PR03MB3127F6773CD8E3C78BDA7D589D5F0@CY4PR03MB3127.namprd03.prod.outlook.com>
X-Forefront-PRVS: 09888BC01D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: /fF0gCe8XfjfT9OgTeNx6muGXuhEhJy2rCi4HnGnCY2z3GeLrFFTVI5nrcBpEaHhPCuZz5V4NL/33R1BIcT+u45RCyhePtKjQIq/ZM6sFjtEdDGDPXoeoudzKHW/1F6J26cAY+v8Sb5PjqyFxx+hy2voFnI6oPWyhXhf+2WMULx3P6jtYWCSaUYIQZK+1ZAb5u57RxeI1ZmtyDf8DUAE0t1T0MMtN+oNZsU/hD5GPfOpIegkLu7aS5Dln5q0DFrKlA4Tj7O87ijFqRBMtBRwopY+EQfhnvpwQk7DizWWdktY/D6Yj55KisApdlbIZ37ulMor4pCoxeYNyA7vQ8jeQ8JTsShY7qgC/TnYvCffYb9RJtTwQZ8TvntF2VEGerGt5+BJwhNHJJIv7DhoV4ZEq/nfbIP47edvq2SzRy0meSA=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2019 11:00:04.1062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9409487-2e87-4cf0-7480-08d6b1da3387
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devicetree bindings documentation for ad7606 should also include
the vendor prefix: ad7606.txt -> adi,ad7606.txt

Fixes: 6e33a125df66 ("dt-bindings: iio: adc: Add docs for AD7606 ADC")
Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v2:
	- Added Fixes tag

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

