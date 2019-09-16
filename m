Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1099FC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 18:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB937206A4
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 18:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568657308;
	bh=KbwPsELW3WIASO4863nxdNhKgePSrm4NMEwpLvuisQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yypP6ZvD0a0Vjv3UqSbK7mfN+h0MfbeJn4EnzN7I9Kn27YHjmFfKShr8NaLmis9aK
	 OgMOX4ihlRozfPJnrRbCAc0rfCWBBJ7DY2mkYXsy6CLdIbqwC3JP+yUSrWS6fC6WLD
	 277WxmBVEvklUCueiSHSQxji1P3Kx/hEht4l13JY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390234AbfIPSI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 14:08:28 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49180 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729765AbfIPSI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 14:08:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IhH8eG5jrmv5K+PdK/jRPJRJORLMPGfQ9Mu0yZDLXao=; b=KwzTtsFTbybFw474V6VBrCeXi
        EQ9ZNyYUDVea3mWV6fDFsK7Aanb7ZWj+GzYrXbtDNgrInzYj4Z9kpuBIILVqS/XXkS7RAK0ITFjG+
        MSwdIU5caaopv9HF1cI5CDtZ1RF6vVqZUNH1Qlq8+A8Qbs46wi4iy0WP3ydsbUpI9zHLw=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i9vQ9-0005Jy-2b; Mon, 16 Sep 2019 18:08:17 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 24F432741A0D; Mon, 16 Sep 2019 19:08:16 +0100 (BST)
Date:   Mon, 16 Sep 2019 19:08:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Austin Kim <austindh.kim@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Roman.Li@amd.com,
        amd-gfx@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/amd/display: Fix compile error due to 'endif' missing
Message-ID: <20190916180815.GK4352@sirena.co.uk>
References: <20190916044651.GA72121@LGEARND20B15>
 <CAK7LNARZMr5ZKGufi63GZrZ45k60faAiXr4mBB_mU9h_QifjxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IKC1RK7+nRZ8SZaO"
Content-Disposition: inline
In-Reply-To: <CAK7LNARZMr5ZKGufi63GZrZ45k60faAiXr4mBB_mU9h_QifjxQ@mail.gmail.com>
X-Cookie: Man and wife make one fool.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IKC1RK7+nRZ8SZaO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2019 at 02:46:48AM +0900, Masahiro Yamada wrote:
> (+CC Stephen Rothwell, Mark Brown)
>=20
> On Mon, Sep 16, 2019 at 1:46 PM Austin Kim <austindh.kim@gmail.com> wrote:
> >
> > gcc throws compile error with below message:
>=20
> GNU Make throws ...
>=20
>=20

I don't have the original patch so I don't know what the issue being
reported is :/  Whatever it is it wasn't caught by any of the builds
done during the process of building -next and nothing is jumping out at
me on KernelCI.

> This is probably a merge mistake in linux-next.

> If so, this should be directly fixed in the linux-next.

> If it is not fixed in time,
> please inform Linus to *not* follow the linux-next.

It's probably worth coordinating this merge with DRM, it's not *super*
complex but clearly there's some potential for error here and it was
definitely annoyingly fiddly.

--IKC1RK7+nRZ8SZaO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1/z48ACgkQJNaLcl1U
h9BEtAf8Cg6gsw4Wr7G6vas1AyCCbY8RUAsjUmUecWcXXaUrxAlhZINRy+3tV8pB
1+uxPZZbpbrAtrb7GATiJZAEmCbazZP5PlHWivEgTfqSUQiHSDoX/5gvtaGdfQoq
fEosO5kiJ1Z7uEjKLgqfdIotR0oGxYYBRAhMPs5Q+KDheHdNDVVkWjKkqfLGBMvc
QxAbEbCfF3mk0MziIFmI4rmsREpvVE3YqWZFcp/u0dUbg/+hAf9/MKH2W1EK7qi4
L45PCcnI9vR5hivC8iNYZnvFtg1IugOgX7kM/6Wp8g4jxvTPeZGqYG4LFfdRU2lx
wMBC2pjSApPd0pdO0uUyA7Cjn9Tg/A==
=cbJO
-----END PGP SIGNATURE-----

--IKC1RK7+nRZ8SZaO--
