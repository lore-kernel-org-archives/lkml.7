Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A74C28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 12:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 933D724D8A
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 12:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfFAMr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 08:47:29 -0400
Received: from sauhun.de ([88.99.104.3]:49746 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbfFAMr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 08:47:29 -0400
Received: from localhost (unknown [91.64.182.124])
        by pokefinder.org (Postfix) with ESMTPSA id 675B32C54BC;
        Sat,  1 Jun 2019 14:47:27 +0200 (CEST)
Date:   Sat, 1 Jun 2019 14:47:26 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     David Miller <davem@davemloft.net>
Cc:     ruslan@babayev.com, mika.westerberg@linux.intel.com,
        linux@armlinux.org.uk, andrew@lunn.ch, f.fainelli@gmail.com,
        hkallweit1@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [net-next,v4 0/2] Enable SFP on ACPI based systems
Message-ID: <20190601124726.GB11008@kunai>
References: <20190528230233.26772-1-ruslan@babayev.com>
 <20190530.112759.2023290429676344968.davem@davemloft.net>
 <20190531125751.GB951@kunai>
 <20190531.112208.2148170988874389736.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Content-Disposition: inline
In-Reply-To: <20190531.112208.2148170988874389736.davem@davemloft.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I already put other changes into net-next and also just merged 'net'
> into 'net-next' and pushed that out to git.kernel.org, so I don't know
> how I can still do that for you.

Okay, it is just one patch. I will apply it to my tree as well. Should
be good enough.


--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlzyc94ACgkQFA3kzBSg
Kba1Xg//aW4eaS0Z0rjf0K6tZgQP/48mTRKsBSGJbqDaoTdMP4K0tJjB8hmIvCzL
LLS5ydN6/w5izMs4NF3SpyrvU7AXTUwVj8ikR7PEZogYdD2vd2MBQYfdPOWwbQXC
WMghLuaGV/6OBoS3f13yjm+yrdVv5cVzwZI7abdgbIR2QEz+wKHaYnmyUbu+YRzH
itWmNRtFsiTYhJv+DKZrjz6HzbK+F9zKVNU03nt0coIAFmiYDxCBM23wzacMH56p
KtnW1RvsYId7x+Rbvk9I6c9YNJ8Rt+ttHOJwDOebY54jfQQt/2K+guhTEi+SDMm9
gjsH1XbZyhj6I9hr4aaK8jAf6n8gmUtqvO78rKKmXJ5WbIo80Vc1/7aUykKk+2yv
te3Yyiwqj8la57z6x64CtfeA6irEIj9tVXuKslNxJwguR8k/kqDIO5f0qawfi7Ti
ZYxOC/JG2dnWp5Y/Cea1oM5b5J2JMIiCYpe84k4rosqaHUgJhjAO1VhhUpJhiYVD
rtyfjdKqAUqx0sQo/K1Cji04QnMWJgDbiwaCCtsoEqScUV/JLj1efLn+r4VoP1BD
u+69vxyf4hHGoeDK1qvjwbKxHToPjkI+NqsPSqGQCBJJvIkXG7QXQZWROJZ2OcBX
SdGkrtvqKSz1Nr0QzGfjdEDm7Qrka31s+dxeKcDGvc85mSyLOaw=
=i+6S
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--
