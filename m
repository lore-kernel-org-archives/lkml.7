Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F211C4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4353220820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569264556;
	bh=M/L9wCP5h3ultSZnGK9CCiZn9DZ/ezkmvfuB4NK9VzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0HTcyMadhugqTXT5fMTpYDWv/78p5kYT1riMujwIGcYSfDFEZeMWgIk/gDAjjRE0o
	 iiufT37NtKlE5nyg3SzGlbidoTIz3deRACkuCCM0SEy2hb6sMqjLtZVTU5MrCJFv++
	 u/lEUXenRoyv1cJshkgmx2qyesbWLLr44IxIZj7Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733137AbfIWStP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 14:49:15 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58452 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfIWStO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 14:49:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EupMjxcDDxYMZCqO2iFI6bmVxPF+mEoAtji705sGeoM=; b=EmbmpEoL3Xmeaocc9MdnIip3Y
        HmmRxYS9VQT2JOSIMT+o488blJyrpX7cl3vp6zuBO3KqG4H6hV0jH7pAQ2dsVVl+w3reUN2AVAoW9
        HHvAaJBrBef2/smHsezqgrMC9UhAZY55sz7nXzC7TDidgACXEOqqHu8y0uI/IP01Zg2Co=;
Received: from [12.157.10.114] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1iCTOX-0004e4-13; Mon, 23 Sep 2019 18:49:09 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 56DA9D02D0B; Mon, 23 Sep 2019 19:49:07 +0100 (BST)
Date:   Mon, 23 Sep 2019 11:49:07 -0700
From:   Mark Brown <broonie@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Marco Felsch <m.felsch@pengutronix.de>, zhang.chunyan@linaro.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        ckeepax@opensource.cirrus.com, LKML <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Subject: Re: [PATCH 1/3] regulator: core: fix boot-on regulators use_count
 usage
Message-ID: <20190923184907.GY2036@sirena.org.uk>
References: <20190917154021.14693-1-m.felsch@pengutronix.de>
 <20190917154021.14693-2-m.felsch@pengutronix.de>
 <CAD=FV=W7M8mwQqnPyU9vsK5VAdqqJdQdyxcoe9FRRGTY8zjnFw@mail.gmail.com>
 <20190923181431.GU2036@sirena.org.uk>
 <CAD=FV=WVGj8xzKFFxsjpeuqtVzSvv22cHmWBRJtTbH00eC=E9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p19/OaUkOQckSefz"
Content-Disposition: inline
In-Reply-To: <CAD=FV=WVGj8xzKFFxsjpeuqtVzSvv22cHmWBRJtTbH00eC=E9w@mail.gmail.com>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p19/OaUkOQckSefz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 23, 2019 at 11:36:11AM -0700, Doug Anderson wrote:
> On Mon, Sep 23, 2019 at 11:14 AM Mark Brown <broonie@kernel.org> wrote:

> > Boot on means that it's powered on when the kernel starts, it's
> > for regulators that we can't read back the status of.

> 1. Would it be valid to say that it's always incorrect to set this
> property if there is a way to read the status back from the regulator?

As originally intended, yes.  I'm now not 100% sure that it won't
break any existing systems though :/

> 2. Would this be a valid description of how the property is expected to behave
> a) At early boot this regulator will be turned on if it wasn't already on.
> b) If no clients are found for this regulator after everything has
> loaded, this regulator will be automatically disabled.

> If so then I don't _think_ #2b is happening, but I haven't confirmed.

> > boot-on just refers to the status at boot, we can still turn
> > those regulators off later on if we want to.

> How, exactly?  As of my commit 5451781dadf8 ("regulator: core: Only
> count load for enabled consumers") if you do:

>   r = regulator_get(...)
>   regulator_disable(r)

> ...then you'll get "Underflow of regulator enable count".  In other
> words, if a given regulator client disables more times than it enables
> then you will get an error.  Since there is no client that did the
> initial "boot" enable then there's no way to do the disable unless it
> happens automatically (as per 2b above).

It should be possible to do a regulator_disable() though I'm not
sure anyone actually uses that.  The pattern for a regular
consumer should be the normal enable/disable pair to handle
shared usage, only an exclusive consumer should be able to use
just a straight disable.

> ...or do you mean that people could call regulator_force_disable()?
> Couldn't they also do that with an always-on regulator?

No, nothing should use that in a non-emergency situation.

--p19/OaUkOQckSefz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2JE6IACgkQJNaLcl1U
h9D1yAf+J7IlRKZcRaDe46unExgr97b1dbhBAvQGi0SxLxQ4EwdRl6wd3cN02SEY
j2G6C92Szw0KTwKMtWhTaxTDtF9Cw/nWPpl/gGyrJPXkTV2FnuFdrx3AfpYyRJzL
VZ76RHjVsIFkVak8ZS2NwiFVGGyd87P9mpav/adObdxfmXpZbELhMuZTZ3G8GLbs
X9ApzhsR66b1QcSH5V+yfIoEza1QOmAdvxzrNyS0unW9OjArdPrOE9YUFRDhGwAP
t4RrGlAua/21M3uuY36vvloQ48FAy2Pr8rqLFyFKRDdYnaUP8Xm1oV7twUPe6SFd
wnbJIIGFCJOTJ9MC3nNUjd2inNpZiw==
=rhg2
-----END PGP SIGNATURE-----

--p19/OaUkOQckSefz--
