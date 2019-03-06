Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4361CC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 13:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A5020675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 13:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fm+ZduX0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfCFNgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 08:36:48 -0500
Received: from mail-eopbgr150070.outbound.protection.outlook.com ([40.107.15.70]:54710
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726266AbfCFNgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 08:36:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjkFAZqWClS7AL07Isp6Rt50DHzHYN+N9Duk6JJ/ALY=;
 b=fm+ZduX0M+6xtpSmq1zCCNIA7qomlhTXhyVGvexjt5aQrm00YazP4crSTdYJ+Hp1XvQznQtl+Er9Sjl6skirWwogzzPL2T1fZBXNQ2uVXrx5ly54WK5vv6KTWkaNAsYlFyfWWWYRkFvTIl4L/lWM0mwPFKeeNTdfYsD1xkqurY8=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB6209.eurprd04.prod.outlook.com (20.179.32.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.18; Wed, 6 Mar 2019 13:36:43 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::50ed:d1b5:c043:3b79]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::50ed:d1b5:c043:3b79%2]) with mapi id 15.20.1686.016; Wed, 6 Mar 2019
 13:36:43 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     BOUGH CHEN <haibo.chen@nxp.com>, Stefan Agner <stefan@agner.ch>
CC:     Christina Quast <cquast@hanoverdisplays.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Document: dt: binding: imx: Fix PAD_CTL_DSE_X*
Thread-Topic: [PATCH] Document: dt: binding: imx: Fix PAD_CTL_DSE_X*
Thread-Index: AQHUytCIfTFXSadJckWCjEy0gWR0oKXyA8SQgAATHICAClra8IACAHHAgAA7I0A=
Date:   Wed, 6 Mar 2019 13:36:42 +0000
Message-ID: <AM0PR04MB42118ED0DB09896BB860AF7C80730@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190222170038.9669-1-cquast@hanoverdisplays.com>
 <VI1PR04MB42227AA158BA1FCBF314AA27807B0@VI1PR04MB4222.eurprd04.prod.outlook.com>
 <db6c2755e80e41f7c169406c213a40e8@agner.ch>
 <AM0PR04MB4211737BF7A85E15090636BD80720@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <VI1PR04MB504036C9FA56673680279BB190730@VI1PR04MB5040.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB504036C9FA56673680279BB190730@VI1PR04MB5040.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16031107-a854-47c9-aadd-08d6a238c541
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB6209;
x-ms-traffictypediagnostic: AM0PR04MB6209:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM0PR04MB6209;23:47T6FphPP76e//jxKl150fmyF24SIZ/xTdWKwckKX?=
 =?us-ascii?Q?st4p1hN/Bj7mm00c4r4O9bsyOu4WqUUVV3Sn6v1+NMM0wyBKh1pslHc9WAud?=
 =?us-ascii?Q?bRCB19c/VR7BbA/0Y6sQw8GYNWRmPv4IpVCbQ32jYu16qLTSNzNHYpl+AKRa?=
 =?us-ascii?Q?b4AAQBukg2pKgZq4gfZ80jzZi0rM6kD4PE1NY5TknZMhtFcRJq7lKwPU+K+0?=
 =?us-ascii?Q?33UAocIXTDH/a0LEhQ/YxZ7EgghCd+VI6Y2fzU2eCgmAipVnaObiMAOw2sTX?=
 =?us-ascii?Q?Bkh+BVuvZA1Bqk1fZfLx7HO3N/Wl0m15E5Aic5LpMJIUyD0RiojxAoSiNVcz?=
 =?us-ascii?Q?mJMSFCHmurCjuYEvBD2g4Ca/t4SX36Rr7PC/l1gpuVqI0s7vs6AAeigjnvw7?=
 =?us-ascii?Q?s1lSBjwWYRSUHoBmGy6ViXPPcHH8vYROeBMxoqcJJbrj3E+skqAORWat0bEJ?=
 =?us-ascii?Q?E20oFdaWKdGXVrw8LWWW2oG+0MdQbQ71ZcQPgWqxV8GKn2xzmZrDwLjULJYI?=
 =?us-ascii?Q?qITTZZ1pF2PqRlTmafNtQOAJb0JmTqH3oFClCd3iUcrPjFOf/OO1XRAJQOW7?=
 =?us-ascii?Q?z9g/YOIAeYlsV0y3Jl7tInCx2SL9zFk0/GeQBS6388/bCxsE6C2XvYQdDneA?=
 =?us-ascii?Q?nYf60UFMmaXxsnvSRPowQUGFu+MSL5+3SworafCV47NxjmpKWU8tabwj0D8n?=
 =?us-ascii?Q?PLDGvGLc0/xNnygrBCmFtH/J4sguUO2CrkCj2qAdSbyq439ykEgVn+psxcEN?=
 =?us-ascii?Q?921cy/Bdegtn2jtzcdgGcr77WCrvla8ACOffxAgPO1aUHJcRZWQVgbArWPYM?=
 =?us-ascii?Q?w5ngTFZZCHWNf0m5G1ZM3TICc1uB4bdb6IwUZ/1gyZVr3OFtfKZeYyJ65XVB?=
 =?us-ascii?Q?HYmbvqCOcROJXDMTyjbnu0hdz70C5Om6cIq3MDi1pIgXmBhKgm/Nl5GmoHSN?=
 =?us-ascii?Q?7BFJjXxGhDf4i96G0Ter1JDQmEkSUQA2kcSsuwqkyVZPjbEZ6Ix+LX806Gkb?=
 =?us-ascii?Q?7DzSSl442XeUKbkW5UXSGgtbOZGuzjxfutwzzW1mgaeX8a/TulCsRA+izxg8?=
 =?us-ascii?Q?WHlCOVnhICSnDqNn/iecz/LPy0SqrE5hx+xy6X8QU8ZSSOkDTGqRSOelGxrr?=
 =?us-ascii?Q?GOPM6TSv1DLxqi+aeZVP9KY8hzinvB8SMocqcVfrzgAMeDkaVuPIGbWzMxe4?=
 =?us-ascii?Q?XUyPCiq8ROMvHulCZ4wlMVJErEWl7BvLujZ2EM89pn2UYvpiGPeDhOmuxisU?=
 =?us-ascii?Q?iJeMYbD6hGQfYxBNTC4scSByJinSBs96wCXl9E2r6TYi6+pjqfqaxoJSMTp/?=
 =?us-ascii?B?dz09?=
x-microsoft-antispam-prvs: <AM0PR04MB62097137A22ABFF6C1C383B180730@AM0PR04MB6209.eurprd04.prod.outlook.com>
x-forefront-prvs: 0968D37274
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(396003)(39860400002)(366004)(189003)(199004)(256004)(7416002)(76176011)(93886005)(4326008)(53936002)(6246003)(186003)(66066001)(52536013)(99286004)(7696005)(97736004)(478600001)(74316002)(86362001)(446003)(14454004)(25786009)(486006)(229853002)(81156014)(305945005)(316002)(476003)(8936002)(68736007)(7736002)(55016002)(26005)(2906002)(71190400001)(71200400001)(6436002)(6506007)(110136005)(102836004)(54906003)(44832011)(81166006)(8676002)(33656002)(11346002)(14444005)(9686003)(5660300002)(6116002)(3846002)(105586002)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6209;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: O8j11z65A5u4kkHZxuL/yrNqHT7sqfvPbT6nS0XExlO5mtrqYzHskngvNjpMTbdqttSlDDHsZSJPnLZkXvcGYKpnmVFm53QVVPxMRbssEODQqemHZz2mJXpimq1Jl+l8I7N7aj2UPpl3tFZb8FBwJ0+NSSLiIq63quA7dx6mIOy6/kOVOpp818Zrvw3xJKQ0LXIS71tVL/MggVTxJ3T1Oz+TzaAgeMq+n5y4JXLRuCVgHudgKysJerSsj+haMJHKu0Qy8ANxSSDS+o4ol94xlgbfkd1/5vUBY97cUKnHCpuE6TaP1S6NeQt84NVlIrAbc4HI6SzvAkT2qqQYRgHSjxKO0UifbnHw7kT0JmeneBMvBZxJ42o0UN9+S0ZnJnFzc7/sSBi1qmEl384rHZAnX2HRVaZ4eNlXjufEE4NL468=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16031107-a854-47c9-aadd-08d6a238c541
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2019 13:36:42.9816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6209
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> > > Btw, I saw that imx7d-sdb.dts (and probably other i.MX 7 boards too)
> > > use three different settings for usdhc pinctrl: 0x59, 0x5a and 0x5b
> > > (for default, 100MHz and 200MHz respectively). One would expect that
> > > higher frequency use higher driver strength (and this is the case for=
 i.MX 6).
> > > But with this new/corrected pad values this means we use x4, x2 and
> > > x6 for default, 100MHz and 200MHz respectively. This hardly seems rig=
ht..?
> > > Probably needs fixing too?
> > >
> >
> > Yes, that's true.
> > Especially 100Mhz setting should be updated.
> >
> > Haibo,
> > Can you please help double check if X2 for 50Mhz and X4 for 100Mhz can
> > work stably on MX7D SDB?
> > If yes, we'd like to update the pad setting according to new RM version=
.
> >
>=20
> X2 for high speed and x4 for ddr50/ddr52 can work stable on MX7D SDB.
> I think all the 7D related dts need to fix this. Not sure whether 7S need=
 this fix,
> can you confirm?
>=20

Yes, please make a patch to test board maintainer.

Regards
Dong Aisheng

> Best Regards
> Haibo Chen
