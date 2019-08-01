Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C44C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 12:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F33214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 12:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731089AbfHAM0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 08:26:04 -0400
Received: from sauhun.de ([88.99.104.3]:52348 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730299AbfHAM0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 08:26:01 -0400
Received: from localhost (p54B333D2.dip0.t-ipconnect.de [84.179.51.210])
        by pokefinder.org (Postfix) with ESMTPSA id 61D0B2C2817;
        Thu,  1 Aug 2019 14:26:00 +0200 (CEST)
Date:   Thu, 1 Aug 2019 14:25:59 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        linux-kernel@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        cocci@systeme.lip6.fr, Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [Cocci] [PATCH v5 0/3] Add error message to platform_get_irq*()
Message-ID: <20190801122559.GC1659@ninjato>
References: <20190730053845.126834-1-swboyd@chromium.org>
 <20190731142645.GA1680@kunai>
 <5d41ab2c.1c69fb81.6129.661f@mx.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oTHb8nViIGeoXxdp"
Content-Disposition: inline
In-Reply-To: <5d41ab2c.1c69fb81.6129.661f@mx.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oTHb8nViIGeoXxdp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> these drivers pop up, I think we can have another function like
> platform_get_irq_probe() or platform_get_irq_nowarn() that doesn't print
> an error message. Then we can convert the drivers that are poking around
> for interrupts to use this new function instead. It isn't the same as a
> platform_get_optional_irq() API because it returns an error when the irq
> isn't there or we fail to parse something, but at least the error
> message is gone.

True.

I still feel uneasy about pushing false positive error messages to
users. Do you think your cocci-script could be updated to modify drivers
which do not bail out when platform_get_irq() fails to use
platform_get_irq_nowarn()? I'd think this would catch most of them?

Or maybe the other way around? platform_get_irq_warn() and only convert
those which print something?


--oTHb8nViIGeoXxdp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl1C2lcACgkQFA3kzBSg
KbbdSg/9HFWL5iUwHEJsV52vt2XJENx9m8QrdHV7lZ7jTjNxOOjLR976Iv/OBTSf
M5+n+gSboLLJceumo7HdRuMmAf0+VUk/Di4vfIdhHTSqo39L5cUNvIOi64Qkt3We
mrAv8PyJUaQvxS8GUD3VaWqpPLmqFuQVPWkjBdfkJtmOuhbn0/BR6zeScXVQ6WBA
0wbiDg4ttOPZqRzmgqLmOjN8k/b5bxEirMvp6HUUK5wxXaI88Odaj8XvGAbl6IJ3
G+youdvTAoueajXSegpQNbp3q2RSt1HOaSSG+86n0WL+R4m5veK8kxvWjMNe6D1s
RlaqozlL2m+zbXAPpT3rY8OKiBxUKkaTNhUmdMOxWxsrbgWZAapeU3f9djwmlXNx
BStZhTMnnSy3JcbS6Fk9cKjgHYfDQTaNDCWkdrSC5V3To8ZytkkMVbT7LwzmcHLF
bbPPrtfKDSLeSUKufK+ICrYWfVQLgAWh9XyX+Vtm3NZ+kQvQMxk6QCV55A5wkRqk
4JHRwks9yjkpCr18m5kpgYO87/AlA7TKz3nxoYLucIXvc+56exCRBCC8dQiHbaSM
Q5A7bNLnWWa35txkCTIMlMCBQbnvqe5GH2H6CvRk21KyJqwVOfpio56V05qjYRep
YkyTYumHpai0MlMIQdHbdOLFxtMInjyeDjw/mnaqdpL0gRqzUoE=
=aWtB
-----END PGP SIGNATURE-----

--oTHb8nViIGeoXxdp--
