Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8906FC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 611892075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729759AbfDBJBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:01:09 -0400
Received: from sauhun.de ([88.99.104.3]:38166 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726337AbfDBJBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 05:01:08 -0400
Received: from localhost (p5486CD10.dip0.t-ipconnect.de [84.134.205.16])
        by pokefinder.org (Postfix) with ESMTPSA id B43AC2CF606;
        Tue,  2 Apr 2019 11:01:05 +0200 (CEST)
Date:   Tue, 2 Apr 2019 11:01:05 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc:     Ray Jui <ray.jui@broadcom.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Shreesha Rajashekar <shreesha.rajashekar@broadcom.com>,
        Michael Cheng <ccheng@broadcom.com>
Subject: Re: [PATCH v5 2/8] i2c: iproc: Add slave mode support
Message-ID: <20190402090105.GA2960@kunai>
References: <20190214175725.60462-1-ray.jui@broadcom.com>
 <20190214175725.60462-3-ray.jui@broadcom.com>
 <20190327221452.GA15396@kunai>
 <c67178db-9459-b424-a29a-23bb0e0c5ca9@broadcom.com>
 <CAHO=5PG=wsYZqa0+BVbvSKgWg9NgDOrDc8J2DoXn4BRRWmDvRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <CAHO=5PG=wsYZqa0+BVbvSKgWg9NgDOrDc8J2DoXn4BRRWmDvRg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > >> +    /* RANDOM SLAVE STRETCH time - 20ms*/
> > >
> > > What is a "random stretch time"? 20ms sounds like a lot. Also, missing
> > > space before comment terminator.
> > >
> >
> > Rayagonda,
> >
> > Could you please help to comment on the choice of the 20 ms to allow
> > clock stretch from the slave? In probably all cases, the slave should
> > not need more than 1 ms? 20 ms does seem way too long as Wolfram pointed
> > out.
>=20
> In fact we are programming max slave stretch time  ie 25ms, comment
> should be correcting.
> Its maximum time for slave to complete read/write operation, if slave
> is done with read/write then clock will not be stretched further, it
> will be released immediately.

Ah, now I see. This is a protection against the slave stretching the
clock forever. This makes sense.

> Hence I feel no harm in programming max timeout value.

I agree. "Random stretch" is just a bit confusing as a name. "Maximum"
would have been more clear IMO.


--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyjJM0ACgkQFA3kzBSg
KbYwnRAAhyvKGZin7EPbNl42uih8M22BfSs+//ZzA92ckfe99z34MztaQzSbXRym
wKO3ncesoIPM81IrYkwTY4lNTCRCLMxsmXMJbd518lumNp/4ZUp9sNSmoD8Z/61R
e6YWJ7kysBz/iNjcbw8igaJLTvrZfV9IeSxuNdxQXCq9k9Whaa1yealO9CVVJiNU
TpA16pFWbI7it7SuGwY2EEO/3asBqYj0CjjUthtS8kwqZ67MTVVzoK2cxstaoXec
1T9dhvRX++vIDpBoFlTRQH2ZGpSEQJmKosvNuagNIiKs/6Rcw+AbNLUYx9Z1qRwt
FxYADEeszSLtFM1QoqTcwwERDap32YnZzhnnC61fpI+SIIKV6twClJWeZ/gPrU5u
0bxeAN8GwJ5OzxTAnoKNECwSUf0CsN2jnjbMv+1kXKmXJgYEhxQotgdxL2ywXeJ1
RL9SI2xApC47SAX6qJX/Z4ZtxT2aF1hdG7doy3rUu82e2VX9FcVyl/Qn1XQdgE6G
h9JR5mqtOA5K9e3bDcKFQgeSFFCM+gKWd4LBfkEpsLR6EIzglwqcAtWYgbfp7kuD
PSiacbJCZDTcbHMezQt2GI683MaDcIhwIYSPzgqv8KlHK9TXXHqm/+l3D1+RTrCz
+aBK7knHXHplb37AOPZKSbjqCe9ksOJoIFIgAwaJu8rmZUs09X8=
=MmnH
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
