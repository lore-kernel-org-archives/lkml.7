Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB3FC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6C752084D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 10:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="DnwpNLG2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbfCEKHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 05:07:52 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:13237 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfCEKHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 05:07:51 -0500
X-IronPort-AV: E=Sophos;i="5.58,443,1544511600"; 
   d="scan'208";a="24831768"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 05 Mar 2019 03:07:50 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 5 Mar 2019 03:07:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DCYhMwJcYpP1s+mG1n8Bq9kKtKO49eT9uS2+vU2zuo=;
 b=DnwpNLG2dvNzRHFx5sqBVYhXhSurNyYZhw5XVcSW/fopdmfuyUUTx9XZ1Ck5MAXninFsDuBM9yxq2l2kCdvILmPwPPBZbxKDuAkxP+Rw1FDhfyYkMg0EJj7Ga2pqsx/xE36GcjP+I2TblABWoLOc6Hv1jvv8maxh4Lruf8TRDOk=
Received: from MWHPR11MB1549.namprd11.prod.outlook.com (10.172.54.17) by
 MWHPR11MB1647.namprd11.prod.outlook.com (10.172.55.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.21; Tue, 5 Mar 2019 10:07:47 +0000
Received: from MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6]) by MWHPR11MB1549.namprd11.prod.outlook.com
 ([fe80::54fe:95ed:b0cf:55a6%9]) with mapi id 15.20.1665.020; Tue, 5 Mar 2019
 10:07:47 +0000
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
Subject: [PATCH v2 3/7] dt-bindings: mfd: add bindings for SAM9X60 HLCD
 controller
Thread-Topic: [PATCH v2 3/7] dt-bindings: mfd: add bindings for SAM9X60 HLCD
 controller
Thread-Index: AQHU0ztIogSP4qcMaU2NRJoCR5xAbQ==
Date:   Tue, 5 Mar 2019 10:07:47 +0000
Message-ID: <1551780434-4580-4-git-send-email-claudiu.beznea@microchip.com>
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
x-ms-office365-filtering-correlation-id: 51300ba4-2481-4f69-0061-08d6a1526af3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1647;
x-ms-traffictypediagnostic: MWHPR11MB1647:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR11MB1647;23:VfIeBeeTk/6WSJbykotmj9JSif+iOIOFF1Tfr9f?=
 =?iso-8859-1?Q?ONNTeP8lzhZAZOV0xOGU6XNzmkmYnWk5s53IPKg2KzjCYYHL6thjS2vodK?=
 =?iso-8859-1?Q?A+rZlG85bhCXgo/u7g3NtXNImFZWXGIo9RlACrYDO7xFml6Lca9L7pfY/3?=
 =?iso-8859-1?Q?3nuydUhluLNXtLfT+lKhgedTz3bV/+YJ93rLokX6p72uxfQk4XKdfuGPZb?=
 =?iso-8859-1?Q?CX5+p7Gedx/RRlkYpM/uUAzyYA8zPQcFKXXTWD4nUwEaOGD5WjIqM4u8jK?=
 =?iso-8859-1?Q?y6XiKkQIYHgbLh7U09jEENDBdL7O7GClIgtqknEAb6pewBBxDnEtljkwNt?=
 =?iso-8859-1?Q?l5tUjcR+lo1AtQ5We5mcwm0uk4zVTzQM7UI0tQ4gxdv52IEK4IcyMqNS+u?=
 =?iso-8859-1?Q?1X14l8DX3EeVNLNAKzv26nQqR7FoOveLHRJSkT2MBg7L1BuQL5gZTpROEf?=
 =?iso-8859-1?Q?WHVE6wA7ltScGdesxJAe6bpn9bg2Nwnc27Ss8foMz8K8Ob21Qwmf8vtOr7?=
 =?iso-8859-1?Q?8dtBVzvjsrrGO8P1dvOQyGZzJ6AnukzcdNAd1cate77ldRj35ZE+C8cnDy?=
 =?iso-8859-1?Q?PfzL8HRwI11nL3I4ag4gAcPQ/oy0gHhcfFTo1tjWnze96B+PJ6OJDpXOxa?=
 =?iso-8859-1?Q?IqWnuCsKVhqpq44nf8TUrPhozZOMEjXeBnh+jiG5Qry/2zdD7a2gI4gOpf?=
 =?iso-8859-1?Q?YogoMzbEVD/7HizOKTQdkeUyW6YHgWDF/afZXBfWNl8h2Mmh0O0ccJn+h/?=
 =?iso-8859-1?Q?SGJjiGMAfVXsP/jSL/JLA19EgEm+BsbN+7T8gvy+jeUwZoa83b7vRmwSFg?=
 =?iso-8859-1?Q?m6F0XwKAd2D13w2yaylhJVuuVkgh8pPHoO/nzYFqh5vKH9/nnvThuB60hR?=
 =?iso-8859-1?Q?kes4SwgEueuESVkC1tdzorh2fOJaUgW5B0IayLhSxURnOGY4c40kE4Md3s?=
 =?iso-8859-1?Q?LeCg4kpnpqt0UwoqvCZgE3v7M325MLbDpW1uAx884/KNuZIk8oJk9wxSB/?=
 =?iso-8859-1?Q?IfNlUJVGvVuLWqWNYvIQ/YLCnyVec0wtPwI8eKt7nBQt4n1OBH91ojCgdM?=
 =?iso-8859-1?Q?PygBRc9Dh8+0/qr+M1NjsFu0QbSAR4b5/hNrfQIJK2RAfE6dtE/+/cqdKO?=
 =?iso-8859-1?Q?44064OMTZDvA7HEVC2dLtUDZWASyQhpMghf5anrHKfFovKU3e6PjdB94Vb?=
 =?iso-8859-1?Q?BXGT1yA2+DT/VTfzLYMWRspgFYMbu3H6F+2HwMdVhtIcRetq6oWwrNSYxx?=
 =?iso-8859-1?Q?5izNO1qBfP5zTT8Nq6OghwtTUBYIPr723nxj8NCmToTj4OMwek11/Qpnf4?=
 =?iso-8859-1?Q?xzZVBBqWxqKm/9Agj8aC7I+WahItCcGUaP+Y/kZXr6a3smo0igtD3nKiz2?=
 =?iso-8859-1?Q?fodIW1jZpzbE53C8lVLKLC/SYncvL?=
x-microsoft-antispam-prvs: <MWHPR11MB164715B5F7418852DD863C8F87720@MWHPR11MB1647.namprd11.prod.outlook.com>
x-forefront-prvs: 0967749BC1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(346002)(136003)(366004)(199004)(189003)(106356001)(72206003)(4744005)(3846002)(99286004)(81156014)(52116002)(36756003)(76176011)(14454004)(81166006)(66066001)(8676002)(110136005)(6116002)(105586002)(6486002)(7736002)(5660300002)(8936002)(305945005)(25786009)(102836004)(54906003)(97736004)(316002)(2906002)(7416002)(2501003)(2616005)(186003)(71190400001)(6506007)(386003)(256004)(476003)(68736007)(11346002)(71200400001)(6512007)(2201001)(107886003)(53936002)(446003)(50226002)(486006)(4326008)(86362001)(6436002)(478600001)(26005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1647;H:MWHPR11MB1549.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9lRHegfMQWU48mWlHW24H/0U1xtRujjDaabY1AuWvqUbPsDTG+ibq4AzFHqdQHLMws64aZEYMG2eAAo4uQQu4yd/RsYkspejRapt6ztsHJg1fYldMCE15gDAKBcfLqDRTvT1zQW7IHXsPu7BFPYexhVlwboUg8W6iTwGKwobscPuLOhU5FJ7+KVqk0A05IrVG+DQkUvEWac/DETdbpvZB/gZJSBoTaZQkd5rcjbbXgVtqFopthXCoUNzBaqUYlfHIW9/dMApfOvHbXwCqDDWPyTId7jKBfyFnAg+UeCOAqWZcUcsybQqfX3RwmMGAE535TH1H+DyI7jlUseUbz9jZ4kJb5qrcA2+66K/ygurKiYyHcOdm6xjItvTXrEhwKCRXjlRL3xYzNbpEpKbvlXZQyF0kPRVfVH1oavWc71cMVQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 51300ba4-2481-4f69-0061-08d6a1526af3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2019 10:07:47.8558
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

Add new compatible string for the HLCD controller on SAM9X60 SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt b/Docume=
ntation/devicetree/bindings/mfd/atmel-hlcdc.txt
index 3f643ef121ff..5f8880cc757e 100644
--- a/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
+++ b/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
@@ -7,6 +7,7 @@ Required properties:
    "atmel,sama5d2-hlcdc"
    "atmel,sama5d3-hlcdc"
    "atmel,sama5d4-hlcdc"
+   "microchip,sam9x60-hlcdc"
  - reg: base address and size of the HLCDC device registers.
  - clock-names: the name of the 3 clocks requested by the HLCDC device.
    Should contain "periph_clk", "sys_clk" and "slow_clk".
--=20
2.7.4

