Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA12C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 14:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F5CC20679
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 14:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbfGaO0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 10:26:49 -0400
Received: from sauhun.de ([88.99.104.3]:41960 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbfGaO0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 10:26:48 -0400
Received: from localhost (p54B33080.dip0.t-ipconnect.de [84.179.48.128])
        by pokefinder.org (Postfix) with ESMTPSA id 6D2D32C270A;
        Wed, 31 Jul 2019 16:26:46 +0200 (CEST)
Date:   Wed, 31 Jul 2019 16:26:46 +0200
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
Message-ID: <20190731142645.GA1680@kunai>
References: <20190730053845.126834-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <20190730053845.126834-1-swboyd@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Stephen,

> There were some comments about adding an 'optional' platform_get_irq()
> API in v4. This series doesn't include that, but I can add such an API
> if it's required. I started to look into how it might work and got hung
> up on what an optional IRQ means. I suppose it means that in DT there
> isn't an 'interrupts' property in the device node, but in ACPI based
> firmware I'm not sure what that would correspond to. Furthermore, the
> return value is hard to comprehend. Do we return an error when an
> optional irq can't be found? It doesn't seem safe to return 0 because
> sometimes 0 is a valid IRQ. Do other errors in parsing the IRQ
> constitute a failure when the IRQ is optional?

Some time ago, I tried a series like yours and got stuck at this very
point. I found drivers where using an interrupt was optional and
platform_get_irq() returning a failure wasn't fatal. The drivers used
PIO then or dropped some additional functionality. Some of them were
very old.

I didn't like the idea that platform_get_irq() will spit out errors for
those drivers, yet I couldn't create a suitable cocci-script to convert
drivers to use the *_optional callback where possible. So, I neither
created the optional callback.

I still have doubts of unneeded error messages popping up. Has this been
discussed already? (Sorry, I missed the first iterations of this series)

Thanks,

   Wolfram


--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl1BpSEACgkQFA3kzBSg
KbZhaQ/9HsT5Cy7Ah1bd3cSpQWkH7rJ4UUVNRskWX+dUIxckOfNlPnvxof79Yskr
Fsp5ZrGlMCT3s49sfH5E2NF3Ubq2wVsIpSLH1u1Aoh1X4HPd4FuLzkX7slniJd9e
DSCkWJaUVoxCq7O8S4LF3fZNzvsNk3HO7nxZXxwsrzJkwRIY9OOiPrkwkOR8EsPo
mAi0TfC8kSqzHYTLoV8SwaVyOWxAGYYYHPJTCWiwAy8M5Z0fk566Jwf7fAohHDSC
v4fGYkHpm8cy6jLGMbEPk/gqTEXYh9zIqlDelmdL+nqzJ9THZEcpU/zFITPqdNSs
QaOci5P9DLUzGdXhlE3VvxJb8uHrgkDIYI2jg2wB58Nl/otzXZbwL7oNjF17D0Rl
ATA/kuEnXFYVIEXBfXET4dr7JHvGpseDpjHpFau+KtbWQ0uVpCppimw2SryFUB+c
9tymL7pdVG2t5LSMhwAYpqG7qiB5GLjtbfIbztvr9BuLnPoDmWeda7vVhI21LZXo
NeO/w7ucmTKaMEKwwT8RgYn/TTZiGrGtnzSRdjY2AYDBxeVfRSir+Tu4x+bhMJne
L/C/cv2uhhT+ZmysSI9CmBVeYTcVd55+43vmAbRftGRb7BSoEcuWY2vIL1SPsQUx
Y/6gPBKbhNxLeHK6X2LHWthbBFhBqGAFJfv8+UnnU6nyJ64Rw+Q=
=B9Za
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
