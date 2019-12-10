Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9650EC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68C3B2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575982969;
	bh=AczfoLJPZVx5bxneZlZgjjZlR3YW0MKGD5RArA43qjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ijdgrw3T9accd8LN0JtucNSTk2ThKbCNIl7buiyQ/0/76gA9GO07QxWrzb6JLQr/G
	 Vobc0P4NB909zTVJf5l+3eux70SD9uYt86xbTg1YfhvEPgnrMWzx1omVDiPYP5x8PB
	 u1kGBFy6C7plXhWL4IY+lp8UdXQHxu5Gqv9IcSmA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfLJNCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 08:02:48 -0500
Received: from foss.arm.com ([217.140.110.172]:43428 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727296AbfLJNCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 08:02:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8D3E328;
        Tue, 10 Dec 2019 05:02:46 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 67D853F52E;
        Tue, 10 Dec 2019 05:02:46 -0800 (PST)
Date:   Tue, 10 Dec 2019 13:02:44 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH] regulator: max77650: add of_match table
Message-ID: <20191210130244.GE6110@sirena.org.uk>
References: <20191210100725.11005-1-brgl@bgdev.pl>
 <20191210121227.GB6110@sirena.org.uk>
 <CAMRc=MftOnQVAUjOz=UGV-S2HKPpiucQp98xYTdxgt7d8obCMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="N1GIdlSm9i+YlY4t"
Content-Disposition: inline
In-Reply-To: <CAMRc=MftOnQVAUjOz=UGV-S2HKPpiucQp98xYTdxgt7d8obCMg@mail.gmail.com>
X-Cookie: We have ears, earther...FOUR OF THEM!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--N1GIdlSm9i+YlY4t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2019 at 01:51:38PM +0100, Bartosz Golaszewski wrote:
> wt., 10 gru 2019 o 13:12 Mark Brown <broonie@kernel.org> napisa=C5=82(a):

> > Why would we need to use a compatible string in a child node to load the
> > regulator driver, surely we can just register a platform device in the
> > MFD?

> The device is registered all right from MFD code, but the module won't
> be loaded automatically from user-space even with the right
> MODULE_ALIAS() for sub-nodes unless we define the
> MODULE_DEVICE_TABLE().

This seems to work fine for other drivers and the platform bus has to be
usable on systems that don't use DT so that doesn't sound right.  Which
MODULE_ALIAS() are you using exactly?

> Besides: the DT bindings define the compatible for sub-nodes already.
> We should probably conform to that.

I would say that's a mistake and should be fixed, this particular way of
loading the regulators is a Linux implementation detail.

--N1GIdlSm9i+YlY4t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3vl3QACgkQJNaLcl1U
h9Amagf9FHdZjq75Wvos3izwzeUuhA4se+7rzpaxSkC1wuTcff7UCmtpwq8mFMwl
GFlGj6oayrvDwNGT2XUm0vCNOP/be+ZrPkw+eTbPZlHSm5WVzL+YS+P76VYhDzSC
hNd+ssKgFVogMY0r9sn0PYHQWURQ//7InGAPf+IehUw/Mu1LRO/y/i3CbBuLwYAV
n3LzU8BRzmTzR4+nEh4gQRv12dY3L2q4mE79W+0z+/r4RLlMXRMFKp88aQWjeJGg
k4xTwmRl7YrqidecCibDidKDqtVr7hMD6lxcfcImmGosEc55QMLspqdm7Mi29jKW
cFmiaQHxRsBYvUrNsFquFFK9WE/YrA==
=3eJr
-----END PGP SIGNATURE-----

--N1GIdlSm9i+YlY4t--
