Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660BCC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 06:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2563221019
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 06:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557297380;
	bh=HRSYxr/27+eqtszKC65CFRHVv3BvRaM+8RS36Soh/sM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bBFdz/nQHP5n4r0MSjDQ8QjcMJ6RgsCCN+Ah6z+AEXo4gO8/m1DKjjcQhQnyKrW4v
	 PCaE4Axnf9zXDnBOFz5bK7V9OONJpZNcnrcI2FlfqV2ymusMZi0fWjRXoD5a8R/0It
	 qlX2f0sShzgpAq36//fJ+11F8XUoeKGPaECbvjPI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfEHGgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 02:36:19 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54660 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbfEHGgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 02:36:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OYCNy7tkPY7Q7/D7L/X6WuduwJJrhyZwHhYAzjXd5sM=; b=eo4CINxuY5v3bG3LULC/w5Qmc
        Grs313C71BNmpRVgbFTGnz9pHbSO7fSixPkCbShlt5jrgNGt5yKUqwjpdUUchAc+ys5E/o23sR1us
        6I/spAkXxWgwHoIqx4uDOPzqk2C7X97BybbJM1IyYokgbgL85qpGfFhtxMzFyN9kFza5w=;
Received: from [61.199.190.11] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hOGBU-000795-Pm; Wed, 08 May 2019 06:36:09 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id E0C2A44000C; Wed,  8 May 2019 07:35:58 +0100 (BST)
Date:   Wed, 8 May 2019 15:35:58 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Curtis Malainey <cujomalainey@chromium.org>
Cc:     Fletcher Woodruff <fletcherw@chromium.org>,
        linux-kernel@vger.kernel.org, Oder Chiou <oder_chiou@realtek.com>,
        alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ben Zhang <benzh@chromium.org>
Subject: Re: [alsa-devel] [PATCH v4 1/3] ASoC: rt5677: allow multiple
 interrupt sources
Message-ID: <20190508063558.GM14916@sirena.org.uk>
References: <20190503230751.168403-1-fletcherw@chromium.org>
 <20190503230751.168403-2-fletcherw@chromium.org>
 <CAJ77E19K7ukNzvhOx1Jh_E6A69fqc6OMJ1aEgR6QjFmM0d=ePw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yf+QnTYkcH7pT0Mu"
Content-Disposition: inline
In-Reply-To: <CAJ77E19K7ukNzvhOx1Jh_E6A69fqc6OMJ1aEgR6QjFmM0d=ePw@mail.gmail.com>
X-Cookie: -- I have seen the FUN --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yf+QnTYkcH7pT0Mu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2019 at 02:10:26PM -0700, Curtis Malainey wrote:
> On Fri, May 3, 2019 at 4:10 PM Fletcher Woodruff <fletcherw@chromium.org>
> wrote:
>=20
> > From: Ben Zhang <benzh@chromium.org>
> >
> > This patch allows headphone plug detect and mic present
> > detect to be enabled at the same time. This patch implements
> > an irq_chip with irq_domain directly instead of using
> > regmap-irq, so that interrupt source line polarities can
> > be flipped to support irq sharing.
> >

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--yf+QnTYkcH7pT0Mu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzSeM4ACgkQJNaLcl1U
h9BylAf+Nv/ilS/5+jTsgqLELyIU1qpJcPHRC012pUfUyxBH8YSDpyPfqOOCGXoI
O9V67lf67LEVCYsUXgSfpcALi084m38vQfXGJppyPniYWEczD90yZOkm2faA46o4
QKeDeVGTwtbZ5phTrqOx9YsBE8k8XfBmzcy3u1b0ZmHMUqAM1b33QO4rCFJs5iZD
at95vkcj9Adm092gyGgmcY32xIAMR2Y0CGlKAAGd9Gk77mtPL7gVhrPXGQu266Cb
XKrDI44ZX79Ob00wMMoJUaVKAAbGwcl71VOXQFpI5tnDgnV5jCq+1k+00b6xlwiC
sE+rE+1f4uGwLBJt04QQa8kW8dA0xA==
=mlaw
-----END PGP SIGNATURE-----

--yf+QnTYkcH7pT0Mu--
