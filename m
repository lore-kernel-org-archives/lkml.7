Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FFCC282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82F2B20693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555424911;
	bh=K6YR0frV1ogxUKl5qBR9A0xlSpniASxqyinIy0tNWEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rp4vX8uRXQC3mQPd20MLpOTIpdsF4ylHOo8SiZToOtx16QYOldqTquXuhrDZrtBMl
	 TaaVIrdOAHo5d0ttLX7InO910CqEyrHb1I5xPViCpDJgYigwoCg3y8KB9iP54J3V73
	 UnJVkUIX4oAJ4uU77zdAYyNJUEzD8CpzO/ZnGo4U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbfDPO2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:28:30 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49450 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfDPO22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 10:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jGssofTgPYvFmx2NhnYdrTIvwfYqQ3p4yJez9KkF7ZM=; b=Xyw71ncmatYfMyTwOekObbCNA
        6q1zGs8MDrVFvd/hqUql9zh555oVE7ZVtKAmAyyXPaPMWtJV6H3EDv3MF1Rn8whcfva7Qk4enleYX
        yWfj+tRu8Q+/DVc0Cmi3yx31EiaWB3s34hxDIrj059FNgwGTnGhJbXNd5hs3AvTW6g5pw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hGP4I-00074X-MD; Tue, 16 Apr 2019 14:28:14 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 23DB21127D45; Tue, 16 Apr 2019 15:28:14 +0100 (BST)
Date:   Tue, 16 Apr 2019 15:28:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, sean.wang@kernel.org, ryder.lee@mediatek.com,
        hsin-hsiung.wang@mediatek.com, wenzhen.yu@mediatek.com,
        chaotian.jing@mediatek.com, yong.mao@mediatek.com,
        jjian.zhou@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-clk@vger.kernel.org, stephane.leprovost@mediatek.com
Subject: Re: [PATCH 19/24] dt-bindings: spi: spi-mt65xx: add support for
 MT8516
Message-ID: <20190416142814.GB4834@sirena.org.uk>
References: <20190323211612.860-1-fparent@baylibre.com>
 <20190323211612.860-20-fparent@baylibre.com>
 <5bc3fbfa-6d7e-08d3-116c-a8f78bc680cd@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Content-Disposition: inline
In-Reply-To: <5bc3fbfa-6d7e-08d3-116c-a8f78bc680cd@gmail.com>
X-Cookie: Who messed with my anti-paranoia shot?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 16, 2019 at 09:55:41AM +0200, Matthias Brugger wrote:
> On 23/03/2019 22:16, Fabien Parent wrote:
> > Add binding documentation of spi-mt65xx for MT8516 SoC.

> > Signed-off-by: Fabien Parent <fparent@baylibre.com>
> > ---
> >  Documentation/devicetree/bindings/spi/spi-mt65xx.txt | 1 +
> >  1 file changed, 1 insertion(+)

> applied to v5.1-next/dts64

> Mark let me know if you want to take it through your tree and I drop the patch.

Yes, DT bindings generally get reviewed in the subsystem :(

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAly15n0ACgkQJNaLcl1U
h9DZ1gf9H2Yrq00KAenFGyeh+9in9sO60dj3xTkLjw+cqBEC68iT6kOwJF1bGe49
cTerjLC7g1Z4O7Fas/ExIVqn6vQ2DYvGTRDEQ/3OyrGJa0mL8WZe5ZxSPBrIqFGN
DM83Tt+WHi26ZhKZ7F3eLtoN8TZcs7mNt9OAi2YF4OnoOS51JSyrOKA1sQn00xGf
uQi9IfnJkLOxel+qQhsefoWYKwNZFcIz2qV4K1eKjcnvZKVW+3OeZ2QJok7qWFNf
g/JHvvdaPgHk0ObyQXGNH83a2urwHLFrWNFWZIIHlR1HfpsOUXcTy4luxYlikFxg
1F4MbBZ6WhZuYSlOJ2pQaNJHhEamgQ==
=t4yQ
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--
