Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9779DC2BD09
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 09:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64CC724683
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 09:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575885032;
	bh=kK/I1htj5iKmRP2SOIMYrpp9j8JAcrd7L6geivuOKJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LKbFqWezLKuO9zmrwNaCqiG3AW4GMJdIbEyLnZo5j6s7pgCd189ilQ1x3FUwfsOOu
	 Fc8eKaYHGWJokT/VuKswQr09VBrlinFQbf9HpDmtLuN0SuC6Y2DHqFrpsm9gQ4F9uf
	 OlXRHSfHBlWujX4OEjs9M9NlEh2C4/x+1z5fHDoc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfLIJub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 04:50:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:60382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbfLIJub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 04:50:31 -0500
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 393F324680;
        Mon,  9 Dec 2019 09:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575885030;
        bh=kK/I1htj5iKmRP2SOIMYrpp9j8JAcrd7L6geivuOKJ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pd3bkAeCwLsfknhYLwW5D5ACMrJir0Nd8fxBEHXzX23+IvhzeXMqC795QiGC6ii+t
         Ab/ujdrOpc5MkZkjlFcuehhQsp+UtrbtsuVAZXR09sVyu3LXeVIzUPJJ/QlVWw25Lg
         p9/gl1rc3XARVg/MwzOjTm7CT9xzPxo9/fE4NTOw=
Date:   Mon, 9 Dec 2019 10:50:27 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Chen-Yu Tsai <wens@csie.org>, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] rtc: sun6i: Add support for RTC clocks on R40
Message-ID: <20191209095027.ivvatpcmft6357hs@gilmour.lan>
References: <20191205085054.6049-1-wens@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="adfqrlv2c7xcdepi"
Content-Disposition: inline
In-Reply-To: <20191205085054.6049-1-wens@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--adfqrlv2c7xcdepi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 05, 2019 at 04:50:54PM +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
>
> When support for the R40 in the rtc-sun6i driver was split out for a
> separate compatible string, only the RTC half was covered, and not the
> clock half. Unfortunately this results in the whole driver not working,
> as the RTC half expects the clock half to have been initialized.
>
> Add support for the clock part as well. The clock part is like the H3,
> but does not need to export the internal oscillator, nor does it have
> a gateable LOSC external output.
>
> This fixes issues with WiFi and Bluetooth not working on the BPI M2U.
>
> Fixes: d6624cc75021 ("rtc: sun6i: Add R40 compatible")
> Cc: <stable@vger.kernel.org> # 5.3.x
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--adfqrlv2c7xcdepi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXe4Y4wAKCRDj7w1vZxhR
xYNaAQCetuw+MBQxkDVO9bmDf8kmcwTq+uA3DS6rDGX1p7rgGwD/SEy8iOesX8M3
XURC17yL4C6iJ4kO/yUvMDP24FhMpg0=
=FAWR
-----END PGP SIGNATURE-----

--adfqrlv2c7xcdepi--
