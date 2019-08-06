Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D2DC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 18:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 485AC20C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 18:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565115972;
	bh=sbO0nE9384gcc6xD06AuymJFXg8osSzO1359K+pMu6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OSWgKeq1k1bOmZMCmlExI/079onecUtZvWPMINoN5ox6iiOH8yvY9XnQ/mPAaB0Wo
	 UahnBFBpV5nPMqP6XAdXtor6gQtXB5NEl3hMapE+NGya70d6N3zHpbC9fH0os7y2km
	 LO+SROKUwGSzU5L6dPU0QaRKPvbLTlhYC2qCXGEk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730268AbfHFS0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 14:26:10 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59682 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbfHFS0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 14:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YUYFEtxyIM/Z4kpTSGmIasxeWQN/9EH3EiO8E1CRrbI=; b=Mn0IAWzIMSeGH0FpNL7tk00YF
        LUiDaewEUoR5a/f/3fttxLo0qS19rskp6U4ihi5FzI6WhPpdE4mMh/7byENDhjHjnoh792Qr+XRRw
        J+PaYpbwnmvSV8wTGMja8PxNGYPvYpL0MefhZD549z4Ny9qM9HXkUJ3QLerY4MHCcuyPw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hv49v-0005PN-3j; Tue, 06 Aug 2019 18:26:07 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 3738C2742BDD; Tue,  6 Aug 2019 19:26:06 +0100 (BST)
Date:   Tue, 6 Aug 2019 19:26:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Philippe Schenker <philippe.schenker@toradex.com>
Cc:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/2] Regulator: Core: Add clock-enable to
 fixed-regulator
Message-ID: <20190806182606.GG4527@sirena.org.uk>
References: <20190730173006.15823-1-dev@pschenker.ch>
 <20190730173006.15823-2-dev@pschenker.ch>
 <20190730181038.GK4264@sirena.org.uk>
 <b5e1cc3fb5838d9ea4160078402bff95903ba0da.camel@toradex.com>
 <20190731212335.GL4369@sirena.org.uk>
 <0b51a86ad6ee7e143506501937863cd8559244ec.camel@toradex.com>
 <20190805163724.GK6432@sirena.org.uk>
 <af076ff7e1df4c07ab659ff83efa0c85d5e5e3d6.camel@toradex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="L1c6L/cjZjI9d0Eq"
Content-Disposition: inline
In-Reply-To: <af076ff7e1df4c07ab659ff83efa0c85d5e5e3d6.camel@toradex.com>
X-Cookie: All men have the right to wait in line.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--L1c6L/cjZjI9d0Eq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 06, 2019 at 12:57:32PM +0000, Philippe Schenker wrote:
> On Mon, 2019-08-05 at 17:37 +0100, Mark Brown wrote:

> > So the capacitor on the input of the p-FET is keeping the switch on?
> > When I say it's not switching with the clock I mean it's not constantly
> > bouncing on and off at whatever rate the clock is going at.

> Ah, that's what you mean. Yes, the capacitor gets slowly charged with
> the
> resistor but nearly instantly discharged with the n-FET. So this
> capacitor
> is used as a Low-Pass filter to get the p-FET to be constantly switched.

> It is not bouncing on and off with the clock but rather it is switched
> constantly.

Good, I guess this might be part of why it's got this poor ramp time.

> > I think you are going to end up with a hack no matter what.

> That's exactly what I'm trying to prevent. To introduce a fixed
> regulator that can have a clock is not a hack for me.
> That the hardware solution is a hack is debatable yes, but why should I
> not try to solve it properly in software?

A lot of this discussion is around the definition of terms like "hack"
and "proper".

> In the end I just want to represent our hardware in software. Would you
> agree to create a new clock-regulator.c driver?
> Or would it make more sense to extend fixed.c to support clocks-enable
> without touching core?

At least a separate compatible makes sense, I'd have to see the code to
be clear if a completely separate driver makes sense but it'll need
separate ops at least.  There'd definitely be a lot of overlap though so
it's worth looking at.

--L1c6L/cjZjI9d0Eq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1Jxj0ACgkQJNaLcl1U
h9BYwwf+PficToNtWBf/QerO7Vq5QspxtqyqtatS4M9ZlcsHPhJ8+bBwc9Eda+T+
XjcL09fZdVsweddmRgAvyoNKvPjbv/BMz0jmKmUQKipXDhTWS6IgNhWXfCrpizPl
4wLbPCimTJVGfkUboyM5ka8OuH/xo/my92iUIQURdjpTXEEGIhCzq3ezDVIHwtL0
NoUpjJhkMkbvOEsjO3O62npmGFppMO/nSj/G5BGroNU3DlW2xeabNoG+QrIjN3dm
9TByVcL3GJ+CyKVJRmFlwbFd3KB4C5TsAhEL4Nr65jD0mA349Ss58XSVn3jZ+9RR
ZeAaATekeVK8kvtNpEbLeuja0kXbfA==
=S33F
-----END PGP SIGNATURE-----

--L1c6L/cjZjI9d0Eq--
