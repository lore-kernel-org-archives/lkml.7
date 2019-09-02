Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD12EC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 15:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FD2A22D6D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 15:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567439546;
	bh=jEk14Xw+qReRDvI7HP9Vpt19N2X62LAWFe5kv4gLOLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ynWjrvXTXzDI7efymOCUvrcjhhKHsQot1gWQ09XoBpWr5esEDLCBwj0eXOqKyRIXN
	 PkHtIk13JLBADOSC6UeyaHsx7q4hwE/h70jFfngG0mrsghE6Elii8u1kb3+2GRAj84
	 AhQdFbAxymFLGmWDiNY/8ARPu9kE95mBhfUiWCmM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbfIBPwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 11:52:25 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60460 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfIBPwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 11:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4snlMMv36cskyMNKU3ymZ+DNhz9Szex5LZ1cJjgF/oE=; b=vMgNoxLsQ2OdwDMfQal76QX6q
        yFK8aDuSJNaBrC6c2rEAbXdWCOi4TiUGgyAy3uzXB2xrYp3gARtzG756t6DiVArWe2VVJeV0txXl8
        eSJbnWT0V/ynRwnySl2YCGJybMQrC96D26jDk0tuo0VFpysWShVi8Fj8D5DVaLjkSPabQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i4oct-0003fI-E6; Mon, 02 Sep 2019 15:52:19 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 852E02742CCB; Mon,  2 Sep 2019 16:52:18 +0100 (BST)
Date:   Mon, 2 Sep 2019 16:52:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Baluta <daniel.baluta@gmail.com>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Timur Tabi <timur@kernel.org>,
        Cosmin-Gabriel Samoila <gabrielcsmo@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Set SAI Channel Mode to Output Mode
Message-ID: <20190902155218.GC5819@sirena.co.uk>
References: <20190830225514.5283-1-daniel.baluta@nxp.com>
 <20190902123944.GB5819@sirena.co.uk>
 <CAEnQRZDmVoSkpf47mTHeEKodX9_x4Y_9EVrkS=ta4sWU8tD3Zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ABTtc+pdwF7KHXCz"
Content-Disposition: inline
In-Reply-To: <CAEnQRZDmVoSkpf47mTHeEKodX9_x4Y_9EVrkS=ta4sWU8tD3Zw@mail.gmail.com>
X-Cookie: Lost ticket pays maximum rate.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ABTtc+pdwF7KHXCz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 02, 2019 at 04:35:56PM +0300, Daniel Baluta wrote:
> On Mon, Sep 2, 2019 at 3:42 PM Mark Brown <broonie@kernel.org> wrote:

> > This patch seems to do this unconditionally.  This is fine for
> > configurations where the SoC is the only thing driving the bus but will
> > mean that for TDM configurations where something else also drives some
> > of the slots we'll end up with both devices driving simultaneously.  The
> > safest thing would be to set this only if TDM isn't configured.

> I thought that the SAI IP is the single owner of the audio data lines,
> so even in TDM
> mode SAI IP (which is inside SoC) is the only one adding data on the bus.

> Now, you say that there could be two devices driving some of he masked
> slots right?

Doing that is the major point of TDM modes.  It could even be another
SAI on the same bus.

> I'm not sure how to really figure out that SAI is running in TDM mode.

As a first approximation you could just check if set_tdm_slots() has
been called, it might still be the only device but it's a good first
guess.

--ABTtc+pdwF7KHXCz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1tOrEACgkQJNaLcl1U
h9DwBwf+JVnQJkaiQDq4QeWXVRXWkHGSybe5ZQnqojYXRZ71ee4yODWtXbxwki74
prPVLxMWCoCRvuoxUB4fQFbKN9qCkz0uZ/uthmNqsjueAVWYsAE+3YIA5cw6Kc/c
KFa1n4mptpdnmRwLg79ZKuX8GiudgJon/bR5fdveOdB2oeqmx4ooAD/TXsvmx7D6
qn9AAyYbadyk/6WAVGhmBj+N7lN1R6kdW35i8kVtrMvlOnsmFOYLVXjQnKZCQT9w
zHYp3kQWX2QxderqG4qqQNLc03R1qYBLWv784lj91hyXuaXGovxg84tzYzqgVb2c
nIPwaFdNgrNWTHCQ4ijb7pXXcuieQw==
=gUoA
-----END PGP SIGNATURE-----

--ABTtc+pdwF7KHXCz--
