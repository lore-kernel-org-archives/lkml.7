Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C24C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 03:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58742086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 03:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554088546;
	bh=yH3XPuffHfcafYLBTbdxqk7haH9EwWlvT06qac9tnY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DaJnPtiOQe5LGahomCf/Xh5zprV4ZCsk+67fpyQkHk0gf9sLXI6a5Lm08mx0p8Ov4
	 5FTLHS36XDfdVNQsz3wjhdEcKcAFCwIffYK0cl5Hpklpeocm+S4T234xHowgTaH/Mn
	 qf8P/Q0hMSRY6FfTPXaSu/NrR6nfqs9HhsMK/kow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731732AbfDADPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 23:15:41 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56988 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731593AbfDADPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 23:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rW/8qQ9H25UHVlfrRW4Q7mo2XGbiJ5Fac4dINrgJXRU=; b=cq2UHsmjsumMuqm0pYf8ufTuA
        Y+55rpwWpcbGy5uV3HhJpQbQ27jL2sgkqv0RdWqIVYlM3NIst+yVYCgY6+/eQxc3w3KMut2SZMqnm
        tdTXi06EqmOxgXqMDxSJZFhpxa4yeAK5NkkAY2EzyT6Yh/XRSzC3lKtPfC+Md1+sNNjng=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hAnQ4-0006WG-Vy; Mon, 01 Apr 2019 03:15:33 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id D81CA440082; Mon,  1 Apr 2019 04:01:40 +0100 (BST)
Date:   Mon, 1 Apr 2019 04:01:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     syzbot <syzbot+a979743610b4755d4d57@syzkaller.appspotmail.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        dmitry.torokhov@gmail.com, jbrunet@baylibre.com,
        lgirdwood@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, rydberg@bitmath.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: INFO: task hung in evdev_release
Message-ID: <20190401030140.GA2059@sirena.org.uk>
References: <000000000000f1be430578524a20@google.com>
 <000000000000bf3ccd05851d68a7@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
In-Reply-To: <000000000000bf3ccd05851d68a7@google.com>
X-Cookie: Use extra care when cleaning on stairs.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2019 at 06:24:01PM -0700, syzbot wrote:

> syzbot has bisected this bug to:

This bug being...

> commit e32d99af6830c9a8f37b4f2637ef0cdc60fa79fb
> Author: Jerome Brunet <jbrunet@baylibre.com>
> Date:   Tue Jul 17 15:42:50 2018 +0000
>=20
>     ASoC: meson: add axg fifos DT binding documentation

This is fairly clearly a false bisection result.

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyhfxIACgkQJNaLcl1U
h9CYJgf/UNLYpBORuC8ySyXKjv9u88zc9YzTYOz9msumtsKzL05CjdW72UucOcW+
xF71zVLPkWxpOiiz1GY0i6KR6T/H2BZ/nOLm+RK57DE+d06FNkrZY5WFkoqBT8WV
HjOs/QJYpH+tIlirwTzrnxp1ADaROD6otZfhVhFsQGE3VoYIPn9A7quYaEbVMHeM
i6/Bs/q1g3K6B3zrBEueeGS4bew2Pha8Jd33/BBOCbiODNnIuBuCeOUc5LLcyVJg
BdewxSIh7TU+bAvJvFNYEtOJTM1hbMNv23ZH/GETjakfjql014dpzzN77zdRhnBO
XWgjVW7HaG0ycAwLYu1hbc+F9VoI7A==
=RbAG
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
