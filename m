Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2785DC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A04217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 07:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbfDJHG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 03:06:29 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:42833 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfDJHG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 03:06:29 -0400
X-Originating-IP: 90.88.18.121
Received: from localhost (aaubervilliers-681-1-63-121.w90-88.abo.wanadoo.fr [90.88.18.121])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 7FB151C0010;
        Wed, 10 Apr 2019 07:06:26 +0000 (UTC)
Date:   Wed, 10 Apr 2019 09:06:25 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 22/23] watchdog: sunxi_wdt: Use 'dev' instead of
 dereferencing it repeatedly
Message-ID: <20190410070625.wybaix4pogbjhpzq@flea>
References: <1554830641-9247-1-git-send-email-linux@roeck-us.net>
 <1554830641-9247-23-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="756b5ij5lgzy2uih"
Content-Disposition: inline
In-Reply-To: <1554830641-9247-23-git-send-email-linux@roeck-us.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--756b5ij5lgzy2uih
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 09, 2019 at 10:24:00AM -0700, Guenter Roeck wrote:
> Introduce local variable 'struct device *dev' and use it instead of
> dereferencing it repeatedly.
>
> The conversion was done automatically with coccinelle using the
> following semantic patches. The semantic patches and the scripts
> used to generate this commit log are available at
> https://github.com/groeck/coccinelle-patches
>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--756b5ij5lgzy2uih
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXK2V8QAKCRDj7w1vZxhR
xXoGAP0YRRrWUugA7N3pU9SJgPBm9e29WYNqD7vOixa4avt8wwEA06NOnPWdMtX0
sByc9EtiBplsCUSYRqe3VzkEHlrHaQM=
=wS81
-----END PGP SIGNATURE-----

--756b5ij5lgzy2uih--
