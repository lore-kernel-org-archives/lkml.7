Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174D6C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 09:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB2D72083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 09:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="NSSs3Dxo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbfDLJBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 05:01:04 -0400
Received: from mail-eopbgr30072.outbound.protection.outlook.com ([40.107.3.72]:42370
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727321AbfDLJBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 05:01:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urBcVYm6KLJT0CAX9BwkEdZ6RUyfCUV1PqMCrzuPISs=;
 b=NSSs3DxoDiHsIlBaCeaW+dp57xtzBVLCIMQemnG5ezhIBs1J4MYg3p/ssUzsDh0JXPCbIkisJULxtups+AUrBMuD4f5MVfcb8wRPtsSJZ6wvKMWwRO6YtPg+sFyzPwUzDfA9rrGyU8Cs8LJ9pForUyzM4xpC5sirySM/x3gBPy8=
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com (20.178.82.147) by
 AM0PR08MB4433.eurprd08.prod.outlook.com (20.179.33.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.15; Fri, 12 Apr 2019 09:00:58 +0000
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::758d:33f6:320d:a1a3]) by AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::758d:33f6:320d:a1a3%4]) with mapi id 15.20.1792.009; Fri, 12 Apr 2019
 09:00:58 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     Eric Engestrom <eric.engestrom@intel.com>
CC:     Rob Clark <robdclark@gmail.com>, Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
        "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH libdrm] headers: Sync with drm-next
Thread-Topic: [PATCH libdrm] headers: Sync with drm-next
Thread-Index: AQHU7hEpHCbXaTxqPk+eq2C0+nBeZ6YyvlkAgAD2EwCAAAa9gIAAB88AgAJyhICAAEu2AIABvyeA
Date:   Fri, 12 Apr 2019 09:00:58 +0000
Message-ID: <20190412090057.GB4183@arm.com>
References: <20190408205422.dj7z4dl36nauwlk7@intel.com>
 <1554809706-15389-1-git-send-email-ayan.halder@arm.com>
 <20190409115913.hvyjxlda4wtzm75t@intel.com>
 <20190409122710.k2bh25xg43lrqzvq@intel.com>
 <CAF6AEGvUsWF+_dZzGBM1BYnwvZRY9T0P7OGq30KJLohFU3soKg@mail.gmail.com>
 <20190411062032.qqxz3j7mm4cgzgfp@intel.com>
In-Reply-To: <20190411062032.qqxz3j7mm4cgzgfp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0410.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::14) To AM0PR08MB3891.eurprd08.prod.outlook.com
 (2603:10a6:208:109::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dbd74ed5-b0c3-49c1-2d34-08d6bf2560f0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR08MB4433;
x-ms-traffictypediagnostic: AM0PR08MB4433:
x-ms-exchange-purlcount: 1
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB4433A8237155C972D5AFF9FCE4280@AM0PR08MB4433.eurprd08.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(376002)(136003)(39860400002)(189003)(199004)(6916009)(386003)(6116002)(36756003)(44832011)(7416002)(6436002)(97736004)(229853002)(6486002)(3846002)(53546011)(14454004)(305945005)(54906003)(186003)(8676002)(52116002)(93886005)(86362001)(81166006)(105586002)(316002)(81156014)(26005)(6506007)(106356001)(256004)(478600001)(102836004)(76176011)(14444005)(25786009)(8936002)(7736002)(11346002)(2616005)(5660300002)(66066001)(476003)(72206003)(446003)(6512007)(4326008)(6306002)(71190400001)(33656002)(53936002)(486006)(6246003)(71200400001)(1076003)(2906002)(99286004)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB4433;H:AM0PR08MB3891.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tHRcDlZ5C/WrrS4RGLJqYx3VuQb3cWry9Qzjy83EQLjNJtDdjHGR8Y9AL8GxdCtbA2eBS1CnbfGG2DADgR+O7RcF3bc79AG7lUz2kFc8eUw2iaAZcfB0JvPdzvoyM6bZFH8n/wZUD2rmgSEzZ6d7SILaclYeKsQx8fPjGOCHklLXObKRavKarP+0K+YIYw6zlyZR5dF0XXJAvIGFAjjHmctgcTbTrg+9dB0s58qWhQSnlSOC1H5LnJC2mdCu0M5j83p0xCHsXZw9t+QnJ/TyU26B8wHekOvnmxJOucAnK1ouKO86AFFBAs5N/Iq++aSfCDqEDNc29wEvarWo4J6Bzf4kLz3Ag0F9LmHUla8HF6oSCUYZFnqXr7YPIL6xYy2dxzBaGgW2lgi9RzP0AOugoWPLEoFC/7lFPeEoOm81aRQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <106AAFF8BC9E054FA41CCB1FB7E91036@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd74ed5-b0c3-49c1-2d34-08d6bf2560f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 09:00:58.3664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4433
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 07:20:32AM +0100, Eric Engestrom wrote:
> On Wednesday, 2019-04-10 21:49:33 -0400, Rob Clark wrote:
> > On Tue, Apr 9, 2019 at 8:27 AM Eric Engestrom <eric.engestrom@intel.com=
> wrote:
> > > > > diff --git a/include/drm/msm_drm.h b/include/drm/msm_drm.h
> > > > > index c06d0a5..91a16b3 100644
> > > > > --- a/include/drm/msm_drm.h
> > > > > +++ b/include/drm/msm_drm.h
> > > > > @@ -105,14 +105,24 @@ struct drm_msm_gem_new {
> > > > >     __u32 handle;         /* out */
> > > > >  };
> > > > >
> > > > > -#define MSM_INFO_IOVA      0x01
> > > > > -
> > > > > -#define MSM_INFO_FLAGS (MSM_INFO_IOVA)
> > > > > +/* Get or set GEM buffer info.  The requested value can be passe=
d
> > > > > + * directly in 'value', or for data larger than 64b 'value' is a
> > > > > + * pointer to userspace buffer, with 'len' specifying the number=
 of
> > > > > + * bytes copied into that buffer.  For info returned by pointer,
> > > > > + * calling the GEM_INFO ioctl with null 'value' will return the
> > > > > + * required buffer size in 'len'
> > > > > + */
> > > > > +#define MSM_INFO_GET_OFFSET        0x00   /* get mmap() offset, =
returned by value */
> > > > > +#define MSM_INFO_GET_IOVA  0x01   /* get iova, returned by value=
 */
> > > > > +#define MSM_INFO_SET_NAME  0x02   /* set the debug name (by poin=
ter) */
> > > > > +#define MSM_INFO_GET_NAME  0x03   /* get debug name, returned by=
 pointer */
> > > > >
> > > > >  struct drm_msm_gem_info {
> > > > >     __u32 handle;         /* in */
> > > > > -   __u32 flags;          /* in - combination of MSM_INFO_* flags=
 */
> > > > > -   __u64 offset;         /* out, mmap() offset or iova */
> > > > > +   __u32 info;           /* in - one of MSM_INFO_* */
> > > > > +   __u64 value;          /* in or out */
> > > > > +   __u32 len;            /* in or out */
> > > > > +   __u32 pad;
> > >
> > > freedreno/msm/msm_bo.c needs to be updated to reflect those changes.
> >=20
> >=20
> > I think you can just rename flags->info and offset->value, the rest of
> > the struct should be zero-initialized.. if in doubt you can check
> > $mesa/src/freedreno/drm/msm_bo.c
> >=20
> > side-note:  the libdrm_freedreno code was folded into mesa in 19.0, so
> > at *some* point we can probably disable libdrm_freedreno build by
> > default.
>=20
> Right now, freedreno's `auto` enables it by default on arm and disables i=
t on
> everything else.
>=20
> I always enable everything to at least build-test it, but Ayan was using
> the defaults which is why he didn't see this issue at first.
>=20
> Btw, the GitLab CI builds everything, so it hopefully won't bitrot unnoti=
ced.

My bad, I was not aware that there is repo of libdrm in gitlab when I
submitted my v1 patch. I have taken care of it in my v2 patch ([PATCH
libdrm v2] headers: Sync with drm-next) and have also raised a merge
request
(https://gitlab.freedesktop.org/ayan.halder/drm/merge_requests/1/diffs)
to execute the gitlab ci tools.
Please be requested to have a look at my v2 patch.
>=20
> > (I'd kinda still like to keep the code around for some misc
> > standalone tools I have, but that is the sort of thing where I can fix
> > libdrm if it gets broken).  When to switch to disabled by default I
> > guess comes down to how long we want to support mesa 18.x with latest
> > libdrm??  Maybe after 19.1, since (selfishly motivated) that gives me
> > a long enough window back in case I find myself needing to bisect for
> > some regression..
