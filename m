Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97306C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9E32070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570536378;
	bh=Tp7W2qNt3xmj2uz/0unJgy9NljpDnUvi+6KS4MOzt5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R1OqX0TKoY6xEGVOMCXbYe93Ni9NhWgwedtss2qyI6PBpPiDea4ZxXjzprJnFhDhu
	 iMkQGg7YFD90QfrqM7zqywekhPrCwZ6XPWdVBD7S0YePOUgu4ClfJHqKa9LkEzuDbW
	 mr4LNilpu6KY//pdP7qP08awJsv9ABGbipRIP6mA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730955AbfJHMGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 08:06:18 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58158 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730249AbfJHMGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:06:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iNXCq0tdrGr+v7qLVsnpGqjHYmCeZ78z3PFZJHaeMP8=; b=WL1P9kiXgzGcYtmdIzPPUSwi2
        e078UMBv6u0H4uP1gcANf0zyzq0lvQhR51bV3+nh60NbKPhmoAecyshaBuTQX3uYm+BE+q8IsHMQn
        7D4Eb/yl0AzxicYvZRRBfuLR73k7qSPLzHG5B5F8ryNieZ0cskUt0siySP076tEecLF2I=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iHoFo-0008EX-8U; Tue, 08 Oct 2019 12:06:12 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 6F8752742998; Tue,  8 Oct 2019 13:06:11 +0100 (BST)
Date:   Tue, 8 Oct 2019 13:06:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH] regulator: core: Skip balancing of the enabled
 regulators in regulator_enable()
Message-ID: <20191008120611.GG4382@sirena.co.uk>
References: <CGME20191008101720eucas1p2e0d1bca6e696848bf689067e05620679@eucas1p2.samsung.com>
 <20191008101709.13827-1-m.szyprowski@samsung.com>
 <20191008115025.GF4382@sirena.co.uk>
 <0e222fdd-4407-51ea-b75c-a62621cbe622@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+1TulI7fc0PCHNy3"
Content-Disposition: inline
In-Reply-To: <0e222fdd-4407-51ea-b75c-a62621cbe622@samsung.com>
X-Cookie: Do not disturb.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+1TulI7fc0PCHNy3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 08, 2019 at 02:01:15PM +0200, Marek Szyprowski wrote:
> On 08.10.2019 13:50, Mark Brown wrote:

> > This then means that for users that might legitimately enable and
> > disable regulators that need to be constrained are forced to change the
> > voltage when they enable the regualtors in order to have their
> > constraints take effect which seems bad.  I'd rather change the the
> > cpufreq consumers to either not do the enable (since there really should
> > be an always-on constraint this should be redundant, we might need to
> > fix the core to take account of their settings though I think we lost
> > that) or to set the voltage to whatever they need prior to doing their
> > first enable, that seems more robust.

> Well, I'm open for other ways of fixing this issue. Calling enable on=20
> always-on regulator imho should not change its rate...

Yes, although there is the whole "don't touch things until a consumer
tells us to" thing going on.  I had expected that this was kicking in
because we weren't paying attention to the constraints of disabled
regulators but I can't see the code implementing that any more so I
guess we removed it at some point (it was always debatable).

--+1TulI7fc0PCHNy3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2ce7IACgkQJNaLcl1U
h9AGmwf/UbimQ9sq/zEYWdR5N0U5nYyw0n1illJslo92MzhrHjeXkA+J75dNT9wo
E1wtoPEndtrRtb0F+650lzfqvceJauFIaDwb2WvG3vxutwoSdFCJ9qjoPoXLFZOx
T0gTrPtDX9HHTgMoFackql9B0xwjwHg+cEV6bcAfw3B4F6LnwYIZB27i4Rbf+DXt
oxB70sgrULzP0QJAtJLMN3QZtNOg94vNdA8xH83V/FeXdtZiE1VLlJVSQ0hjAjc2
GJ+zjjSFfC5qRLw+DpKpF6CbBO9NwkcBEhFt5CVNiQlQCwL/tuXHBBGUAXvlk/GN
zDivlP9XJXhyJRNSbxzDX7C4rEqn3w==
=Qc9y
-----END PGP SIGNATURE-----

--+1TulI7fc0PCHNy3--
