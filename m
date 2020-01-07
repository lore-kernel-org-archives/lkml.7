Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674F4C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 18:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4781520715
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 18:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbgAGSLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 13:11:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:41582 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728358AbgAGSLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 13:11:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 644F8AD7F;
        Tue,  7 Jan 2020 18:11:23 +0000 (UTC)
Message-ID: <65e976494676a7081b154961ba51048892c2a779.camel@suse.de>
Subject: Re: [RFC] ARM: add bcm2711_defconfig
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Stefan Wahren <wahrenst@gmx.net>, f.fainelli@gmail.com
Cc:     mbrugger@suse.com, Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, hch@lst.de,
        linux-arm-kernel@lists.infradead.org
Date:   Tue, 07 Jan 2020 19:11:21 +0100
In-Reply-To: <3688a55b-e929-6cef-66c6-affed97d938b@gmx.net>
References: <20200107172459.28444-1-nsaenzjulienne@suse.de>
         <3688a55b-e929-6cef-66c6-affed97d938b@gmx.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-vwyhc/iY3H5c6/B9T0Uh"
User-Agent: Evolution 3.34.2 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-vwyhc/iY3H5c6/B9T0Uh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-01-07 at 19:06 +0100, Stefan Wahren wrote:
> Hi Nicolas,
>=20
> Am 07.01.20 um 18:24 schrieb Nicolas Saenz Julienne:
> > The Raspberry Pi 4 depends on LPAE in order to use its PCIe port, which
> > is essential, as it ultimately provides USB2/3 connectivity. As this
> > setup doesn't fit any generic purpose configuration this adds
> > bcm2711_defconfig which is based on the current Raspberry Pi foundation
> > config file[1] with as little changes as possible
>=20
> i really dislike the Foundation config file, because it contains so many
> unnecessary features. Bisecting with such a kernel config is horrible.
>=20
> How about finding a compromise between bcm2835_defconfig and
> multi_v7_defconfig + LPAE?

If there is a consensus this is the right approach (creating a new config
file), I'll be happy to try that out.

Now that I think of it, maybe we shouldn't add bcm2711_thermal into
multi_v7_defconfig.

Regards,
Nicolas


--=-vwyhc/iY3H5c6/B9T0Uh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl4UyckACgkQlfZmHno8
x/4TWwf+N1kMZUeYu3KkZhj6rIrwQPenFhPmhuIKOmAW4imMGNHYaxKFRgG4FTf3
9023yNOuqmscpCycWPH1/lxA0SIWIZ4MI/MotvlKnQhFICjtJLRP0MmZHK0Pn0dm
4o+VZJZRwGjSYOGhCZTi3lrnDmSv5MmlmJPkSOvBwlHvDxDFdZnld0bSMAuOHi5J
+I1kCILWreHI63WalnD8UlaPWjIYVjlSJ4obi9k7k5hTa+PNJVes8CZvkIOnn1c6
+VH8H7YmbhwyMity9f2+4MSDZVPkGf83ibYaIquHaXNC9iSzC3fdKj9XBFmlXtTS
IpbYFYkRpI1bED5DeC7Rlw3h1pZkbw==
=KEm+
-----END PGP SIGNATURE-----

--=-vwyhc/iY3H5c6/B9T0Uh--

