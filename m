Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8F6C10F05
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 11:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC01217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 11:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbfC2L1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 07:27:52 -0400
Received: from sauhun.de ([88.99.104.3]:53758 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728755AbfC2L1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 07:27:52 -0400
Received: from localhost (p5486CEF3.dip0.t-ipconnect.de [84.134.206.243])
        by pokefinder.org (Postfix) with ESMTPSA id 45DDF2C2817;
        Fri, 29 Mar 2019 12:27:50 +0100 (CET)
Date:   Fri, 29 Mar 2019 12:27:49 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Steve Twiss <stwiss.opensource@diasemi.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Subject: Re: [PATCH 0/6] mfd: da9063: remove platform_data
Message-ID: <20190329112749.GA1415@kunai>
References: <20190318154759.21978-1-wsa+renesas@sang-engineering.com>
 <VI1PR10MB235256E1840C1E594ECDC0A5FE5A0@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <VI1PR10MB235256E1840C1E594ECDC0A5FE5A0@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I've acked-by and tested-by for all the patches now. Apologies because it took
> such a long time to get around to looking at this.

Thanks for the testing! I think 10 days is actually quite fast :)


--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyeATEACgkQFA3kzBSg
KbZ19Q//ToPq/H49dntfH9jC6I7MvzlZQ42fbLvjb+HR4WEqMBGg71Y+DfsZTDNc
stLXhZ1CawrJ5SY0biUfDQTtr6QAHLpyH3unJvcmdlJRsZVGTOY4gPL+YYZMA6r+
81QXqVlzBul0TYCKey4L+v2pxKz7/FQknQNZe49YUa4CH5JnYjGibp8sSSkjQPda
/a9RrOWr5f9de2Nif73AxbDCTvGMg0+Ls7pSqKTCR5qNslXUp9DZq9nxtLmWD8iW
EpxXp9ZZjg8SqYLGIfx3tlv3UtBcbDl7N4+oI04/lVvJgPg+AWQH7T3Ex0gC+cu1
doeCSAfcbwtAPvvVQs6jN5weFpH62u4pALaDtkX4OqdFhlsfhfpqArN5ZJrtUUU8
sOS3Kc+LGVAvYwG2fV4OpZ2QwmLwhEnp5c2Go/Sa4r7XckwhJfbuDG+rM/rDREAD
/pzX6QrWH7+eyd2ZIf7AF9ND9oxZbsbCjup6+iihu5eJ0vrgddoy1Y+X5EGfxzjp
tQ3bhPAbKn02f2gbQH/EkKzpCB3Q3FK8esE04PkKPAr8MCHn7Qp4edcMY4nrwpwW
2wUXMZSdnyWagx5fT35sqr8r7ZLbjv13q7I4+F2c42mVDDvJSbnR5TYM7AgbP99W
1W8ghQX8QPCB3Z2IPKAEV8H5yoSiW9aKxmhZrj3svpwXSTEQQAM=
=IGCN
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
