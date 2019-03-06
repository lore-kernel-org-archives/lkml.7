Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0ACC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 08:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A60206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 08:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dogEcHew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbfCFIZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 03:25:13 -0500
Received: from mail-eopbgr140083.outbound.protection.outlook.com ([40.107.14.83]:2334
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729113AbfCFIZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 03:25:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbrwoxL+4LYEmdJgt24KKmS/XzME2eTaXoFOqh+eSLA=;
 b=dogEcHewTkqeKgg1WszgaobKbKtZ4DDhqZLL/zek/C+kGO0DxmRi7aTw96acy3ypXPAnizNpoiHEQ8advOWqyDB19RSA5EqidaIapEUm5Wus/kHklvcqwVznzIacaJO2DFd9DIrqz+whUVm0nm9CAgtVHrp9ptpPhiIXkJ+U/wE=
Received: from DB7PR04MB4058.eurprd04.prod.outlook.com (52.135.130.23) by
 DB7PR04MB4859.eurprd04.prod.outlook.com (20.176.234.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.16; Wed, 6 Mar 2019 08:25:08 +0000
Received: from DB7PR04MB4058.eurprd04.prod.outlook.com
 ([fe80::c0f7:5662:df0c:49a6]) by DB7PR04MB4058.eurprd04.prod.outlook.com
 ([fe80::c0f7:5662:df0c:49a6%5]) with mapi id 15.20.1665.020; Wed, 6 Mar 2019
 08:25:08 +0000
From:   Alison Wang <alison.wang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     Leo Li <leoyang.li@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] arm64: dts: ls1028a: add pmu dt nodes
Thread-Topic: [PATCH] arm64: dts: ls1028a: add pmu dt nodes
Thread-Index: AQHUzkC2wiMK8wZiykaPBnEoBfBm1KX6vEYAgAOFqPA=
Date:   Wed, 6 Mar 2019 08:25:08 +0000
Message-ID: <DB7PR04MB4058729B6DDC6767647AD716F4730@DB7PR04MB4058.eurprd04.prod.outlook.com>
References: <20190227015752.18342-1-alison.wang@nxp.com>
 <20190304014838.GV26041@dragon>
In-Reply-To: <20190304014838.GV26041@dragon>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=alison.wang@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ed3f8f5-cd52-4cb9-b984-08d6a20d3e9f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4859;
x-ms-traffictypediagnostic: DB7PR04MB4859:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;DB7PR04MB4859;23:KO/w4I4r6oc1aOUUQYrtD3hSaoDfzWQ3lEAMDG+2K?=
 =?us-ascii?Q?wfUcJ0hcrqvc0iL5TLS7rkmUNytSDkFxotG9soSbJ6uZVILu4CsOOPMbuqK0?=
 =?us-ascii?Q?f3FkLFV+oEsIrb2UH8e9ZHYk0d3nx3VChpb5QtMoBm+S3nkemvtVNRnO6YwA?=
 =?us-ascii?Q?tE/VdHrEez0lmnE7k88mNSpjSLJWG8FZv3zk/dzyGGorsT5QW4qw0yKDNhvy?=
 =?us-ascii?Q?mhsoZaDhEhXBrX2lDFYEMq/DGfG0DDg/OWRQ6rnckjR0NlT4gEAlVD+f4/k9?=
 =?us-ascii?Q?eDsIV14X+Xor0NRG7MwVHCgDhybrGiK+fjK6XEgz0WG+B7uPPV4EYBgyIYDz?=
 =?us-ascii?Q?YfBz0nw4tcvK1bkkdLkhYqP9YGSw6X/I3tLOo6gh4OgghiDBsQFUggtPcyCS?=
 =?us-ascii?Q?YhedV8pCGU6VBmOal3yjmUm47pRjylkBGde4kb503TXA4bZhtuLwCtSR+BxC?=
 =?us-ascii?Q?I/DWQITKOzgwfdeaG/YsuBY2KiqxrvGuta1DVmhcu8WDmFf5q20XY+RmodIz?=
 =?us-ascii?Q?oMIzO56XXuPUWWDNb5fZrorO39x7oB5clw+2XR4jYvvIiZhwbFc4zyWrddXo?=
 =?us-ascii?Q?nHD8AmHes++pIPGmxnZw8lpv4CvNISCILbOYK7SJnldYKTnw6a0fcAjhCAc8?=
 =?us-ascii?Q?ctijszkCv4++EsEXLHKBrebXMQjRnMbIc5KJrnS7azPHM6vYEoshk/oUhV2/?=
 =?us-ascii?Q?Ny+XsO/8LQIq0V2yW9wKyhl86TM17EOIxy0cVeJH8K1BqQuaWwbqWYWSGYO7?=
 =?us-ascii?Q?syzh8HziNCSpe8kw2d2Nq8fjqf1yOUewK6Vfltyw1yOJHMsLIBoaSmH6wijZ?=
 =?us-ascii?Q?uhbBhMlezD6NfY2EbjEf3MOBuNXngM+w+JD8VEgDGV58xztZRDoIIMhxLU9P?=
 =?us-ascii?Q?G6qHgCLRiMYucQ1Yt2GfB1QzRbaE9hszV7UqjnnUbWKbQSDZyFOSh7e6/Iq0?=
 =?us-ascii?Q?jnzxAL8l4eSuq11QMtziCkPYlJzjHRZQDFRKsXJsmJ9RuzZCrEYaNhBTOM2f?=
 =?us-ascii?Q?IjxkTApvlecb3YIVeJ8htW+Gk1i3GHo4AfmlZAdaMUy8xN8CjXVWZqTSZd8o?=
 =?us-ascii?Q?qa1T+6ocaVqiw+BIUav+8X0Q38eR50xqIl1QxyEo8sTldFXE4UwIquq8LY9p?=
 =?us-ascii?Q?4K+zgRvxuHK3wpaqzi+OiB1SnnaCtMrQL1IQA98RTgbamK88b+zD4Y2a1S7T?=
 =?us-ascii?Q?LsnESzekPQJG3+MUE22pLNGJ6arlBd4Ex48HyXGMIM0WekqWEy5LkvOnDjA6?=
 =?us-ascii?Q?yjJzkyWsFK0u1ccX6Q=3D?=
x-microsoft-antispam-prvs: <DB7PR04MB48593E31CD5104A4733F14EDF4730@DB7PR04MB4859.eurprd04.prod.outlook.com>
x-forefront-prvs: 0968D37274
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(376002)(346002)(39860400002)(189003)(199004)(74316002)(229853002)(305945005)(86362001)(6436002)(106356001)(105586002)(54906003)(3846002)(316002)(97736004)(33656002)(25786009)(7736002)(66066001)(6916009)(14454004)(2906002)(26005)(186003)(6116002)(102836004)(4326008)(53936002)(6246003)(4744005)(52536013)(5660300002)(476003)(6506007)(68736007)(8936002)(11346002)(446003)(256004)(44832011)(55016002)(8676002)(81156014)(81166006)(76176011)(486006)(99286004)(7696005)(478600001)(71190400001)(71200400001)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4859;H:DB7PR04MB4058.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GE74hUyCPrpNQ7c9/jaJg8kQM6/u6Xb3hDNLGL7o0X+RjHOwkDjFuK5dLlE1v6Qkilv1SYniQrEWjmWTW8wuLt1OtS+bEcHPKHqp4MND8qyRRlbshaIhPDkdiTT49Xw+O9H1woMeaAgpYnsZLFZfZVAQqI8A8+B9nREqJ/E6tzxPZW88I4MmXmoJgFSGkYSpHq5bJ+WTDf8/U0pibNihzfSoG4OQkOCA8sCbSwSWxXPVVtXLeowt4MiMl5Tscb52KHQ6VvFdkbz91fg4JsWWAID6ygG1umoho/4TSMRBR4czf1yL++zCJEiRiq+6kCWJxuF4jMG2WrWQpWOm/1Mpqg/j+vJijkJ461oh+9CnWJbeJS5QdEo7qB/z0ewIza3c6pqtkj49cBUwB4dYUaolicXrLDY1/Q+iWw3j84ByNko=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed3f8f5-cd52-4cb9-b984-08d6a20d3e9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2019 08:25:08.7362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4859
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Shawn,

> On Wed, Feb 27, 2019 at 09:57:52AM +0800, Alison Wang wrote:
> > This patch adds pmu dt nodes for LS1028A.
> >
> > Signed-off-by: Alison Wang <alison.wang@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi |    5 +++++
> >  1 files changed, 5 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > index a8cf92a..36ef9c5 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > @@ -89,6 +89,11 @@
> >  					  IRQ_TYPE_LEVEL_LOW)>;
> >  	};
> >
> > +	pmu {
> > +		compatible =3D "arm,armv8-pmuv3";
>=20
> Shouldn't we use "arm,cortex-a72-pmu" as compatible for better?
>=20
[Alison] Yes, it is better as compatible. I will change it in v2.
Thanks.


Best Regards,
Alison Wang

> Shawn
>=20
> > +		interrupts =3D <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
> > +	};
> > +
> >  	gic: interrupt-controller@6000000 {
> >  		compatible=3D "arm,gic-v3";
> >  		#address-cells =3D <2>;
> > --
> > 1.7.1
> >
