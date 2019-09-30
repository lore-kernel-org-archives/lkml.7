Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AEBC35280
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 347BD218DE
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569853275;
	bh=6yoAIqG6hzy/d8bd7DXLZXV/MdLd77qxmf5UP8tY4bc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ExnFF29WaLSxcjuuzWMXdqoMQi/2ONJ5JMP3U23bqIZfX1kycVssrYUBxKaEGOh0V
	 GFUVsm6ZVcluec7lJgJCuCMB1F1llJZQqG3SPsecDH5zrgO5kVl5WipxHKFFl/MGCv
	 Yth26pdVufSmPEX2prkdcyuaPz8caESlqqP4xvT4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731669AbfI3OVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 10:21:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729738AbfI3OVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 10:21:14 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0AF3215EA;
        Mon, 30 Sep 2019 14:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569853273;
        bh=6yoAIqG6hzy/d8bd7DXLZXV/MdLd77qxmf5UP8tY4bc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A1PXmtM1yeRrqnIzd0YbtRtXiOabHe11LfWnRmlafiXfQZYHNbyEtYvT5FSZAmWTD
         EzI+Sd9B+UkLch9hx5VNM1eXqy+yTd0wcrJczKXUz9nQBC8AMl96TD+bLNA/TD3B0r
         0h7ctJ1OIW0jhzXr7N+rVmFXuMyU2uA4n0AWX/J0=
Date:   Mon, 30 Sep 2019 16:21:10 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH] arm64: dts: allwinner: a64: sopine-baseboard: Add PHY
 regulator delay
Message-ID: <20190930142110.vscmnupg6lqrbmuy@gilmour>
References: <20190929085259.76462-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="quermkw47rmscx7x"
Content-Disposition: inline
In-Reply-To: <20190929085259.76462-1-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--quermkw47rmscx7x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 29, 2019 at 10:52:59AM +0200, Jernej Skrabec wrote:
> It turns out that sopine-baseboard needs same fix as pine64-plus
> for ethernet PHY. Here too Realtek ethernet PHY chip needs additional
> power on delay to properly initialize. Datasheet mentions that chip
> needs 30 ms to be properly powered on and that it needs some more time
> to be initialized.
>
> Fix that by adding 100ms ramp delay to regulator responsible for
> powering PHY.
>
> Note that issue was found out and fix tested on pine64-lts, but it's
> basically the same as sopine-baseboard, only layout and connectors
> differ.
>
> Fixes: bdfe4cebea11 ("arm64: allwinner: a64: add Ethernet PHY regulator for several boards")
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Applied as a fix for 5.4, thanks!
Maxime

--quermkw47rmscx7x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXZIPVgAKCRDj7w1vZxhR
xVgqAQCDfcX+A/qtKjlld5IAr3fEdXZnqTWyYKgCOlqsd8Kl7gEA8JWPsQEWWnH9
gsSbLYjkSKUkUMavqHDbIgZ6r9D58wg=
=PU/D
-----END PGP SIGNATURE-----

--quermkw47rmscx7x--
