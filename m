Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB97C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB97E21473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfDCJWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:22:35 -0400
Received: from sauhun.de ([88.99.104.3]:46916 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbfDCJWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 05:22:33 -0400
Received: from localhost (p54B3311F.dip0.t-ipconnect.de [84.179.49.31])
        by pokefinder.org (Postfix) with ESMTPSA id 591FB2C282F;
        Wed,  3 Apr 2019 11:22:31 +0200 (CEST)
Date:   Wed, 3 Apr 2019 11:22:30 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 4/6] regulator: da9063: move definitions out of a header
 into the driver
Message-ID: <20190403092230.dsgce4jscuqg72ls@ninjato>
References: <20190318154759.21978-1-wsa+renesas@sang-engineering.com>
 <20190318154759.21978-5-wsa+renesas@sang-engineering.com>
 <20190319130134.GD5514@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ib56ms7zxi5iicic"
Content-Disposition: inline
In-Reply-To: <20190319130134.GD5514@sirena.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ib56ms7zxi5iicic
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2019 at 01:01:34PM +0000, Mark Brown wrote:
> On Mon, Mar 18, 2019 at 04:47:56PM +0100, Wolfram Sang wrote:
> > Those definitions are only used within the driver meanwhile, so put them
> > there.
>=20
> Acked-by: Mark Brown <broonie@kernel.org>

Mark, if you are OK with all the patches going in via MFD, could you ack
the other regulator patches, too? Steve is fine with the patches and
tested them, too.


--ib56ms7zxi5iicic
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyke1IACgkQFA3kzBSg
Kbb7cg//SsItwrNcvnk+KesM0IgnlsoXsdqWnbe0Ck+NCE6TylDYwU19zjOxUdqK
NvJy447sWgYREaaEi6dzbI02xNcDnxje/SZyWAhRG7TZwPQcXBVfxfr+LUKZtHnf
5o6mm7sagLyN523a6oHZCgNrmPjYsCMwBg6N31iFp1RrRnytwTsEGscPoz50zKvw
G5PoFStrZvQb+hb4Q4F1Jnc9PwGwoEkXp9lyLh+i7SMDoxc/WmcuVyLTxtHss/fB
qxIH4rEwR7H0X51hjZMPG3CX6xQMuAu4jnZ3CWIswCD2TTBXx1c0aN2erU9f54Ja
oM8EbPzjH01Lzj7KBT9EkuPF8XPrH9jvZpZBM2Kuh7sd9OH4Iw7CiqktXuox87Hr
PexYmBi7i3fvMDyOS3KW7obTnyakLIyzk120lFGO/TgkFEz4NZIqmHriz81xcgj3
7pcEdOKi8tScHd5zkiMHW7ycenpdL1SOVomZcFLhcf7p8s/bXHbpvSgDuPmH3T/n
IwjfE2wML4TlATCuImEhUhaMaAGbV2zRtpcyouj4czPGufo0DuXs0ag9UcZBbXog
y3C3El/3Om++5P68jfaDKKPSDctY9QRUBqLijEo75auDBShfvn5d2+Jmv2/gkvvx
8LeGRoaoBD765N8NW2ERqs1ikA6xQf4kRBOzk73ExiVW66NBuLc=
=++ae
-----END PGP SIGNATURE-----

--ib56ms7zxi5iicic--
