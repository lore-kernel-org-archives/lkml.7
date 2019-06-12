Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33ABEC31E48
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D24821734
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="la5Lq+ye"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438727AbfFLMPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 08:15:40 -0400
Received: from mail-eopbgr30071.outbound.protection.outlook.com ([40.107.3.71]:27930
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726696AbfFLMPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQShRtZUn3kdVbZlVtiPK0sW/NYp/0ABeaPC2Fqs8PY=;
 b=la5Lq+yelONW/6Em6LNSfIXTfRS7KtcR/wgY5GyII173HYa3jFO4EP9bYNioH5Y/haLpA8elIF6/wh9R+mLBOt0UdQ0sQ4Fqq4KLKu75gUeZnFOKi998LxmMz3QLgxyHbcjt6kmhmo8Z+BEuWOqDN9fVIDLQaZEO2YJNt7HbnL0=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5506.eurprd04.prod.outlook.com (20.178.115.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Wed, 12 Jun 2019 12:15:35 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6090:1f0b:b85b:8015]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::6090:1f0b:b85b:8015%3]) with mapi id 15.20.1965.017; Wed, 12 Jun 2019
 12:15:35 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: linux-next: Fixes tag needs some work in the imx-mxs tree
Thread-Topic: linux-next: Fixes tag needs some work in the imx-mxs tree
Thread-Index: AQHVHLFm4+M1Nb0Br0ijahXpQNE+6aaPVUEAgAbSoGCAAbgtAIAAF2kA
Date:   Wed, 12 Jun 2019 12:15:35 +0000
Message-ID: <AM0PR04MB448134A784B77716C9C93A7488EC0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <20190607074652.4b3d0c97@canb.auug.org.au>
 <20190607002407.GY29853@dragon>
 <AM0PR04MB44817EB65913F29630453E1A88ED0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20190612105059.GG11086@dragon>
In-Reply-To: <20190612105059.GG11086@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c18891d3-fe98-4c96-54d3-08d6ef2fac97
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5506;
x-ms-traffictypediagnostic: AM0PR04MB5506:
x-microsoft-antispam-prvs: <AM0PR04MB55069DB7C18A6D8F0227E96588EC0@AM0PR04MB5506.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0066D63CE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(376002)(396003)(366004)(53754006)(189003)(199004)(43544003)(229853002)(25786009)(9686003)(55016002)(53936002)(3846002)(6116002)(6436002)(186003)(71200400001)(71190400001)(33656002)(86362001)(102836004)(478600001)(6506007)(14454004)(68736007)(26005)(7696005)(256004)(66446008)(76176011)(2906002)(66946007)(66476007)(66556008)(64756008)(73956011)(76116006)(476003)(11346002)(52536014)(6916009)(44832011)(446003)(99286004)(486006)(5660300002)(305945005)(7736002)(74316002)(4326008)(6246003)(66066001)(8936002)(316002)(81156014)(81166006)(54906003)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5506;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YxwaACQqBrjh+mWcX3dwCAkLlc1cYCygISE4TfvDVPB2+OEMESDI9WHzTn3TcQj9ZAcyzsIuqTImw4eybUYDqo85JU6zw567CgzsJnbWihqNge9KyRlZYDx6gQ+Vbukq+2SEK4wIrbznR+ay3wG+E2yfC2CGqTKS+cb5B8SCR8KXNBryc8/zuawDd9nWdtGcIVWY8tBkRIxAO+TJ3JK+vBLyHs1GQxByuWHOHc4dBKUTvrE+QatpPIvlnfNKle78A+m8QjmaYbbf2xM69oLn6fr56SNPl4lNHQVoAnRWtK9PAuP02k8ltMC2mce4RypqmtyDhI+T4SSeA+mkUzf7jqWSSDg3r8iu2BVH6BWlEQ3937UWdBpClEGDtU0XdQ9tzcVHnQvYY74YRzc6fQ/7Jsex8UOlXjFv8jA/xixj6yY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c18891d3-fe98-4c96-54d3-08d6ef2fac97
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2019 12:15:35.6944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: peng.fan@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5506
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Subject: Re: linux-next: Fixes tag needs some work in the imx-mxs tree
>=20
> On Tue, Jun 11, 2019 at 08:36:52AM +0000, Peng Fan wrote:
> > Hi Shawn, Stephen
> > > Subject: Re: linux-next: Fixes tag needs some work in the imx-mxs
> > > tree
> > >
> > > On Fri, Jun 07, 2019 at 07:46:52AM +1000, Stephen Rothwell wrote:
> > > > Hi all,
> > > >
> > > > In commit
> > > >
> > > >   f6a8ff82ce68 ("clk: imx: imx8mm: correct audio_pll2_clk to
> > > > audio_pll2_out")
> > > >
> > > > Fixes tag
> > > >
> > > >   Fixes: ba5625c3e27 ("clk: imx: Add clock driver support for
> > > > imx8mm")
> > > >
> > > > has these problem(s):
> > > >
> > > >   - SHA1 should be at least 12 digits long
> > > >     Can be fixed by setting core.abbrev to 12 (or more) or (for git=
 v2.11
> > > >     or later) just making sure it is not set (or set to "auto").
> > >
> > > Hi Stephen,
> > >
> > > Thanks for reporting.  I just got it fixed, will be more careful
> > > about that in the future.
> > >
> > > @Peng, please check your git configuration as suggested above, thanks=
.
> >
> > Sorry for this. Do I need to resend the patch?
>=20
> No.  I have fixed it on my branch.

Thanks. I'll take care in future.

Thanks,
Peng.

>=20
> Shawn
