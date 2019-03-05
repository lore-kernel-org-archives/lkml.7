Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834D4C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AD78206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="JaR3WV/H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfCEKIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 05:08:02 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:2681 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfCEKIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 05:08:00 -0500
X-IronPort-AV: E=Sophos;i="5.58,443,1544511600"; 
   d="scan'208";a="27662207"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 05 Mar 2019 03:08:00 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 5 Mar 2019 03:07:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ea+EBmSvyJnwQOyzXeojEjHa9w+k/SkMz8JYNE+A73o=;
 b=JaR3WV/HWiWlr7BXrAG0ews33dEXtF9f0Z28r9260FEj3LC40KVgi9f7PgJRyuj08051jWt52o1eXtqU32pukSisYQjc4lb/Q9VyAPmlfAQYV3fmMqML/j/yK0VCBy/inC6gGjeO/3XzvbHQzeGJuPvRmGB4ziNBqLwq3eaZR/c=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1647.namprd11.prod.outlook.com (10.172.55.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.21; Tue, 5 Mar 2019 10:07:57 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6%9]) with mapi id 15.20.1665.020; Tue, 5 Mar 2019
 10:07:57 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <bbrezillon@kernel.org>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <thierry.reding@gmail.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-pwm@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH v2 5/7] pwm: atmel-hlcdc: add compatible for SAM9X60 HLCDC's
 PWM
Thread-Topic: [PATCH v2 5/7] pwm: atmel-hlcdc: add compatible for SAM9X60
 HLCDC's PWM
Thread-Index: AQHU0ztO/XA/ucaOTEyHzcBvHIJYzw==
Date:   Tue, 5 Mar 2019 10:07:57 +0000
Message-ID: <1551780434-4580-6-git-send-email-claudiu.beznea@microchip.com>
References: <1551780434-4580-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1551780434-4580-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0502CA0011.eurprd05.prod.outlook.com
 (2603:10a6:803:1::24) To MWHPR11MB1549.namprd11.prod.outlook.com
 (2603:10b6:301:c::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 204ebf02-85d9-4e9c-4438-08d6a152707d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1647;
x-ms-traffictypediagnostic: MWHPR11MB1647:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR11MB1647;23:ZJQrA1LdURKRxp49Ny4T8ZIQ8/JKqrWAqvrTv3s?=
 =?iso-8859-1?Q?faTQTI3ReyNtsbZ+JqoMzd+HGUQYP9Q5OYaYuX7+eV1QddxDINUm8D3OKk?=
 =?iso-8859-1?Q?pNvDPXZeWyyE075QS/+0WX1AHQxWn5ZZhs4Ut5BaIPMEDE+p0Y6vI0yXTk?=
 =?iso-8859-1?Q?3t+rnoDWlV1PmECDZx3An5rt6JL6T5wSTrJwe3edVZOprmUjz84lzXWNrp?=
 =?iso-8859-1?Q?5ARz0Md4pftP7NNAjbzYq8RfVo23FBkHz5RdonUpwBgpwexNHYj12rIV3M?=
 =?iso-8859-1?Q?gxyX2Wh1HgbiNKHUWWhX21Fq1moT5mRJQnHoPp5MemOY7XgTLPNNLT9hgz?=
 =?iso-8859-1?Q?VRP4QMK5gR63vL5iO+tdqjaz7LWgpZlCIN3olHCZBd0MZk8ehemITtHsym?=
 =?iso-8859-1?Q?sNLvJ65MfBt7INS2LC/l1rXM/ny9UXM12jX2QeUdyM7ZNawNmWmcVBh8g9?=
 =?iso-8859-1?Q?AO7wijEt1mbrYQHOYWcze6HKcThhFipBOdPlN4zU8Re8rQ5Z/1CQUn0LHo?=
 =?iso-8859-1?Q?2XXQn+A1DsHWzbR2iHoJlqYjAI9gFN5e1Yl5rDiLPgqDvknbREw1dUhTmZ?=
 =?iso-8859-1?Q?FGlHM7z7ERL4c71tq3qzGpAQVVRUrtwlG9m7JI9Gz2C0jGB5QEjQuEghSV?=
 =?iso-8859-1?Q?LJ3Svzq8iBGJ5mQSCaeJMkteTuMRfmRiugG3Hqpv+aBD6DBhKgERo5GgJx?=
 =?iso-8859-1?Q?ARF14NqfouogZdJqFB36Y5nPTjRftXZmKysl1f5S5lINLOxMOjIR2CM1om?=
 =?iso-8859-1?Q?y7eIX7OmuCWDXgeOyCDS913cEkNQCSTHUMGlq8Cj1WwuujW4b8rAtX6o7g?=
 =?iso-8859-1?Q?6BjV3Y3VWuvJmA+MSVJS5stLmGLMPlGk3zdjHzYxuYcOMWZ1Wyw57gb3MJ?=
 =?iso-8859-1?Q?yREvwBr93N3eyff8kKgykaf7abJ8UnhkopQ5tqhGL5rvNFJ4DHR3WUf01G?=
 =?iso-8859-1?Q?Z9fbVULyehRLCngRC7LE30asjpaHXYG0WmeuOkzJr5s6iYyL/P119Nhyhu?=
 =?iso-8859-1?Q?I1F4qTKUOTDLZ0DCoA0rQlyX/CGeaLH8O/7WzLHHkP2K+aiOhygUZ/O1MU?=
 =?iso-8859-1?Q?2GawVDEhZ7YYfFGu1lghz4WBDvk69ODQOd1xD9TAjwDlJry4f8F6mz+Q6j?=
 =?iso-8859-1?Q?dWCGJGA+ehjhS/Xwo/ULEE2OuOSuyP1Hi0IphBcRka3XN/i+uDa9wC+Pbq?=
 =?iso-8859-1?Q?orNoVSl8hn1U+OswXMnEn87QqEtHpfvHUIAthw6iClRjBcTi2zM/Jk3nGb?=
 =?iso-8859-1?Q?ghLFXWpj2hQ0t/YbGwg5+CwWEOfacFtchztxQLA7mROsl/LZhNvAPJSCV7?=
 =?iso-8859-1?Q?ux9epvP4yDNlvK5Ewawv0U0g/W/9kH2rQiJH2hmxYL9fZM/UEpzVNdW4/D?=
 =?iso-8859-1?Q?uix/Xjemksfgh3YxZk1npjgwKc8Bl?=
x-microsoft-antispam-prvs: <MWHPR11MB1647F5198940C70E77DEE85387720@MWHPR11MB1647.namprd11.prod.outlook.com>
x-forefront-prvs: 0967749BC1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(346002)(136003)(366004)(199004)(189003)(106356001)(72206003)(4744005)(3846002)(99286004)(81156014)(52116002)(36756003)(76176011)(14454004)(81166006)(66066001)(8676002)(110136005)(6116002)(105586002)(6486002)(7736002)(5660300002)(8936002)(305945005)(25786009)(102836004)(54906003)(97736004)(316002)(2906002)(7416002)(2501003)(2616005)(186003)(71190400001)(6506007)(386003)(256004)(476003)(68736007)(11346002)(71200400001)(6512007)(2201001)(107886003)(53936002)(446003)(50226002)(486006)(4326008)(86362001)(6436002)(478600001)(26005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1647;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0SSp634xCIvfUEC303a7jTIiOq/qUrExccqxTy8kzL/8k+9qNjlr7nTtpCDbM2m1D47Xbnwso6hGt64YLMy9lW/9YQRAmI7HpaX7tQQpm3Mikja6KPOpcZyjKjVM4FMqJDYrw2oOP8nd/GPEQrf5SGhtKEyw4NWGrsIw4bCgX4/vIpGdWpfeeLvfI9C9sqYUTLJVgTKqy607j2XnsPeAHX5DMWZOpDmMlNr/F3z5aU4CWMX3lOpZxFEYt3Zx4JzZYgsa14ZrtqSDrkuT3bpk9yFo7ktiMs6y3CKDJAPgOt789V46FT2LD3h0x7u5X6nKJFsd6+5IMRRcj2sWR8XMd2O13XvQSau2PO40fM7nHf3Gt0pTK8GWoH0jr2wCbQuY5mTte/SKyJjVxzy/j0wRp8AGr+REa3QhGJQJgDmflN4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 204ebf02-85d9-4e9c-4438-08d6a152707d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2019 10:07:57.5159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1647
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add compatible string for SAM9X60 HLCDC's PWM.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Acked-by: Thierry Reding <thierry.reding@gmail.com>
---
 drivers/pwm/pwm-atmel-hlcdc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
index 54c6633d9b5d..331ca0233d9e 100644
--- a/drivers/pwm/pwm-atmel-hlcdc.c
+++ b/drivers/pwm/pwm-atmel-hlcdc.c
@@ -246,6 +246,9 @@ static const struct of_device_id atmel_hlcdc_dt_ids[] =
=3D {
 		.compatible =3D "atmel,sama5d4-hlcdc",
 		.data =3D &atmel_hlcdc_pwm_sama5d3_errata,
 	},
+	{
+		.compatible =3D "microchip,sam9x60-hlcdc",
+	},
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, atmel_hlcdc_dt_ids);
--=20
2.7.4

