Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D849C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 16:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10A32217BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 16:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfK1QQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 11:16:46 -0500
Received: from sauhun.de ([88.99.104.3]:43852 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbfK1QQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 11:16:45 -0500
Received: from localhost (p54B33127.dip0.t-ipconnect.de [84.179.49.39])
        by pokefinder.org (Postfix) with ESMTPSA id 111DF2C039E;
        Thu, 28 Nov 2019 17:16:43 +0100 (CET)
Date:   Thu, 28 Nov 2019 17:16:42 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 01/12] i2c: replace i2c_new_probed_device with an
 ERR_PTR variant
Message-ID: <20191128161642.GC5412@kunai>
References: <20191106095033.25182-1-wsa+renesas@sang-engineering.com>
 <20191106095033.25182-2-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8NvZYKFJsRX2Djef"
Content-Disposition: inline
In-Reply-To: <20191106095033.25182-2-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8NvZYKFJsRX2Djef
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 06, 2019 at 10:50:19AM +0100, Wolfram Sang wrote:
> In the general move to have i2c_new_*_device functions which return
> ERR_PTR instead of NULL, this patch converts i2c_new_probed_device().
>=20
> There are only few users, so this patch converts the I2C core and all
> users in one go. The function gets renamed to i2c_new_scanned_device()
> so out-of-tree users will get a build failure to understand they need to
> adapt their error checking code.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Eeks, this nearly slipped through the cracks because I marked it as RFC
in patchwork...

Applied to for-next, thanks!


--8NvZYKFJsRX2Djef
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl3f8uYACgkQFA3kzBSg
Kbb4cg/4oDouHaIm5+H8FfA0fpu1y0g+oBZDOFdCpknFWq/HPG4KmsDAdL2AWceN
7ECWh9/izN4m0K5Ffl93UDi3z0hPwLwoogRGWtKef3UwV9/gimFdHXSS/nbeX+uq
Jx+HA1Ie5mOGEUtBKM7RPS/7wdsfKv93cYWtj3wqH2VXJO1vxnG12YdVTjeeKy+4
Qep+Sl9z6zWm1hD7uP2TB5MngSb4fpkJvUKG7vQP7ExTrPhEetjHCH2kcQlJ04Kw
lUvyZDs+0X3bxiu/T58/IfoXlMGSFy+V8/rdRc7wrtRGAYB9Y7W4lDhUcy+cpCt3
WL/lwMgdgf0bVsYCCDApm+2oVNjB4kmCznXChH9P9oSUHKz5sMw8xQ2NKr/EE5MS
QcuvCx2zGzPijHQEgQtT1AkgFfbp1c+Q4o31xO0iiXr+825G2zze/9QZm0LOywgR
HsBKHwtDhHkCGCpHDm986ePZEEKuWgzPsAf96difB9+uwZVtou2zgvnfYO7cb913
w/UCqT8dxmNvrTynMBfnhKYNuESEaPAwYnAot0WlDgbxSrMQoVTuLd3ZhC4Ncs8V
igOzuE4kBLlRY5ojrOjRF+/S6aBJaUkDFuSmDJygDuNR5DjVEtl6iVo7ev5DfbZ1
yt0Odho8eHv/nzK5qLeXVlsqsSBGuLc911kZF60S66l2tjticQ==
=bUe7
-----END PGP SIGNATURE-----

--8NvZYKFJsRX2Djef--
