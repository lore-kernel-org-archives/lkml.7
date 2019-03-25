Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3926CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 013082084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="hV8Gc1GU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730781AbfCYV1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:27:23 -0400
Received: from mail-eopbgr20058.outbound.protection.outlook.com ([40.107.2.58]:2542
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730638AbfCYV1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3bdNdC9hQx+056JNrIuzUOPke+48Vr/KfEJs9wIT8M=;
 b=hV8Gc1GUyBA0KToHXntqIJ/1BJBB+yp5hgxd7vvLydgKTKbBZNusW+Wg4Zw2Qfc7eUByPfQkb5OitV0H7/ZEos0CFFHIx8kLVMEbsTHwcgn0mVVNK0mRVGBqdQyb7TvQJT6gJGi31GedIRhB5FpRG3dddnY2sZvjlrLhmHWxKIw=
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com (10.169.135.8) by
 VI1PR0501MB2189.eurprd05.prod.outlook.com (10.169.134.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Mon, 25 Mar 2019 21:27:16 +0000
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::a0b8:7ed8:d657:2f59]) by VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::a0b8:7ed8:d657:2f59%6]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 21:27:16 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/8] vfio/mdev: Drop redundant extern for exported symbols
Thread-Topic: [PATCH 4/8] vfio/mdev: Drop redundant extern for exported
 symbols
Thread-Index: AQHU4QXqzLMFPpu7G0u9kQlX9218ZaYcudEAgAAL8wCAABp3QA==
Date:   Mon, 25 Mar 2019 21:27:16 +0000
Message-ID: <VI1PR0501MB2271ACBFDAC6164A3F11C7F9D15E0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
References: <1553296835-37522-1-git-send-email-parav@mellanox.com>
        <1553296835-37522-5-git-send-email-parav@mellanox.com>
        <658437a2-6ed1-c834-bc40-f1bf6dce920c@nvidia.com>
 <20190325134950.16876957@x1.home>
In-Reply-To: <20190325134950.16876957@x1.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3d2dccf-42db-41de-1f98-08d6b168a75c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2189;
x-ms-traffictypediagnostic: VI1PR0501MB2189:
x-microsoft-antispam-prvs: <VI1PR0501MB21895456A97FFA3FE1DBA556D15E0@VI1PR0501MB2189.eurprd05.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(136003)(396003)(376002)(199004)(13464003)(189003)(52536014)(110136005)(33656002)(3846002)(76176011)(25786009)(54906003)(8676002)(5660300002)(81156014)(4326008)(81166006)(14454004)(316002)(106356001)(478600001)(66066001)(105586002)(305945005)(7736002)(6246003)(8936002)(6436002)(68736007)(229853002)(53936002)(97736004)(186003)(53546011)(6506007)(476003)(55016002)(74316002)(2906002)(102836004)(486006)(11346002)(256004)(446003)(7696005)(93886005)(71200400001)(26005)(6116002)(71190400001)(86362001)(9686003)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2189;H:VI1PR0501MB2271.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: //O0F5REme6EwJHVPMN7rouABFe1z9e3enT54HX+fIGg28lO79+Ou60F7osf6zroEpqc52ffl/v8xouGG4c3V5YT/6Ib8nXxodT88IS/3oWwOeQXaWKxXZmXYv8tI6HuzRJWNyrUdaQzLdS60Qv+Qm9ga5Jz65Gfq7eJx9XJ0LHNC8yRflEECcOOGggLj9B/s3bRAbKLXEkUWwLPzBcwRTx0c8Svpzrdsm+XabIwTbz9Gyf8rYSCR6n++ZifFvsWnLIlVKhFG8KVbJfCA3AUPFQ+SUoK9ibGZOgLHoVhBx4ErwAcSnEh1iT0mgaDsroSJZNX0tXvDWwA1EgmMoLhSS9hUW6F1MFQ0wxA0GT+regXJFg9AvU6Svg+DBsT682PmWfQWNOrvE/QIr4iRlUYMnswgOInf27xTY8JDjfEOCQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3d2dccf-42db-41de-1f98-08d6b168a75c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 21:27:16.0820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2189
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Alex Williamson <alex.williamson@redhat.com>
> Sent: Monday, March 25, 2019 2:50 PM
> To: Kirti Wankhede <kwankhede@nvidia.com>
> Cc: Parav Pandit <parav@mellanox.com>; kvm@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH 4/8] vfio/mdev: Drop redundant extern for exported
> symbols
>=20
> On Tue, 26 Mar 2019 00:37:04 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
>=20
> > On 3/23/2019 4:50 AM, Parav Pandit wrote:
> > > There is no need use 'extern' for exported functions.
> > >
> > > Signed-off-by: Parav Pandit <parav@mellanox.com>
> > > ---
> > >  include/linux/mdev.h | 21 ++++++++++-----------
> > >  1 file changed, 10 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/include/linux/mdev.h b/include/linux/mdev.h index
> > > b6e048e..0924c48 100644
> > > --- a/include/linux/mdev.h
> > > +++ b/include/linux/mdev.h
> > > @@ -118,21 +118,20 @@ struct mdev_driver {
> > >
> > >  #define to_mdev_driver(drv)	container_of(drv, struct mdev_driver,
> driver)
> > >
> > > -extern void *mdev_get_drvdata(struct mdev_device *mdev); -extern
> > > void mdev_set_drvdata(struct mdev_device *mdev, void *data); -extern
> > > uuid_le mdev_uuid(struct mdev_device *mdev);
> > > +void *mdev_get_drvdata(struct mdev_device *mdev); void
> > > +mdev_set_drvdata(struct mdev_device *mdev, void *data); uuid_le
> > > +mdev_uuid(struct mdev_device *mdev);
> > >
> > >  extern struct bus_type mdev_bus_type;
> > >
> > > -extern int  mdev_register_device(struct device *dev,
> > > -				 const struct mdev_parent_ops *ops);
> > > -extern void mdev_unregister_device(struct device *dev);
> > > +int mdev_register_device(struct device *dev, const struct
> > > +mdev_parent_ops *ops); void mdev_unregister_device(struct device
> > > +*dev);
> > >
> > > -extern int  mdev_register_driver(struct mdev_driver *drv, struct
> > > module *owner); -extern void mdev_unregister_driver(struct
> > > mdev_driver *drv);
> > > +int mdev_register_driver(struct mdev_driver *drv, struct module
> > > +*owner); void mdev_unregister_driver(struct mdev_driver *drv);
> > >
> > > -extern struct device *mdev_parent_dev(struct mdev_device *mdev);
> > > -extern struct device *mdev_dev(struct mdev_device *mdev); -extern
> > > struct mdev_device *mdev_from_dev(struct device *dev);
> > > +struct device *mdev_parent_dev(struct mdev_device *mdev); struct
> > > +device *mdev_dev(struct mdev_device *mdev); struct mdev_device
> > > +*mdev_from_dev(struct device *dev);
> > >
> > >  #endif /* MDEV_H */
> > >
> >
> > Adding 'extern' to exported symbols is inline to other exported
> > functions from device's core module like device_register(),
> > device_unregister(), get_device(), put_device()
>=20
> Right, I'd be inclined to leave this as a style choice, but...
>=20
> commit 3fe5dbfef47e992b810cbe82af1df02d8255fb8c
> Author: Alexey Dobriyan <adobriyan@gmail.com>
> Date:   Thu Jan 3 15:26:16 2019 -0800
>=20
>     Documentation/process/coding-style.rst: don't use "extern" with funct=
ion
> prototypes
>=20
>     `extern' with function prototypes makes lines longer and creates more
>     characters on the screen.
>=20
>     Do not bug people with checkpatch.pl warnings for now as fallout can =
be
>     devastating.
>=20
> So it's a new decision and rather weakly imposed new standard.  Thanks,
>=20
We always improve the kernel, sometimes in pieces, sometime at subsystem le=
vel or sometimes tree wide.
This is done mdev level.
device core is not good example to point that they use 'extern' so its fine=
 here...
That was written more than 10 years ago.
So we should be open to improvements.. silly or large..
