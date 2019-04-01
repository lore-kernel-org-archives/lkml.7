Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEB3C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A983320857
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfDAV1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 17:27:12 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54493 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfDAV1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 17:27:12 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id A9152807EB; Mon,  1 Apr 2019 23:27:02 +0200 (CEST)
Date:   Mon, 1 Apr 2019 23:27:10 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     robh+dt@kernel.org, jacek.anaszewski@gmail.com, marek.behun@nic.cz,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [RFC PATCH 3/5] documention: leds: Add multicolor class
 documentation
Message-ID: <20190401212709.GA14681@amd>
References: <20190401173400.14238-1-dmurphy@ti.com>
 <20190401173400.14238-4-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
In-Reply-To: <20190401173400.14238-4-dmurphy@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> +Under the "colors" directory there are two files created "sync" and
> +"sync_enable". The sync_enable file controls whether the LED brightness
> +value is set real time or if the LED brightness value setting is deferre=
d until
> +the "sync" file is written.  If sync_enable is set then writing to each =
LED
> +"brightness" file will store the brightness value.  Once the "sync" file=
 is
> +written then each LED color defined in the node will write the brightnes=
s of
> +the LED in the device driver.
> +
> +If "sync_enable" is not set then writing the brightness value of the LED=
 to the
> +device driver is done immediately.  Writing the "sync" file has no
> affect.

I believe better solutions exists for this problem.

One was discussed before -- have single file which contains
coefficients for r/g/b channels.

Or at least... you should not really need separate sync and
sync_enable files. One should do.

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyigi0ACgkQMOfwapXb+vLJEQCglrQD1CyGUjgfMgOATusshQBp
qZoAoMAH1gMgUSg48K2AADxlgrGvPy0I
=WtxB
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
