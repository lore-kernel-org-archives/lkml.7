Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF780C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 12:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF09206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 12:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbfDPMlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 08:41:55 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:51015 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfDPMly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 08:41:54 -0400
X-Originating-IP: 90.88.18.121
Received: from localhost (aaubervilliers-681-1-63-121.w90-88.abo.wanadoo.fr [90.88.18.121])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 8E53F60008;
        Tue, 16 Apr 2019 12:41:52 +0000 (UTC)
Date:   Tue, 16 Apr 2019 14:41:52 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Lee Jones <lee.jones@linaro.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: sun6i-prcm: fix build warning for non-OF
 configurations
Message-ID: <20190416124152.374wjfd6nczlkagv@flea>
References: <20190416122506.3180853-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2j6zfcc7locmltwc"
Content-Disposition: inline
In-Reply-To: <20190416122506.3180853-1-arnd@arndb.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2j6zfcc7locmltwc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 16, 2019 at 02:24:59PM +0200, Arnd Bergmann wrote:
> When CONFIG_OF is disabled, we get a harmless warning about an
> unused variable:
>
> drivers/mfd/sun6i-prcm.c: In function 'sun6i_prcm_probe':
> drivers/mfd/sun6i-prcm.c:151:22: error: unused variable 'np' [-Werror=unused-variable]
>
> Remove the variable and open-code the value in the only place
> it is used, so it can get left out as well without CONFIG_OF.
>
> Fixes: a05a2e7998ab ("mfd: sun6i-prcm: Allow to compile with COMPILE_TEST")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--2j6zfcc7locmltwc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXLXNkAAKCRDj7w1vZxhR
xeGSAQC/JAkcxmhcVfD5oZNQ+VOPcb9hPuhhpyamLhzQ3N6ykwD9FTntJhN49Jp2
3Enlorbcx57RfuGQ0gmbbhROHu/HAwU=
=4Cnp
-----END PGP SIGNATURE-----

--2j6zfcc7locmltwc--
