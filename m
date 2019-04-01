Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C451C10F0B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D5F20857
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbfDAPHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 11:07:46 -0400
Received: from sauhun.de ([88.99.104.3]:52036 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbfDAPHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 11:07:45 -0400
Received: from localhost (p54B331B1.dip0.t-ipconnect.de [84.179.49.177])
        by pokefinder.org (Postfix) with ESMTPSA id ED2782C7BF4;
        Mon,  1 Apr 2019 17:07:42 +0200 (CEST)
Date:   Mon, 1 Apr 2019 17:07:42 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Steve Twiss <stwiss.opensource@diasemi.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 1/2] rtc: da9063: set range
Message-ID: <20190401150741.vwqzzngnma4jvkid@ninjato>
References: <20190321101557.26857-1-alexandre.belloni@bootlin.com>
 <20190401084143.uqbiktkt2vltgrxa@ninjato>
 <CAMuHMdW_Gz4qaRXFeW-h7vNxJ5RwjDXDP4oZZcUaYHcqEC75bA@mail.gmail.com>
 <VI1PR10MB235254A7A95F4045A5410D1EFE550@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
 <CAMuHMdVsp86n_1+c6NZpCG1MwcAzEH7rgaESHfYESb5YcLk6zw@mail.gmail.com>
 <20190401132109.GA4570@kunai>
 <CAMuHMdV79HAn8jpodQcripAViCqBh3rFGZ39oEiSiP8nC+UyTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6ocnamgrfg2a77io"
Content-Disposition: inline
In-Reply-To: <CAMuHMdV79HAn8jpodQcripAViCqBh3rFGZ39oEiSiP8nC+UyTA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6ocnamgrfg2a77io
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2019 at 03:39:43PM +0200, Geert Uytterhoeven wrote:
> Hi Wolfram,
>=20
> On Mon, Apr 1, 2019 at 3:21 PM Wolfram Sang <wsa@the-dreams.de> wrote:
> > > I was just wondering whether they work for Wolfram, who has a similar
> > > but different board than I have. Last time I tried, they didn't work =
for me.
> >
> > How did you test?
>=20
> tools/testing/selftests/rtc/rtctest.c cfr.
> https://lore.kernel.org/lkml/CAMuHMdWbV2=3DLfSWz0rFTGRakZ=3D2iXKOYdM_Uwao=
v8-OsJpUgoA@mail.gmail.com/

Hmm, with vanilla v5.1-rc3, I don't even get that far:

[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] Running 7 tests from 2 test cases.
[ RUN      ] rtc.date_read
rtctest.c:49:rtc.date_read:Current RTC date/time is 01/01/2000 04:06:40.
[       OK ] rtc.date_read
[ RUN      ] rtc.uie_read

And here it blocks forever. Any pointers?


--6ocnamgrfg2a77io
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyiKTkACgkQFA3kzBSg
KbbF7Q//d8G8g954MeZu6QHsuzKifb6VyViKHoS7bgWG4ohJWch+IQZyad1+PFgM
LPQ6NVgHXsaH77cb32O6mnedCU6qLX6S8uiUVbINEObM8Hp/0c4OrPm2tJvWYa3P
HYvJnxGNBGl2lMAIHONpKm4yq5mPVa++W4AIjANg7n8lUwLU1hF/G3r62V3NYCj8
bj/lD20CvgG3STUUig+PNgPGsfaLeirQUp1RSI9kN+AkeVGCV+Y4kicv+o1CYCaA
TWMmVAz0ptP0K+4vMt+0x4f2XnfbdVDgFsfLCWOgDXER6d4wFkVyZ5ErKdNmG9Mr
sI+eMFUU63gJnFcLj3ZZ8EEeO6+4o7XUA0CE3pGfjxPIxJG3OOYF+vcUeHp+qIQJ
m8W14TNE9lWVwxs1rxat4czfq1NEYOz929jya7U/J50WKaH6iJzyZTP9KlKl8EQS
DqNe/CJ9Mp4jAKJ5hDDAiJCluV60roj72hrfkA1XlwmZDkxgXP6HmDV1ykWvvb/i
wxp8UyO0/+3mBxqyLfYjMFrxSwse59nPcdUxfZWST628K50KumvoeWXdwXM+ZVFy
62UQPjt1pyIkvHQTns0KlS9lVZ7BLSocry5RYZ2iswmv+z20bbfwOLGn71wAjsRe
LQDCLVaajWIeIn6oztInK24WbRvd7kMGlW3b6yBvPyAd3v0DsVM=
=9wQK
-----END PGP SIGNATURE-----

--6ocnamgrfg2a77io--
