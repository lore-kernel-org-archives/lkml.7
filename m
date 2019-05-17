Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE87C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 20:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 391DD2087B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 20:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="rGQ9z+bd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfEQUg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 16:36:58 -0400
Received: from mail-eopbgr80052.outbound.protection.outlook.com ([40.107.8.52]:35726
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726293AbfEQUg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 16:36:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBJPlMULgaPfSx0QG6cmj+LGIWa+kkKU6hEWAnHgwSQ=;
 b=rGQ9z+bdp2itYV2mVz9Dpzha1Oycbo+GmNCjxEds9M/4SlQd/7DxLvnccB3ffZoJTLgKYDla6Voxs4F5V9P4RAw3SacPuXSzpdvg8A6xxCATZAaOLsyeihDbI69QD++T81OqqmejC1jNcc295s30nkBNHvF/k/zuLxIKgiUYMuQ=
Received: from DB6PR05MB3223.eurprd05.prod.outlook.com (10.175.232.149) by
 DB6PR05MB3208.eurprd05.prod.outlook.com (10.170.221.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Fri, 17 May 2019 20:36:53 +0000
Received: from DB6PR05MB3223.eurprd05.prod.outlook.com
 ([fe80::244a:2b0:6510:9864]) by DB6PR05MB3223.eurprd05.prod.outlook.com
 ([fe80::244a:2b0:6510:9864%7]) with mapi id 15.20.1900.010; Fri, 17 May 2019
 20:36:53 +0000
From:   Liming Sun <lsun@mellanox.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        David Woods <dwoods@mellanox.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: RE: [PATCH v5 2/2] platform/mellanox/mlxbf-bootctl: Add the ABI
 definitions
Thread-Topic: [PATCH v5 2/2] platform/mellanox/mlxbf-bootctl: Add the ABI
 definitions
Thread-Index: AQHVDNjmA7J6ytTaRUCpqARej1sfCqZvmtYAgAAkXdA=
Date:   Fri, 17 May 2019 20:36:53 +0000
Message-ID: <DB6PR05MB32235A6F891E438131471CE2A10B0@DB6PR05MB3223.eurprd05.prod.outlook.com>
References: <0b74e9ad12360b56bc0a3c2ca972798c424f2610.1548790896.git.lsun@mellanox.com>
 <1558115345-32476-2-git-send-email-lsun@mellanox.com>
 <20190517175926.GA24535@kroah.com>
In-Reply-To: <20190517175926.GA24535@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=lsun@mellanox.com; 
x-originating-ip: [216.156.69.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 35e12a8b-a2d5-4486-ad43-08d6db07659b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB6PR05MB3208;
x-ms-traffictypediagnostic: DB6PR05MB3208:
x-microsoft-antispam-prvs: <DB6PR05MB32088AEE219F1402090F1876A10B0@DB6PR05MB3208.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0040126723
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(346002)(136003)(39860400002)(199004)(189003)(13464003)(6506007)(76176011)(52536014)(476003)(53546011)(305945005)(316002)(71190400001)(71200400001)(486006)(446003)(6436002)(102836004)(11346002)(33656002)(7736002)(7696005)(186003)(8936002)(54906003)(7416002)(81156014)(4326008)(25786009)(26005)(81166006)(9686003)(8676002)(99286004)(55016002)(6916009)(3846002)(6116002)(76116006)(73956011)(68736007)(229853002)(66066001)(64756008)(66446008)(66476007)(66556008)(66946007)(256004)(5660300002)(6246003)(14454004)(5024004)(86362001)(74316002)(2906002)(53936002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR05MB3208;H:DB6PR05MB3223.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eehj/6mjHxkwe2csO141joYjTOVeEPe07ugttp0iwSsKMoTPYTf0+Gn11T65xBqv2BljX0KQUvMyEWdwU8Y2RYMRJWawyL6CmvwUJA0whFHGYpVrUkqa/bHXwAwx0E0u499Nm5kCHbL+8I/lpK+X+lNXJziGFZpQg0SW/rh8bK5JWkCy56P1EKcxShfwEQZV+kGTM77vFYHWSLJ/rnE6oVODEm8vz5u+jlGTSRdtGhfOkJGcPZCqaO6svGUMtKvki91NdrULNUwqksWKE7L3B6HXySFt00PgJXVy//aHFZt5uHU1mx3ZubqSeF2ll7qnH+VyQYCrLlYde1w2eXsiI0Rsw0CXiRncv/alEMHLYsb5+8AvGaXupSLrJ2aPx/nkR1FVLF90WfCYc6przuVHyK5i4mIj4Wef0GqRB9ZG+Vc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e12a8b-a2d5-4486-ad43-08d6db07659b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2019 20:36:53.3800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR05MB3208
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Greg for the comments!  Please see my response inline.

Regards,
- Liming

> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Friday, May 17, 2019 1:59 PM
> To: Liming Sun <lsun@mellanox.com>
> Cc: Andy Shevchenko <andy@infradead.org>; Darren Hart <dvhart@infradead.o=
rg>; Vadim Pasternak <vadimp@mellanox.com>; David
> Woods <dwoods@mellanox.com>; platform-driver-x86@vger.kernel.org; linux-k=
ernel@vger.kernel.org; David S. Miller
> <davem@davemloft.net>; Mauro Carvalho Chehab <mchehab+samsung@kernel.org>=
; Jonathan Cameron
> <Jonathan.Cameron@huawei.com>; Nicolas Ferre <nicolas.ferre@microchip.com=
>; Paul E. McKenney <paulmck@linux.ibm.com>
> Subject: Re: [PATCH v5 2/2] platform/mellanox/mlxbf-bootctl: Add the ABI =
definitions
>=20
> On Fri, May 17, 2019 at 01:49:05PM -0400, Liming Sun wrote:
> > This commit adds the ABI definitions exposed to userspace for
> > the platform/mellanox/mlxbf-bootctl driver.
> >
> > Reviewed-by: Vadim Pasternak <vadimp@mellanox.com>
> > Signed-off-by: Liming Sun <lsun@mellanox.com>
> > ---
> >  .../ABI/testing/sysfs-platform-mellanox-bootctl    | 58 ++++++++++++++=
++++++++
> >  MAINTAINERS                                        |  1 +
> >  2 files changed, 59 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-platform-mellanox-b=
ootctl
> >
> > diff --git a/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl =
b/Documentation/ABI/testing/sysfs-platform-mellanox-
> bootctl
> > new file mode 100644
> > index 0000000..19a14db
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl
> > @@ -0,0 +1,58 @@
> > +What:		/sys/bus/platform/drivers/mlxbf-bootctl/lifecycle_state
> > +Date:		May 2019
> > +KernelVersion:	5.3
> > +Contact:	"Liming Sun <lsun@mellanox.com>"
> > +Description:
> > +		The Life-cycle state of the SoC, which could be one of the
> > +		following values.
> > +		  Production - Production state and can be updated to secure
> > +		  GA Secured - Secure chip and not able to change state
> > +		  GA Non-Secured - Non-Secure chip and not able to change state
> > +		  RMA - Return Merchandise Authorization
>=20
> A "driver" does not have a lifecycle state, a "device" does.
>=20
> You are putting all of these attributes in the wrong place.  Put them on
> your device please, not the driver.  driver-specific attributes are
> _VERY_ rare, and only for things that can modify/show for all devices
> attached to that driver.

This driver is running on the ARM processor of the SoC. The 'device' is
the SoC itself. That's to say, there is only one device here attached to
the driver and the driver state will also be the device state.

This interface has been used by user-space applications for a couple of
releases. It'll be great if it could stay in such way for compatibility. Pl=
ease
advise if this is strongly preferred to move them under devices.

>=20
> thanks,
>=20
> greg k-h
