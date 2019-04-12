Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B6CC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 680262171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="dOrZoCk6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfDLIw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:52:59 -0400
Received: from mail-eopbgr20067.outbound.protection.outlook.com ([40.107.2.67]:11266
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727060AbfDLIw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 04:52:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3SCIgxCSt5yCPJNAMBsgq31zNQal/3KwQsnVkAToSI=;
 b=dOrZoCk6ZGYgt2pxEd8ETaO9igMgaJJZxPS2ZAp6/yflZwFNrA5OoFEQy09puzzwyuwMMbFCpBrMZ+L++4KBneqUATOjrSp2AgAtclqzUc7xUHXqvB+hV6XiDewzKm77PGx75MSFQcsstUTUIFinE5uWi3nC5MAVH8LN82oeEAU=
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com (20.178.82.147) by
 AM0PR08MB3604.eurprd08.prod.outlook.com (20.177.111.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.16; Fri, 12 Apr 2019 08:52:53 +0000
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::758d:33f6:320d:a1a3]) by AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::758d:33f6:320d:a1a3%4]) with mapi id 15.20.1792.009; Fri, 12 Apr 2019
 08:52:53 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     Rob Clark <robdclark@gmail.com>
CC:     Eric Engestrom <eric.engestrom@intel.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
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
Thread-Index: AQHU7hEpHCbXaTxqPk+eq2C0+nBeZ6YyvlkAgAD2EwCAAAa9gIAAB88AgAJyhICAAgibAA==
Date:   Fri, 12 Apr 2019 08:52:52 +0000
Message-ID: <20190412085251.GA4183@arm.com>
References: <20190408205422.dj7z4dl36nauwlk7@intel.com>
 <1554809706-15389-1-git-send-email-ayan.halder@arm.com>
 <20190409115913.hvyjxlda4wtzm75t@intel.com>
 <20190409122710.k2bh25xg43lrqzvq@intel.com>
 <CAF6AEGvUsWF+_dZzGBM1BYnwvZRY9T0P7OGq30KJLohFU3soKg@mail.gmail.com>
In-Reply-To: <CAF6AEGvUsWF+_dZzGBM1BYnwvZRY9T0P7OGq30KJLohFU3soKg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0399.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::27) To AM0PR08MB3891.eurprd08.prod.outlook.com
 (2603:10a6:208:109::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94995669-c07a-4106-423f-08d6bf243f91
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR08MB3604;
x-ms-traffictypediagnostic: AM0PR08MB3604:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB3604938277BB855EBC154C27E4280@AM0PR08MB3604.eurprd08.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(366004)(136003)(396003)(189003)(199004)(186003)(14444005)(106356001)(26005)(1411001)(102836004)(54906003)(6506007)(386003)(86362001)(76176011)(68736007)(53936002)(256004)(7416002)(7736002)(6246003)(4326008)(1076003)(6916009)(5660300002)(316002)(305945005)(8676002)(229853002)(81156014)(11346002)(446003)(81166006)(53546011)(105586002)(2616005)(44832011)(52116002)(33656002)(3846002)(25786009)(6116002)(478600001)(476003)(97736004)(6512007)(8936002)(6486002)(2906002)(14454004)(72206003)(486006)(99286004)(93886005)(71190400001)(66066001)(71200400001)(6436002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3604;H:AM0PR08MB3891.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gHKneflhBUZ30UIj54tTPLpZzJCjyL3BC4iFTLSmmHgvFo1F7RUttVlC3hdwjCv9O5WcQ/oD9i6jpGAh4EUKG+I9HJFTaC6hIfn9Wo1gGWcbcyyT1hbeMrcprl6Xl88vY+fenZUZTrXNSYp9cn5GTo4l49f4wusez/hQ0ZvaB/PDtPeISr5S6FZTlU/x4BX+L2IB/vamX57EhrdIYciO/G5Vx7ebiboTgIs+Z+AaLvpBe2bzfSFYXuWcW3t22fCPmaQMpQzIobfIIzV/twZbmgI1xuIVMPG4SjxIVshzXFe0/S80DkndIGk2p+t1Z9MN3esenfTh3kpVUfpFzP+N6sv3Pr8zKycV8LGFZzYwhYRfcxroEEFiySUcNQsdfGvstX6mDH/cg92bPWhXVSaxItp+oang220oFlt7ivWaU2Y=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BF8988CE19F8CC45B1B052E7891C6B17@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94995669-c07a-4106-423f-08d6bf243f91
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 08:52:52.9698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3604
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 09:49:33PM -0400, Rob Clark wrote:
> On Tue, Apr 9, 2019 at 8:27 AM Eric Engestrom <eric.engestrom@intel.com> =
wrote:
> >
> > On Tuesday, 2019-04-09 12:59:13 +0100, Eric Engestrom wrote:
> > > On Tuesday, 2019-04-09 11:35:14 +0000, Ayan Halder wrote:
> > > > Generated using make headers_install from the drm-next
> > > > tree - git://anongit.freedesktop.org/drm/drm
> > > > branch - drm-next
> > > > commit - 14d2bd53a47a7e1cb3e03d00a6b952734cf90f3f
> > > >
> > > > The changes were as follows :-
> > > >
> > > > core: (drm.h, drm_fourcc.h, drm_mode.h)
> > > > - Added 'struct drm_syncobj_transfer', 'struct drm_syncobj_timeline=
_wait' and 'struct drm_syncobj_timeline_array'
> > > > - Added various DRM_IOCTL_SYNCOBJ_ ioctls
> > > > - Added some new RGB and YUV formats
> > > > - Added 'DRM_FORMAT_MOD_VENDOR_ALLWINNER'
> > > > - Added 'SAMSUNG' and Arm's 'AFBC' and 'ALLWINNER' format modifiers
> > > > - Added 'struct drm_mode_rect'
> > > >
> > > > i915:
> > > > - Added struct 'struct i915_user_extension' and various 'struct drm=
_i915_gem_context_'
> > > > - Added different modes of per-process Graphics Translation Table
> > > >
> > > > msm:
> > > > - Added various get or set GEM buffer info flags
> > > > - Added some MSM_SUBMIT_BO_ macros
> > > > - Modified 'struct drm_msm_gem_info'
> > > >
> > > > Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
> > >
> > > This looks sane, and applies cleanly :)
> > > Acked-by: Eric Engestrom <eric.engestrom@intel.com>
> >
> > Actually, revoking that, as this patch breaks the build; see below.
> >
> > >
> > > > ---
> > > >  include/drm/drm.h        |  36 +++++++
> > > >  include/drm/drm_fourcc.h | 136 +++++++++++++++++++++++++++
> > > >  include/drm/drm_mode.h   |  23 ++++-
> > > >  include/drm/i915_drm.h   | 237 +++++++++++++++++++++++++++++++++++=
+++++-------
> > > >  include/drm/msm_drm.h    |  25 +++--
> > > >  5 files changed, 415 insertions(+), 42 deletions(-)
> > > >
> > [snip]
> > > > diff --git a/include/drm/msm_drm.h b/include/drm/msm_drm.h
> > > > index c06d0a5..91a16b3 100644
> > > > --- a/include/drm/msm_drm.h
> > > > +++ b/include/drm/msm_drm.h
> > > > @@ -105,14 +105,24 @@ struct drm_msm_gem_new {
> > > >     __u32 handle;         /* out */
> > > >  };
> > > >
> > > > -#define MSM_INFO_IOVA      0x01
> > > > -
> > > > -#define MSM_INFO_FLAGS (MSM_INFO_IOVA)
> > > > +/* Get or set GEM buffer info.  The requested value can be passed
> > > > + * directly in 'value', or for data larger than 64b 'value' is a
> > > > + * pointer to userspace buffer, with 'len' specifying the number o=
f
> > > > + * bytes copied into that buffer.  For info returned by pointer,
> > > > + * calling the GEM_INFO ioctl with null 'value' will return the
> > > > + * required buffer size in 'len'
> > > > + */
> > > > +#define MSM_INFO_GET_OFFSET        0x00   /* get mmap() offset, re=
turned by value */
> > > > +#define MSM_INFO_GET_IOVA  0x01   /* get iova, returned by value *=
/
> > > > +#define MSM_INFO_SET_NAME  0x02   /* set the debug name (by pointe=
r) */
> > > > +#define MSM_INFO_GET_NAME  0x03   /* get debug name, returned by p=
ointer */
> > > >
> > > >  struct drm_msm_gem_info {
> > > >     __u32 handle;         /* in */
> > > > -   __u32 flags;          /* in - combination of MSM_INFO_* flags *=
/
> > > > -   __u64 offset;         /* out, mmap() offset or iova */
> > > > +   __u32 info;           /* in - one of MSM_INFO_* */
> > > > +   __u64 value;          /* in or out */
> > > > +   __u32 len;            /* in or out */
> > > > +   __u32 pad;
> >
> > freedreno/msm/msm_bo.c needs to be updated to reflect those changes.
>=20
>=20
> I think you can just rename flags->info and offset->value, the rest of
> the struct should be zero-initialized.. if in doubt you can check
> $mesa/src/freedreno/drm/msm_bo.c

Sorry, I had dropped the changes to 'msm_drm.h' in my v2 patch (which
I had sent 10th April, 2019 titled '[PATCH libdrm v2] headers: Sync
with drm-next ') as I wasn't sure about the changes.
>=20
> side-note:  the libdrm_freedreno code was folded into mesa in 19.0, so
> at *some* point we can probably disable libdrm_freedreno build by
> default.  (I'd kinda still like to keep the code around for some misc
> standalone tools I have, but that is the sort of thing where I can fix
> libdrm if it gets broken).  When to switch to disabled by default I
> guess comes down to how long we want to support mesa 18.x with latest
> libdrm??  Maybe after 19.1, since (selfishly motivated) that gives me
> a long enough window back in case I find myself needing to bisect for
> some regression..
>=20
> BR,
> -R
>=20
> >
> > > >  };
> > > >
> > > >  #define MSM_PREP_READ        0x01
> > > > @@ -188,8 +198,11 @@ struct drm_msm_gem_submit_cmd {
> > > >   */
> > > >  #define MSM_SUBMIT_BO_READ             0x0001
> > > >  #define MSM_SUBMIT_BO_WRITE            0x0002
> > > > +#define MSM_SUBMIT_BO_DUMP             0x0004
> > > >
> > > > -#define MSM_SUBMIT_BO_FLAGS            (MSM_SUBMIT_BO_READ | MSM_S=
UBMIT_BO_WRITE)
> > > > +#define MSM_SUBMIT_BO_FLAGS            (MSM_SUBMIT_BO_READ | \
> > > > +                                   MSM_SUBMIT_BO_WRITE | \
> > > > +                                   MSM_SUBMIT_BO_DUMP)
> > > >
> > > >  struct drm_msm_gem_submit_bo {
> > > >     __u32 flags;          /* in, mask of MSM_SUBMIT_BO_x */
> > > > --
> > > > 2.7.4
> > > >
