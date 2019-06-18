Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2953C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C070621479
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560883673;
	bh=fS53sAvfrvYkIRVRA1b2mWm15QF9/fZkNXNJFG6eZ8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vbtMsKGWOs5zD/2EM4Iw0g130icN0e0guLsNIOmP5CLxbl2zJaX5leH/Zs9eYl3GZ
	 5BisBv2lIJaaPPau260bL5HcQxI28F0kWf00CefL84R1hGDJ3FRPNqqH8K0tsBACHv
	 lzaM8u781USeG+RoWaYIcx/DRtpEH6X3noPpKn+U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730239AbfFRSrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 14:47:51 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43626 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730147AbfFRSrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 14:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2GybvW+pvKzG30g9GQw9L9iwbdt1DhKvlt4DtJh360k=; b=b7Qz7KSSZmxUpMZGWWHLF/qPy
        Uh/Abr8TZ673wGtXFfudJl1y/K7E4W8HXP/+s41ygKirEKIhzJT5eAxS18YynY2vFz/Uj0FOUatgK
        s0dc6mT6tLv4CFDqS2GkyCX3hksbgV+QqUQhyc+JsXZJQoyBSUh8h0C3cdsdFF66iTNyg=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hdJ8R-0005Ms-30; Tue, 18 Jun 2019 18:47:11 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 61995440046; Tue, 18 Jun 2019 19:47:10 +0100 (BST)
Date:   Tue, 18 Jun 2019 19:47:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Curtis Malainey <cujomalainey@google.com>
Cc:     Fletcher Woodruff <fletcherw@chromium.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Ross Zwisler <zwisler@chromium.org>,
        ALSA development <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v7 3/4] ASoC: rt5677: clear interrupts by polarity flip
Message-ID: <20190618184710.GP5316@sirena.org.uk>
References: <20190614194854.208436-1-fletcherw@chromium.org>
 <20190614194854.208436-4-fletcherw@chromium.org>
 <4e560e12-4c20-8d5d-b3f9-587a55da279d@intel.com>
 <CAN-6NYZzMqwDaw2oDyms4P9uKFPJvuQOtGbqMWLtFV3kDyQHJQ@mail.gmail.com>
 <CAOReqxhETC9xAojXyDWLMOJ3W22Zn4GNGry44=XC=t_k7SCHqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BQstn4t8nd6twlV3"
Content-Disposition: inline
In-Reply-To: <CAOReqxhETC9xAojXyDWLMOJ3W22Zn4GNGry44=XC=t_k7SCHqA@mail.gmail.com>
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BQstn4t8nd6twlV3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 18, 2019 at 11:12:58AM -0700, Curtis Malainey wrote:
> On Tue, Jun 18, 2019 at 11:01 AM Fletcher Woodruff
> > On Sun, Jun 16, 2019 at 10:56 AM Cezary Rojewski
> > > On 2019-06-14 21:48, Fletcher Woodruff wrote:

> > > > +     ret = regmap_read(rt5677->regmap, RT5677_IRQ_CTRL1, &reg_irq);
> > > > +     if (ret) {
> > > > +             pr_err("rt5677: failed reading IRQ status: %d\n", ret);

> > > The entire rt5677 makes use of dev_XXX with the exception of.. this very
> > > function. Consider reusing "component" field which is already part of
> > > struct rt5677_priv and removing pr_XXX.

> > I was using dev_XXX, but I believe Curtis found that 'component' was
> > sometimes uninitialized when this function was called, so I switched
> > back to pr_XXX. I may be misremembering though, so I'll let Curtis
> > comment as well.

> The issue here is that the IRQ is setup in the i2c probe and the
> component is setup in the codec probe. In theory if the hardware is in

The component is not needed for a struct device, you must have a struct
device if you have a regmap or have probed at all.

--BQstn4t8nd6twlV3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0JMa0ACgkQJNaLcl1U
h9DZcQf/ccl646Fq6MOoLNN1gJ8spcWeyqqS0N9BX8AF0sxJxnubO0NtjYtWNrqS
yRwufehgJtFHiEubQEyDR75hAO69qzV/vdYOMyohwCo2wcS8c/l3pZqKomHdRsBb
UJQbxFdW1M1nlgfOWza83Ko9dT7cV/DnXQZquAKmwbLYaAp0BrBEoDIcjIuD7GdN
pKnmw6/oAcpcVahvg/uVSriAcRjjvaykpzXnmDB78vqJ5yRs0thrTlBtkvlE3b4B
lkymwUB3X1rSbrIMP2+8RC9vEsS96D0uyp4uL4IHFPqeOGxcdOd7k6dV/qbj8OH2
LRRkK3adUQg1tGf/ksckR/q/1Em4Rw==
=AmR9
-----END PGP SIGNATURE-----

--BQstn4t8nd6twlV3--
