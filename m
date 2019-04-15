Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C2EC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22CC220848
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfDOLEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:04:14 -0400
Received: from sauhun.de ([88.99.104.3]:40684 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727289AbfDOLEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 07:04:12 -0400
Received: from localhost (p54B331F8.dip0.t-ipconnect.de [84.179.49.248])
        by pokefinder.org (Postfix) with ESMTPSA id EDC9C2C0114;
        Mon, 15 Apr 2019 13:04:09 +0200 (CEST)
Date:   Mon, 15 Apr 2019 13:04:09 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Steve Twiss <stwiss.opensource@diasemi.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        LINUX RENESAS SOC <linux-renesas-soc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: Re: [PATCH RFT] watchdog: da9063_wdt: parse DT for timeout value, too
Message-ID: <20190415110409.5q6la4wz5bjiesrc@ninjato>
References: <20190414110933.30529-1-wsa+renesas@sang-engineering.com>
 <VI1PR10MB23525523F623FFAC4126EBC9FE2B0@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
 <20190415092853.GA1861@kunai>
 <VI1PR10MB23520D64B2120138FF64D0BBFE2B0@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lqmkg5kji7elbzig"
Content-Disposition: inline
In-Reply-To: <VI1PR10MB23520D64B2120138FF64D0BBFE2B0@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lqmkg5kji7elbzig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > I am confused, what is not possible? That I have an AD version? Yes, we
> > found that out when we worked on the RTC recently.=20
>=20
> Sure, I know, people have been requesting continued support for DA9063 AD=
 silicon
> for years. The original DA9063 Linux driver was sent to LKML with AD supp=
ort.

I see. Well, unlike the RTC patches recently, this watchdog patch is
independent of the variant AFAICS, or?


--lqmkg5kji7elbzig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAly0ZSkACgkQFA3kzBSg
KbYm2g/+MtI543GeMiwqgNwVhWzUd3MzVQYrgjPF8x/E0UmUTLSFn6TkFLlQrcGu
e00szB+GXFJ3d+CRtxVNo0gbjmMNcegeLNUYu+7GSAbNQl1v8uwY9GVoKatoSzS/
Ns3CoeZuVEqhLq85IaDxiVXRLeHJDyzAlZnYPm+pInAUvR/IantsvuUyB1wSTUt6
KSJkQFLI8CT1dF6AO+uVfYMl7kMvZO44oaezUBg1RQYMD6RUeoWgfhRZ/v46hIBP
z5pEsS56Hh6HJjjFzoUltb5AueTurbO97KGcLR5RMLr5gAZtpdGBdgwk6ZpUTqnu
CLs/YTm5G1ftcIBpraTr+NwFJzVSa8WFswnIdPJPRpYCoOqNighXjCjkADa7FAZX
or4d0M5xnOLKmNyQT/8m27XAGXPV03kO+DAtlr9RA73Uq8RXNtmXl74j18AUq9FD
tq04kff1k0mY/iuHA5OEescGLJk7lNZqPXPvpHmLzNRIpg+4LS5m8HmlpVNUK01a
coATYT7byYTof1MfOwWZkeDZ2HXw+pN+3V2TH5B3GVUAYCFcWbTKr2A8x3HjE2Qc
zJF239K5l4IRgWZLWUt7yZbvIvS9I5J2oZ2dwxCJ4AZaCnQf4rEtGNTvxaB4G3Vh
ihxxYdIEGG/w11WwnfHzMw0g+a80m5S87EAs1LeYtOhbwPNWP9U=
=/Lia
-----END PGP SIGNATURE-----

--lqmkg5kji7elbzig--
