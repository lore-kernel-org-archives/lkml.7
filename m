Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8DAC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 02:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8BC72086C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 02:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556762976;
	bh=/xvat0Dy24eH97apuIldA6Kz8uuGYiYT1K0fyKfCg4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LKwnHxGj85tU5ca3eyb7acwiY8QIS9ERiyxUy2relF4RSbFL1sTYcWleCDpllFLKj
	 jH4URg7tUFKNygJAuDo/D260N2dOsXn30uqtvdt7ybyBbWzeGH8l3y9RQn6XrOpvva
	 lYGeAQryPWSwdIriDm9P2SpBkP3VWGkjZXx7FxTk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfEBCJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 22:09:35 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40158 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfEBCJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 22:09:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9qrOjXUAzoL3QukZfNxj9Z2f6/cNNtJl5gF/8qMJ/nM=; b=k1j3roMBI641G/c+bxN1yEEbF
        cAlY0SqS8Mkq1cFSLFGCTq3yFmYeHaZUzF+yDjSGElj/2zbti6J/jbLMR8rD4C+ANsOblUq1HUBiJ
        sdX5THxIJTjsQ49Jrk4cJ4+11L0oj+lbLFdK43+oVHWAQ13zQ+M4xwPgc+1sZJB1PtFHY=;
Received: from [211.55.52.15] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hM1A5-0005ng-Jg; Thu, 02 May 2019 02:09:25 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 2D2DA441D3B; Thu,  2 May 2019 03:09:22 +0100 (BST)
Date:   Thu, 2 May 2019 11:09:22 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: tlv320aic3x: Add support for high power analog
 output
Message-ID: <20190502020922.GA1602@sirena.org.uk>
References: <20190430200118.13014-1-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <20190430200118.13014-1-sravanhome@gmail.com>
X-Cookie: Do YOU have redeeming social value?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2019 at 10:01:18PM +0200, Saravanan Sekar wrote:
> Add support to output level control for the analog high power output
> drivers HPOUT and HPCOM.
>=20
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>

This doesn't build with current code:

  CC      sound/soc/codecs/tlv320aic3x.o
sound/soc/codecs/tlv320aic3x.c:428:20: error: expected =E2=80=98}=E2=80=99 =
before =E2=80=98;=E2=80=99 token
    4, 9, 0, hp_tlv);
                    ^
sound/soc/codecs/tlv320aic3x.c:330:61: note: to match this =E2=80=98{=E2=80=
=99
 static const struct snd_kcontrol_new aic3x_snd_controls[] =3D {
                                                             ^

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzKUVEACgkQJNaLcl1U
h9COAgf/bEXTHlf3176QpGpGHCWyhIp2dGCP6gMgr0PXVEVWSMHxsgsy+VoB9x/n
lApLY1dU5su1ZFAIfrgKw50lYRcplng82rn9ucAWXaU/mRh5siPAvHoNajCauI8n
6mjjlv4gngHg8ctQQ2y0vNyzs96MlMcs9aYnIBYnLDOthFBbcai8IBRcgxw2pWp7
dqJK+je2hIFMyJN3ChvgU0h9/C0OFWraSShvMEZRmQJJQ04IxjjuCUXKqHUYoqcZ
QkGa/zyYw/rrD4XlTp0dQF3aVwe+b4SuytbQ6Hf0bd6Z8G2ze70jSXuArQpLa/Tq
jx6FAB963mIStEewayY4z0zmNbQqzQ==
=WLwu
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
