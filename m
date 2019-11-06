Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131DBC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 12:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0827217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 12:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573042450;
	bh=6pXVrNEi0TQdglHE4NKwGTm6WggLgXwchzzv4dRBuzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rwb/bWydDjekExTREvJjE1J+Ohm+PdMuDtCjef6NXv70Bs01jocKZ/yDCYbZ/1RmA
	 o3zR5h0erD0LtFOXlcfUuhp3BD65A5AfjW37YNcEDuFlv3c/jJ/JI2sKHGSLnrls2O
	 NKyXOIdosYzKwHEOGEf2ngvnCGEM6bJVX+FDu+D4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbfKFMOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 07:14:09 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60060 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbfKFMOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 07:14:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8OkFhjqnHHDimjh3kNYigriAaDRNxTtnxl3F/wSWgO4=; b=tyWGGmIg5lpIkDPc1T4eRbPcf
        ukghfI+MIRb4nNzy7h1+MnZggP+iQhGQUNuhkzNo5+WDf6lI7ab7FXZXG6pIlJFFcPF5J3cvITG0k
        jJQI5958xcxrQvR1QzuEVQNvUt9XVa4ByY6caF8PZw1MlGI/miryb7AcwXCgb/fpDeepo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iSKBb-0001NJ-4e; Wed, 06 Nov 2019 12:13:19 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 7A24D2743035; Wed,  6 Nov 2019 12:13:18 +0000 (GMT)
Date:   Wed, 6 Nov 2019 12:13:18 +0000
From:   Mark Brown <broonie@kernel.org>
To:     syzbot <syzbot+f1048ebddb93befb085f@syzkaller.appspotmail.com>
Cc:     alexandre.belloni@bootlin.com, alsa-devel-owner@alsa-project.org,
        alsa-devel@alsa-project.org, bhelgaas@google.com, kirr@nexedi.com,
        linux-kernel@vger.kernel.org, linux@roeck-us.net, lkundrak@v3.sk,
        maxime.ripard@bootlin.com, perex@perex.cz, peron.clem@gmail.com,
        robh@kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, tiwai@suse.com, tiwai@suse.de
Subject: Re: INFO: task hung in snd_timer_close
Message-ID: <20191106121318.GB4544@sirena.co.uk>
References: <0000000000004dfaf005969d1755@google.com>
 <000000000000b9dd9c0596ac5b94@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Content-Disposition: inline
In-Reply-To: <000000000000b9dd9c0596ac5b94@google.com>
X-Cookie: No line available at 300 baud.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 06, 2019 at 04:05:00AM -0800, syzbot wrote:
> syzbot has bisected this bug to:
>=20
> commit b2045303147254d01b1db90a83e5df3832c4264b
> Author: Cl=E9ment P=E9ron <peron.clem@gmail.com>
> Date:   Mon May 27 20:06:21 2019 +0000
>=20
>     dt-bindings: sound: sun4i-spdif: Add Allwinner H6 compatible
>=20
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D14acecb4e0=
0000
> start commit:   a99d8080 Linux 5.4-rc6

This bisection is clearly a false positive.

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3CuN0ACgkQJNaLcl1U
h9C/tgf+OL9uHYsC4lsb0+2dZcC9mIuU5eRO1OGKyj/Xs+3IQzoSdG8lmnAzGOnN
9u9rGTWJmcjpjdTI+ir/OvOuj3EiIVaHI74Sg7ZcByEr0VApnnGd3uWhWy+TwSBp
Q+hhd9YWbC/em3843B3lmwUq/OAj178uTaQ/ZrNxhiK3vZZlloiZg1OoKE3eGXIz
IGSjn8VRTmZZV4VBRZtlr6DkDzuujg2a0f8cdHboIN+UICCtav/4U5UJNKzqSBXV
+6kEZZxPeE//jOjMW3+DLwiGkh05BQuM1F010oVKUs6pDTBrKlZ3WI2mPgB5tZ5S
eESyKon52UVVzt8flxZuQ/UDWmbShw==
=Whut
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--
