Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4CAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC55218A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="jEUbhCLj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbfCNQ0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:26:48 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:12577 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbfCNQ0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 12:26:47 -0400
X-IronPort-AV: E=Sophos;i="5.58,478,1544511600"; 
   d="scan'208";a="28034312"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Mar 2019 09:26:45 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 14 Mar 2019 09:26:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1ruMccf7ffO0JnY02B03ARcHud93JayCy9DMxJZR44=;
 b=jEUbhCLj2m43Zu6Uko+nD6tz6AgyoaFgJbu5xlsUbTus1wTxsTUZHduU1hgYCfBANzHhYj8erW2EzY7pofsBlzJc5pNYFCL1DLuWEnJfxlHeziqcJaigCnNh9tASZIEcOlwhXoE1QORWaspLl2kCsxXQYbYc8RG9VEubGm1L128=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB0061.namprd11.prod.outlook.com (10.164.204.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Thu, 14 Mar 2019 16:26:42 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6%9]) with mapi id 15.20.1686.021; Thu, 14 Mar 2019
 16:26:42 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH 3/5] MAINTAINERS: change section name to be more generic
Thread-Topic: [PATCH 3/5] MAINTAINERS: change section name to be more generic
Thread-Index: AQHU2oK1kR8hpBJuE0iDiznsYmI68w==
Date:   Thu, 14 Mar 2019 16:26:42 +0000
Message-ID: <1552580772-8499-4-git-send-email-claudiu.beznea@microchip.com>
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
x-ms-office365-filtering-correlation-id: aefae04a-d73d-47d2-0833-08d6a899d7c0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB0061;
x-ms-traffictypediagnostic: MWHPR11MB0061:
x-microsoft-antispam-prvs: <MWHPR11MB0061AB35DBFA9F2ED317FA2A874B0@MWHPR11MB0061.namprd11.prod.outlook.com>
x-forefront-prvs: 09760A0505
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(39860400002)(346002)(366004)(396003)(189003)(199004)(107886003)(305945005)(106356001)(7736002)(14444005)(316002)(478600001)(86362001)(2201001)(72206003)(256004)(25786009)(99286004)(53936002)(6512007)(4326008)(8676002)(105586002)(81156014)(81166006)(54906003)(110136005)(50226002)(14454004)(6116002)(3846002)(66066001)(8936002)(97736004)(5660300002)(68736007)(2501003)(102836004)(6436002)(2906002)(71190400001)(446003)(386003)(2616005)(6506007)(4744005)(476003)(186003)(71200400001)(26005)(52116002)(11346002)(76176011)(36756003)(6486002)(486006)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB0061;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: T8jAqLUsFT4jH+rTafYtNK4Bk64qXZD/VMIcZPP63RslibxnqzrdHDhbMHocwJpfaSGGLi4U44GR0PMYPGo1kIBXuiJKBdAz3qnnvf6QLWDn2YBPHD5mgCOj7LiaMu61t0wwAeGPTZSO58hoCiN8ZRkXHKQ/JYG+rutN9m83fWAcwwntf7mfQftC1gsMLQNY+svy3ecT3SjPEGxHUkPPWMGQ7G6UEg8SrdOsNpBxgRnGfqflgDzANK0dlmuDndD2pQzXwpbBMxPPUvpd6BRSK8JFoNpEKIzVEFF7izvnqnullwraMx7l0blT8103nUCgiC0petpQ8c1d3GYvs2THxavYhtPe2xnkqG3D8lF2mqNBh5gXbK3fa5HJXfAibLI0oFH2RP4vMyjQgJ+JkI9ujDwxZa/9qEV8WJC2phKrSoM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: aefae04a-d73d-47d2-0833-08d6a899d7c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2019 16:26:42.7436
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

Change Microchip timers section name to be more generic.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4d04cebb4a71..0948d6592ea5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10016,7 +10016,7 @@ S:	Supported
 F:	drivers/misc/atmel-ssc.c
 F:	include/linux/atmel-ssc.h
=20
-MICROCHIP TIMER COUNTER (TC) AND CLOCKSOURCE DRIVERS
+MICROCHIP TIMERS AND CLOCKSOURCE DRIVERS
 M:	Nicolas Ferre <nicolas.ferre@microchip.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
--=20
2.7.4

