Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B67CC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00DD22073D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575999426;
	bh=68fJHwa23ik7w9aZXtoNpMuzICW4PQUubwWMvhuwEvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MhMJaqSm8AiOnTsiMNY0WVY6TNDQ8griTpKe7snfvcTcJkuDwdSn/SUbrSUZFUJiZ
	 6b3jnn/ZSZOUIzs7248VOQtFPs6IG+i66tlwR7M+hA4Klraevp6wYXbSONKvJ90kIR
	 rW9I65PTfS7XiTHkenYpseTRatWoDwMHj71ktBQI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbfLJRhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 12:37:05 -0500
Received: from foss.arm.com ([217.140.110.172]:51980 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727527AbfLJRhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 12:37:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F15F1FB;
        Tue, 10 Dec 2019 09:37:03 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E9123F6CF;
        Tue, 10 Dec 2019 09:37:02 -0800 (PST)
Date:   Tue, 10 Dec 2019 17:37:01 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH] regulator: max77650: add of_match table
Message-ID: <20191210173701.GH6110@sirena.org.uk>
References: <20191210100725.11005-1-brgl@bgdev.pl>
 <20191210121227.GB6110@sirena.org.uk>
 <CAMRc=MftOnQVAUjOz=UGV-S2HKPpiucQp98xYTdxgt7d8obCMg@mail.gmail.com>
 <20191210130244.GE6110@sirena.org.uk>
 <CAMRc=MenTgffszv4NsbCKRhH0TcRPSTLbeP3BttW9fmFBjLdCA@mail.gmail.com>
 <20191210132136.GG6110@sirena.org.uk>
 <CAMRc=MfUSJeNur3VpA7_=kSDpk1L83cK1+Tke3MPBZwfG9NubA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SUk9VBj82R8Xhb8H"
Content-Disposition: inline
In-Reply-To: <CAMRc=MfUSJeNur3VpA7_=kSDpk1L83cK1+Tke3MPBZwfG9NubA@mail.gmail.com>
X-Cookie: We have ears, earther...FOUR OF THEM!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SUk9VBj82R8Xhb8H
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2019 at 05:53:11PM +0100, Bartosz Golaszewski wrote:
> wt., 10 gru 2019 o 14:21 Mark Brown <broonie@kernel.org> napisa=C5=82(a):
> > On Tue, Dec 10, 2019 at 02:10:15PM +0100, Bartosz Golaszewski wrote:
> > > wt., 10 gru 2019 o 14:02 Mark Brown <broonie@kernel.org> napisa=C5=82=
(a):

> > > MODULE_ALIAS("platform:max77650-regulator");

> > Huh, that should work...  I wonder if adding a compatible to the DT has
> > messed it up, does it work without the compatible in the .dts (and with
> > the of_compatible removed from the MFD driver I guess)?

> It does work when removing the compatible strings.

Ah, that explains it.

> > Yeah.  Though it may be too late, shame I didn't catch this when it was
> > merged :(

> Yeah, I didn't know any better too.

> Rob: the bindings for this were released some time ago and they define
> compatible strings for MFD sub-nodes, but using compatible strings for
> sub-nodes is apparently incorrect and the drivers don't support it
> either. Can we remove them from the bindings?

I think at this point it's better to just keep compatibility rather than
disrupt anything, I'll go ahead and apply your patch.

--SUk9VBj82R8Xhb8H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3v17wACgkQJNaLcl1U
h9DbiggAhAq08wPQeNItD926Re1YRbHI9TGDDUAQ2i8GCliAn3AR1uJc2Vzjme3r
Lx3LmdVCye9k4rZazMgTSkOcPi1eg7zmDP98tdLdyqxbwPMTK56yPiIS6rYiDeDo
NBPW8dt7XU71RKFA6QwhVfgDoxVK63ZeXR31KkEmWf1Ybbcb2k7PDMisgjhKEyk1
/I7KSaQ+ga/bBJQNNPd3ratyB6ut/SJMNE5bYDUOs2jJNrvUdmp0WrLAoQxRfRvl
ZAuwZORYbMmE6W6sgymxBS0uxgHU9kBRqsXR4ypoS8qgA+wdRXmJMI3njdWIZ+87
FOMmh0IEJ5e9PQ6QqHZQd9fwhuE9hA==
=ItqK
-----END PGP SIGNATURE-----

--SUk9VBj82R8Xhb8H--
