Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5EEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4ED2184A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZohBSR9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731389AbfB1O2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:28:23 -0500
Received: from mail-eopbgr20051.outbound.protection.outlook.com ([40.107.2.51]:58607
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725918AbfB1O2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:28:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuWfuj9e/+cszLVRDUQd7zfg0uiKVfV2GHI1B36br/4=;
 b=ZohBSR9T17Uq1AD5G+RTzdVasEggHvoh6OSZtt03qa7Ugj9GTlfjCBLB3dFuJuN8ZBSjStfRGoQTLiD6bExT82J2rF1YUxLW3RZQoYbfsM5QS3EHGBQfLfjvAr3bJdTsBZ+5lRGtAQNFHXtuDafMlHdDidSl6TcpOwQpgvFkvY8=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4675.eurprd04.prod.outlook.com (52.135.144.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.21; Thu, 28 Feb 2019 14:28:18 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c%3]) with mapi id 15.20.1643.022; Thu, 28 Feb 2019
 14:28:18 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Angus Ainslie <angus.ainslie@puri.sm>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 3/3] arm64: dts: imx8mq: Add the opp table and cores
 opp properties
Thread-Topic: [PATCH v2 3/3] arm64: dts: imx8mq: Add the opp table and cores
 opp properties
Thread-Index: AQHUxVlNIq31A6OcskGGyy1wv+2NnaX1VtMAgAACK4A=
Date:   Thu, 28 Feb 2019 14:28:18 +0000
Message-ID: <20190228142817.wxgv5u5y6v5rncwo@fsr-ub1664-175>
References: <1550254032-16451-1-git-send-email-abel.vesa@nxp.com>
 <1550254032-16451-4-git-send-email-abel.vesa@nxp.com>
 <20190228142030.GB29231@dragon>
In-Reply-To: <20190228142030.GB29231@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dbf3831e-58fd-4213-2b05-08d69d88fbfb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4675;
x-ms-traffictypediagnostic: AM0PR04MB4675:
x-ms-exchange-purlcount: 2
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM0PR04MB4675;23:VYAmmGezwa11X4FqRAU6iGgbAX2MRh03nyK1So8jY?=
 =?us-ascii?Q?fxUPACPG/wpQBCxoiofW8O4v6V5dL9sGdxjt4sJs7UIxYwlxYZbab9b+TMla?=
 =?us-ascii?Q?ZIm9QxVc/7jdkGT0OErMHvBepbMKyWuHDLxiejeMajvaB/2PmVtXs1BtPpDX?=
 =?us-ascii?Q?zs/RS4QpVxFtb8TvMEKDkiGlHprvxxXoWccueEYcVIJiC4v8gfJa6nuupCrr?=
 =?us-ascii?Q?qlGesH3+9gZjDtj/vAEATdPhetRfK6tEZH7qFe90IwuSSMrWkpmknxEB33iG?=
 =?us-ascii?Q?rc1T+RaYAosTL5bxrXGJ/OYLOOsklwbdsP73cB1JpdFXpzOTuzE2OKDWErS6?=
 =?us-ascii?Q?R1dNGiPoh00co0iJ7WjGp6DKmhACsP875i5P94jSyzXlKu/xBqIMEcQ5lbWw?=
 =?us-ascii?Q?B9+mWLblhNzX6/RMDN5UyvWxE5cGMGP7iBQJrv/aufCKBv1Ii+rzCW1amRDx?=
 =?us-ascii?Q?hZyki8HjgLOtkOzUQmuko+Ho03CwJibmTUGqb3fdSssTGqK6wrksm5GGmHtj?=
 =?us-ascii?Q?NKyjP8OCIDmg1J5l4sEFN+GUZwQjBybWfRc1sU2JeXIv0gLw0hE7Gkcn4068?=
 =?us-ascii?Q?1Q5l3u60u+6UpDPUiuaD/X69uJJZlsuU5OJDGDIJFuvId2VVTHOksEgDUClY?=
 =?us-ascii?Q?MblSWZwryQK8SihBiAcYyY81d5ZIkDG5mjoS4m097D+8BiM4eY5RfDQyiP0P?=
 =?us-ascii?Q?zT8HKXsa7kW7h28E4T0m04KBMDK2G23XB/dtRpuM0vvXfol2CcNa8YjgSmk+?=
 =?us-ascii?Q?235u6425gXy57bcx64qIHRc26Jt37XnS7A7vsbbUGMFal670IgvBQAlxN4oD?=
 =?us-ascii?Q?mDlFdJPu9AHmTdDcclwqbWTn70RG83Tx+8X9bk1t8f0j4gf8ra4BFv6V8NuP?=
 =?us-ascii?Q?Xm64JhTA9t5fJ6VOKlbr3nIAcXONrOADW5nvcQ39XfrFS88I4ebk3UcWpJ37?=
 =?us-ascii?Q?rPiuiQKAiGf0dGsJhr/5lnF6is0MDxgRJ9ueDj65/JISGeD5HtYp0FMMx50A?=
 =?us-ascii?Q?LxfxDyq1oN/D5FUjd06XcgGjuCPBek2Z+DB6lZHDqDuA4XtgFPtOk0LhBnl4?=
 =?us-ascii?Q?ybcvrIGp8ty8BzY2Q17fbMB1w6DjRcgzXS393yGYIqgnb3790yeedSsWSAOA?=
 =?us-ascii?Q?BX0/UEX+97hTwFUmOXi4NookfQQmxGg/x7a6nm9G1rRMOTOV/PEUAXuAnL//?=
 =?us-ascii?Q?pt6QO6jDGSgNbMdjPewDxxDk/SMaUHVSqJCgXoMiC0Tz5Y8lsiRmsj3M4Jv0?=
 =?us-ascii?Q?Oq5XRB4wDHs3SfhvCrmopHpJDCSPzQgnjiwvr6+thD23Sdnl0esQ4eBjaY/4?=
 =?us-ascii?Q?QQl4EOYJlpgahkW9rWq9pNIJNhe0/cOpnECnDNC88Y06wwKocjWa59/Helsg?=
 =?us-ascii?Q?mQiYw=3D=3D?=
x-microsoft-antispam-prvs: <AM0PR04MB4675B0EEDCC09D2875024255F6750@AM0PR04MB4675.eurprd04.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(376002)(366004)(346002)(136003)(396003)(39860400002)(199004)(189003)(316002)(97736004)(76176011)(6506007)(53546011)(486006)(6246003)(102836004)(54906003)(106356001)(99286004)(14454004)(229853002)(6486002)(44832011)(2906002)(105586002)(476003)(9686003)(6306002)(53936002)(6512007)(8676002)(6436002)(11346002)(45080400002)(25786009)(6116002)(66066001)(186003)(966005)(4326008)(81166006)(81156014)(5660300002)(86362001)(446003)(26005)(33716001)(256004)(6916009)(3846002)(7736002)(478600001)(1076003)(305945005)(8936002)(71190400001)(68736007)(14444005)(71200400001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4675;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mnaNbayIdCdSGM6GHqXj/g47cUeN0ldd90PJDIHSUEfpAkuOUuDFwdREjE4tpsVUpkRkj0aiqFo0WoJ0hJJXIv18CtUqqJKvxIAAnxHOuw4LyTLPA+VAztYW+SpBbcTFmjFFWch5TPqMEWubPUYG+/E2g1MgNb/ugAPUKLtDoSotaEBu6jS6ROYX684pcg6ygjipuDzClxR+styZ8xhky5VuDlJwi0VayVHIr9AwC/ERqgBpmntQFfpOKt/blRoRNkrXGqSaBiC/Z9kMxWWgxOcheEGtfyE52xcpIs8UMOKHT4Pq64wHbc2t6uD7eseFN8877fQlVT9lTdGZ1H1n9SbvC+BfW3pWqdi8Kk588ajCpFmYtly+xp/EFBJ+udn3dI7/d9HCVjG7tEw4UvQkJ15IiqWVUjvGdwcABtHDX2k=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <750FFEAC4349A1428AC36753A9F5524A@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbf3831e-58fd-4213-2b05-08d69d88fbfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 14:28:18.7138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4675
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-02-28 22:20:32, Shawn Guo wrote:
> On Fri, Feb 15, 2019 at 06:07:24PM +0000, Abel Vesa wrote:
> > Add the 0.8GHz and 1GHz opps. According to the datasheet:
> > https://emea01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fww=
w.nxp.com%2Fdocs%2Fen%2Fdata-sheet%2FIMX8MDQLQIEC.pdf&amp;data=3D02%7C01%7C=
abel.vesa%40nxp.com%7C05d898b625824204bb3908d69d880aaf%7C686ea1d3bc2b4c6fa9=
2cd99c5c301635%7C0%7C1%7C636869604952370425&amp;sdata=3DyDuM%2ByO%2F9twQ3cX=
TR%2FkCSSfxOMm015qG%2FfBSFZC91SQ%3D&amp;reserved=3D0
> > section 3.1.3 Operating ranges.
> >=20
> > The 0.8GHz opp runs in nominal mode with the regulator set to 0.9V.
> > The 1GHz runs in overdrive mode with the regulator set to 1V.
> >=20
> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >=20
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boo=
t/dts/freescale/imx8mq.dtsi
> > index 1a89062..ebdec9e 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > @@ -91,6 +91,7 @@
> >  			clocks =3D <&clk IMX8MQ_CLK_ARM>;
> >  			enable-method =3D "psci";
> >  			next-level-cache =3D <&A53_L2>;
> > +			operating-points-v2 =3D <&a53_0_opp_table>;
> >  		};
> > =20
> >  		A53_1: cpu@1 {
> > @@ -101,6 +102,7 @@
> >  			clocks =3D <&clk IMX8MQ_CLK_ARM>;
> >  			enable-method =3D "psci";
> >  			next-level-cache =3D <&A53_L2>;
> > +			operating-points-v2 =3D <&a53_0_opp_table>;
> >  		};
> > =20
> >  		A53_2: cpu@2 {
> > @@ -111,6 +113,7 @@
> >  			clocks =3D <&clk IMX8MQ_CLK_ARM>;
> >  			enable-method =3D "psci";
> >  			next-level-cache =3D <&A53_L2>;
> > +			operating-points-v2 =3D <&a53_0_opp_table>;
> >  		};
> > =20
> >  		A53_3: cpu@3 {
> > @@ -121,6 +124,7 @@
> >  			clocks =3D <&clk IMX8MQ_CLK_ARM>;
> >  			enable-method =3D "psci";
> >  			next-level-cache =3D <&A53_L2>;
> > +			operating-points-v2 =3D <&a53_0_opp_table>;
> >  		};
> > =20
> >  		A53_L2: l2-cache0 {
> > @@ -666,6 +670,25 @@
> >  			status =3D "disabled";
> >  		};
> > =20
> > +
> > +		a53_0_opp_table: opp-table {
>=20
> What's the point of having '0' in the label name, considering it's
> actually referred by all CPU nodes?
>=20

Good catch. Will remove and resend.

Thanks.

> Shawn
>=20
> > +			compatible =3D "operating-points-v2";
> > +			opp-shared;
> > +
> > +			opp-800000000 {
> > +				opp-hz =3D /bits/ 64 <800000000>;
> > +				opp-microvolt =3D <900000>;
> > +				clock-latency-ns =3D <150000>;
> > +			};
> > +
> > +			opp-1000000000 {
> > +				opp-hz =3D /bits/ 64 <1000000000>;
> > +				opp-microvolt =3D <1000000>;
> > +				clock-latency-ns =3D <150000>;
> > +				opp-suspend;
> > +			};
> > +		};
> > +
> >  		gic: interrupt-controller@38800000 {
> >  			compatible =3D "arm,gic-v3";
> >  			reg =3D <0x38800000 0x10000>,	/* GIC Dist */
> > --=20
> > 2.7.4
> >=20
> >=20
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > https://emea01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Flis=
ts.infradead.org%2Fmailman%2Flistinfo%2Flinux-arm-kernel&amp;data=3D02%7C01=
%7Cabel.vesa%40nxp.com%7C05d898b625824204bb3908d69d880aaf%7C686ea1d3bc2b4c6=
fa92cd99c5c301635%7C0%7C1%7C636869604952370425&amp;sdata=3DHD1WvWQJGR319rM5=
OrQRXRLU2zEuHzEeLMkq3vbi3OA%3D&amp;reserved=3D0=
