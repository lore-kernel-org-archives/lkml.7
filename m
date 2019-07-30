Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9120DC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691AC20693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564510243;
	bh=a379iHSgcPfxyFa/ad87uE7C3zQ643k/rIvp2Qv2HQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XXv3yIKP/fB9zIV2psOlm2l27c8EbehvbM0beGczV9VwRJ8//doSlU9epMzeWPw/c
	 dRDA29ZvU3RbgAiCjMzCZvEx+3X07hMPEgyStU4QAErLLOy1B/38tPLLzRbuqg9xNK
	 ecx2x+GLtjDUyupxL67g4nuSLiWzjJ3qKRKmBqmg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbfG3SKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:10:42 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37840 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfG3SKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:10:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QqTYr7rDpWTKZ0tgJj879jROstvjPJUY9DWnD1mPY10=; b=CnyPiQ7Y8JvUubxqT3e7xR2Go
        AgLF6yzH+9ceTmWrW+sDVDY0EjCs1y6l1uLXj2EEroesVOQ/6k1/wsdxypLSmYVdNUcopy2xvIn6P
        qqxLQVqFB49x+230B6A2Ge6mQXeCYeT5VZuvicD1fQvvdk/mhoCbcnE34/wq7urwf4x6I=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hsWa7-0008DM-Cl; Tue, 30 Jul 2019 18:10:39 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 822262742D42; Tue, 30 Jul 2019 19:10:38 +0100 (BST)
Date:   Tue, 30 Jul 2019 19:10:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Philippe Schenker <dev@pschenker.ch>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Philippe Schenker <philippe.schenker@toradex.com>
Subject: Re: [RFC PATCH 1/2] Regulator: Core: Add clock-enable to
 fixed-regulator
Message-ID: <20190730181038.GK4264@sirena.org.uk>
References: <20190730173006.15823-1-dev@pschenker.ch>
 <20190730173006.15823-2-dev@pschenker.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zYjDATHXTWnytHRU"
Content-Disposition: inline
In-Reply-To: <20190730173006.15823-2-dev@pschenker.ch>
X-Cookie: Times approximate.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zYjDATHXTWnytHRU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2019 at 07:30:04PM +0200, Philippe Schenker wrote:
> From: Philippe Schenker <philippe.schenker@toradex.com>
>=20
> This adds the possibility to enable a fixed-regulator with a clock.

Why?  What does the hardware which makes this make sense look like?
Your cover letter didn't explain at all clearly, it just said that
there's a circuit that is connected to a clock which somehow switches
something but it's not clear.  It's certainly not clear that this should
be in the core, the circuit doesn't sound like a good idea at all.

> Signed-off-by: <philippe.schenker@toradex.com>
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

This needs a cleanup.

> =20
>  	/* cares about last_off_jiffy only if off_on_delay is required by
> @@ -2796,6 +2805,9 @@ static int _regulator_is_enabled(struct regulator_d=
ev *rdev)
>  	if (rdev->ena_pin)
>  		return rdev->ena_gpio_state;
> =20
> +	if (rdev->ena_clk)
> +		return (rdev->ena_clk_state > 0) ? 1 : 0;
> +

Please write normal conditional statements, this isn't helping
legibility.  Though in this case the ternery operator is totally
redundant anyway...

--zYjDATHXTWnytHRU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1AiB0ACgkQJNaLcl1U
h9AnVQf/bmxm9da7buxiCOzPFvSNO2buPNUm9sCLCjwKvN6BY0kxCM5uILlj2v/s
WvsCpcpoSMhvBKX+gZmnasln8eIRdKnKwDfTN1Joo1qEk0JQAKR8xjWH7ZWF0T38
PQNfTahnq0vCiCFd6ItNqntqBtGN8r9BjraBTgwyB46ASzPPwOimQOkUd73d6E6g
C/ySgZjbJtoKwULdf9u6MqPo9dBrHq69lAA7n106zaSBAVXqX8Pdv7bEYhN+fkle
RqXlZ0vpvhwKnh67xT9lIIzVezEKzSyjfOJ/dwb4fdWeBU7L0AUeh9Zem6Q+hl3b
1fNieVb6RKUOdoAO7cWX/OfG+vIK+w==
=bKfQ
-----END PGP SIGNATURE-----

--zYjDATHXTWnytHRU--
