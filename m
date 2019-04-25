Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E3BC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 06:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D00B4218AD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 06:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="LGA2BCje"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbfDYGRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 02:17:33 -0400
Received: from mail-eopbgr40063.outbound.protection.outlook.com ([40.107.4.63]:8142
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726427AbfDYGRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 02:17:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=loYFdjw37m9atjYbOHpTE2DsQlsn23d1xjo9bb0gl+w=;
 b=LGA2BCjetRRYfozL6+YQvQyMIwtEndF2iB+g7CEJzF5Y3Eyq2uXmKI4ZPezrGRpWGwDoRNEuxYlw0mwtt+g6EYQQf/l8ao3q48sn+/C29Vmet71N3x+gKRUFjEahAtZFG4yw5ADqATeQEGb30S8k+caPx1t7xQiz8cdVJ71wOVw=
Received: from AM0PR08MB4995.eurprd08.prod.outlook.com (10.255.28.224) by
 AM0PR08MB4579.eurprd08.prod.outlook.com (20.178.82.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.19; Thu, 25 Apr 2019 06:17:28 +0000
Received: from AM0PR08MB4995.eurprd08.prod.outlook.com
 ([fe80::58c8:40bf:8f31:2ed9]) by AM0PR08MB4995.eurprd08.prod.outlook.com
 ([fe80::58c8:40bf:8f31:2ed9%6]) with mapi id 15.20.1813.017; Thu, 25 Apr 2019
 06:17:28 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Emil Velikov <emil.l.velikov@gmail.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>, nd <nd@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
Subject: Re: [PATCH] drm/komeda: Mark the local functions as static
Thread-Topic: [PATCH] drm/komeda: Mark the local functions as static
Thread-Index: AQHU+mHMyYOfGpzbx0SuyD5V70fYFg==
Date:   Thu, 25 Apr 2019 06:17:28 +0000
Message-ID: <20190425061721.GA20409@james-ThinkStation-P300>
References: <20190424055108.19390-1-james.qian.wang@arm.com>
 <CACvgo50zWO61bbY7Mwxhp0YSxaPT02aTEfG6pzUZ8bpPkzyo=g@mail.gmail.com>
In-Reply-To: <CACvgo50zWO61bbY7Mwxhp0YSxaPT02aTEfG6pzUZ8bpPkzyo=g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0P153CA0040.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::28) To AM0PR08MB4995.eurprd08.prod.outlook.com
 (2603:10a6:208:15a::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3511024-ce2a-432e-7dbd-08d6c945b0d4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR08MB4579;
x-ms-traffictypediagnostic: AM0PR08MB4579:
x-ms-exchange-purlcount: 2
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB4579B1242F685DAD2472D5C5B33D0@AM0PR08MB4579.eurprd08.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(366004)(376002)(136003)(346002)(396003)(39860400002)(189003)(199004)(229853002)(3846002)(4326008)(14454004)(68736007)(6246003)(446003)(11346002)(6916009)(33656002)(476003)(25786009)(7736002)(486006)(256004)(2906002)(66476007)(305945005)(66556008)(66446008)(64756008)(66946007)(316002)(1076003)(73956011)(186003)(6116002)(9686003)(6512007)(6486002)(6436002)(5660300002)(26005)(58126008)(97736004)(54906003)(53936002)(102836004)(86362001)(33716001)(71200400001)(66066001)(76176011)(6506007)(52116002)(386003)(8676002)(81156014)(81166006)(99286004)(966005)(508600001)(55236004)(8936002)(6306002)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB4579;H:AM0PR08MB4995.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pYo1DoBD3tgb7yD5JbYU36QWrGsNeDQ0km+F1BBHZ2csfYbJrOF22poIfSuowadVr4tqLqZ+/Om3QcsEtNxZX86vhyKddPK9nr8DVg4gC2tgIwdFN/rHrOdZn1mXH3LiSQGYeWJa0cJuOYd2haYN0yNqHyEM8CRFA+6o7S8ZM/msEJFKEPHY2/ADb8DK+fuQoRe8Msf4StQK7O5LlgaGXhbrjL91MqC8lmfQEznTXKhvCbYUJ6P6YSav01XyL+SqlP8tKkdWEk8sU3zWouamiHkdXh1DEF2OloAmKljwJv6D7axOJBq71GrQrnw+y5+Olzmdp1fJBg1UL7gadR0DV9a0drEh0n9BAPojkUJuGfOpQmEe3pHngvX8GH5baU1mfKJogLI8nRE1JW1XFN+oZ5AxEPPgXS2G9ZGzxWGhhxU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AABCA030FBAF5C4AAA06ECC48EDA6F10@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3511024-ce2a-432e-7dbd-08d6c945b0d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 06:17:28.3511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4579
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 12:06:55PM +0100, Emil Velikov wrote:
> On Wed, 24 Apr 2019 at 06:51, james qian wang (Arm Technology China)
> <james.qian.wang@arm.com> wrote:
> >
> > Fix the kbuild test rebot reported warnings:
> > - symbol was not declared. Should it be static?
> > - missing braces around initializer
> >
> > Depends on:
> > - https://patchwork.freedesktop.org/series/58976/
> >
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Signed-off-by: James (Qian) Wang <james.qian.wang@arm.com>
> > ---
> >  .../gpu/drm/arm/display/komeda/d71/d71_component.c    |  9 +++++----
> >  drivers/gpu/drm/arm/display/komeda/komeda_crtc.c      |  4 ++--
> >  drivers/gpu/drm/arm/display/komeda/komeda_dev.c       |  4 +++-
> >  drivers/gpu/drm/arm/display/komeda/komeda_drv.c       |  2 +-
> >  drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c  |  2 +-
> >  .../drm/arm/display/komeda/komeda_pipeline_state.c    | 11 ++++++-----
> >  drivers/gpu/drm/arm/display/komeda/komeda_plane.c     | 10 ++++++----
> >  7 files changed, 24 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/d=
rivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > index c56cfc2de147..031e5f305a3c 100644
> > --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > @@ -391,7 +391,7 @@ static void d71_compiz_dump(struct komeda_component=
 *c, struct seq_file *sf)
> >         seq_printf(sf, "CU_USER_HIGH:\t\t0x%X\n", v[1]);
> >  }
> >
> > -struct komeda_component_funcs d71_compiz_funcs =3D {
> > +static struct komeda_component_funcs d71_compiz_funcs =3D {
>=20
> Side note: Practically any piece of komeda_component_funcs and
> komeda_pipeline_funcs could (and should) be constified.
>=20
> -Emil

Thank you Emil, I submit a new patch for fixing this problem,
https://patchwork.freedesktop.org/series/59915/
pls help to have a look.

James
