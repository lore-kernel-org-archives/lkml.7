Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7F5C282DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 21:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8D25217FA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 21:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733156AbfDQVSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 17:18:35 -0400
Received: from sauhun.de ([88.99.104.3]:34540 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbfDQVSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 17:18:35 -0400
Received: from localhost (p5486CD54.dip0.t-ipconnect.de [84.134.205.84])
        by pokefinder.org (Postfix) with ESMTPSA id 570E92C088A;
        Wed, 17 Apr 2019 23:18:32 +0200 (CEST)
Date:   Wed, 17 Apr 2019 23:18:32 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jerry Hoemann <jerry.hoemann@hpe.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/16] watchdog: hpwdt: drop warning after calling
 watchdog_init_timeout
Message-ID: <20190417211831.GA16788@kunai>
References: <20190416102515.12269-1-wsa+renesas@sang-engineering.com>
 <20190416102515.12269-7-wsa+renesas@sang-engineering.com>
 <20190416203431.GA20072@anatevka>
 <20190416204814.GA26442@roeck-us.net>
 <20190416205533.GB8268@kunai>
 <20190416212046.GC26442@roeck-us.net>
 <20190416221702.GC8268@kunai>
 <20190416223813.GA744@roeck-us.net>
 <20190417194528.xwivkyubhxyfrx4m@ninjato>
 <20190417201758.GB6223@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
In-Reply-To: <20190417201758.GB6223@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > I have the following diff applied on top of patch 2. Works with and
> > without a parent device. I am not super happy casting 'identity' but
> > since its u8-type is exported to userspace, I think we can't avoid it.
> > Guenter, is this cast safe? Here is the diff:
> >=20
> I would think it is safe, but question is if it is it needed - ie do you =
see
> a warning if it isn't there ? Presumably yes; if so, let's just do it.

Yes, the compiler rightfully complains otherwise.

Do you prefer resending only patch 2 or the whole series?


--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAly3mCMACgkQFA3kzBSg
KbZ55A//a8dPznCMpbiAiMSpm25GuqnN5IonhgKfWizBJ5LDBAOzPO6WRwMxbeN4
JyNVKNI6+0VcR2FXcrzj93uz6Ref8Tk+zgar811cALZHi0mcUj3RMjVbmj2CB9d0
715VE2jJidTkoaRLPpNLSJNczG9hOZ5JRLeFLiW161+ZQc9uD8sgx/Dg/P5XJj2t
Y5vK28wkBsZnKyMIYfxM7/nX0tht3E3ujCu1me1iW9iEygQkNRI2zwFmeX/ZR2HH
cvuP0usvuXWsT3HC7HkRCM8zzLbWSqjoRM5v61NZXcp4HvNKdjvK5TvHybG1X+JJ
eBYd1tOX2OKvMasRvnmvzl8K5TwMlYVuM8ust6Toun1sJzMue4IdKORBGl7vp+i3
ALHgVJlFCRG1mLNTqNeK8M6khsDHQjCbQTMwVFweXUEYZrWn8SqilpM88e9fyyvW
1QdQBRsdRghZ9UqHPQAQcKMfbEebEjc3kUKRPUxzH0ZwHAw7powyqbu+c1DpSVyo
lPxq1eVrn9lOcpxtgO1JNvRi3ary7igMomUaVM941PpkhRWkm/bX9m2kuOdqP8wd
wtW2ra7nzj4TapZaLBt1ysHnXtOhc7imiC81ReVE/yU9294o4MnYV2HDHB7N1HYv
ufvYQblWmTXR3Ta9sq6BOOP8VropQQDy0tG61oetwdT97magc60=
=G6Gx
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
