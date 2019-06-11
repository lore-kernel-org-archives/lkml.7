Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C34C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 08:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B732173B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 08:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RBMXNht1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391356AbfFKIgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 04:36:55 -0400
Received: from mail-eopbgr60072.outbound.protection.outlook.com ([40.107.6.72]:11059
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391272AbfFKIgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 04:36:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7lK2MUaoyrUfKVctNJy5kA4pdqQxlgdqLXtUfuyt4z4=;
 b=RBMXNht1svF3miDhSkFi/KjOZRaeJEiXzLulLYu21uB4lgWDs7Jo2X9gDp6ZLbPxVWhTWNJHOY8J7waN0HWgXcFH4rR15ZVH6dszNRuDYuQlvTry6g/zjs4P08xNoIzq89fIIECXR6tm4PtT+r53x6bxArqfAXGPhkbxcGAcEvw=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5810.eurprd04.prod.outlook.com (20.178.117.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.13; Tue, 11 Jun 2019 08:36:52 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6090:1f0b:b85b:8015]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6090:1f0b:b85b:8015%3]) with mapi id 15.20.1965.017; Tue, 11 Jun 2019
 08:36:52 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: linux-next: Fixes tag needs some work in the imx-mxs tree
Thread-Topic: linux-next: Fixes tag needs some work in the imx-mxs tree
Thread-Index: AQHVHLFm4+M1Nb0Br0ijahXpQNE+6aaPVUEAgAbSoGA=
Date:   Tue, 11 Jun 2019 08:36:52 +0000
Message-ID: <AM0PR04MB44817EB65913F29630453E1A88ED0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <20190607074652.4b3d0c97@canb.auug.org.au>
 <20190607002407.GY29853@dragon>
In-Reply-To: <20190607002407.GY29853@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7207be81-e401-4dcf-38fb-08d6ee47f3ed
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5810;
x-ms-traffictypediagnostic: AM0PR04MB5810:
x-microsoft-antispam-prvs: <AM0PR04MB5810B6454B7159C79B1347B488ED0@AM0PR04MB5810.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 006546F32A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(346002)(136003)(366004)(189003)(199004)(53754006)(52536014)(5660300002)(6246003)(33656002)(99286004)(71190400001)(74316002)(7736002)(305945005)(66556008)(76116006)(66476007)(81166006)(71200400001)(66446008)(64756008)(66946007)(81156014)(68736007)(73956011)(86362001)(478600001)(8936002)(8676002)(4744005)(256004)(476003)(66066001)(486006)(7696005)(2906002)(4326008)(9686003)(6116002)(186003)(44832011)(3846002)(76176011)(26005)(55016002)(14454004)(6506007)(53936002)(6436002)(11346002)(229853002)(54906003)(446003)(102836004)(316002)(110136005)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5810;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Bng48ruAX0z789kgZWfbm4RA88eSEPbzZtUValHLzO+/xUSOqu8qpOXhZwSOKeEWp/6+GvHXELUY0kWaeKi59XZHoHTP0GjB/hB5ulMccNoZh8oqJcnsiNjifUBZsYylBKHXR2SvoX0v3kdIhT7XeZCViViP1mQfrjHt78XS9t6NA8Forn79RtuFN5W9ww7eJ0/hBBXBiq0qtrV/Ih95MuYzlB5vORmbQGeTwcYGDMrW7kTxH53Uqmw/CvHr0SN9Z70TXQQM6D7d+Wa2BXFX6Rv1jjrfVNRImdzCiIFz7DvuY4LhUJiJdM23+bJvQXTPe5oOF2Jlqzf5sgzBCD8bPw79Mkvx9PuANV/9Pg7TdimAsUfjkPhxMhhwZ5qGstwEjCcP9BGP+t2nRsJL8W6VSU0OIM487u5jCsi0kukeqIE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7207be81-e401-4dcf-38fb-08d6ee47f3ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2019 08:36:52.1213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: peng.fan@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5810
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn, Stephen
> Subject: Re: linux-next: Fixes tag needs some work in the imx-mxs tree
>=20
> On Fri, Jun 07, 2019 at 07:46:52AM +1000, Stephen Rothwell wrote:
> > Hi all,
> >
> > In commit
> >
> >   f6a8ff82ce68 ("clk: imx: imx8mm: correct audio_pll2_clk to
> > audio_pll2_out")
> >
> > Fixes tag
> >
> >   Fixes: ba5625c3e27 ("clk: imx: Add clock driver support for imx8mm")
> >
> > has these problem(s):
> >
> >   - SHA1 should be at least 12 digits long
> >     Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.=
11
> >     or later) just making sure it is not set (or set to "auto").
>=20
> Hi Stephen,
>=20
> Thanks for reporting.  I just got it fixed, will be more careful about th=
at in the
> future.
>=20
> @Peng, please check your git configuration as suggested above, thanks.

Sorry for this. Do I need to resend the patch?

Thanks,
Peng.

>=20
> Shawn
