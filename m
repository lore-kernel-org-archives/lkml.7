Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01700C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 14:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA9220731
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 14:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgAFOri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 09:47:38 -0500
Received: from sauhun.de ([88.99.104.3]:39536 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbgAFOrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 09:47:36 -0500
Received: from localhost (p54B338AC.dip0.t-ipconnect.de [84.179.56.172])
        by pokefinder.org (Postfix) with ESMTPSA id D9B2F2C3939;
        Mon,  6 Jan 2020 15:47:34 +0100 (CET)
Date:   Mon, 6 Jan 2020 15:47:34 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     =?utf-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, paul.burton@mips.com, paulburton@kernel.org,
        mark.rutland@arm.com, paul@crapouillou.net,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com, 2374286503@qq.com
Subject: Re: [PATCH v3 2/2] I2C: JZ4780: Add support for the X1000.
Message-ID: <20200106144734.GJ1290@ninjato>
References: <1576570450-122556-1-git-send-email-zhouyanjie@wanyeetech.com>
 <1576570450-122556-4-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7ArrI7P/b+va1vZ8"
Content-Disposition: inline
In-Reply-To: <1576570450-122556-4-git-send-email-zhouyanjie@wanyeetech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7ArrI7P/b+va1vZ8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2019 at 04:14:10PM +0800, =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou=
 Yanjie) wrote:
> Add support for probing i2c driver on the X1000 Soc from Ingenic.
> call the corresponding fifo parameter according to the device
> model obtained from the devicetree.
>=20
> Signed-off-by: =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@wany=
eetech.com>
> Acked-by: Paul Cercueil <paul@crapouillou.net>

Applied to for-next, thanks!


--7ArrI7P/b+va1vZ8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl4TSIYACgkQFA3kzBSg
Kbao2g/9Fw00CvW6HoZ3t/gz4atSoANS3Fuifoxz5o1oIkdX5o1deWwRWx9zYHW4
OdDQQ/gBwY1s2p+GxbdvPmdp/4fPRGl6caoVQUrm30lS/yrtttAD+90xRcDyD8/i
mb8qKagOYM2vif6eGedidLjK2Jy2ShQCyQJhb41cpk73JjXUpc5jXrdzL+rgU8qg
TvF28Il7HM+j/XXN4DwxVIsDhPYTWUM0rMlbZ/dacLGTnhp5Gz80uzaeuK2VCFIM
t61fvI549eaR/m51elIzDrytokR2S4G/Y6URP9BfhPHGbc/BczKaensAHjxjHpWc
ts0B+tLr16Tlbad4F8qnCk1Upp1O4H/fsq5uGqWcuzeDyNGM5W7RkEHXHiCsSk0q
FQViD3x8RKt2NU91txAcxfIZzv4zkLnWaRETkSUnpNUiqw9aHr8XNNtTccPUsnsD
C5PgywSZqok7pTfAeWeOJs+qNwypnrrCfc33rk1TcqsPHl9zgWMiqAZ77+Zf/J9E
EfmDu8xvf5OG2cTWrXoFkUjN4s0lLsizTsYTovK90MSBBrTFr/zKacPgpSPzqtuX
VX9Efjf6GHM3n8xk8yuFWaY5b/FPyWpJzTqcqdzLGQOGnZu7AyRlGMrE82nEo2sJ
fOyKaUs+dxZKCJSPKsLedgo3DVnfYhPwOA5VGJt1EoqhA5V16iw=
=Gabw
-----END PGP SIGNATURE-----

--7ArrI7P/b+va1vZ8--
