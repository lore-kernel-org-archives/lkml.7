Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDA2C10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD63D213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554105399;
	bh=wLp/QB/bhEXwxZBKIvvDh3ZKXvdKifdGDNm3u97IV/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SKaZaPr6zOFbB4Vqyno0xQYnzRI+HQEHr37HpWuONiCZiMkNq/PoeHrK2sYhHrPTc
	 PXp5RE8zOuVpzh1i0HKLhxQtKtopafOK39lnm9Yh+X+kv1azjJD6LG3mjrmX4EBLFq
	 ovdgHjkRNMCFxzIGPb8hOXOcIeiXxKTiUjyxv3zc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732079AbfDAH4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 03:56:38 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48916 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731944AbfDAH4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 03:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wLp/QB/bhEXwxZBKIvvDh3ZKXvdKifdGDNm3u97IV/E=; b=e5uk6IEgQj6sGPfrc6DX++YQo
        HBdX2F4fJRZE+AaIjV6kgsIsdEqwH0AHEfIrTaxg45nQ2gs1fQQyi5VUy8QYBDsXNawdnz9AsNJu3
        PUDEUPGYS6SmaIQ+jCoM0ldXwdmRPnhyqtis2eIYJ/pqFlG5RE4OHUgCKVZXujccxP2Xw=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hAro0-0008Eh-Ry; Mon, 01 Apr 2019 07:56:33 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 51C70440082; Mon,  1 Apr 2019 08:56:24 +0100 (BST)
Date:   Mon, 1 Apr 2019 14:56:24 +0700
From:   Mark Brown <broonie@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 1/3] ASoC: cros_ec_codec: Rename ec_response_codec_gain
 into ec_codec_i2s_gain
Message-ID: <20190401075624.GA25436@sirena.org.uk>
References: <CAPUE2uti=fketJ4vJw34et_y9L_gsEUwXNDdjg0sG8Z27ir1Hg@mail.gmail.com>
 <CAPUE2usk3unTTp+3mpL7TgZ02u9fJtB5gLTLBMfMwHErwyeOsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <CAPUE2usk3unTTp+3mpL7TgZ02u9fJtB5gLTLBMfMwHErwyeOsw@mail.gmail.com>
X-Cookie: Oh, wow!  Look at the moon!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2019 at 10:56:36AM -0700, Gwendal Grignou wrote:
> In preparation to update cros_ec_commands.h to match ChromeOS EC code
> base, rename data structure that will be merged together.
>=20
> TEST=3Dcompile.

This doesn't apply against current code, please check and resend.

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyhxCcACgkQJNaLcl1U
h9DKaQf9HzlYgnF7SZmZfCJRlYEA5W6K00+Nk4R8ETSyXaf+6AawoKWbeQwAq3t4
kmW/w1VWuQUQwGvjc7iEbsgFecj2U94GykVJkj01V4J8zEXfPhc/1sDrHqJ4KXzq
e2SSoyeNZZ2L1bUYoevG3Of6NYdz0ji9AE4mObqrH4EjS/yHH1uNyWCgf+FZ+hqt
XGggYTpagvtSZt1CvNcPDo9oeyOTYm4qJvdI7gSMlxTjtXDe2KnguJGDhT+aGW2j
M5zDRgJY+GC3g+sAeyEd4JpK5/hsQfMfLv8QkwFr2eWo1fmgudcOILochdBSfcu3
hrSduRHGWK9cqyU/drHx+hF3eH7tMw==
=K0bZ
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
