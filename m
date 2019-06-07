Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D86BC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 19:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 574812133D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 19:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559934029;
	bh=UszEn/JpKSNYEk8a9nY3GlGefPE+tI0KaJgJuLLFVI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W1rPfh81ZLZv4V4A5noJBR5ZCI5oW1Mcu6E1yJp3DxkTLIW6AexlPDw0HgZxLx12l
	 hFF3f0UtbWlaftySCcXIli7n8qIyuSJq2fBBDJvFzZXAje/PnI2Urt2ztNRTEv/R6Z
	 PjaNgWPgYImel79hmpLmMr5P4rWYp9aayFgT45AA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbfFGTA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 15:00:28 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56178 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728595AbfFGTA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 15:00:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Shd1VsepN7SYP3yVPk9hMU0yqhXpPeTv75Jd3AVt0P0=; b=XD6H6uP30Tyt1i9a43MsXvcpS
        u78tzMpMXmRFJi7+J2OFniP5Opgl+cB03BvPJacjiQl+7IAu/TaqpTTWGOT1M/U2zPwBvIaufMXQv
        Xvm+65sI1aUsFdYWBEjaxYeUQDYYkpIHh/QMis5XsshMiclrpjwYA7l6Y1Lcry9biLmqs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hZK6A-0003fU-Th; Fri, 07 Jun 2019 19:00:22 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id E88C1440046; Fri,  7 Jun 2019 20:00:21 +0100 (BST)
Date:   Fri, 7 Jun 2019 20:00:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Takashi Iwai <tiwai@suse.de>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        tomeu.vizoso@collabora.com, mgalka@collabora.com,
        matthew.hart@linaro.org, khilman@baylibre.com,
        enric.balletbo@collabora.com, Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, "kernelci.org bot" <bot@kernelci.org>,
        linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] next/master boot bisection: next-20190528 on
 sun8i-h3-libretech-all-h3-cc
Message-ID: <20190607190021.GK2456@sirena.org.uk>
References: <5cef9f66.1c69fb81.39f30.21e8@mx.google.com>
 <s5hr28gszvj.wl-tiwai@suse.de>
 <8ca25787-fc03-7942-0705-3ec7d88862a6@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y+dl6OcicAkN96vR"
Content-Disposition: inline
In-Reply-To: <8ca25787-fc03-7942-0705-3ec7d88862a6@collabora.com>
X-Cookie: The other line moves faster.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y+dl6OcicAkN96vR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 07, 2019 at 05:31:12PM +0100, Guillaume Tucker wrote:
> On 30/05/2019 16:53, Takashi Iwai wrote:

> >> +	mutex_lock(&client_mutex);
> >>  	for_each_rtdcom(rtd, rtdcom) {
> >>  		component =3D rtdcom->component;
> >> =20
> >>  		if (component->driver->remove_order =3D=3D order)
> >>  			soc_remove_component(component);
> >>  	}
> >> +	mutex_unlock(&client_mutex);

> > Ranjani, which code path your patch tries to address?  Maybe better to
> > wrap client_mutex() in the caller side like snd_soc_unbind_card()?

> Is anyone looking into this issue?

> It is still occurring in next-20190606, there was a bisection
> today which landed on the same commit.  There just hasn't been
> any new bisection reports because they have been temporarily
> disabled while we fix some issues on kernelci.org.

I was expecting that Ranjani or one of the other Intel people was
looking into it...

--y+dl6OcicAkN96vR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlz6tEQACgkQJNaLcl1U
h9Dh3wf/TNLGXITYp6q9mQ9egkequDBS+4Phd+1FUwWoAvAmPXJ1f5U3mBFy/7mT
5ZiqLcBmGCrEJWoeohd9oqBw6vCq9g+qGUKxcv/1qG0eI4kTvLi5Vrq8VvJpzYop
wRcBL30vIj27Z6AlWCEHqzQkFdKo06UiWtvb1GbDgIfpII1pr/m8hfenlcmR5b8j
JvGLkVxJ248cTy73FsK4/RiS+Cb45Dgbrj90jTKP5FT7SHE67KnDCV54K7HRK3qA
5SxBggCaEgEk93RcuwbhhbPIXv8qsNhsrtC6sJpFQ7WM68oeJ0zIkofpnfv85g27
DzUdFQChfcThUIgj21AdnLC/rXxgrA==
=9vhX
-----END PGP SIGNATURE-----

--y+dl6OcicAkN96vR--
