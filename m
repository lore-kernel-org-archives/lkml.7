Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EC3C4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5814020856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569262479;
	bh=9JnE4fmdEWiKSwublyyIWd6j/KzXUP9nRmeoN6pKKxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OnsGVg9+u8DeWfmBaiScSA3w+kcrehND+ls/EsKKePnGYdSBklQPA1G1cue7XnSDp
	 VCEjOrzr7MK6F0pHb6xr1aUwilB50tz/KUoykrQ70McA2MIGwe+RMuGdEYgUJpg7Am
	 +VNUNBIjfZPW4xvFLb1Cgrc4pWOot/QORo+Kbxao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440360AbfIWSOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 14:14:38 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56794 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437960AbfIWSOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 14:14:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HCO9H13hsLGlf0IU4gFCSB/WykjOxYi/O/UOB7GTiPU=; b=qUf6Le+pnZyKScoYdTpB1aoFq
        AyeXuA1UmnNF+LErbecWhBfua3o2ufC5IHbKBRgWrqZzeY3npKa2bANyDYCf2DETARTLeZGOEBUwu
        hiA6aH6pI1Td2GVPv1GTasB9Nvy46v1Wg5nUH4MxtSnfXLOYAVTdzrumkjwJYlxL4qxpU=;
Received: from [12.157.10.114] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1iCSr3-0004To-Ht; Mon, 23 Sep 2019 18:14:33 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id BB79CD01FE8; Mon, 23 Sep 2019 19:14:31 +0100 (BST)
Date:   Mon, 23 Sep 2019 11:14:31 -0700
From:   Mark Brown <broonie@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Marco Felsch <m.felsch@pengutronix.de>, zhang.chunyan@linaro.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        ckeepax@opensource.cirrus.com, LKML <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Subject: Re: [PATCH 1/3] regulator: core: fix boot-on regulators use_count
 usage
Message-ID: <20190923181431.GU2036@sirena.org.uk>
References: <20190917154021.14693-1-m.felsch@pengutronix.de>
 <20190917154021.14693-2-m.felsch@pengutronix.de>
 <CAD=FV=W7M8mwQqnPyU9vsK5VAdqqJdQdyxcoe9FRRGTY8zjnFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J19t2I20ndwispKK"
Content-Disposition: inline
In-Reply-To: <CAD=FV=W7M8mwQqnPyU9vsK5VAdqqJdQdyxcoe9FRRGTY8zjnFw@mail.gmail.com>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J19t2I20ndwispKK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 23, 2019 at 11:02:26AM -0700, Doug Anderson wrote:

> I will freely admit my ignorance here, but I've always been slightly
> confused by the "always-on" vs. "boot-on" distinction...

> The bindings say:

>   regulator-always-on:
>     description: boolean, regulator should never be disabled

>   regulator-boot-on:
>     description: bootloader/firmware enabled regulator

> For 'boot-on' that's a bit ambiguous about what it means.  The
> constraints have a bit more details:

Boot on means that it's powered on when the kernel starts, it's
for regulators that we can't read back the status of.

> ...but then that begs the question of why we have two attributes?
> Maybe this has already been discussed before and someone can point me
> to a previous discussion?  We should probably make it more clear in
> the bindings and/or the constraints.

boot-on just refers to the status at boot, we can still turn
those regulators off later on if we want to.

--J19t2I20ndwispKK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2JC4YACgkQJNaLcl1U
h9Cw9Qf/ZIeAGiJh/nkJJEspZ/933nlFfSOVQp075WtLBEPxwZcMwK+l3ub1FKtA
Fgi6KR3Ig/Sh5MSIJKJsqbhtv7bhOuYwPtsFrDoBdfMU6hCfHLrZBb0WxFJMzGfh
Ta9yCbXOiviw0GaVDSmK7io7Uwle+lxkr3pIU37BfVlyL8HmZ6OlbNJW95SvYFwo
gIhUdadCTDHOagRMqlA/iDYl1pBX0XexRGT6qcRobrzhYmIJnvRHNnjm1W3V0k6M
6OJvmtnTUE/s2DnQaNM7MOnuvhHfI39qEAVB9/UefwBLVigLgAvqH4QKj7fk960W
hvwhs8dPtTgi8o1O9WFNRXQh4uYL+w==
=aqxZ
-----END PGP SIGNATURE-----

--J19t2I20ndwispKK--
