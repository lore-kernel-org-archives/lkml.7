Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA320C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B535C21881
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566934502;
	bh=yx8nk8dTM0aqNuwn7gaixZWJzPlxEO6RGGKg8j8x+9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1l2KjAODT20XoIbMZPNLpNu3V1HxgSBomRWLl3y9e155UBgR12QAuHl/ykP+GHoVv
	 LUlHqucmt1F5Rj3z5waS5yYsv+6f0pTIDJm5InF681EgStGGyWT880YgA7LLwQHMMm
	 TcgJRvg/AYhHz8sA/v5zmaRNk+jKg9M68WtlrKrI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731051AbfH0TfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 15:35:02 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37126 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfH0TfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 15:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BSEGfqhHxosfCTMFvfb3OH6NA/dqX4PwBSHkt8Fu78M=; b=Xzgl2tF92u90dovfixrre3NOw
        /UJclMg0mJA39k867X3iKgwNaqWc9yAWB0CUG6+lOzn7kPyFvSpNOjV6r1ESZh+kNBtpmBxjmPoxN
        oE3MeSCXWob2f61MIkETk6RH5ClKztvhHtzJt2SICjnLtJCLtDCJnKpF2yzYXPlr4+Yx4=;
Received: from 188.28.18.107.threembb.co.uk ([188.28.18.107] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i2hEy-00016d-7C; Tue, 27 Aug 2019 19:34:52 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 52866D02CE6; Tue, 27 Aug 2019 20:34:51 +0100 (BST)
Date:   Tue, 27 Aug 2019 20:34:51 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        =?iso-8859-1?Q?=22Ren=E9_van_Dorst=22?= <opensource@vdorst.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: Aw: Re:  Re: BUG: devm_regulator_get returns EPROBE_DEFER
 (5.3-rc5..next-20190822) for bpi-r2/mt7623/mt7530
Message-ID: <20190827193451.GN23391@sirena.co.uk>
References: <trinity-584a4b1c-18c9-43ae-8c1a-5057933ad905-1566501837738@3c-app-gmx-bs43>
 <20190822193015.GK23391@sirena.co.uk>
 <trinity-5d117f0d-9f34-4a2b-8a12-1cd34152c108-1566505724458@3c-app-gmx-bs43>
 <20190823100424.GL23391@sirena.co.uk>
 <trinity-2f905f45-85d8-4343-8613-31dda5f7556f-1566561616610@3c-app-gmx-bs11>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rG+KBTClKkGekJUE"
Content-Disposition: inline
In-Reply-To: <trinity-2f905f45-85d8-4343-8613-31dda5f7556f-1566561616610@3c-app-gmx-bs11>
X-Cookie: Don't SANFORIZE me!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rG+KBTClKkGekJUE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2019 at 02:00:16PM +0200, Frank Wunderlich wrote:
> > Gesendet: Freitag, 23. August 2019 um 12:04 Uhr
> > Von: "Mark Brown" <broonie@kernel.org>

> > Can you run a git bisect to try to identify the commit that
> > caused things to fail?
>=20
> i have not figured out, how to rebase linux-next on my current (working) =
codebase :) (failes on file untouched by me at Patch 3/7000+)

git rebase --onto next/master <your base> is your best bet,
though it depends how long you've left it how easy that's going
to be.

> > Look to see if there is a device driver bound to that device, or
> > check if the parent regulator is visible in /sys/class/regulators.
> > You'll also see a mesage printed out for each regulator as it
> > instantiates in the boot logs, you can check there too.

> in working version i only get this message in dmesg which
> looks like a device-binding:

> mt6323-regulator mt6323-regulator: Chip ID =3D 0x2023

You shuould see announcements of the individual regulators on the
device from the regulator subsystem.

> 		mt6323_vpa_reg: buck_vpa{
> 			regulator-name =3D "vpa";
> 			regulator-min-microvolt =3D < 500000>;

In this case it'll say something about "vpa" if it registers this
one (but if there's a parent that's having trouble then this
won't register).

> parent regulator is then
> mt6323regulator: mt6323regulator

No, a parent regulator - something providing a power supply to
vpa.  Though I can't see anything in the kernel code that'd set
one up and there's nothing in the DT...

> where can be the cause for no more binding main-regulator?

You should generally get an error message if it's the regulator
subsystem.

> are these strange messages related to this problem?

> mtk-cpufreq mtk-cpufreq: failed to initialize dvfs info for cpu0

That's a user of the regulator so it's probably just a symptom of
the regulator not loading.

> another strange line is this:

> mt6397 1000d000.pwrap:mt6323: unsupported chip: 0x0

This could well be it, if the MFD the device is on fails to load
the regulator won't either since it will only load after the MFD
does.  The MFD driver ensures that the drivers for all the
functions on the chip share the chip effectively.

> a4872e80ce7d mfd: mt6397: Extract IRQ related code from core driver
> 708cb5cc3fde mfd: mt6397: Rename macros to something more readable

> after reverting those 2 regulators are working again.
> Adding both Signed-off-People to CC to keep them informed that a fix is n=
eeded

That sounds like the issue then.

> > Please fix your mail client to word wrap within paragraphs at something
> > substantially less than 80 columns.  Doing this makes your messages much
> > easier to read and reply to.

> i currently write in webmailer, where i cannot set this setting,
> i try to add manual linebreak in long lines, ok?

Sure, thanks for trying.

--rG+KBTClKkGekJUE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1lhdoACgkQJNaLcl1U
h9ChiQf/WidpZEEUZ3U+/NSD1T1c8ZlhHguqdDz5T5GvUHrnDHMsDhsZeZokMsiM
BAG5JTig9S07exFlkrEQ1Qx6UQkKt9K3EUjtqrIP4xLyzIEHrNfeD1tCYDRBIo5T
ec04VNu3CcISh4KkTvYj53Y9RTIFenkxqhn0kkvmZcyVVW8Z2+e5laMnOLaA7nxP
feTmsEft7dnNub73WS++ZNQ6JDQuV00Xy/go5UI7Pn9WuMxBPEHU27vkjLDYiAJ1
X2MVfbai9CUPdXR5pazYXhKSr6+Q9PuN0EjJgvQ/Ep2Hm+uarHDAg5UuAYYNdS8P
3oZCwI+UeHR0bUDPzPa8Bp+BpK7gCA==
=VMor
-----END PGP SIGNATURE-----

--rG+KBTClKkGekJUE--
