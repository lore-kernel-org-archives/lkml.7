Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E803C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09A8F20821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbfDPLFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:05:39 -0400
Received: from sauhun.de ([88.99.104.3]:49090 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726917AbfDPLFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:05:38 -0400
Received: from localhost (p54B332D3.dip0.t-ipconnect.de [84.179.50.211])
        by pokefinder.org (Postfix) with ESMTPSA id D02B62C3637;
        Tue, 16 Apr 2019 13:05:34 +0200 (CEST)
Date:   Tue, 16 Apr 2019 13:05:34 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        sean.wang@kernel.org, ryder.lee@mediatek.com,
        hsin-hsiung.wang@mediatek.com, wenzhen.yu@mediatek.com,
        chaotian.jing@mediatek.com, yong.mao@mediatek.com,
        jjian.zhou@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-clk@vger.kernel.org, stephane.leprovost@mediatek.com
Subject: Re: [PATCH 22/24] dt-bindings: i2c: i2c-mtk: add support for MT8516
Message-ID: <20190416110534.ndcnjjy3dzdb6xbv@ninjato>
References: <20190323211612.860-1-fparent@baylibre.com>
 <20190323211612.860-23-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vcxgegcyuczhk53y"
Content-Disposition: inline
In-Reply-To: <20190323211612.860-23-fparent@baylibre.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vcxgegcyuczhk53y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 23, 2019 at 10:16:10PM +0100, Fabien Parent wrote:
> Add binding documentation of i2c-mtk for MT8516 SoC.
>=20
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

Applied to for-next, thanks!


--vcxgegcyuczhk53y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAly1tv4ACgkQFA3kzBSg
Kba07w/+KTVnldbBtdAYM6iGz11cWe28Ofxfurg1FNf4t6S9ar2RYhtGMYaJpNwQ
YYKURH2tM7i8cAB2sVG+h6TbSPr+WeXmeqXFtgdste+rlcHcU7W8xJG0DUgvjVUa
uC5cJlB9nFzpwX4AVsyhlZHmlT6lwccvtbVE0ZhO9HF3QAAGyzCLTrcwz9upiw06
uXASUNd8vbNt+Wxh1I5d+bhlmFHtn88+cOm5G2u7wibcOhStgJnqo/VXs11ha48E
TQdT+WiMSE1JBMq5szsrjaCA094yEh2muSKBTyKi7uOdxAdN3qv8HJHReM9q5HH8
coLVq8RYb6I7BgbDnuYMTCO2K/GqVstsIp8F/3Mq6ea6uh/5mFME/p5EGHeKBKDM
sGYj2wehgWE/qsVs3NUJiy/Z7lDpuzkgRo0ULpSx64evmwQWmtHeOuGuTny51G44
S/0B1boZJerOLpoJTKctG8Eq6lRkUWvRQzX9fZZmhtiyeEGbXE7sRTLeiLTaDvuc
ma8cDNp7VKfDob4SJeRszjMmgyjOIRtGOutjeS8MipNlKrO8b4AkiiKXoZDWmTt1
q3tDg1hBsfV5T/Pawr4QJHOEXoZ/sh5AT7fh4HdE0aqYTqNZ5jt11dVVktO56U4X
VG54fSn9KZ1GIiAFAyhSG9hac8ldBwxR9tdn2DSHmx0Qh6HYg28=
=TvId
-----END PGP SIGNATURE-----

--vcxgegcyuczhk53y--
