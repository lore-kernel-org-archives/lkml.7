Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AD7C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D38218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570627903;
	bh=oZzfMFCR/j7Wy5PTVMA5uQX2L9GGCFSn0pppXeOTmn0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0+zbmUpiHGGVN3JF7Z7mPBLGLiLtNDb6VohVUpcFtYcID6Y+/PxunxdgWoylQD9Qc
	 EMta03IYQ6LAMWuNpYIhpakUpKjUWA3KErlu+RlLr2T5hhavuu0EGqxTe3KMfMdBkq
	 Xs87e0nYBnYnZWdnwQLCVW9YY6lXHWh2mq1/48bU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731382AbfJINbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 09:31:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730901AbfJINbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 09:31:42 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D448320B7C;
        Wed,  9 Oct 2019 13:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570627901;
        bh=oZzfMFCR/j7Wy5PTVMA5uQX2L9GGCFSn0pppXeOTmn0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0hvHSAxdEvU3eQFJbCNTHqxGpclBsrkmEQIoY6D9TPohbGcsawUwe/9diqs9p0t6/
         tP4yB1NShXDz88eLxAFzZ+hVSfLsQKjUUOfbLKMOMXsow+I1nsuJ4VJ4SGPB9405oy
         u+X7FGxkIQ4RB6Cx0rTsBuZqZD2x1LSD/X97pZz0=
Date:   Wed, 9 Oct 2019 15:31:38 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Jason Gunthorpe <jgg@ziepe.ca>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        sam@ravnborg.org, hdegoede@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [1/3] drm/tinydrm/Kconfig: Remove menuconfig DRM_TINYDRM
Message-ID: <20191009133138.scz3i5jjcqt3gnjd@gilmour>
References: <20190725105132.22545-2-noralf@tronnes.org>
 <20191001123636.GA8351@ziepe.ca>
 <1fffe7b1-a738-a9e3-ea5f-9d696cb98650@tronnes.org>
 <20191001134555.GB22532@ziepe.ca>
 <75055e2d-44f7-0cba-4e41-537097b73c3c@tronnes.org>
 <20191009104531.GW16989@phenom.ffwll.local>
 <1bc77839-c47a-6e79-dd6e-e26e05b34eae@tronnes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2a3a74y3f5owva3n"
Content-Disposition: inline
In-Reply-To: <1bc77839-c47a-6e79-dd6e-e26e05b34eae@tronnes.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2a3a74y3f5owva3n
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2019 at 02:48:20PM +0200, Noralf Tr=F8nnes wrote:
> Den 09.10.2019 12.45, skrev Daniel Vetter:
> > On Tue, Oct 01, 2019 at 04:07:38PM +0200, Noralf Tr=F8nnes wrote:
> >> Hi drm-misc maintainers,
> >>
> >> I have just applied a patch to drm-misc-next that as it turns out shou=
ld
> >> have been applied to -fixes for this -rc cycle.
> >>
> >> Should I cherry pick it to drm-misc-next-fixes?
> >
> > Yup, cherry pick and reference the commit that's already in -next (in c=
ase
> > it creates conflicts down the road that reference makes the mess easier=
 to
> > understand).
> >
>
> I remembered that Maxime just sent out a fixes pull and the subject says
> drm-misc-fixes. The prevous one he sent out was -next-fixes.
> So it looks like I should cherry pick to drm-misc-fixes for it to show
> up in 5.4?

drm-misc-next-fixes is the branch where we gather fixes supposed to be
applied on top of drm-misc-next during the merge window. If you have
something targeting the current release, it should be drm-misc-fixes
indeed.

Maxime

--2a3a74y3f5owva3n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXZ3hOgAKCRDj7w1vZxhR
xcoFAP9hmbX/w4RrCCKqQTCWRP1Ft+AL7c/nMJYOR0IRZ3qrCwEA7/Pl7InBhhZI
wtLFUjQymChPxBbMXs1GgwfpUD7ZTgg=
=iry/
-----END PGP SIGNATURE-----

--2a3a74y3f5owva3n--
