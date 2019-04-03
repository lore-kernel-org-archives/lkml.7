Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A336C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA6920830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554262456;
	bh=Ju1wuodl2IcAuE1D45APnrzal1M8zCYsOriwhb9F40g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qT/XdOM3VB00dhPvbxu7QPoHjsOOAA7yrRxK4qST2/n687nZwzwnO5k7pu82fr7EX
	 BBGptn8ea0TkQVHPqWvWoEBDSijHDz4IvyOQ2x8MM8IfgjzrM/uWO1G/Vj80+OWH/A
	 Q200pdEZT5HORvKfvkIZ9rjgOT358YJ7E+kLAf2E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbfDCDeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 23:34:14 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38836 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfDCDeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 23:34:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ju1wuodl2IcAuE1D45APnrzal1M8zCYsOriwhb9F40g=; b=czQ7xdBY+uYZj694wLFtQArBX
        TmIWJoxJWTVsZp5PvA49s/4eLs/Uo2+ru4CTvWrnK5YWq0Mx3zyam9wSJBWATxWk0AulH1Zbyq9/d
        5L1uypSKyKrgSr6e/k/NbGoUXMHmOsQfXFkfukQWL3r+Lx1+I3wLr90Ndet2d3Xg8ryYg=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBWez-0003b5-5n; Wed, 03 Apr 2019 03:33:57 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 0C6EB440082; Wed,  3 Apr 2019 04:33:54 +0100 (BST)
Date:   Wed, 3 Apr 2019 10:33:53 +0700
From:   Mark Brown <broonie@kernel.org>
To:     Fletcher Woodruff <fletcherw@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        alsa-devel@alsa-project.org, Ross Zwisler <zwisler@google.com>
Subject: Re: [PATCH 2/2] ASoC: rt5677: make ACPI property names match _DSD
Message-ID: <20190403033353.GH2059@sirena.org.uk>
References: <20190401205519.34023-1-fletcherw@chromium.org>
 <20190401205519.34023-2-fletcherw@chromium.org>
 <20190402050637.GW2059@sirena.org.uk>
 <CAN-6NYYPL=W66vnnqbXK+LBFbuSnpqL8iv+h_x4G67PWFsMoKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HZmXSWY/1Xf1kK7R"
Content-Disposition: inline
In-Reply-To: <CAN-6NYYPL=W66vnnqbXK+LBFbuSnpqL8iv+h_x4G67PWFsMoKA@mail.gmail.com>
X-Cookie: Use extra care when cleaning on stairs.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HZmXSWY/1Xf1kK7R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 02, 2019 at 09:52:56AM -0600, Fletcher Woodruff wrote:
> On Mon, Apr 1, 2019 at 11:06 PM Mark Brown <broonie@kernel.org> wrote:

> > It'd be fine to add your new DT style properties but this
> > might break existing systems.

> That said, I agree it would be safer to use the idiomatic ACPI names, and then
> fall back to the DT style names if the idiomatic names fail. Does that sound
> reasonable?

Yes.

--HZmXSWY/1Xf1kK7R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlykKaEACgkQJNaLcl1U
h9CBCQf+NRB3vvcQqq83OqlGvqNPTlklbaDb7Dxl/u7aRVTEtnk/CUYK919RICan
9lbW88q6uibWZ53742jjEvR78GOWm50ZLu1ht5lqrvCYa3E3ZPggpMaf5f+rk+DV
RcYUAHwDfinabYcuR8hfJ/ITngB9Xop9zl1VVXSovHlLIRnXoPGpUagKCtFamkSV
NpvXVkJ3NTyLLPOYH/aCVOC+/ZxuOPrKBD/NQe3wv3n2mZSFo6/o3sWp27tNsU9E
5MKTtD6JNs6tRVt5IvFPOR3XSztzRaDElhJSqRJgpXurrfzpsyIV4Uh6/FWLZIJe
q7AMrRMdi0i0xdQZb/hEwZ2XvrhhKQ==
=m8Q1
-----END PGP SIGNATURE-----

--HZmXSWY/1Xf1kK7R--
