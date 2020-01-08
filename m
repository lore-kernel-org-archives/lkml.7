Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D19C00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AFA3206F0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cyberus-technology.de header.i=@cyberus-technology.de header.b="TD4KfA1m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgAHIYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 03:24:30 -0500
Received: from www413.your-server.de ([88.198.28.140]:43508 "EHLO
        www413.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgAHIY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 03:24:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=cyberus-technology.de; s=default1911; h=MIME-Version:Content-Type:
        References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JBlWYGGSvBWACbm7HRiuPkVho02AyIMjSgIaZ7f4e1Q=; b=TD4KfA1mHsPk/otH1nsJhcfx2
        6qMbUG8qh3Ag+InObwXGU1QjJ5b8J0+nvAXqzzzNrUd9Uarn2o3GB5AU+KsXEpmm37+MnJCBKZrPx
        A3S6FfMg2BTQuxXDat1VNUmpEtlM08UgFaErOIV5VqS0QoaiBoMoegmfB7Mz37cmfKX8uTW6HB1j2
        DVdc4kQ+GQ4GGKBgWTGwVUW/NnoYxlAFb2JWS3qaDdW/ItuzT72Bt20hWhpk9UjOOE8hW5vM4Jey1
        tg8Qqsf9ZID9xNjchIdKF+1R0qAmL8sm+DEc7y8RmFI8bfs7iF8gQmv+BJAwOGEwJrtawIYa2w0pd
        LuMtXVm1Q==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www413.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <julian.stecklina@cyberus-technology.de>)
        id 1ip6dd-00062z-4J; Wed, 08 Jan 2020 09:24:25 +0100
Received: from [24.134.37.229] (helo=192-168-0-109.rdsnet.ro)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <julian.stecklina@cyberus-technology.de>)
        id 1ip6dc-0007FL-PG; Wed, 08 Jan 2020 09:24:24 +0100
Message-ID: <ab56cd76c4a4c1266ca35df1645d05bfeae58e25.camel@cyberus-technology.de>
Subject: Re: [PATCH 1/3] drm/i915/gvt: fix file paths in documentation
From:   Julian Stecklina <julian.stecklina@cyberus-technology.de>
To:     Zhenyu Wang <zhenyuw@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, hang.yuan@intel.com,
        dri-devel@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org, zhiyuan.lv@intel.com
Date:   Wed, 08 Jan 2020 10:24:22 +0200
In-Reply-To: <20200107020637.GA5894@zhen-hp.sh.intel.com>
References: <20200106140622.14393-1-julian.stecklina@cyberus-technology.de>
         <20200107020637.GA5894@zhen-hp.sh.intel.com>
Organization: Cyberus Technology GmbH
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-YmIID+xuIDInK9HOwQWr"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
X-Authenticated-Sender: julian.stecklina@cyberus-technology.de
X-Virus-Scanned: Clear (ClamAV 0.101.4/25687/Tue Jan  7 10:56:22 2020)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YmIID+xuIDInK9HOwQWr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-01-07 at 10:06 +0800, Zhenyu Wang wrote:
> On 2020.01.06 16:06:20 +0200, Julian Stecklina wrote:
> > The documentation had some stale paths to i915 graphics virtualization
> > code. Fix them to point to existing files.
> >=20
> > Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
> > Cc: zhiyuan.lv@intel.com
> > Cc: hang.yuan@intel.com
> >=20
> > Signed-off-by: Julian Stecklina <julian.stecklina@cyberus-technology.de=
>
> > ---
> >  Documentation/gpu/i915.rst | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/Documentation/gpu/i915.rst b/Documentation/gpu/i915.rst
> > index e539c42a3e78..d644683c5249 100644
> > --- a/Documentation/gpu/i915.rst
> > +++ b/Documentation/gpu/i915.rst
> > @@ -43,19 +43,19 @@ Interrupt Handling
> >  Intel GVT-g Guest Support(vGPU)
> >  -------------------------------
> > =20
> > -.. kernel-doc:: drivers/gpu/drm/i915/i915_vgpu.c
> > +.. kernel-doc:: drivers/gpu/drm/i915/gvt/vgpu.c
> >     :doc: Intel GVT-g guest support
> > =20
> > -.. kernel-doc:: drivers/gpu/drm/i915/i915_vgpu.c
> > +.. kernel-doc:: drivers/gpu/drm/i915/gvt/vgpu.c
> >     :internal:
> > =20
> >  Intel GVT-g Host Support(vGPU device model)
> >  -------------------------------------------
> > =20
> > -.. kernel-doc:: drivers/gpu/drm/i915/intel_gvt.c
> > +.. kernel-doc:: drivers/gpu/drm/i915/gvt/gvt.c
> >     :doc: Intel GVT-g host support
> > =20
> > -.. kernel-doc:: drivers/gpu/drm/i915/intel_gvt.c
> > +.. kernel-doc:: drivers/gpu/drm/i915/gvt/gvt.c
> >     :internal:
> >=20
>=20
> The i915_vgpu.c and intel_gvt.c are still there for guest
> and host part of i915 interface with gvt. We still need them
> in doc. The files in gvt/ directory are gvt device model internals.=20

Thanks for clarifying. I'll drop the patch.

Julian

--=-YmIID+xuIDInK9HOwQWr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEIO56Pp1G3IBsGtZJ7pdfAn5EfbIFAl4VkbcACgkQ7pdfAn5E
fbK0dgf+NEF/F4ESZ27i+/L3luQ2NUKGLIdTQZDfA0Wajb8ljuRZuEpM5Uv8D+r3
o1+hTYRp15yqp1m23KKgvlJm9jUke4rpzNB7dJ1W/dbShshdsxRr90pCC0Mvm7W7
emIY80YjJLT0hq9Yhy4lEDhXju75Xrt5SHmnBm+XKYn6d+14BgZn9W+s4GzL1zUF
GdO791wtZpOAN2KK0B3+10ikhIkdtmoVsQvrRNflDWrDlQSSOqsDKu82KQDz2xxo
ykDmaB/zVvbC5WN5i5CNc/McC538Y1rkrHW3Re7cjEV8U3Pl2zmTXmNODv2fOR8D
jld35ZwlafJktmjluDQ0nbJUw8OBbA==
=t/Da
-----END PGP SIGNATURE-----

--=-YmIID+xuIDInK9HOwQWr--

