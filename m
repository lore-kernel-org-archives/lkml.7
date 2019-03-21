Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87272C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC7721873
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jeqajlm0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbfCUImr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 04:42:47 -0400
Received: from mail-eopbgr130080.outbound.protection.outlook.com ([40.107.13.80]:41537
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728005AbfCUImq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 04:42:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3JqHmj4IXQREQb3U/EunLkTGHMlctatjVe5PWg1cm4=;
 b=jeqajlm0q8Vev8KDVCbqm16hABFg0F4X6owB9hM529cxL/tiT6VA2k61CfX08b+YlWfXRlXkEkfTtOBCRL54jSU538MGU0Jy+F9Hgj3XsQ2wm1lIOS/gZRYkG91LCjY4KON5QlWeKSrY4gRVTWd87VQM9uFUkaKRNBzZiaAfCQs=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4609.eurprd04.prod.outlook.com (52.135.144.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.15; Thu, 21 Mar 2019 08:42:42 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769%2]) with mapi id 15.20.1709.017; Thu, 21 Mar 2019
 08:42:42 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Steve Twiss <stwiss.opensource@diasemi.com>,
        Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        DEVICETREE <devicetree@vger.kernel.org>,
        LINUX-ARM-KERNEL <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: Re: [PATCH] ARM: dts: imx6qdl-sabresd: change phy-mode to use
 rgmii-id
Thread-Topic: [PATCH] ARM: dts: imx6qdl-sabresd: change phy-mode to use
 rgmii-id
Thread-Index: AQHU3xVQNY2ThIklIUqO9LId/2wrEKYUb2uAgAA/YgCAABENAIABBhEA
Date:   Thu, 21 Mar 2019 08:42:41 +0000
Message-ID: <20190321084240.fveqkhfrbtg7qr4q@fsr-ub1664-175>
References: <20190320120604.7D99B3FBE9@swsrvapps-01.diasemi.com>
 <CAOMZO5AHzQJzz3vd5MzYgSSxzPjU9xan1dFh9473BXeiRCOzzg@mail.gmail.com>
 <VI1PR10MB2352C3A55BE8FABAF3B02681FE410@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
 <CAOMZO5By8=j7gZRAdf2-h-5ak-Qo34rqwDL4+HA_97cMXTAnEQ@mail.gmail.com>
In-Reply-To: <CAOMZO5By8=j7gZRAdf2-h-5ak-Qo34rqwDL4+HA_97cMXTAnEQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 11d5c2ab-02df-46d8-590d-08d6add92e9b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4609;
x-ms-traffictypediagnostic: AM0PR04MB4609:
x-microsoft-antispam-prvs: <AM0PR04MB460918E92A7F3D0D1C0135A9F6420@AM0PR04MB4609.eurprd04.prod.outlook.com>
x-forefront-prvs: 0983EAD6B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(366004)(376002)(39860400002)(396003)(136003)(346002)(189003)(199004)(51914003)(4326008)(446003)(476003)(106356001)(186003)(9686003)(81156014)(11346002)(8676002)(81166006)(486006)(76176011)(7736002)(44832011)(71190400001)(68736007)(71200400001)(305945005)(8936002)(5660300002)(66066001)(105586002)(1076003)(99286004)(478600001)(256004)(14454004)(6512007)(14444005)(6486002)(229853002)(54906003)(93886005)(26005)(102836004)(86362001)(316002)(6246003)(6436002)(53936002)(25786009)(6916009)(6116002)(2906002)(3846002)(53546011)(33716001)(6506007)(97736004)(7416002)(1411001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4609;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: g9mgzK0saWRm9q+aJVPLMCFIB9baC9Y6X6hIF3oxZkUcg1F7lAdspxrHQ3C3AW4/X95XFSIKqEyivtu+6TEct+/aNQmaA3ix5gQEQM3hfNLVfFlKVe9P6Yzv6WJMM6/TcD0otTFiufofjtgU/r2bem+RoKf5ekLNp3YqHUao7YSacyC8oXwvUzTNh0+hvF9L46AdwUKHcO0iT3Wd89zzDgKsGH8IsFeiKLAoGTVDw/czGHgpZ8MJAEa3AJ57fvqpjcNnprnor/gAUM9bFthQ3iD23k+HxKUhvoCG25ymkboxB/9uoHDiwzoT87aQtpe2qL2BKxGDNiyqrPCPnwaWwv6rpReCAplAT2Dc81h0RhThSGWYMrkcRahBBxSsnuMu6R1bB05zL/8KjrG8E5aA0mD7v61AReLxEV7lM4sR0eU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <29C97F4A7987A341B98417C2C544B3F5@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d5c2ab-02df-46d8-590d-08d6add92e9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2019 08:42:41.9884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4609
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-03-20 14:04:42, Fabio Estevam wrote:
> Hi Steve,
>=20
> [Adding Andrew]
>=20
> On Wed, Mar 20, 2019 at 1:03 PM Steve Twiss
> <stwiss.opensource@diasemi.com> wrote:
> >
> > Hi Fabio,
> >
> > On 20 March 2019 12:17, Fabio Estevam wrote:
> > > Subject: Re: [PATCH] ARM: dts: imx6qdl-sabresd: change phy-mode to us=
e rgmii-id
> > >
> > > Hi Steve,
> > >
> > > On Wed, Mar 20, 2019 at 9:06 AM Steve Twiss
> > > <stwiss.opensource@diasemi.com> wrote:
> > > >
> > > > The PHY used on the Freescale i.MX6Q/DL SABRE boards is qualified a=
s
> > > > 'rgmii' instead of 'rgmii-id'. Meaning the RX and TX delays that we=
re
> > >
> > > This patch declares it as 'rgmii-id', which contradicts the commit lo=
g.
> >
> > The PHY used on the Freescale i.MX6Q/DL SABRE boards is qualified as
> > 'rgmii' instead of 'rgmii-id'.
> >
> > Can that be read two ways?
> > I meant the phy-mode is currently qualified as 'rgmii' instead of what =
it
> > should be: 'rgmii-id'.
>=20
> Thanks for the clarification.
>=20
> >
> > [...]
> >
> > > > This patch fixes the network problems seen on the Freescale i.MX6Q/=
DL
> > >
> > > Please provide a Fixes tag. It would be good to know if this fix need=
s
> > > to be applied to older kernels.
> >
> > I didn't put a Fixes tag in because I find this patch fixes v5.1-rc1 (w=
hich I see as broken).
> > But the patch is not needed in v5.0 because I see that as working.
> > So didn't see the need for a Cc: stable.
>=20
> It seems we have other boards that need to be fixed and we can not
> have an old dtb with functional Ethernet with a new kernel.
>=20
> Does anyone know if this issue is AR8031 specific?

I can confirm the same fix is works on imx6sx too.

>=20
> Thanks=
