Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C1AECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD5421848
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570640400;
	bh=Ix2LISwnINrg5/TxVckaeESYmmQSFSkxHfTMO6PEgT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=O4PQX5bX8SiM2ILhPhrMQCIOZwzjrMI+gkxTD+2zxBmvY1RKPzzhSDikOiA5AxqZP
	 GKgbHgSq4uyhb7oE+H+bTWfBQ10k8f7qL7fXSwtrIX5XUPsn1uN6kmMuQMRkIRpIQQ
	 BHcqG5bNyEqG+tRE2H5KmxN87NWwHVbVlwr6melM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731720AbfJIQ77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 12:59:59 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35070 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730546AbfJIQ77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 12:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Rj06Tv5j+rvhEcTqvvqFPxXNxUI4Mfz6LMD0PqzgMF4=; b=wnmE+fItLg2W6Q9JuGiFzyNtF
        Hn5rFYVs1CrEiohk66VdhhmARG+r/KAFLkPbtAbHUTN6IXR4w5tV4MDBnF1qr5mWmTkMGcAChts1f
        /D/pJ3wR2vnnQczB01F9vf05nuT2dzVeJgbvo8DohPDZ16Ck4T3wz33eEkJJXEZ4rSveI=;
Received: from 188.31.199.195.threembb.co.uk ([188.31.199.195] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1iIFJa-0005HN-L7; Wed, 09 Oct 2019 16:59:54 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 8DBA3D03ED3; Wed,  9 Oct 2019 17:59:53 +0100 (BST)
Date:   Wed, 9 Oct 2019 17:59:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     spapothi@codeaurora.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        vkoul@kernel.org, bgoswami@codeaurora.org
Subject: Re: [RFC PATCH] ASoC: soc-dapm: Invalidate DAPM path during dapm
 addition of routes
Message-ID: <20191009165953.GM2036@sirena.org.uk>
References: <20191009102127.7860-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5y45gzHVJWc99xXB"
Content-Disposition: inline
In-Reply-To: <20191009102127.7860-1-srinivas.kandagatla@linaro.org>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5y45gzHVJWc99xXB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2019 at 11:21:27AM +0100, Srinivas Kandagatla wrote:
> From: Sudheer Papothi <spapothi@codeaurora.org>
>=20
> During sound card registration, dapm adds routes of
> codec and other component paths, but the invalidation of
> the widgets in these paths will happen only when the
> sound card is instantiated. As these routes are added

The whole point with this check is that as you say we're
validating everything as we instantiate the card, not piecemeal
while the map is partially constructed.  Doing that is wasteful
and noisy.

> before sound card instantiation, these widgets are
> not invalidated until a playback or recording usecase
> is started.

You said yourself that we sync everything when the card is
instantiated.  Not on first capture or record, when the card is
instantiated.  If for some reason there is some problem with that
on your system please fix that, don't add a bodge somewhere else
to mask the problem.

--5y45gzHVJWc99xXB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2eEggACgkQJNaLcl1U
h9BgPgf3RQI51vbBRTM40x54ZfHusQX6D6EE8gGPuMWgrrPkxU6CroFzRmvr5jps
n2voRmRkI7TsiHIRL7qYwCwjsNxwRi7J/s3SLem7WoC64io0f+yU7z/hTmuMK9Js
NejKG2uFU0o3Cmtzn6I160MCnav+FsCJ5UgwqTcZdUxLmMJJoOScM8BEK3ExdUf5
06YQGcMpaZtB1XbfyCNqy7KpHkOpFxAerW5Df5Vkv5WEs0zZNZpbvUKpyKBD8lOY
iBIq48MHlsZ7sp55FKhTKqfs5Uj2DZ2zkF7fSeqTBQuaZK/o2zRTxEB5lnkD/88Q
dNCBvlCBtU4PiMfgJ0mvrUbjD4lQ
=rzwa
-----END PGP SIGNATURE-----

--5y45gzHVJWc99xXB--
