Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02B1C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 16:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8186A20873
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 16:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557763322;
	bh=DspoTWu/hYffzlc3mAsnDJo05jblojBt72u7d7f1tPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kL5L9ObmXoYmnfnMKOOLoy/74RHDmVX23emUmEwwPArIst28V8K1XZ5O9j6c9o3gH
	 wNpTw6ijfi4m7BDTuqKjE69bAXr0L/87uozk+4G296+YpCxdvWGrSbbE+qUJyS+J+V
	 pghbhlUL43+RE23i28SOkh9M1RXI2wgyv4iWN/Yc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbfEMQCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 12:02:00 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44612 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfEMQB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 12:01:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3h6H85EVVknVN735yBVABZFWWJ/Hs9GjX/eqsJpiqQA=; b=dpnxvmk4LHC9RaoteNJVql2gy
        v64CuTr4G1JlKK4YO22r4+I0GDpDcMzuyDy6UAIqxxCXigsfU3ZQgjALF5dwq75E5hOQzr2neHnJo
        UIJgE7ZlDXZKM9/uf6vQ7rsVAUP653+XUVq1rBUr87jxJ2I4RN64I8iaZ0FcF1bFj27x8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hQDOm-0006zU-84; Mon, 13 May 2019 16:01:56 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 8E4631129232; Mon, 13 May 2019 17:01:53 +0100 (BST)
Date:   Mon, 13 May 2019 17:01:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] Revert "platform/chrome: cros_ec_spi: Transfer
 messages at high priority"
Message-ID: <20190513160153.GD5168@sirena.org.uk>
References: <20190510223437.84368-1-dianders@chromium.org>
 <20190510223437.84368-5-dianders@chromium.org>
 <20190512074538.GE21483@sirena.org.uk>
 <CAD=FV=Xg96SGg-JDjEJRtC6jACcN9Xizcr-zV4rQwXYvuEvmRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EY/WZ/HvNxOox07X"
Content-Disposition: inline
In-Reply-To: <CAD=FV=Xg96SGg-JDjEJRtC6jACcN9Xizcr-zV4rQwXYvuEvmRA@mail.gmail.com>
X-Cookie: Must be over 18.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EY/WZ/HvNxOox07X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 13, 2019 at 08:57:12AM -0700, Doug Anderson wrote:
> On Sun, May 12, 2019 at 10:05 AM Mark Brown <broonie@kernel.org> wrote:

> > It isn't clear to me that it's a bad thing to have this even with the
> > SPI thread at realime priority.

> The code that's there right now isn't enough.  As per the description
> in the original patch, it didn't solve all problems but just made
> things an order of magnitude better.  So if I don't do this revert I

I'm not saying the other changes aren't helping, I'm saying that it's
not clear that this revert is improving things.

--EY/WZ/HvNxOox07X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzZlPAACgkQJNaLcl1U
h9C7UQf/X1Is6ypg5kydcvdMhkuJTCwQwCyVTp61r+ONkbX8IGTCy/peNvsyuQZd
qfelfepJ1N1M1Kss7RehpaEV7TWECxlECSrfCA6a3slYTSytIRHyIQHQx6KD14xM
YOmLPaSF4xzdMboJP4M8zVRQSDQZVWAvohvZ+xIAqoMrzd69Ew6emJeVG0aUQ++L
DGehingQgrrHdtla+ywW8NJrat7K2garMK6syGdKS4DO90+0wUoroy9KOuvccwFQ
QL6hcR3spWrlv4srjapt71wJGwf/S3k1R/VAIYe+7qVKj6glm94L0ziba1BdBOgP
B4t298Dh3eaZZyPtO1x9DvgsYz2zxg==
=SNtQ
-----END PGP SIGNATURE-----

--EY/WZ/HvNxOox07X--
