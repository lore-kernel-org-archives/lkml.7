Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B781C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 11:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D1472184C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 11:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="YZOfLafF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfCOLOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 07:14:42 -0400
Received: from mail-eopbgr800073.outbound.protection.outlook.com ([40.107.80.73]:58144
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727059AbfCOLOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 07:14:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACAF+kVsHyDAd9xbUOty989MI4EM1kQ3b75qaZCepss=;
 b=YZOfLafF9yePqlM8i1s4ezQn4sYskZn4WYfmUK6kR8jH4sffpHx/pLq4w7HfxGe/ZyVoMd1t/8Ad+DhpWbIwBqkdZ4XGVtbx823s4Ae2rlgNrMGVd9pY8fqHZK6n+k8fcXndk4cEUensIhnHv25U0piIcUrYXTuslbEslKHdIW0=
Received: from DM6PR03CA0067.namprd03.prod.outlook.com (2603:10b6:5:100::44)
 by BLUPR03MB551.namprd03.prod.outlook.com (2a01:111:e400:882::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.14; Fri, 15 Mar
 2019 11:14:38 +0000
Received: from BL2NAM02FT056.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by DM6PR03CA0067.outlook.office365.com
 (2603:10b6:5:100::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.13 via Frontend
 Transport; Fri, 15 Mar 2019 11:14:38 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; metafoo.de; dkim=none (message not signed)
 header.d=none;metafoo.de; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT056.mail.protection.outlook.com (10.152.77.221) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1709.13
 via Frontend Transport; Fri, 15 Mar 2019 11:14:35 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x2FBEYKb025815
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 15 Mar 2019 04:14:34 -0700
Received: from mircea-Latitude-E6540.analog.com (10.50.3.101) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 15 Mar 2019 07:14:34 -0400
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <lars@metafoo.de>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH 1/2] staging: iio: adc: ad7192: Fix identation
Date:   Fri, 15 Mar 2019 13:14:24 +0200
Message-ID: <20190315111425.14275-1-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(396003)(346002)(2980300002)(189003)(199004)(4744005)(356004)(4326008)(246002)(1076003)(2906002)(107886003)(478600001)(7636002)(26005)(72206003)(336012)(5660300002)(6916009)(86362001)(186003)(48376002)(8676002)(50466002)(305945005)(486006)(106002)(126002)(54906003)(16586007)(77096007)(50226002)(47776003)(2616005)(7696005)(476003)(51416003)(8936002)(2351001)(53416004)(6666004)(44832011)(426003)(316002)(36756003)(106466001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR03MB551;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4721ce1-dfcd-493f-22c3-08d6a9376954
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:BLUPR03MB551;
X-MS-TrafficTypeDiagnostic: BLUPR03MB551:
X-Microsoft-Antispam-PRVS: <BLUPR03MB551013994B93BD1775E9F0881440@BLUPR03MB551.namprd03.prod.outlook.com>
X-Forefront-PRVS: 09778E995A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: zaA1jWn5kx1Cx/Zk96sse3i9VvPJ242IuJP6kvGXR+0j09k5BPVXhmuMHSSTJfCVWt6VbhWRlAUH7kU44fX3MwV6NcV0Jx7o2M32PNWp/8wExZOl9vfv2buIFrrcuZHUBJ2JGGolchMw+/GSYAo6/ufiMMsG/V9cS0ldlDY2Ms/n7hpc9sYMThpUXG78oFMzyKFxPqu3tBhu5b4AhJB35AUg6qx/NwKVb5JlX3Mpwr4py17XL6Tx0HHRmRh4tgaKfGIF73MZN87K3Doonv5Q00RxdgSwkx9tsBBJ003uiKpBjyHwIYOsUxdnEO2iBtQojCBNkpQ7kz59wlZA7xn7uxPxon264Ty7mEgNsCSq/ctllKObjDxed92RjMwnyNmC3ZWhEVYGq0X32wLc/Y1gx2BUFIdsdu4bOm6THnhOsuw=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2019 11:14:35.6509
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4721ce1-dfcd-493f-22c3-08d6a9376954
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR03MB551
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the odd indentation inside function ad7192_calibrate_all.

Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
---
 drivers/staging/iio/adc/ad7192.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index acdbc07fd259..ebab75bdeed7 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -216,8 +216,8 @@ static const struct ad_sd_calib_data ad7192_calib_arr[8] = {
 
 static int ad7192_calibrate_all(struct ad7192_state *st)
 {
-		return ad_sd_calibrate_all(&st->sd, ad7192_calib_arr,
-				ARRAY_SIZE(ad7192_calib_arr));
+	return ad_sd_calibrate_all(&st->sd, ad7192_calib_arr,
+				   ARRAY_SIZE(ad7192_calib_arr));
 }
 
 static inline bool ad7192_valid_external_frequency(u32 freq)
-- 
2.17.1

