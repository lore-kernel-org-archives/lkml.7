Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29742C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A5C20842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="P/Nj3nxr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfCEDfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 22:35:04 -0500
Received: from mail-eopbgr40084.outbound.protection.outlook.com ([40.107.4.84]:8593
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726522AbfCEDfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 22:35:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rwjd2Y4sgG5xKUmCR/4S6kXmWse2fKLcxoApngIwFJQ=;
 b=P/Nj3nxrQlAKDrBMX6i72VbjXd+vzMer8akAUlY2pFtsuBxzWa3XCPfDc8cKFQsEFBtkD26/PNaSULP/4E57aSjh6AMkgdkxWzbC8ylcej7dDqLL/gNI7Rpd4scUFicrZ9+Xt8d+FbDVpqteINDnEGFpyW3SdBoFIW3/CkgMW18=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB4338.eurprd04.prod.outlook.com (52.134.91.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.18; Tue, 5 Mar 2019 03:34:57 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::50ed:d1b5:c043:3b79]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::50ed:d1b5:c043:3b79%2]) with mapi id 15.20.1665.020; Tue, 5 Mar 2019
 03:34:57 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Stefan Agner <stefan@agner.ch>, BOUGH CHEN <haibo.chen@nxp.com>
CC:     Christina Quast <cquast@hanoverdisplays.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        BOUGH CHEN <haibo.chen@nxp.com>
Subject: RE: [PATCH] Document: dt: binding: imx: Fix PAD_CTL_DSE_X*
Thread-Topic: [PATCH] Document: dt: binding: imx: Fix PAD_CTL_DSE_X*
Thread-Index: AQHUytCIfTFXSadJckWCjEy0gWR0oKXyA8SQgAATHICAClra8A==
Date:   Tue, 5 Mar 2019 03:34:57 +0000
Message-ID: <AM0PR04MB4211737BF7A85E15090636BD80720@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190222170038.9669-1-cquast@hanoverdisplays.com>
 <VI1PR04MB42227AA158BA1FCBF314AA27807B0@VI1PR04MB4222.eurprd04.prod.outlook.com>
 <db6c2755e80e41f7c169406c213a40e8@agner.ch>
In-Reply-To: <db6c2755e80e41f7c169406c213a40e8@agner.ch>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 607fde5f-90ce-4c13-5e33-08d6a11b8a89
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4338;
x-ms-traffictypediagnostic: AM0PR04MB4338:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM0PR04MB4338;23:ZkoTGvoUvm6FBjaC/sLEyzn8aRmv+mkG5X+93WtQO?=
 =?us-ascii?Q?HMAtkmQQ+XN5b3JNKt2oQZ7bm1KZAkyy/0ACK4ekr8wlI1QhHz11NOHzYcUI?=
 =?us-ascii?Q?iNCCzkyBQSHwPby0sySI+3CsxciGg72yAP7sloQKFFGvXzLkhXvOi7Czhe14?=
 =?us-ascii?Q?73zPg4ObUnTim0EZRgpvSnV4bBqZM8cSePqyaa86c5xCGMtLTgbyBcxuqK+a?=
 =?us-ascii?Q?W47tj87xVPqP8weWmcmefZAtZ7WFH4posVgxp/cbF3lhKR3vwJ4hZp0mi5EU?=
 =?us-ascii?Q?7uG/+N0BKNDS6t5zfgQVpDQ8fDaRfJ23i6vt6ekeoRvObvoTvAeE+2KdlXKZ?=
 =?us-ascii?Q?MtpMfCYD7wKVsZUwhsvo3qohivucezlVvKBybnfD3Aznl/LiKGRehs8EBoN3?=
 =?us-ascii?Q?gZ/fhXJUvcwwzXBut/tvPvFDpBt6WGOD5luW2hjNlpXH4S5w3m92i+7Kl235?=
 =?us-ascii?Q?2DBNrxtvO0eH5yUJ5Q3DIHoaF4KuUAvgHBgfS50xLSvGanVt+YtuPgQxfnLc?=
 =?us-ascii?Q?XRWDF9TwzRzr8PcqUM1gsejJWFKpxLjUYe76YlYYyuYLrDhW2JZVAeWy7mX/?=
 =?us-ascii?Q?/xT7GnL/QZmVY9gfhdrXI0KzC0UrL3au7tTWztcOMuLq72tDaUvTunzxaK5w?=
 =?us-ascii?Q?nXrHES8LHKWwfLjP/JiCRJTym2WANw+EDyfSnjMB/BkejXB/USp8oBTyveJx?=
 =?us-ascii?Q?4YhFr3swt+gQGfIEbTOADo66dTJgYHebG3D2ZnjN96HKaWNFrbz870Qbd/7E?=
 =?us-ascii?Q?f17vLU3ACIKxdckR9YoBKO3LjQuNKTjLWCpcKOsbn+cb99mck6vTUAo4BFXW?=
 =?us-ascii?Q?kG2M8pl7xB+lsuV7cLGTH4c+5cVVSvWwt1093sotFcw2KRQcyJbORROVfzPO?=
 =?us-ascii?Q?/o3vJy8UZv/caQu75ErYz/ksGFtE3xNgQ3pjk+51lWJTRXArU5976Y+2U721?=
 =?us-ascii?Q?vScPluvTo3RVvGI+cM/K6fsEotFrVrkUuUzmiKWZtX/cM9c+SAMRJA/OPrY+?=
 =?us-ascii?Q?gTP08qnymd/FaVUS+y8i/bQ3TruYiGcwiQ4iImCZIZ3T6YujcyTnqohsZKD1?=
 =?us-ascii?Q?OSrxIrAOhA9PPVIg0LChJ5oDVt73wK6YosmcRJvFzbHpPKGuTdb7OCRBX0yv?=
 =?us-ascii?Q?FAnbnsSY4jxAeymPxQ2zL+TbVch+Dbyk5E60XdsMZhB2Iv6Isah+1UiQLN0d?=
 =?us-ascii?Q?5693WlR//hndTg+PwzuQ+IbxS4cAbqds8EG1ts+KkqhJdSy6Uk4gPrEW6m0/?=
 =?us-ascii?Q?b8xlA3TbNv07ZkeHXfJahrHH4vrfcCEPMl799JaxDvmXQsMxshvbiDQMVAP0?=
 =?us-ascii?Q?VVM1eF0wqq4ghq8W1wdIul7noxOt0I9j8X10zXpA0Xh?=
x-microsoft-antispam-prvs: <AM0PR04MB4338EDB5FE6511F93088955A80720@AM0PR04MB4338.eurprd04.prod.outlook.com>
x-forefront-prvs: 0967749BC1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(376002)(396003)(136003)(189003)(199004)(14444005)(52536013)(305945005)(81166006)(71190400001)(81156014)(71200400001)(5024004)(256004)(229853002)(11346002)(446003)(7416002)(6636002)(476003)(486006)(5660300002)(44832011)(74316002)(2906002)(7736002)(6436002)(53936002)(9686003)(55016002)(8936002)(8676002)(97736004)(14454004)(106356001)(478600001)(105586002)(68736007)(6506007)(26005)(99286004)(102836004)(53546011)(316002)(186003)(3846002)(6116002)(86362001)(110136005)(76176011)(54906003)(66066001)(7696005)(4326008)(33656002)(6246003)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4338;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ttvDNZm6kT8NW2dSblvixqIUN2ZqxBCOFl98XarYkWBBBCNRZlBEma435FAMM5iHghV/YcxEJXQ++Kui5W7ewSS13i+Os0mwLTc57VwOhxdrZmiv1NcwRfF4k24DbfgIaalQX358FaTw5DK2GCOKN01i/+oef1z08NEkHN3mVEkPE1x5KETav7QrUgJIr9sxk1I7+2bLKzMisvc7Ts0PbGrVEeDoNHn7qqdLtdD/8ZWbG8AIE5FwhmYnsBnYVKVrmublcG5GCTInfW834cwg760Plhz9hkcQKtleZWfSLt4NUrxom6kMWANJr8fhTweh+D8iqJcRe50ki2oWSAbiwvWPXeJ7N44j/RgT07IygsWycsv+/ScrfWKGxlDN7xhT/iym/QMr2iIrAGAVp1wYV7JEW3BdTPOE9OyfmFlKT6U=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 607fde5f-90ce-4c13-5e33-08d6a11b8a89
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2019 03:34:57.9390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4338
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Haibo

> From: Stefan Agner [mailto:stefan@agner.ch]
> Sent: Tuesday, February 26, 2019 9:22 PM
>=20
> On 26.02.2019 13:21, Aisheng Dong wrote:
> >> From: Christina Quast [mailto:cquast@hanoverdisplays.com]
> >> Sent: Saturday, February 23, 2019 1:01 AM
> >>
> >> In the iMX7d datasheet, the PAD_CTL_DSE_X* values are different from
> >> the documentation.
> >>
> >
> > It's a doc problem.
> > Latest RM seems got updated.
> >
> > As here it's a reference definition in binding doc and device tree
> > actually does not use it (IMX Pinctrl use raw data to set pad
> > configuration). So it won't cause any compatibility issue to me.
> >
> > Please update the patch title to:
> > dt-bindings: pinctrl: imx7d: xxxxx
> >
> > Otherwise:
> > Ack-by: Dong Aisheng <aisheng.dong@nxp.com>
>=20
> Btw, I saw that imx7d-sdb.dts (and probably other i.MX 7 boards too) use =
three
> different settings for usdhc pinctrl: 0x59, 0x5a and 0x5b (for default, 1=
00MHz
> and 200MHz respectively). One would expect that higher frequency use high=
er
> driver strength (and this is the case for i.MX 6).
> But with this new/corrected pad values this means we use x4, x2 and x6 fo=
r
> default, 100MHz and 200MHz respectively. This hardly seems right..?
> Probably needs fixing too?
>=20

Yes, that's true.
Especially 100Mhz setting should be updated.

Haibo,
Can you please help double check if X2 for 50Mhz and X4 for 100Mhz can work=
 stably
on MX7D SDB?
If yes, we'd like to update the pad setting according to new RM version.

Regards
Dong Aisheng

> --
> Stefan
>=20
>=20
> >
> > Regards
> > Dong Aisheng
> >
> >> Signed-off-by: Christina Quast <cquast@hanoverdisplays.com>
> >> ---
> >>  .../devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt       | 6 +++--=
-
> >>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git
> >> a/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt
> >> b/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt
> >> index 6666277c3acb..8ac1d0851a0f 100644
> >> --- a/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt
> >> +++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt
> >> @@ -48,9 +48,9 @@ PAD_CTL_HYS                     (1 << 3)
> >>  PAD_CTL_SRE_SLOW                (1 << 2)
> >>  PAD_CTL_SRE_FAST                (0 << 2)
> >>  PAD_CTL_DSE_X1                  (0 << 0)
> >> -PAD_CTL_DSE_X2                  (1 << 0)
> >> -PAD_CTL_DSE_X3                  (2 << 0)
> >> -PAD_CTL_DSE_X4                  (3 << 0)
> >> +PAD_CTL_DSE_X4                  (1 << 0)
> >> +PAD_CTL_DSE_X2                  (2 << 0)
> >> +PAD_CTL_DSE_X6                  (3 << 0)
> >>
> >
> >
> >>  Examples:
> >>  While iomuxc-lpsr is intended to be used by dedicated peripherals to
> >> take
> >> --
> >> 2.20.1
> >>
> >>
> >>
> >>
> >>
> >> Please consider the environment before printing this email
> >>
> >>
> >>
> >>
> >>
> >> The information transmitted is intended only for the person or entity
> >> to which it is addressed and may contain confidential and/or
> >> privileged material. Any review, retransmission, dissemination or
> >> other use of, or taking of any action in reliance upon, this
> >> information by persons or entities other than the intended recipient i=
s
> prohibited.
> >> If you received this in error, please contact the sender or
> >> postmaster
> >> (postmaster@hanoverdisplays.com) and delete the material from any
> >> computer.
> >> Although we routinely screen for viruses, addressees should check
> >> this e-mail and any attachment for viruses. We make no warranty as to
> >> absence of viruses in this e-mail or any attachments.
> >> Our Company's email policy is to permit incidental personal use. If
> >> this email is of a personal nature, it must not be relied upon as
> >> expressing the views or opinions of the company.
