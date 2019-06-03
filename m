Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42569C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D21271AF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559584799;
	bh=+j+Z5yrXYrk12i/w+udO7S/iAI3TaKAqbb1gBZmCuTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PmTz1BupLwVnmdaaWNLCPHXbdT4F+tGK/E+ZU0o5YNvAb5+5WYjuUYzVIaqE1luyv
	 qDmfLSr6pxFJgaLSlroX8UH2eiL/n3SNpr8+c/9T2mRdVMY8NpN0esOYenvbjptxww
	 dnY7tye4GyZQPG97Nsduy1aAeeJoPvHa143/eu8A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfFCR76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 13:59:58 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51436 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfFCR75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 13:59:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vNoaf/BsgR5R3vkbQszzxACBpSzqrvmtQNpGl/ZGtVo=; b=ERkp3AU0Wn3OR8kwDnboAVXRT
        HSa2MUef+xurMo13nBTNlXdnGoslMWOjPzFa8Ch8O0j5Bi98vHUVSfr1K8F9wfwv43BduTAQ9m+X+
        STCp7vL/qJB+IhZjMXLi+drV920WiM+1XvaGg7dv7exOUTKS7KR/CHP1FfUC7ekZjy/7c=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hXrEK-0003XG-PV; Mon, 03 Jun 2019 17:58:44 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id B2C30440046; Mon,  3 Jun 2019 18:58:43 +0100 (BST)
Date:   Mon, 3 Jun 2019 18:58:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, kbuild-all@01.org
Subject: Re: [PATCH] ASoC: soc-core: fix ifnullfree.cocci warnings
Message-ID: <20190603175843.GA30701@sirena.org.uk>
References: <alpine.DEB.2.21.1905301904530.2500@hadrien>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1905301904530.2500@hadrien>
X-Cookie: Goes (Went) over like a lead balloon.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2019 at 07:06:11PM -0400, Julia Lawall wrote:
> From: kbuild test robot <lkp@intel.com>
>=20
> sound/soc/soc-core.c:391:2-7: WARNING: NULL check before some freeing fun=
ctions is not needed.
>=20
>  NULL check before some freeing functions is not needed.

This doesn't apply against current code, please check and resend.

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlz1X9IACgkQJNaLcl1U
h9CjqAf/dHMmaH160jKSA3JntU1LqgMdZeChArVfnwMLbNzKgFHsL3QKbmUKc4AG
Tr2UTEkqrx9bWisFr6QHitR8Cn4J65tJd11GlgbtKhbIp4SzA0R91QBgwIq11Ydf
be3a/fPLacVITJLzpB6HXX84NbutITX7NXO3UBrHdvGungUBdp8Y+v7fEtQslP4u
jJjMISUqPyM7zZzKR53beoKqjHQpfyKXaEyM/zJwvj/1kQzOLfw2CXQ7qEfIs0B0
im0OuQfsVNFiOwzP5Ns10p96TbTJ+pTFuuT0jbiMwmKjNDgETC9chUUljIsZZwM+
mCFTYM80ltgY0iT3MjGFN/GPtxoUqA==
=kyDr
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
