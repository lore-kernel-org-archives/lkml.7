Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF66C10F14
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 03:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACBE82075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 03:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AzyqcoB+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfDVDab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 23:30:31 -0400
Received: from mail-eopbgr00086.outbound.protection.outlook.com ([40.107.0.86]:61512
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726210AbfDVDaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 23:30:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GElqonMv/oWzeaQXPVxre9Pbx4aH0LWEItyQklbn0uc=;
 b=AzyqcoB+rcGrDFmmQa8mDFU3mxal7TF0iY2NZpx+XKkHN4Q4W7chXAJe+v4rshiHJCT5FMhUkhzDq2MszqKi9JZN19QeqYFpt/Aipusg2f2MKtZ4MaOOzvKJojyAh98FqIhanq5cIQQt3wQndvNjkXqgpzdeG+I1lwoun+q7Vac=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6445.eurprd04.prod.outlook.com (20.179.232.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Mon, 22 Apr 2019 03:30:26 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311%7]) with mapi id 15.20.1813.017; Mon, 22 Apr 2019
 03:30:26 +0000
From:   "S.j. Wang" <shengjiu.wang@nxp.com>
To:     Nicolin Chen <nicoleotsuka@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: imx: Add mclk0 clock for SAI
Thread-Topic: [PATCH] ARM: dts: imx: Add mclk0 clock for SAI
Thread-Index: AdT4uuVRukjA0rRgTeifBXCEXrMHAQ==
Date:   Mon, 22 Apr 2019 03:30:26 +0000
Message-ID: <VE1PR04MB647951B20E0F334FF1CC3B7AE3220@VE1PR04MB6479.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6671b6d-87e6-4d13-23dc-08d6c6d2dca2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VE1PR04MB6445;
x-ms-traffictypediagnostic: VE1PR04MB6445:
x-microsoft-antispam-prvs: <VE1PR04MB6445D96BA9F96697FA4B6635E3220@VE1PR04MB6445.eurprd04.prod.outlook.com>
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(39860400002)(366004)(376002)(199004)(189003)(99286004)(6116002)(3846002)(7696005)(6246003)(478600001)(25786009)(54906003)(110136005)(316002)(256004)(4326008)(74316002)(2906002)(86362001)(6636002)(229853002)(6506007)(97736004)(7736002)(305945005)(186003)(26005)(102836004)(6436002)(66066001)(33656002)(81156014)(476003)(71190400001)(71200400001)(68736007)(53936002)(5660300002)(76116006)(73956011)(66946007)(14454004)(66476007)(66556008)(64756008)(66446008)(8676002)(52536014)(486006)(8936002)(55016002)(81166006)(7416002)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6445;H:VE1PR04MB6479.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ycfF1jhJyIO0/Jtfk9PWQLsFIdEo3vCh+vWGqt3OuObu/XKh8v19YQ52Jfw41NxMIZuk7Sce32suaBp6dDSuy8drEuFD67XCgS2LHELfHTOmS/Mn48xftWAMcGtONEE2l9GGu5Zk99G30xLTnIXhiIF9QImQc7ciCuAV6nFL26qpc4eBIfO9qOqV0fKbk8EU6Kwos+ZmH1bqqgOlWI8C16k1OZjRXoQAGQgjMsqmdazjqLbl5Vz6hMk7KUI3Or3BeF5JuODRwWDoti78IQq46snWSIk5f8sESAq+D0x6mcqIvrVTxq9IOclt1eacCOXUNY7vGy5Gmx9enDcdoapcN9JUyY2Wz1OeqYXRuwj4c4r4OPtEvzKEsgcvEA+NUyB6hj9iyaomdbPW3lFOlNL58gv0Pf1aeodXnNOGMsNo+JM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6671b6d-87e6-4d13-23dc-08d6c6d2dca2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 03:30:26.5668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6445
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

>=20
>=20
> On Sat, Apr 20, 2019 at 09:12:52AM +0000, Daniel Baluta wrote:
> > From: Shengjiu Wang <shengjiu.wang@nxp.com>
> >
> > SAI has 4 clock sources, which can be selected using MSEL bit of SAI
> > TCR2 register.
>=20
> I have a doubt at this statement. As far as I can understand, this MSEL i=
s
> probably used by its internal clock MUX, so it's not really proving that =
SAI
> has 4 MCLK inputs. What I know is that SAI block itself only has 3 MCLK
> inputs as we defined in DT. It's just internally connects bus clock or MC=
LK1
> to input0 of clock MUX's and connects MCLK[1-3] to input[1-3]. So adding =
an
> MCLK0 here doesn't sound a right way to me. Unless someone can justify
> for it, I think we should just fix it from driver side.
>=20
> Thanks
> Nicolin
>

The MSEL bit width is 2 bit, so there is 4 options,  the MCLK0 maybe the sa=
me input as
MCLK1 or bus clock as you said, so we think may be better to show this rela=
tion in DT,=20
And this is DT's capability.  Driver don't care about which clock connect t=
o MCLK0,=20
it only need to know there is 4 MCLK from DT.=20

Best regards
Wang shengjiu

=20

