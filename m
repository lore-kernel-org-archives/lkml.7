Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68F8C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 06:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 876302086A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 06:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388358AbfHBGEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 02:04:46 -0400
Received: from antares.kleine-koenig.org ([94.130.110.236]:58898 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfHBGEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 02:04:46 -0400
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 4709574A7E7; Fri,  2 Aug 2019 08:04:44 +0200 (CEST)
Date:   Fri, 2 Aug 2019 08:04:41 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: linux-next: build warning after merge of the i2c tree
Message-ID: <20190802060440.GA11858@taurus.defre.kleine-koenig.org>
References: <20190802132123.6eabf3b7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
In-Reply-To: <20190802132123.6eabf3b7@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Wolfram,

On Fri, Aug 02, 2019 at 01:21:23PM +1000, Stephen Rothwell wrote:
> After merging the i2c tree, today's linux-next build (x86_64 allmodconfig)
> produced this warning:
>=20
> drivers/i2c/busses/i2c-designware-master.c: In function 'i2c_dw_init_reco=
very_info':
> drivers/i2c/busses/i2c-designware-master.c:658:6: warning: unused variabl=
e 'r' [-Wunused-variable]
>   int r;
>       ^
>=20
> Introduced by commit
>=20
>   33eb09a02e8d ("i2c: designware: make use of devm_gpiod_get_optional")

The obvious fix is to just remove this variable. Should I send a new
patch, or do you fix up locally?

Best regards
Uwe

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl1D0nQACgkQwfwUeK3K
7AkfHAgAkCkD4f9l3gxnx5SVkc9BB+pszlZHRn7nBgNbsMMgm95AFLb5rBunysSN
0d5D5E9jKwis1xwScAkvpQHXl453FowqFISh029vthsf0rEgztDs320wycNA6e54
cNnYFmTDGaWWDDlmTebj0UHuQL9wqSCau+j00FEgDakxaK8p1ge75Dr4iyAcePtU
mPmWSIL6wdnbCecmpG1SeFA01tPaEHtNpR+H4R9CagUoAqHp5tQD6GrDn6RyvLbz
9kYp55XPs2AfyozK8jSWRf058qWe5qfsuSvjRWhs3IsoUP7Mmzu0FM1LmieU0VAn
xL7xgGEqNeOjXNqjKUHky2ld7FDjWw==
=g3P1
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
