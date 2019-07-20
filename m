Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067DFC76196
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 09:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D458A217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 09:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfGTJnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 05:43:40 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:36039 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbfGTJnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 05:43:39 -0400
X-Originating-IP: 91.163.65.175
Received: from localhost (91-163-65-175.subs.proxad.net [91.163.65.175])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id A30E71BF20F;
        Sat, 20 Jul 2019 09:43:36 +0000 (UTC)
Date:   Sat, 20 Jul 2019 11:43:36 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4 2/8] clk: sunxi-ng: v3s: add the missing PLL_DDR1
Message-ID: <20190720094335.io2dkgen5y4ywgs5@flea>
References: <20190713034634.44585-1-icenowy@aosc.io>
 <20190713034634.44585-3-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s7mdyzoknhwpwznj"
Content-Disposition: inline
In-Reply-To: <20190713034634.44585-3-icenowy@aosc.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s7mdyzoknhwpwznj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 13, 2019 at 11:46:28AM +0800, Icenowy Zheng wrote:
> The user manual of V3/V3s/S3 declares a PLL_DDR1, however it's forgot
> when developing the V3s CCU driver.
>
> Add back the missing PLL_DDR1.
>
> Fixes: d0f11d14b0bc ("clk: sunxi-ng: add support for V3s CCU")
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

queued for 5.4, thanks

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--s7mdyzoknhwpwznj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXTLiRwAKCRDj7w1vZxhR
xV+7AP9wparIVlR4HJLuIV3Qi0DHxN7b3DwLLLyxUw6BxiRHmgD/RPzX9h3vcxY+
LkFkH6ROEu0Lo+wThyHdl83xvlmHoQU=
=J37S
-----END PGP SIGNATURE-----

--s7mdyzoknhwpwznj--
