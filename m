Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EF9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 10:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C97B0218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 10:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DKqVF8Sv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbfCOKQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 06:16:58 -0400
Received: from mail-eopbgr70054.outbound.protection.outlook.com ([40.107.7.54]:24260
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727354AbfCOKQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 06:16:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3v4qii8dDlGHBUm/L+SwUNZgRikUjbCJ9/VLTjjp974=;
 b=DKqVF8SvomiPKtVRdeG+K8FErQI3VdbFhzDX4UOQJAyZfUcX5/mIZwfizE4YwVQC3U6Ilt9dD541C4yKpe5M4U4nVX2xA29E/PKvtMURB5z9E61ENxu+ZXq3N4Re61gL/qFuO3NG2tRn/BscqY9fYwAo5OECabsDnNAylbW+9IQ=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB5361.eurprd04.prod.outlook.com (20.178.113.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Fri, 15 Mar 2019 10:16:54 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::50ed:d1b5:c043:3b79]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::50ed:d1b5:c043:3b79%2]) with mapi id 15.20.1709.011; Fri, 15 Mar 2019
 10:16:53 +0000
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
Subject: RE: [PATCH 1/2] ARM: imx: drop uneccessary
 of_platform_default_populate
Thread-Topic: [PATCH 1/2] ARM: imx: drop uneccessary
 of_platform_default_populate
Thread-Index: AQHU2Xv1SFnRc4p0SkOOn59vTkEkO6YMepnA
Date:   Fri, 15 Mar 2019 10:16:53 +0000
Message-ID: <AM0PR04MB4211DC74D7E72F886A4333D680440@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190313091757.16410-1-peng.fan@nxp.com>
In-Reply-To: <20190313091757.16410-1-peng.fan@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f91148f2-a0dd-49e7-975a-08d6a92f58ec
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5361;
x-ms-traffictypediagnostic: AM0PR04MB5361:
x-microsoft-antispam-prvs: <AM0PR04MB536188E7B6103251D511591880440@AM0PR04MB5361.eurprd04.prod.outlook.com>
x-forefront-prvs: 09778E995A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(366004)(376002)(39860400002)(199004)(189003)(81156014)(81166006)(105586002)(229853002)(53936002)(106356001)(25786009)(8676002)(6436002)(2501003)(14454004)(3846002)(2906002)(66066001)(6116002)(305945005)(7736002)(26005)(55016002)(102836004)(68736007)(256004)(14444005)(8936002)(99286004)(7696005)(4326008)(6506007)(76176011)(71200400001)(71190400001)(2201001)(86362001)(9686003)(316002)(74316002)(486006)(11346002)(476003)(97736004)(446003)(478600001)(110136005)(52536014)(6246003)(5660300002)(33656002)(44832011)(186003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5361;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: N0D8tKh4hxGkbLoJ+ArMLRVrFokozWv4LGWn77EE01qVQwtPmcM+3sHLgM1IggH1ZavKVi+gb3y4r/WigZrRzVPpRhf/7nqJFrTt2kJaA8vZNjL3m3myudyOLRZIAGJ9cSwAXZQWU6gHQkm126UC5y4AK3E/wwE3ifJmSiLb3S/iGC4jdmP4SHcH0HLrJebtgQdpdSLE1zrdIOhMoMt2R+iJbCHVfA01BgNi4hmKymibeGO90+t9n2K1rlJC1eVOjQIO+e1J4iDjJgrcCFJEhHAZ5+9tYgonjo8VH3a2+U5kAlYaO2eSpdBzXLWzOKVCf4j8j0A4x3Vdqeq20WnB4TDI7dH8em3Zb9A+7WTkmFGjB7dKOG3jqVoj0IbC5waplPP1KVMzujP61ImFg9+G7SGewORPNpFjeI1gUVFJDgI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f91148f2-a0dd-49e7-975a-08d6a92f58ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2019 10:16:53.8730
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
>=20
> "arch_initcall_sync(of_platform_default_populate_init);" could be used to
> populate the device tree, there is no need to call of_platform_default_po=
pulate
> in machine code.
>=20
> Tested on i.MX6Q-SDB i.MX6SL-EVK i.MX6UL-EVK board.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm/mach-imx/mach-imx6q.c  | 2 --
>  arch/arm/mach-imx/mach-imx6sl.c | 2 --
>  arch/arm/mach-imx/mach-imx6sx.c | 2 --
>  arch/arm/mach-imx/mach-imx6ul.c | 1 -
>  4 files changed, 7 deletions(-)
>=20
> diff --git a/arch/arm/mach-imx/mach-imx6q.c
> b/arch/arm/mach-imx/mach-imx6q.c index 7d80a0ae723c..655398c20256
> 100644
> --- a/arch/arm/mach-imx/mach-imx6q.c
> +++ b/arch/arm/mach-imx/mach-imx6q.c
> @@ -278,8 +278,6 @@ static void __init imx6q_init_machine(void)
>=20
>  	imx6q_enet_phy_init();
>=20
> -	of_platform_default_populate(NULL, NULL, parent);
> -

This slightly change the device register sequence as well as possible drive=
r probe
sequence as a consequence.

Originally devices are registered in arch_initcall. Now it will be a bit la=
ter
in arch_initcall_sync and this may cause a bit risk if the code under the
default_populate want to access the device service provided by early probe.

Probably it's more safe to leave as it is unless you can double confirm=20
there're no such code depends on accessing early probed devices as follows
before we can make the change.

>  	imx_anatop_init();
>  	cpu_is_imx6q() ?  imx6q_pm_init() : imx6dl_pm_init();
>  	imx6q_1588_init();

Regards
Dong Aisheng

> diff --git a/arch/arm/mach-imx/mach-imx6sl.c
> b/arch/arm/mach-imx/mach-imx6sl.c index 99be4225297a..9743bdbb68fa
> 100644
> --- a/arch/arm/mach-imx/mach-imx6sl.c
> +++ b/arch/arm/mach-imx/mach-imx6sl.c
> @@ -56,8 +56,6 @@ static void __init imx6sl_init_machine(void)
>  	if (parent =3D=3D NULL)
>  		pr_warn("failed to initialize soc device\n");
>=20
> -	of_platform_default_populate(NULL, NULL, parent);
> -
>  	if (cpu_is_imx6sl())
>  		imx6sl_fec_init();
>  	imx_anatop_init();
> diff --git a/arch/arm/mach-imx/mach-imx6sx.c
> b/arch/arm/mach-imx/mach-imx6sx.c index 7f52d9b1e8a4..19b9f2dd309e
> 100644
> --- a/arch/arm/mach-imx/mach-imx6sx.c
> +++ b/arch/arm/mach-imx/mach-imx6sx.c
> @@ -72,8 +72,6 @@ static void __init imx6sx_init_machine(void)
>  	if (parent =3D=3D NULL)
>  		pr_warn("failed to initialize soc device\n");
>=20
> -	of_platform_default_populate(NULL, NULL, parent);
> -
>  	imx6sx_enet_init();
>  	imx_anatop_init();
>  	imx6sx_pm_init();
> diff --git a/arch/arm/mach-imx/mach-imx6ul.c
> b/arch/arm/mach-imx/mach-imx6ul.c index 6cb8a22b617d..c57b9df791b1
> 100644
> --- a/arch/arm/mach-imx/mach-imx6ul.c
> +++ b/arch/arm/mach-imx/mach-imx6ul.c
> @@ -65,7 +65,6 @@ static void __init imx6ul_init_machine(void)
>  	if (parent =3D=3D NULL)
>  		pr_warn("failed to initialize soc device\n");
>=20
> -	of_platform_default_populate(NULL, NULL, parent);
>  	imx6ul_enet_init();
>  	imx_anatop_init();
>  	imx6ul_pm_init();
> --
> 2.16.4

