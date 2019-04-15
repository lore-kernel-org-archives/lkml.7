Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798FDC282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45DCF2077C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfDOMu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:50:56 -0400
Received: from sauhun.de ([88.99.104.3]:41598 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbfDOMu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:50:56 -0400
Received: from localhost (p54B331F8.dip0.t-ipconnect.de [84.179.49.248])
        by pokefinder.org (Postfix) with ESMTPSA id 949BB2C0114;
        Mon, 15 Apr 2019 14:50:53 +0200 (CEST)
Date:   Mon, 15 Apr 2019 14:50:53 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peter Rosin <peda@axentia.se>,
        Stefan Lengfeld <contact@stefanchrist.eu>,
        linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 00/12] i2c: core: introduce atomic transfers
Message-ID: <20190415125053.GB11768@kunai>
References: <20190403124019.8947-1-wsa+renesas@sang-engineering.com>
 <20190403131510.GE9224@smile.fi.intel.com>
 <20190415120611.euidifhshkf5yqns@ninjato>
 <20190415123554.GQ9224@smile.fi.intel.com>
 <20190415124829.GR9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ftEhullJWpWg/VHq"
Content-Disposition: inline
In-Reply-To: <20190415124829.GR9224@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2019 at 03:48:29PM +0300, Andy Shevchenko wrote:
> On Mon, Apr 15, 2019 at 03:35:54PM +0300, Andy Shevchenko wrote:
> > On Mon, Apr 15, 2019 at 02:06:11PM +0200, Wolfram Sang wrote:
> > > On Wed, Apr 03, 2019 at 04:15:10PM +0300, Andy Shevchenko wrote:
> > > > On Wed, Apr 03, 2019 at 02:40:07PM +0200, Wolfram Sang wrote:
> > > >=20
> > > > FWIW,
> > > >=20
> > > > Reviewed-by Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > >=20
> > > > for patches 1-5,12.
> > >=20
> > > Thanks for the review, Andy! May I ask you once more to tag the patch=
es
> > > individually so patchwork can pick them up for me?
> >=20
> > It seems I already cleaned up them from my mailbox. I can check if it's
> > available in another one.
>=20
> Done!

Thanks a ton!


--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAly0fi0ACgkQFA3kzBSg
KbbLjRAAqfHD5UY9gFoiFgkPv39u6VVy20ibtN9AUHIFRnNxRkc+YqhXWNTAVr1T
F510KWtG4S9JtrXCXf/N39bXtZZyLYfl0pFHdRc02z5cF7ChThHjX2MFYLQM72dH
hzOvo/PHEk7efsNfF54sv72od4Tf8gIHMH1qYEL1OkZqMd2F5//7oV7zfOyksTXp
sPZSj69Sq/eIuAtloMmKh4s6uJDzkj8epuXFw08Llr+oOzLXwbkrzIjGTTAUz62o
i+1EKlLwMaCZLET8/4EQ4nPfeZDxacW+u2GAgn0q+UTxHO0dPbcZtPmGGwmvlGDH
BA4Kwu16qhpfC8p88DrQ4Sr3Hee+1VbQ8ID1XhCbzSombf389iJfTMCAl7UajrAm
MKbEHQnsTENys7Z+9gQG+A+Puhy9qnLWxMYr84v+qw/EaxzEI8jL2f5sgnc8qYLV
R7ETEFNtyjKhb9lOrh34vgHfLYqNs15E5zuBJ4vKu1Q9cF7wiyDegbfFy6BmFF3s
OHejKvXHxs8M2I93K5I72LmsApm6IGqDuK3eeenxzem5YCUOqxb2HGNfZzNj2L3q
n7xbx3Dazss4rValbODKOQi2wvkgvh9vUDPyxZ3yYLkOz0NDwkntI5RSROOF5L2t
acqUdHKMtgoLeaDAiCvMwpqj7vCKYZCcmVRCXLiUTC1GAGvLGsw=
=XbuZ
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--
