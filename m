Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F75C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 19:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5268C20700
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 19:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732179AbfCZTIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 15:08:36 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:40835 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfCZTIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 15:08:35 -0400
X-Originating-IP: 90.89.68.76
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id D4CFEC000A;
        Tue, 26 Mar 2019 19:08:32 +0000 (UTC)
Date:   Tue, 26 Mar 2019 20:08:32 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: sun6i-prcm: Allow to compile with COMPILE_TEST
Message-ID: <20190326190832.qnniozjsakxp3ouf@flea>
References: <20190322091650.5189-1-maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="263v6jzubpjkffqe"
Content-Disposition: inline
In-Reply-To: <20190322091650.5189-1-maxime.ripard@bootlin.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--263v6jzubpjkffqe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Lee,

On Fri, Mar 22, 2019 at 10:16:50AM +0100, Maxime Ripard wrote:
> Since this driver only has a dependency on ARCH_SUNXI just because it
> doesn't make any sense to run it on something else, we can definitely
> enable it through COMPILE_TEST as well to get some build coverage.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

This one fixes a Kconfig warning in linux-next, could you merge it?

Thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--263v6jzubpjkffqe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXJp4sAAKCRDj7w1vZxhR
xSKEAP9bNEkWYwOABH0XuKBsLkIvoUJWtMiRC+viaKJ0j1qykQD/VKDTBMCzAhhN
vJ3/TKGZpGCEtpfWKUdAuAnRNUGaiw0=
=46q4
-----END PGP SIGNATURE-----

--263v6jzubpjkffqe--
