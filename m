Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A0AC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0907A218A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="RLwE17Jn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbfCNQ05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:26:57 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:7043 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727713AbfCNQ0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 12:26:54 -0400
X-IronPort-AV: E=Sophos;i="5.58,478,1544511600"; 
   d="scan'208";a="28204172"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Mar 2019 09:26:53 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 14 Mar 2019 09:26:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+dnfcZWUjHFZlADjdlRhYpjhf6rZyGRyHD1mK0sppE=;
 b=RLwE17JnCS/KGbAV5+rHIgo0r2seIUcU0SM2a++R8/53a5bryzBTTsgEOwMnvrAJCwK70bBYzaE0s9DM64kyvKfXJ+tIKOE8Q1puwqPb+G22b6XZEnZnUYHkv3FzfSpfXk+MTOdUap3tbhMaW70iSVjKcUMYiv2LOEstTS4USzU=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB0061.namprd11.prod.outlook.com (10.164.204.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Thu, 14 Mar 2019 16:26:51 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6%9]) with mapi id 15.20.1686.021; Thu, 14 Mar 2019
 16:26:50 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH 5/5] MAINTAINERS: add timer-microchip-pit64c.c
Thread-Topic: [PATCH 5/5] MAINTAINERS: add timer-microchip-pit64c.c
Thread-Index: AQHU2oK6uTkCa+nyqEGt+6z8WTiMQg==
Date:   Thu, 14 Mar 2019 16:26:50 +0000
Message-ID: <1552580772-8499-6-git-send-email-claudiu.beznea@microchip.com>
References: <1552580772-8499-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1552580772-8499-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0801CA0088.eurprd08.prod.outlook.com
 (2603:10a6:800:7d::32) To MWHPR11MB1549.namprd11.prod.outlook.com
 (2603:10b6:301:c::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [86.120.234.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b17940ca-35a2-4432-6812-08d6a899dc9f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB0061;
x-ms-traffictypediagnostic: MWHPR11MB0061:
x-microsoft-antispam-prvs: <MWHPR11MB0061F20CF5C4CC613C71B537874B0@MWHPR11MB0061.namprd11.prod.outlook.com>
x-forefront-prvs: 09760A0505
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(39860400002)(346002)(366004)(396003)(189003)(199004)(107886003)(305945005)(106356001)(7736002)(316002)(478600001)(86362001)(2201001)(72206003)(256004)(25786009)(99286004)(53936002)(6512007)(4326008)(8676002)(105586002)(81156014)(81166006)(54906003)(110136005)(50226002)(14454004)(6116002)(3846002)(66066001)(8936002)(97736004)(5660300002)(68736007)(2501003)(102836004)(6436002)(2906002)(71190400001)(446003)(386003)(2616005)(6506007)(4744005)(476003)(186003)(71200400001)(26005)(52116002)(11346002)(76176011)(36756003)(6486002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB0061;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Esj3bqXxhretAn57mjG8JCqOgzZ6PQ5MM2V/eGdEMe8eYWT1SXafqBhzB17UBpwrErQsUih4D3FGGcJLX3wbM0zvtzfNQSIBp8kXJ+Q9BTpjsdmhEGPKqyvOCKMa74cTCWKALKMQHFB1u2j9lVDHBRv7fV6hTl5RTxB2qFf4mJE79CcsQpHJJBRmXh7IT6PacZc97G6GTL4taGlR5HW3uNrUyYajuVFEu2HYWabIFWFuxP35aDzDAeZVRu957qKXmNezNhwqwtCOlNKNs4u4qPbRQsrT61ve/MxztbiwCjn5Rwh/B/aiRt73t1pqn4S3CC3/rVwdIsUMvTXxcF+iu34skTbnT3zRd6qiQiwSOKc/+0IF90nG4j6mg1NLkgGqYG+XemrGlPUR57vg5IHfQ9L/Lu9/qk1D4rMXnERE3JU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b17940ca-35a2-4432-6812-08d6a899dc9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2019 16:26:50.8814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB0061
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add timer-microchip-pit64b.c as maintained file.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 85bc819867da..5af947c9f350 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10023,6 +10023,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated =
for non-subscribers)
 S:	Supported
 F:	drivers/misc/atmel_tclib.c
 F:	drivers/clocksource/tcb_clksrc.c
+F:	drivers/clocksource/timer-microchip-pit64b.c
=20
 MICROCHIP USBA UDC DRIVER
 M:	Cristian Birsan <cristian.birsan@microchip.com>
--=20
2.7.4

