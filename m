Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2339C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 17:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A710F2239F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 17:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563901277;
	bh=jZ/NKFx6EAiSSbKP6Pqh+pROf76ugHXlNwOSk3+A29I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HbZ+OdhcGYfP6N6drMdI6l7opyH+tufl6pkC7R0Z2nTtCLGnE1zvOPYFu8KskTdYv
	 VxPSG+8wDAtW00vqVZMiIkP6Pxa79t1rwXQdRdLsat/AnlUtNs9jwkxdNnGYi5N4dY
	 3ZrBYhyG/FJZvgdNUlUbRLcRdNqTTTln7tetTMSw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390955AbfGWRBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 13:01:16 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39186 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730940AbfGWRBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 13:01:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lM4rRR9UlNkzJHNHnArlH/ByV65Pyr5ihMbwu1aCo6M=; b=ahn4jTwYjyNa4M8unrPay3xxJ
        qlIqnbejiYbw3DRIt9C70tkP9EFqJ3giqYyOya76N0uvawyijpYmPkEBsUhrU6LcdIrOh0cwbToHJ
        eSDRJERbOtHPC03u2b8BaWLgxBA86iMxobxTGynSM5rNTOe9wRcDXZRV7dWKMKwTfnGMw=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hpy9U-0004J0-5S; Tue, 23 Jul 2019 17:00:36 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 7DD202742B59; Tue, 23 Jul 2019 18:00:35 +0100 (BST)
Date:   Tue, 23 Jul 2019 18:00:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     festevam@gmail.com, perex@perex.cz, tiwai@suse.com,
        Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com, timur@kernel.org,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        shengjiu.wang@nxp.com, angus@akkea.ca, kernel@pengutronix.de,
        l.stach@pengutronix.de, viorel.suman@nxp.com
Subject: Re: [PATCH 01/10] ASoC: fsl_sai: add of_match data
Message-ID: <20190723170035.GO5365@sirena.org.uk>
References: <20190722124833.28757-1-daniel.baluta@nxp.com>
 <20190722124833.28757-2-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9DptZICXTlJ7FQ09"
Content-Disposition: inline
In-Reply-To: <20190722124833.28757-2-daniel.baluta@nxp.com>
X-Cookie: Avoid contact with eyes.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9DptZICXTlJ7FQ09
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2019 at 03:48:24PM +0300, Daniel Baluta wrote:
> From: Lucas Stach <l.stach@pengutronix.de>
>=20
> New revisions of the SAI IP block have even more differences that need
> be taken into account by the driver. To avoid sprinking compatible
> checks all over the driver move the current differences into of_match_dat=
a.
>=20
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  sound/soc/fsl/fsl_sai.c | 22 ++++++++++++++--------

You need to supply your own signoff if you're sending someone else's
patch - see submitting-patches.rst for details on what signoffs mean and
why they're required.

--9DptZICXTlJ7FQ09
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl03PTIACgkQJNaLcl1U
h9Ce4wf9FPwW9YoTZLNQAPLcH2tdxWqllpH3ZIAiKSDjWkeH9SHfV2iiH1AAMTIL
yM/q6mJxSQPQ4MLekLosnBJXVMkh6/2U8t2pX6YsLFs//vvguPT5XnBZ3VGti2vo
/jvnayUvKMLs/KhI6EvTT+6UVOBnPos0aFMsLkNbdVzb76jIOPX4kVy/TTiqoSjY
sAtGZkl3m0hfwBlOxWPRgkuJdsckLcRLAvVV99ZopDdsWDo2m0KLEXDCm/81P0F6
oVukPsYlmNfOuU5XpKC+/droD+XBK4AO9gy42C4aFkeSsA8eRmFvLlGjEHXlqBU9
DWoy0wiEwu0NjI5w/kgYiLSufz+TTA==
=kOOi
-----END PGP SIGNATURE-----

--9DptZICXTlJ7FQ09--
