Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1130C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 22:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C42621D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 22:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576706825;
	bh=SzpvZpyTVQUJYzggrXL+zJuJn0/MFcL+DAfkgMbri6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LtQboAuJf0P59RNkN89KPhA4iLzrQiT7NpkVOrwEnv9SlbeMGgOccxjPoxfT4XhQ4
	 ecXJ/hTv+oounWGDLNxc7rLXD23XKoKBTenGXntaxOcj0swU1mooAd0S5m84WH/vNl
	 wvr1D2cgjeKgYeGGz9HEXdOQZ61nUcpn9GIluS8U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfLRWHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 17:07:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:48470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726512AbfLRWHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 17:07:04 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39F8C218AC;
        Wed, 18 Dec 2019 22:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576706823;
        bh=SzpvZpyTVQUJYzggrXL+zJuJn0/MFcL+DAfkgMbri6c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a4HKB5mZXnBgm305LdZj8p6o/RPgeqiiAz27Eu/w3X6HvnuAUdAnjaDJ2iDFcm95Q
         ng1JPT98N+m8zKZE1Bhzw6h0vLU8HQE5atpzP4bLKp8sR9eBLdcX5/a428Wh9wqBOI
         nbLmcTeojL/KNAvsWnUbo915zoEH9HVBqDGHxo5s=
Date:   Wed, 18 Dec 2019 23:07:01 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH] clk: sunxi-ng: r40: Allow setting parent rate for
 external clock outputs
Message-ID: <20191218220701.43zdbknygwwun466@gilmour.lan>
References: <20191218030431.14578-1-wens@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xvkou3vzvj43berm"
Content-Disposition: inline
In-Reply-To: <20191218030431.14578-1-wens@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xvkou3vzvj43berm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 18, 2019 at 11:04:31AM +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
>
> One of the uses of the external clock outputs is to provide a stable
> 32768 Hz clock signal to WiFi and Bluetooth chips. On the R40, the RTC
> has an internal RC oscillator that is muxed with the external crystal.
>
> Allow setting the parent rate for the external clock outputs so that
> requests for 32768 Hz get passed to the RTC's clock driver to mux in
> the external crystal if it isn't already muxed correctly.
>
> Fixes: cd030a78f7aa ("clk: sunxi-ng: support R40 SoC")
> Fixes: 01a7ea763fc4 ("clk: sunxi-ng: r40: Force LOSC parent to RTC LOSC output")
> Cc: <stable@kernel.org>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
Maxime

--xvkou3vzvj43berm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXfqjBQAKCRDj7w1vZxhR
xRJeAQC1MebiUGSLkV/RhOb0whjdTggJMMda81WZOUUmTHudkQEA33OOy8QL7O6u
F8LFxhExb2qFBAWDGnRSUZcT3DyKhg8=
=8cW5
-----END PGP SIGNATURE-----

--xvkou3vzvj43berm--
