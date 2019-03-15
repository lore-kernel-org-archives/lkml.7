Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B67C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 10:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49E4F218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 10:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FunaQFgc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbfCOKWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 06:22:22 -0400
Received: from mail-eopbgr60054.outbound.protection.outlook.com ([40.107.6.54]:45953
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727428AbfCOKWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 06:22:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/n/1+rfgJ7RrS+a9G5ecRNoaKnLMYrK7BBOIovOFCTg=;
 b=FunaQFgcujCDmQ0FML4oDoUvUKpuDVQCcGhKzvpHC0vQQl+9aA/HZDQOeXS5MYPkp6BXcI9bCK2X2A8Xl3G6ZO9SicTkz2aCVpEzfvg5rcA/Od+AoWnMAWS4VYwUh5j+iDT1O8ztRlZlz4s6EKPsSEA09c2an6u90jcFsJY1JAQ=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB5361.eurprd04.prod.outlook.com (20.178.113.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Fri, 15 Mar 2019 10:22:18 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::50ed:d1b5:c043:3b79]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::50ed:d1b5:c043:3b79%2]) with mapi id 15.20.1709.011; Fri, 15 Mar 2019
 10:22:18 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: RE: [PATCH 2/2] ARM: imx: mach-imx7ulp: warn when imx_soc_device_init
 fail
Thread-Topic: [PATCH 2/2] ARM: imx: mach-imx7ulp: warn when
 imx_soc_device_init fail
Thread-Index: AQHU2Xv6rc4iD5C/cU2/vwnpPpurWaYMfhWQ
Date:   Fri, 15 Mar 2019 10:22:18 +0000
Message-ID: <AM0PR04MB4211FE93F235498D795C2FED80440@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190313091757.16410-1-peng.fan@nxp.com>
 <20190313091757.16410-2-peng.fan@nxp.com>
In-Reply-To: <20190313091757.16410-2-peng.fan@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d375d61-04c6-42ef-d4f8-08d6a9301a6f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5361;
x-ms-traffictypediagnostic: AM0PR04MB5361:
x-microsoft-antispam-prvs: <AM0PR04MB5361AA5299AE258BA077635780440@AM0PR04MB5361.eurprd04.prod.outlook.com>
x-forefront-prvs: 09778E995A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(136003)(396003)(346002)(189003)(199004)(486006)(74316002)(446003)(11346002)(476003)(97736004)(71190400001)(71200400001)(2201001)(6506007)(76176011)(316002)(9686003)(86362001)(6246003)(186003)(44832011)(33656002)(5660300002)(52536014)(478600001)(110136005)(8676002)(106356001)(25786009)(2501003)(6436002)(81156014)(81166006)(105586002)(53936002)(229853002)(102836004)(256004)(68736007)(26005)(7736002)(55016002)(4326008)(99286004)(7696005)(14444005)(8936002)(305945005)(3846002)(14454004)(6116002)(2906002)(66066001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5361;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3gANhdR0FscHxZQmCUh8WkOepFVlYPa0HjcQqTXHTw21LHFxHTlJ5lhMaJEUflM76SllnYhYNSkt1uPL0jPSPEIWATOGdKGUWjGMAZ1XF7ed9p5x1YjzaokdKFFQxVn6+bTlQTBdkg2KWH1U9upy/Mdzgq/+itiCdbIk0B0X9WuGHMQK/z5bklF0yxkhfPUrFcXuvjrZ9E2Cwjhr1Uhp+oLFZl+PPSHTY3AuMiN0SmseVarDQi15PUYPZESRgukSsA1wbbZy9i8OzuZYkUS+U7qAZOYslyd3wjy51HLk+b54NS9NwfNNsS549AUSZA53SEzFM3NHBNGfDSmtsUKaERiTjJ4goh8XOVlfhN1qfMaZtV9aglbRQ/J1Gr3LFva9jsWNvhqLjbcZp3iilW4d7nnfw3mkbX0fjD8eDksELic=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d375d61-04c6-42ef-d4f8-08d6a9301a6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2019 10:22:18.5954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5361
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Peng Fan
>
> [PATCH 2/2] ARM: imx: mach-imx7ulp: warn when imx_soc_device_init fail

ARM: imx: imx7ulp: ...

> Follow other i.MX6/7 machince code to check return value of
> imx_soc_device_init and warn when fail.
>=20
> Also drop of_platform_default_populate, because
> "arch_initcall_sync(of_platform_default_populate_init);" could be used to
> populate the device tree.
>=20

This could be in separate patch.

> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm/mach-imx/mach-imx7ulp.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/mach-imx/mach-imx7ulp.c
> b/arch/arm/mach-imx/mach-imx7ulp.c
> index 11ac71aaf965..6d823f05d9aa 100644
> --- a/arch/arm/mach-imx/mach-imx7ulp.c
> +++ b/arch/arm/mach-imx/mach-imx7ulp.c
> @@ -53,11 +53,16 @@ static void __init imx7ulp_set_revision(void)
>=20
>  static void __init imx7ulp_init_machine(void)  {
> +	struct device *soc_dev;
> +
> +	soc_dev =3D imx_soc_device_init();
> +	if (soc_dev =3D=3D NULL)
> +		pr_warn("failed to initialize soc device\n");
> +

Should this be under set revision?

Regards
Dong Aisheng

>  	imx7ulp_pm_init();
>=20
>  	mxc_set_cpu_type(MXC_CPU_IMX7ULP);
>  	imx7ulp_set_revision();
> -	of_platform_default_populate(NULL, NULL, imx_soc_device_init());
>  }
>=20
>  static const char *const imx7ulp_dt_compat[] __initconst =3D {
> --
> 2.16.4

