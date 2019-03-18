Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6004C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DB8F20854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfCRMUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 08:20:33 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:37731 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbfCRMUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 08:20:32 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 5C4C680619; Mon, 18 Mar 2019 13:20:23 +0100 (CET)
Date:   Mon, 18 Mar 2019 13:20:30 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     rjw@rjwysocki.net, len.brown@intel.com, gregkh@linuxfoundation.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] PM / core: Introduce some helper for better Code
 reuse
Message-ID: <20190318122030.GH6101@amd>
References: <20190316045928.31934-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="y9PDtDHaFrXNoMPU"
Content-Disposition: inline
In-Reply-To: <20190316045928.31934-1-tiny.windzz@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y9PDtDHaFrXNoMPU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 2019-03-16 00:59:24, Yangtao Li wrote:
> This patch set introduces some functions and macros that help reduce
> code duplication.
>=20
> Yangtao Li (4):
>   PM / core: Introduce dpm_async_fn() helper
>   PM / core: Introduce DEVICE_SUSPEND_FUNC() helper macro
>   PM / core: Introduce ASYNC_RESUME_FUNC() helper macro
>   PM / core: Introduce ASYNC_SUSPEND_FUNC() helper macro
>=20
>  drivers/base/power/main.c | 182 ++++++++++++--------------------------
>  1 file changed, 59 insertions(+), 123 deletions(-)

I'm not a big fan. Yes, you got line count down. But no, I do not
think "beauty" of the macros makes it worth it.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--y9PDtDHaFrXNoMPU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyPjQ4ACgkQMOfwapXb+vJd9wCguW/nBTK2LtLS+vq9VZKgdD7Q
+LoAnj9BVw71if8NFT0uaB7RV5SlCBxg
=cbth
-----END PGP SIGNATURE-----

--y9PDtDHaFrXNoMPU--
