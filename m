Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07450C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3B2A2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfCNKPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 06:15:32 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60683 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbfCNKPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 06:15:31 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 9EEE780689; Thu, 14 Mar 2019 11:15:22 +0100 (CET)
Date:   Thu, 14 Mar 2019 11:15:28 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-leds@vger.kernel.org
Subject: Re: [PATCH 2/4] leds: netdev trigger: factor out middle part of
 device_name_store
Message-ID: <20190314101528.GB14455@amd>
References: <20190311144227.GA4404@amd>
 <20190313202615.22883-1-linux@rasmusvillemoes.dk>
 <20190313202615.22883-3-linux@rasmusvillemoes.dk>
 <20190314093111.7ivkdg7ozk4vylio@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
Content-Disposition: inline
In-Reply-To: <20190314093111.7ivkdg7ozk4vylio@pengutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2019-03-14 10:31:11, Uwe Kleine-K=F6nig wrote:
1;2802;0c> Hello,
>=20
> On Wed, Mar 13, 2019 at 09:26:13PM +0100, Rasmus Villemoes wrote:
> > +static void set_device(struct led_netdev_data *trigger_data,
> > +		       const char *buf, size_t size)
>=20
> "set_device" is a very generic name. Can you please prefix it with
> "ledtrig_netdev_"?

Its static.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyKKcAACgkQMOfwapXb+vKsgwCePR496MrvDo6ITledDSoc+UIQ
/TEAoJAJfmQ3qHHbDEJPvIrNPVBzvaOY
=R3p9
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--
