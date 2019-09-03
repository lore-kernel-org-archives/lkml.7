Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370B6C3A5A7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 15:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1475E23431
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 15:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbfICPZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 11:25:32 -0400
Received: from sauhun.de ([88.99.104.3]:55040 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728679AbfICPZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 11:25:31 -0400
Received: from localhost (p54B3348D.dip0.t-ipconnect.de [84.179.52.141])
        by pokefinder.org (Postfix) with ESMTPSA id 7E8672C4F2F;
        Tue,  3 Sep 2019 17:25:29 +0200 (CEST)
Date:   Tue, 3 Sep 2019 17:25:29 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     =?utf-8?B?VGFtw6FzIFN6xbFjcw==?= <tszucs@protonmail.ch>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] mmc: sdhi: fill in actual_clock
Message-ID: <20190903152529.GB6718@kunai>
References: <20190829183634.3376-1-tszucs@protonmail.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tsOsTdHNUZQcU9Ye"
Content-Disposition: inline
In-Reply-To: <20190829183634.3376-1-tszucs@protonmail.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2019 at 08:36:34PM +0200, Tam=C3=A1s Sz=C5=B1cs wrote:
> Save set clock in mmc_host actual_clock enabling exporting it via debugfs.
> This will indicate the precise SD clock in I/O settings rather than only =
the
> sometimes misleading requested clock.
>=20
> Signed-off-by: Tam=C3=A1s Sz=C5=B1cs <tszucs@protonmail.ch>

Oops, I thought I replied already. For the record:

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl1uheUACgkQFA3kzBSg
KbaCwg/+O2P7U/V3PSUWunSFkHZg7dqiAeb5loMjy2RYmUnjrc7PCir2Cb44mRkz
Tyz9XMXpx3g+7VtqUNHG7pj76M7em1OdiulP631pOUroRmVzfo8vpEu/JJlGTAhG
cymJ5x4KSaBA5itAdYWa4TbIdIxfDTxCNkxdZvvpI8LwR5TZ6anPXgwZwQBeYEhk
jyFbyPgoa7ipivVCJKtNCIlxzWPvTOwNiOD/Y8AwL4MdvTXXqdIM6yD6lhao9wm2
+HaSrMYLX9yv0sFBP2OyOpB3tgTPtsyj9MTjYpffzvy/BVeombUE2qYJg2uuOAda
rcUWQNST5hMRoblcWaLoh1pEX5DiuDeV0J9x5x3cnuRAQnpevPo4mli/GLTyaZYB
nklFBJMhr3Yi9cXrnBYmtNvOnm8A6pjo7ML8G/5q3d1+LrqqMEEE2totRFs7/bw/
CXYhW5Y2/m3VEhPflPwq8nzg5jycVegtm9dz7FphAGvYuzCVY0zbggMNPVkBiTbS
RNZJGmlepoJJiR126SOJDNYyedH8zuHpj2DFazOZlfi+aBAehNBoGAmDJTiOzHrf
hXdhPFENueQgdu0nJ71mYNwqatqiYTgcPfSEA5mFV8g2ji5xsS80alB97neoODKS
lBCuQAWSwPF0oPQlTYgRhpd81h+9gYa7IX1SQoAeLIlQoCBo/lE=
=0Ztz
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--
