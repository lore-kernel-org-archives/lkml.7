Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DCCC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 23:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E38320863
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 23:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfCBXH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 18:07:28 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:37599 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfCBXH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 18:07:28 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 32E3080595; Sun,  3 Mar 2019 00:07:19 +0100 (CET)
Date:   Sun, 3 Mar 2019 00:07:25 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        lee.jones@linaro.org, tony@atomide.com
Subject: Re: [PATCH v4 2/7] dt-bindings: ti-lmu: Modify dt bindings for the
 LM3697
Message-ID: <20190302230725.GA9225@amd>
References: <20181023170623.31820-1-dmurphy@ti.com>
 <20181023170623.31820-2-dmurphy@ti.com>
 <20181024090421.GB24997@amd>
 <e8800c2e-8ada-7a0d-c1a6-14ddcbe1576d@ti.com>
 <20181024145434.GC9327@bogus>
 <beb1a6e1-8120-be94-b1a4-60ea6721765d@ti.com>
 <ade3121a-58ab-c0c3-6605-cf7d6a638da0@gmail.com>
 <20181026083703.GB19434@amd>
 <bdb73aa2-60d9-3356-f934-091f738e20a0@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <bdb73aa2-60d9-3356-f934-091f738e20a0@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I just want to follow up here and let you know that I have not abandoned =
this.
> I am trying to rework and fix up the ti lmu binding as asked by Pavel.  I=
ts proving
> to be a bit of a challenge based on looking forward to what will be the i=
mplementation.
>=20
> I also did go offline and speak with Tony.  I have a Droid 4 so I can tes=
t all of this on
> production hardware as well.
>=20
> Updated patchset will take some time to get out.

Is there any progress here?

This is needed for display on Droid 4, so it is somehow
important... and Milo Kim's patches are pretty reasonable.

I still believe best way forward is to merge them, and let you submit
any improvements on top of them...

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlx7DK0ACgkQMOfwapXb+vI9cQCgrs2Ly5FO3fgyUXGv8g9QY/Zl
F5oAoI8W7cLHWqeJEOhlQxg8yViH1z7Z
=l6rC
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
