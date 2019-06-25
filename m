Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE90EC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 12:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A64208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 12:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561464137;
	bh=WJOVGAz1c0OOcyDbIfhtLcfA6Ul6Hv2n0Y1uLzpkXU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0ZQ03tIFxQXBywryJ2L4CcvrvYYA7CUeq2KI3384Tt+A6uGsndQFPcvVON2nG1Sn4
	 2XAoXq9ft2Ibr2PYmv9TFxwvbX38K2q169E7UvooN6XZ9T067M0OzO+ogYuMBAU+vw
	 9RLPcKohy+B48atOlPnIAND3sgH/xqjum0nu9UuM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbfFYMCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 08:02:16 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55434 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbfFYMCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 08:02:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=b2J4Pt7t4hYVG7ofjpjNHmNyJ482a3sq6kwtJg/kj00=; b=pp7H62C8OUex2EpyNRapqgEJN
        bRL9VIiNb8IuO2noOl3YFsOczGlTpPE6vgs/UFEa7EOsdHSJrCaI4fCe9PGZHysZk8x6ojEX7kwgW
        EI0f0Rsa5NvJIrUya5hdhCGDzvZmIYdRvIAkHQf3Dpd22St9v2JsrQGL5bKflSXAAHG5M=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hfk8s-0005Dt-KL; Tue, 25 Jun 2019 12:01:42 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id A18BC440046; Tue, 25 Jun 2019 13:01:41 +0100 (BST)
Date:   Tue, 25 Jun 2019 13:01:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/11] ASoC: compress: Fix memory leak from
 snd_soc_new_compress
Message-ID: <20190625120141.GQ5316@sirena.org.uk>
References: <20190617113644.25621-1-amadeuszx.slawinski@linux.intel.com>
 <20190617113644.25621-4-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FpiZi7hT3UZZkRL4"
Content-Disposition: inline
In-Reply-To: <20190617113644.25621-4-amadeuszx.slawinski@linux.intel.com>
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FpiZi7hT3UZZkRL4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2019 at 01:36:36PM +0200, Amadeusz S=C5=82awi=C5=84ski wrot=
e:
> Change kzalloc to devm_kzalloc, so compr gets automatically freed when
> it's no longer needed.
>=20
> Signed-off-by: Amadeusz S=C5=82awi=C5=84ski <amadeuszx.slawinski@linux.in=
tel.com>
> ---
>  sound/soc/soc-compress.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)

This will mean it'll get freed at some point if the driver for the
device it's allocated against gets removed but it will still get
allocated every time the card gets instntiated (eg, due to deferred
probe or due to some other driver getting probed and removed).

--FpiZi7hT3UZZkRL4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0SDSQACgkQJNaLcl1U
h9CaAwf8DVsk20XPT9zYetddOVSYB+aF3yUzSct7IemG29IlKRZZc/cPOycQkP92
weS9wGPzizmWuHiwwDCOsP9SooYKsYyYIRXJOldfrt4/tjnfuNNsjpF21/moUeoj
rDjJ2RZVz5qwKTkRuNxclDfo0i44/SKK+Mr5hcNGYV1G7hYngza5x45WwsY3N20F
56cNs8ct+Yd25TbrskUE+reGVIoSGrNei8tDunr9BOegLB/FAUdbFYZ61doHesf4
O+X+iNhE+/GbGAzxMUm5jZ6yDR2VEz63Kx4jtJ+auG1d5bOReWXxc/8ezeucdGMd
G4ZL2CALbTKAHgvtZu29cZaZ81T4Ew==
=m/VR
-----END PGP SIGNATURE-----

--FpiZi7hT3UZZkRL4--
