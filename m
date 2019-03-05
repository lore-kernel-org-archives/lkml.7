Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F08DC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D10B820842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="S4OiWjOT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfCEKH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 05:07:58 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:2681 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfCEKH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 05:07:56 -0500
X-IronPort-AV: E=Sophos;i="5.58,443,1544511600"; 
   d="scan'208";a="27662201"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 05 Mar 2019 03:07:55 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 5 Mar 2019 03:07:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwSGtbK7YlE0MWXaYss8ytXvS2vK4pfauPtmUYIt3K0=;
 b=S4OiWjOTQQUS/r97f0/cTv5NqLzXQM/dbqcgXGbsKZebZyfgycz2y0d4CSi5UteF7GuNHbHLufmQ2f7X+hLhE7hgvMhd8h78aYxrT8QB1yIKu/Zgy7vYsN88FbGmOQ+vLPRZLRxsHsV95WMzYMoTrkNRbZYMM+8ki5m+HZtQag0=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1647.namprd11.prod.outlook.com (10.172.55.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.21; Tue, 5 Mar 2019 10:07:52 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6%9]) with mapi id 15.20.1665.020; Tue, 5 Mar 2019
 10:07:52 +0000
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
Subject: [PATCH v2 4/7] mfd: atmel-hlcdc: add compatible for SAM9X60 HLCD
 controller
Thread-Topic: [PATCH v2 4/7] mfd: atmel-hlcdc: add compatible for SAM9X60 HLCD
 controller
Thread-Index: AQHU0ztLr+BS5iaIUki6hLCocD7pbQ==
Date:   Tue, 5 Mar 2019 10:07:52 +0000
Message-ID: <1551780434-4580-5-git-send-email-claudiu.beznea@microchip.com>
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
x-ms-office365-filtering-correlation-id: b034f4a1-0913-4f36-4520-08d6a1526dcf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1647;
x-ms-traffictypediagnostic: MWHPR11MB1647:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR11MB1647;23:GK04IigYwTsybLcWzuE7WonZrUvHR8skz34jQB7?=
 =?iso-8859-1?Q?xZ3UI4RQ+MynlM+icCfusb8GDTYxAIu7ezIjlRRPGMjm25l+2dGoulNsy1?=
 =?iso-8859-1?Q?piwEWd9pTKTxGwEObTXLrhPyyFbg6/Zdrg+5+mr/w8mclbt/mOLgqbCVcl?=
 =?iso-8859-1?Q?Jxm/4/h1ncaszLEEUM0CcAq0KZ40ztyIV8OauNWCGeaaidtyihqMRghB2d?=
 =?iso-8859-1?Q?PgY0hnqHVd3PUjqz0QUg0nwWb75UoL4nGYEPRt9ezGAMUtbdWAaTQfdyxI?=
 =?iso-8859-1?Q?UB3o2H+1PzFht71ju03D2sGme5bEcL60cP0yKR0berwtnIgXLpXJxp/BzV?=
 =?iso-8859-1?Q?qDYOwGxtjKabrGDBVJqe1VZXo/N64n4Zd5ML4tuInEsVb8DMTs2Jn/ymrT?=
 =?iso-8859-1?Q?Fo74K+n9IFIFnx0qDm3+cPYzuJ0OuYXx4ToAjSphTKY1sUYTxRyhql0Jfl?=
 =?iso-8859-1?Q?fk074fCihMT4NHF+mMeik7vusIDmqMYbkkPgi4EkGqHK522d2OGaMK9fxf?=
 =?iso-8859-1?Q?LWD3UTea4DpyK+yQtvqDtfhMbupPjJ7JsCJVDEMUWlo0ZRsxLMlUe9cWkc?=
 =?iso-8859-1?Q?HXBh/Wkx/PbjNFilEOF3SpJd6s7jqW6yx8li+o+I7aWYbqikk5ALToUV+2?=
 =?iso-8859-1?Q?GBCEZ58cigl7ulQnBNXOqzMDNP5C72BOvDJ4U7bV5CtBGhCikgEra9E0js?=
 =?iso-8859-1?Q?e62XaKjg+GNqTUksORkjWBkT76/77pZyyZf2HIkGYhSnMDk9K9/TRMKxvJ?=
 =?iso-8859-1?Q?fFpt7jqc/nBztQQZoSuK9QLQFghJpG40TyHsRkm4IRaNAOBz+8+VvLZPdO?=
 =?iso-8859-1?Q?BPYT2G3YwqgQFTcNpKmFVfVwCyjfs3uYneJx6YK1nDw+0Adh9EXimKMqjc?=
 =?iso-8859-1?Q?vZnptoLUJqSGjGio0QdmVkBNNWxBkJFiEswZME0A3wp7iF4TqVllQpbNqV?=
 =?iso-8859-1?Q?c3q/qUgibrk4RXCoXX+6ruo803zCihf5qKJ/TB2x1wdxsXIpsx5mj8/Cm+?=
 =?iso-8859-1?Q?4hCay2nO6NBIS0nHunu+EVBDcDw+LKcp9AZD+nof6sMWErR/doka82XPSN?=
 =?iso-8859-1?Q?TJWWOH8uG9lN05uGEKTqPoJ4xYZ3P2mgPIUR28k27ZBuDMf0MUfADTUaMz?=
 =?iso-8859-1?Q?ipW9gqM9S02KzEjLus+n+WHcH1x7K07BMzxcLyRmrV38JGWKwxygEin+SN?=
 =?iso-8859-1?Q?egvEfjz3gX3A+wxpbs+DgdaU7qtOE+NLoZZ/n5HamhPDh3xtx6ylqpS0Ij?=
 =?iso-8859-1?Q?fA0/C//tQ4QjO53t3JjM8tpxzRcRSgMr4vnM15ST80johPB4J8MQ7eIpel?=
 =?iso-8859-1?Q?wh8Sb6mOMFsRqzd/+6Ofh5rjO/3+v3lwWzpzjRICNNSkAaR10dgM/TSlUx?=
 =?iso-8859-1?Q?dEdMh2vWonz7fv8WonLyQ+L1fBgZA?=
x-microsoft-antispam-prvs: <MWHPR11MB164771CD654A5FB6E4C70F1887720@MWHPR11MB1647.namprd11.prod.outlook.com>
x-forefront-prvs: 0967749BC1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(346002)(136003)(366004)(199004)(189003)(106356001)(72206003)(4744005)(3846002)(99286004)(81156014)(52116002)(36756003)(76176011)(14454004)(81166006)(66066001)(8676002)(110136005)(6116002)(105586002)(6486002)(7736002)(5660300002)(8936002)(305945005)(25786009)(102836004)(54906003)(97736004)(316002)(2906002)(7416002)(2501003)(2616005)(186003)(71190400001)(6506007)(386003)(256004)(476003)(68736007)(11346002)(71200400001)(6512007)(2201001)(107886003)(53936002)(446003)(50226002)(486006)(4326008)(86362001)(6436002)(478600001)(26005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1647;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VfxHHWhqZZY65kz95Ff0WS6AepOGF67LLanSFkgfx5XcjahpFpFJKgJr1BFfKPLYh3rrkFbwRztlfuupgYtdZ4BNpl5Tu4q6tPKr41zb2E4XFpI7KzHU/+JRhkJWRedurVJJ0el1PE9lQbN+jFpqX90wQbxDmhpIe1wPhoDwv5GFy/y6xOkjUg0J3WH675lJuSsHDYAQFUUIfXNsg1sc3+/haK3XoApLe8x2L2dwGCvtBXA6RvfmEqiQ+TTvQRhNN/EZJaHlLXGH35sTTdPImIVPBNnxsJCeIsvxzJPZ/xAaMl50zsliB2lnptuTuhk75Wk9o+WFU9HHWQRNva4MpweS0ESDssImMYTU7i3fhCZ/jCoYYq2TNL0508tLbAbMMF7uYfmRV5HTKELb08N4PyNukgUcp4oEcutDgQclvE4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b034f4a1-0913-4f36-4520-08d6a1526dcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2019 10:07:52.6458
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

Add compatible for SAM9X60 HLCD controller.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/mfd/atmel-hlcdc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/atmel-hlcdc.c b/drivers/mfd/atmel-hlcdc.c
index e82543bcfdc8..35a9e16f9902 100644
--- a/drivers/mfd/atmel-hlcdc.c
+++ b/drivers/mfd/atmel-hlcdc.c
@@ -141,6 +141,7 @@ static const struct of_device_id atmel_hlcdc_match[] =
=3D {
 	{ .compatible =3D "atmel,sama5d2-hlcdc" },
 	{ .compatible =3D "atmel,sama5d3-hlcdc" },
 	{ .compatible =3D "atmel,sama5d4-hlcdc" },
+	{ .compatible =3D "microchip,sam9x60-hlcdc" },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, atmel_hlcdc_match);
--=20
2.7.4

