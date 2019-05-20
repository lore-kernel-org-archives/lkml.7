Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93718C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 15:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52BF220863
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 15:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="EPymN/JZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388057AbfETPUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 11:20:11 -0400
Received: from mail-eopbgr80048.outbound.protection.outlook.com ([40.107.8.48]:20313
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726146AbfETPUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 11:20:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JK7StW8MI3o5020VMr+pqPaAfmW68otrVgq+xFFyKpM=;
 b=EPymN/JZcESz46lthL0PNnqVXPImih1aVoDusJVTSGSfsRwCKTe32tpCfjUKq0PjXTOrsjB+8sk5jtvzHRiL7GIYjA0zMasW3lRyEkGi4cTUBn1PJvaCck/WSJnhGcoxtNMbllGCen6v5dIoe5VYvAWIpocZ4Q6kfwlkDVy61to=
Received: from DB6PR05MB3223.eurprd05.prod.outlook.com (10.175.232.149) by
 DB6PR05MB3205.eurprd05.prod.outlook.com (10.170.223.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Mon, 20 May 2019 15:20:02 +0000
Received: from DB6PR05MB3223.eurprd05.prod.outlook.com
 ([fe80::244a:2b0:6510:9864]) by DB6PR05MB3223.eurprd05.prod.outlook.com
 ([fe80::244a:2b0:6510:9864%7]) with mapi id 15.20.1900.010; Mon, 20 May 2019
 15:20:02 +0000
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
Thread-Index: AQHVDNjmA7J6ytTaRUCpqARej1sfCqZvmtYAgAAkXdCAAK6+gIADsQdA
Date:   Mon, 20 May 2019 15:20:02 +0000
Message-ID: <DB6PR05MB322356D29192EAED104AA47EA1060@DB6PR05MB3223.eurprd05.prod.outlook.com>
References: <0b74e9ad12360b56bc0a3c2ca972798c424f2610.1548790896.git.lsun@mellanox.com>
 <1558115345-32476-2-git-send-email-lsun@mellanox.com>
 <20190517175926.GA24535@kroah.com>
 <DB6PR05MB32235A6F891E438131471CE2A10B0@DB6PR05MB3223.eurprd05.prod.outlook.com>
 <20190518063501.GA26163@kroah.com>
In-Reply-To: <20190518063501.GA26163@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=lsun@mellanox.com; 
x-originating-ip: [216.156.69.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 90894a91-fee8-42a8-52cd-08d6dd36a191
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB6PR05MB3205;
x-ms-traffictypediagnostic: DB6PR05MB3205:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB6PR05MB3205E6FB6CFB3EEE51E15983A1060@DB6PR05MB3205.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 004395A01C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(136003)(396003)(39860400002)(52314003)(189003)(13464003)(199004)(66946007)(73956011)(186003)(66476007)(26005)(74316002)(7416002)(33656002)(64756008)(53936002)(81166006)(8676002)(81156014)(66556008)(66446008)(476003)(8936002)(66066001)(11346002)(76116006)(966005)(446003)(25786009)(68736007)(55016002)(2906002)(256004)(5660300002)(52536014)(316002)(5024004)(71200400001)(71190400001)(14444005)(14454004)(9686003)(6306002)(99286004)(4326008)(7736002)(305945005)(6436002)(6116002)(86362001)(102836004)(54906003)(478600001)(3846002)(53546011)(6916009)(229853002)(7696005)(76176011)(486006)(6506007)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR05MB3205;H:DB6PR05MB3223.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UtF04EIWMumBP+Fnikj8VnChsTr+glN+KnGDhX9dCYubARgpqjiKF8gL/ZiWHJNct0UxR+YtejsSYvmsD8am/+3YQ3nywW4AA0xfxdk6S8OF0P+xaSU0A3/D4iLGNYuC0L/wvTrSzYOkI2F6gALGmixmLB191v8aJZ7Rsyn90eOvjEAdfdFVchwMub2x6mn22ZR4OZRFlZliM6p48yGL3jSArKFP/7/G8uBeKE+B3rVbRdbO6TJJgfUwmgXipJGav73ygesSNmLgf/nza9cu1mBoBOgUUJelpr3SL4wTaHbeGIpII+cVEqCGPSGDjUSolKi4qbxlU+S800Sqh/3hfW2RLFtA/sHA2vlek5i343mwU4MzX91tv6ldHptu2goUzlqFpRqzJH/FqR79hHl0YPPyONQlGUUdGr5cHZ68Roc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90894a91-fee8-42a8-52cd-08d6dd36a191
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2019 15:20:02.6852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR05MB3205
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please see response inline.

> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Saturday, May 18, 2019 2:35 AM
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
> On Fri, May 17, 2019 at 08:36:53PM +0000, Liming Sun wrote:
> > Thanks Greg for the comments!  Please see my response inline.
> >
> > Regards,
> > - Liming
> >
> > > -----Original Message-----
> > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Sent: Friday, May 17, 2019 1:59 PM
> > > To: Liming Sun <lsun@mellanox.com>
> > > Cc: Andy Shevchenko <andy@infradead.org>; Darren Hart <dvhart@infrade=
ad.org>; Vadim Pasternak <vadimp@mellanox.com>;
> David
> > > Woods <dwoods@mellanox.com>; platform-driver-x86@vger.kernel.org; lin=
ux-kernel@vger.kernel.org; David S. Miller
> > > <davem@davemloft.net>; Mauro Carvalho Chehab <mchehab+samsung@kernel.=
org>; Jonathan Cameron
> > > <Jonathan.Cameron@huawei.com>; Nicolas Ferre <nicolas.ferre@microchip=
.com>; Paul E. McKenney <paulmck@linux.ibm.com>
> > > Subject: Re: [PATCH v5 2/2] platform/mellanox/mlxbf-bootctl: Add the =
ABI definitions
> > >
> > > On Fri, May 17, 2019 at 01:49:05PM -0400, Liming Sun wrote:
> > > > This commit adds the ABI definitions exposed to userspace for
> > > > the platform/mellanox/mlxbf-bootctl driver.
> > > >
> > > > Reviewed-by: Vadim Pasternak <vadimp@mellanox.com>
> > > > Signed-off-by: Liming Sun <lsun@mellanox.com>
> > > > ---
> > > >  .../ABI/testing/sysfs-platform-mellanox-bootctl    | 58 ++++++++++=
++++++++++++
> > > >  MAINTAINERS                                        |  1 +
> > > >  2 files changed, 59 insertions(+)
> > > >  create mode 100644 Documentation/ABI/testing/sysfs-platform-mellan=
ox-bootctl
> > > >
> > > > diff --git a/Documentation/ABI/testing/sysfs-platform-mellanox-boot=
ctl b/Documentation/ABI/testing/sysfs-platform-mellanox-
> > > bootctl
> > > > new file mode 100644
> > > > index 0000000..19a14db
> > > > --- /dev/null
> > > > +++ b/Documentation/ABI/testing/sysfs-platform-mellanox-bootctl
> > > > @@ -0,0 +1,58 @@
> > > > +What:		/sys/bus/platform/drivers/mlxbf-bootctl/lifecycle_state
> > > > +Date:		May 2019
> > > > +KernelVersion:	5.3
> > > > +Contact:	"Liming Sun <lsun@mellanox.com>"
> > > > +Description:
> > > > +		The Life-cycle state of the SoC, which could be one of the
> > > > +		following values.
> > > > +		  Production - Production state and can be updated to secure
> > > > +		  GA Secured - Secure chip and not able to change state
> > > > +		  GA Non-Secured - Non-Secure chip and not able to change state
> > > > +		  RMA - Return Merchandise Authorization
> > >
> > > A "driver" does not have a lifecycle state, a "device" does.
> > >
> > > You are putting all of these attributes in the wrong place.  Put them=
 on
> > > your device please, not the driver.  driver-specific attributes are
> > > _VERY_ rare, and only for things that can modify/show for all devices
> > > attached to that driver.
> >
> > This driver is running on the ARM processor of the SoC. The 'device' is
> > the SoC itself. That's to say, there is only one device here attached t=
o
> > the driver and the driver state will also be the device state.
>=20
> That might be true today, but maybe not tomorrow :)
>=20
> Anyway, again, this is device state, not driver state.

Yes, I agree. I discussed with the team and will move these attributes
under device (since they could be all considered as device state).

>=20
> > This interface has been used by user-space applications for a couple of
> > releases. It'll be great if it could stay in such way for compatibility=
. Please
> > advise if this is strongly preferred to move them under devices.
>=20
> So this is code that is already in the tree, and is just now being
> documented?  What .c file(s) is this referring to?

This code is not in the kernel tree yet. It has been in Mellanox BlueField
SW packages for a couple of releases and is trying to be up-streamed now.

>=20
> As for "comptability", sysfs is made such that if a file is not present,
> userspace should be able to survive, that is why it is
> one-value-per-file.  What tool is using this, and where is the source
> for it?

The latest 2.0 code can be found at link
https://github.com/Mellanox/mlxbf-bootctl/tree/2.0

In file mlxbf-bootctl.c, currently it uses the 'drivers' path as sysfs path=
.
#define SYS_PATH "/sys/bus/platform/drivers/mlx-bootctl". We could
update it to support both paths.

>=20
> thanks,
>=20
> greg k-h
