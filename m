Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4757C606D3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 00:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C1762166E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 00:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="nwGowiic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbfGIAHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 20:07:45 -0400
Received: from ozlabs.org ([203.11.71.1]:41873 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbfGIAHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 20:07:45 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45jN1V1cBXz9s7T;
        Tue,  9 Jul 2019 10:07:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562630862;
        bh=7o/CYp6VmWj5bE6XI6YBbczvFiYUx/Lm356IJopePaQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nwGowiicUsvtnVt8/SwXIwFDzR1yTEqGPX+VvJWVu+k2cT0lUu9hN3HJLtsqcWi+7
         dlIGczWZu8aitWpbCBCVvtleMgQ4wrJbnrxyvOjj8sXiBGQfDzF0QyZaJ+C01TFDgM
         3V62OquK9lgcPH4SuQRPr5XK1VdmY9BH30kksUvFrC7s7bqOqM5bHFgkyQ8iuFPpq6
         6W9o/1Hwr3548sxgO+3UeB2MvHBRwiCKB4cX7/SgSrgwCP4HRUN23nac6W+VfTV10q
         oCAeLpXmymbCCdNs23Tcc5I3x8QDTE4zqiERTIYucgt3ETm6XsrVVYoGik1PvCd/ue
         K9HqTgExXsXpQ==
Date:   Tue, 9 Jul 2019 10:07:41 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: linux-next: manual merge of the fbdev tree with the v4l-dvb
 tree
Message-ID: <20190709100741.1ad8ed91@canb.auug.org.au>
In-Reply-To: <20190625122817.1f6657c7@canb.auug.org.au>
References: <20190625122817.1f6657c7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/GHbZJ=_yBDykcP0DXGHjWLx"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/GHbZJ=_yBDykcP0DXGHjWLx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 25 Jun 2019 12:28:17 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the fbdev tree got a conflict in:
>=20
>   drivers/media/pci/ivtv/ivtvfb.c
>=20
> between commit:
>=20
>   2161536516ed ("media: media/pci: set device_caps in struct video_device=
")
>=20
> from the v4l-dvb tree and commit:
>=20
>   deb00d2785be ("fbdev: make unregister/unlink functions not fail")
>=20
> from the fbdev tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc drivers/media/pci/ivtv/ivtvfb.c
> index 800b3654cac5,299ff032f528..000000000000
> --- a/drivers/media/pci/ivtv/ivtvfb.c
> +++ b/drivers/media/pci/ivtv/ivtvfb.c
> @@@ -1251,16 -1246,7 +1251,12 @@@ static int ivtvfb_callback_cleanup(stru
>   	struct osd_info *oi =3D itv->osd_info;
>  =20
>   	if (itv->v4l2_cap & V4L2_CAP_VIDEO_OUTPUT) {
>  +		itv->streams[IVTV_DEC_STREAM_TYPE_YUV].vdev.device_caps &=3D
>  +			~V4L2_CAP_VIDEO_OUTPUT_OVERLAY;
>  +		itv->streams[IVTV_DEC_STREAM_TYPE_MPG].vdev.device_caps &=3D
>  +			~V4L2_CAP_VIDEO_OUTPUT_OVERLAY;
>  +		itv->v4l2_cap &=3D ~V4L2_CAP_VIDEO_OUTPUT_OVERLAY;
> - 		if (unregister_framebuffer(&itv->osd_info->ivtvfb_info)) {
> - 			IVTVFB_WARN("Framebuffer %d is in use, cannot unload\n",
> - 				       itv->instance);
> - 			return 0;
> - 		}
> + 		unregister_framebuffer(&itv->osd_info->ivtvfb_info);
>   		IVTVFB_INFO("Unregister framebuffer %d\n", itv->instance);
>   		itv->ivtvfb_restore =3D NULL;
>   		ivtvfb_blank(FB_BLANK_VSYNC_SUSPEND, &oi->ivtvfb_info);

I am still getting this conflict (the commit ids may have changed).
Just a reminder in case you think Linus may need to know.

--=20
Cheers,
Stephen Rothwell

--Sig_/GHbZJ=_yBDykcP0DXGHjWLx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0j2s0ACgkQAVBC80lX
0GzbWwf/fKuOWrnaTkat8SYhc+tcZOVRwcCVMqUwTCP2JxM1izsb5pEmwV5ZLRKT
2ismZwjAd3JKKBjQ/mJqdALa9ss9hAPq+rrYaRHrIWbgA9tZnNJrk5mKtxbeCQlH
ffyzxEfD/BX371PF1nqLaKd1zq1Y6FZKiUuPvrJHed868vaurQZee/kDxpHM39N/
jNByVhw9o5SqRTBzTfTSkR2s1DWvIg9tduh9OtxbAAE3Y8/0qsple5WDVApmXew/
qpdp6oZqOM8G4vu9OcJKEzqnMyeG3w0kD0daDSJFO6AL3qpT2kOUwsXFvC8iwA+E
aYRzRSF+ryXfYcjCVmDt6Ga5lh+0ug==
=yPX7
-----END PGP SIGNATURE-----

--Sig_/GHbZJ=_yBDykcP0DXGHjWLx--
