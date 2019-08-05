Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE95C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 16:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E36152064A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 16:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565023050;
	bh=0/BIxc8mhBhYH3Ib+vhnqOIjrI+SrIhPShaOPUp7YI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=m3DFUu+sgrmdrXrajtIz4B4m5zxvWrDayfsm0dFJQN3fn2mI+FnsnIF2qSZ5u8MHZ
	 G4EMITiMBD3NKbIhmfgz/BIAbYjn7Q8VaPo0m7B+KR29gaIDFo5Dzdy5h12gwG0uDf
	 uE+2zMLUjtDRWlwmnxoaBt4iPHXpOyk+g/CRfVjk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbfHEQh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 12:37:28 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54818 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfHEQh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 12:37:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=N/+b7lg2LZUN9MbsueTnHaM/5HWbEaqnfqPiRMvrM28=; b=ERjnBSErYIX4gxaZ9FtiN5tN9
        nxDY5Br8V2ge/Dzj6TB0aP0EamwlhV2nUtg3YP8JrXDb2wI/7poP3LrJA+REpPZj+hZAytqVM0f8U
        dVT396bXHPLTt4QHvizsXnYL18vYrCkKuPbowk9sxzU2GiH8Ko43jMjAb/R/evwB6vpt8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hufzB-0000qh-Ax; Mon, 05 Aug 2019 16:37:25 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 50BD02742D06; Mon,  5 Aug 2019 17:37:24 +0100 (BST)
Date:   Mon, 5 Aug 2019 17:37:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Philippe Schenker <philippe.schenker@toradex.com>
Cc:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/2] Regulator: Core: Add clock-enable to
 fixed-regulator
Message-ID: <20190805163724.GK6432@sirena.org.uk>
References: <20190730173006.15823-1-dev@pschenker.ch>
 <20190730173006.15823-2-dev@pschenker.ch>
 <20190730181038.GK4264@sirena.org.uk>
 <b5e1cc3fb5838d9ea4160078402bff95903ba0da.camel@toradex.com>
 <20190731212335.GL4369@sirena.org.uk>
 <0b51a86ad6ee7e143506501937863cd8559244ec.camel@toradex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rwbb4r/vLufKlfJs"
Content-Disposition: inline
In-Reply-To: <0b51a86ad6ee7e143506501937863cd8559244ec.camel@toradex.com>
X-Cookie: Place stamp here.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rwbb4r/vLufKlfJs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 05, 2019 at 11:07:58AM +0000, Philippe Schenker wrote:
> On Wed, 2019-07-31 at 22:23 +0100, Mark Brown wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> > So it's not switching with the clock, the circuit somehow keeps the
> > switch latched?

> No, it doesn't keep it latched. To make things clear here a status table:

So the capacitor on the input of the p-FET is keeping the switch on?
When I say it's not switching with the clock I mean it's not constantly
bouncing on and off at whatever rate the clock is going at.

> > It does feel like it might be simpler to just handle this as a quirk in
> > the PHY or ethernet driver, this feels like an awful lot of work to
> > add a sleep on what's probably only going to ever be one system.

> I thought of that too, but the problem with that approach is that I
> can't reflect the actual switching behavior. What would happen is if
> you turnethernet off with 'ip link set eth0 down', the clock would
> stop and therefore no more supply voltage to the PHY. But the ethernet
> driverwould in that case let the regulator enabled preventing,
> switching off the clock.

You could include that in your quirk?

> Anyway I feel that to solve this with a quirk would be a little
> hackish, plus I'd anyway need to mess around with the Ethernet/PHY
> drivers. So why not solve it properly with a regulator that supports
> clocks?

I think you are going to end up with a hack no matter what.

> > Hopefully not a *lot* of duplication.  The GPIOs are handled in the core
> > because they're really common and used by many regulator devices, the
> > same will I hope not be true for clocks.

> I agree that they are commonly and widely used. To add support for clocks in
> regulator-core was really easy to do as I did it the same way as it is done with
> gpio's. If I don't need to touch regulator-core I don't want to. But as I said
> it was really easy for me to integrate it in there in a way without even
> understanding the whole regulator API.

> If it makes more sense to do it in a new file like clock-regulator.c and
> creating a new compatible that is what I'm trying to find out here. I'd be happy
> to write also a new clock-regulator driver for that purpose.

It would be better if it wasn't in the core, that keeps everything
partitioned off nicely.

> > I guess my question here is what the trip through the regulator API buys
> > us - it's a bit of a sledgehammer to crack a nut thing.

> In my opinion this is not only about to solve my problem with startup-delay. I
> think that this is really a behavior that can be generic. That's also why I'm
> asking here how we want to solve that so not only I solve my little problem with
> a board quirk but in a broader view for possible future usage by others.

> It is possible that a regulator needs a clock. That exactly is, what we have on
> our board and works better than expected (at least by myself :-)).

The majority of regulators that need clocks are PWM devices which is a
whole other thing that we already support.  This is a highly unusual
hardware design, we don't have the regmap stuff in the core and that's a
lot more common.

--rwbb4r/vLufKlfJs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1IW0MACgkQJNaLcl1U
h9CeHwf/eC2BmK/40EmK4CPSSL99FIGsL7s+PYPXXPMWeJrxQpeQinTh1AQZEt9D
AsBCfmbRNLbt6pPhGXaMZpavAq6byxOmkROrpWdACcs0/YlgGDbFiR138YQLN4z1
zBsBv5V3qw+rY7vZObvFVeOEk8VSDpwIrwJspmLXojxI9LeJfZ+fWsU8JlPfB4+x
CH7XF2v8VTndmWcgIRJ2XssnHJyG0FfeheaPQQVuFhTk5OelFwZf5m55XvriNx4m
bZ+SmuW5bu2nbQH+nl+rAl+/vuZstvAVQwqRkH5FnjhHF4EnOzAhRAIm1j2gOXUV
AQY/5lwQNIXD521N+wQW/JPXCxciMA==
=TUAt
-----END PGP SIGNATURE-----

--rwbb4r/vLufKlfJs--
