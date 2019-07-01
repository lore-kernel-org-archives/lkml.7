Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767D2C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 07:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4929E208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 07:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfGAHvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 03:51:39 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:37531 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfGAHvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 03:51:38 -0400
X-Originating-IP: 86.250.200.211
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 5D67724000A;
        Mon,  1 Jul 2019 07:51:29 +0000 (UTC)
Date:   Mon, 1 Jul 2019 09:51:29 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/selftests: reduce stack usage
Message-ID: <20190701075129.wu5q5j2cl6fkkzxp@flea>
References: <20190628121712.1928142-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k3xrq2kk3vkmur5d"
Content-Disposition: inline
In-Reply-To: <20190628121712.1928142-1-arnd@arndb.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k3xrq2kk3vkmur5d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 28, 2019 at 02:16:45PM +0200, Arnd Bergmann wrote:
> Putting a large drm_connector object on the stack can lead to warnings
> in some configuration, such as:
>
> drivers/gpu/drm/selftests/test-drm_cmdline_parser.c:18:12: error: stack frame size of 1040 bytes in function 'drm_cmdline_test_res' [-Werror,-Wframe-larger-than=]
> static int drm_cmdline_test_res(void *ignored)
>
> Since the object is never modified, just declare it as 'static const'
> and allow this to be passed down.
>
> Fixes: b7ced38916a9 ("drm/selftests: Add command line parser selftests")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--k3xrq2kk3vkmur5d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXRm7gAAKCRDj7w1vZxhR
xSj3AQD883LdPCF2VHnJQSOigD1rze6Ji5RXavfZBuw0Wl+AFwEAhNezyMQujyQ9
tnGzcooJ6/8XWBIhPBIfP0Hs3nkamwk=
=tsnW
-----END PGP SIGNATURE-----

--k3xrq2kk3vkmur5d--
