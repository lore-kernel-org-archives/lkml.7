Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F2EC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C498520675
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfDOJ24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 05:28:56 -0400
Received: from sauhun.de ([88.99.104.3]:40066 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfDOJ2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 05:28:55 -0400
Received: from localhost (p54B331F8.dip0.t-ipconnect.de [84.179.49.248])
        by pokefinder.org (Postfix) with ESMTPSA id C05822C0114;
        Mon, 15 Apr 2019 11:28:53 +0200 (CEST)
Date:   Mon, 15 Apr 2019 11:28:53 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Steve Twiss <stwiss.opensource@diasemi.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        LINUX RENESAS SOC <linux-renesas-soc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: Re: [PATCH RFT] watchdog: da9063_wdt: parse DT for timeout value, too
Message-ID: <20190415092853.GA1861@kunai>
References: <20190414110933.30529-1-wsa+renesas@sang-engineering.com>
 <VI1PR10MB23525523F623FFAC4126EBC9FE2B0@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
In-Reply-To: <VI1PR10MB23525523F623FFAC4126EBC9FE2B0@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2019 at 08:11:16AM +0000, Steve Twiss wrote:
> Hi Wolfram,
>=20
> On 14 April 2019 12:10, Wolfram Sang wrote:
>=20
> > Tested with a Renesas Lager board (R-Car H2, DA9063AD), checking the in=
itial
> > timeout value via sysfs. I didn't test handover from bootloader because=
 my
> > bootloader neither supports WDT or I2C out of the box.
>=20
> Can I please check there is no mistake in your description. I have been r=
epeatedly
> told by the hardware engineers here, (for the past 6 years) it is not pos=
sible.
> But, you seem to have an R-Car H2 with the AD silicon version of DA9063?

I am confused, what is not possible? That I have an AD version? Yes, we
found that out when we worked on the RTC recently. It is an early
version of the Lager development board. I have no numbers but my
assumption is there are not too many out there.


--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAly0TtEACgkQFA3kzBSg
KbZu+hAAtPAAsEVe3hvrEKUMHPu4rBL95DIYXjax75QuarpT0oiPLIPutpVoynlk
T4bbdFyWK6PONBGY/iViNoWo+lcmQdh/bOQtn4ZfdNQJCqk7IZWKHToEifQPR75l
IyHqh8bCufDPzF9zy6cWYYD0kxAUdctcIq6mVxVFollfrtHge20IzBw5grJzFIPv
i5C0Reoeh7wvfMOnlIal/fHp1dFGkNAv3JmU9SAzrr3zARlvRLXcZ/5NW6+zqtto
hKL/g8fEu5i30q8J0UaG+nKz1750sGlMGXscQwhVDjLR9CXvg9OA73bZ956S/h2g
nPqM1qvS2jV0TfbKIeK8AC8rgBgByppOJGWhhk+hwxGwvIFz5H79Cf9XGT7p1ST2
7Jzjo7ahYMMRFLIi+ucA95yN7grSHG/bQz58Iypu8gL1IH1ZqXwS+arbwpdmQIfH
F/fuBi4d50q+jPpjLVSYzL4SUPXTMjpC6INogQo3djrS0Gtu97sLLd47t2hA/q8G
zZMwVXIg3x2tcaRt6O2rsgMM8L+JUklSwfBJnCJ6zOQIHjHdOUB3YZgLFzlhHq1b
HZ/nKMu/XEWIKRYCkiynnWFp1h2JC3FjKCF+FIfKlFZUg7fpmPLmDqTV/IYu5gAb
OQIceEb8UkGxB0rqNnMvHcyBJDB3+zOXgU3s72vw/hFaxmmhFIE=
=4QmZ
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
