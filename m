Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BCDCA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 22:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B1620862
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 22:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbfJaWMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 18:12:16 -0400
Received: from sauhun.de ([88.99.104.3]:37458 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726602AbfJaWMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 18:12:16 -0400
Received: from localhost (unknown [77.130.135.221])
        by pokefinder.org (Postfix) with ESMTPSA id 6726A2C009F;
        Thu, 31 Oct 2019 23:12:13 +0100 (CET)
Date:   Thu, 31 Oct 2019 23:12:11 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Chuhong Yuan <hslester96@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mmc: renesas_sdhi: add checks for pinctrl_lookup_state
Message-ID: <20191031221211.GA3853@kunai>
References: <20191018131338.11713-1-hslester96@gmail.com>
 <CAPDyKFoBYchP96hv=7XfTo8CrCSD+KC0h_oFRAsOYT-Lc1SFZQ@mail.gmail.com>
 <20191023153313.GB5153@kunai>
 <CAPDyKFo9wYwhdy-1BDcRMJKTjADappsT-gBaKZE7hTLE4obxiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <CAPDyKFo9wYwhdy-1BDcRMJKTjADappsT-gBaKZE7hTLE4obxiA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

HI Ulf,

> > Well, I don't like to bail out because this error is not fatal for basic
> > operations. How about releasing priv->pinctrl again with an additional
> > warning that pinctrl settings are broken and will prevent 1.8v modes?
> >
> > Opinions?
>=20
> Hmm, from a mmc driver probe point of view, I don't quite share this appr=
oach.
>=20
> I would rather fail as it forces the DTB to be corrected immediately,
> rather than trusting some developer to look at a warning in a log. The
> point is, in such a case it may never get fixed, if the product is
> shipped with the wrong DTB.

I could agree to this arguement, iff the only way pinctrl_select fails
is a DT misconfiguration. I am not sure if this is true right now, and
we can't be sure about the future. Or?

> My concern at this point is rather to break existing DTBs, but it
> seems that should not be an issue, right?

AFAIK not for the upstream ones, I don't know the customer ones.

I still prefer to not bail out.

Kind regards,

   Wolfram


--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl27XDcACgkQFA3kzBSg
KbYYBRAAiikrBSwiMJ26xkXJxt4soVNJykMZrHS9niXYlb+cM9mznO9ah9yPKjFL
Op6LtWP5EKJPU7Yz1FM+wjKKyLgC/nvLKw3gvbXXDI1GhZAa4yl0e9diIBzECp8g
5EMTYmB5i9u5Z1MBkNQB8/UuQ7JlVNtGuWI3YcbcG0reM6i20BaynpDthwVKa9vv
2h+5OWf8Ep76B5CEOmqF/TePJeTwR/Dzzzf9PxJOqu/v3MW8Pwc9WF7UwWSmxLel
yBHr4bHOxYg4WEta99YirlXYadlxdv9cZ3+lcx+6kwaWd0kgv+xF5sxsxJFz2G/Y
d8c1zYso/Js37VFI/E0lxCDnVBbZaiDDpSkkS2E+ZmBFZeHigFhRvRenkPKnjxCu
S38I9e3M4pE//z7UirjR/uHv6VDopd1nEOmx4Md6eo0Yj5QhrlPOromAIVenpECO
S2/L5NWy+sNZ4APAUeesKqRy0yQVqEEg3U01AC6PQpqfIHrjKXXHObsTwtt24ct3
Vy51uTTB0BWZGY3cO+YuHJiJTCS5aC1k63FA7XCINArVhZh3ZTqGQZH3MoGy9dvj
L168HXbOVK5HkDh/xZx9b1S0dkdPvciYYHiJ3GU2b63ICOczGPsF0vIwJdbgzN7i
66m5ckYQdR1zDZVQAdWSoAMGAUYScPDMm3sU6/MTTu7I9D2H4ks=
=XBqM
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
