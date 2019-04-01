Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B923C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BD2820870
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfDAL6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 07:58:33 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:33449 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfDAL6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 07:58:32 -0400
X-Originating-IP: 90.88.32.136
Received: from localhost (aaubervilliers-681-1-91-136.w90-88.abo.wanadoo.fr [90.88.32.136])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 0CAACFF808;
        Mon,  1 Apr 2019 11:58:29 +0000 (UTC)
Date:   Mon, 1 Apr 2019 13:58:29 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Mans Rullgard <mans@mansr.com>
Cc:     David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/sun4i: hdmi: add support for ddc-i2c-bus property
Message-ID: <20190401115829.n52yna5c43i6w7yy@flea>
References: <20190326194907.6lekrewcdiuteomp@flea>
 <20190328130249.19356-1-mans@mansr.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kt2o7lx2aymd4u4n"
Content-Disposition: inline
In-Reply-To: <20190328130249.19356-1-mans@mansr.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kt2o7lx2aymd4u4n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 28, 2019 at 01:02:49PM +0000, Mans Rullgard wrote:
> Sometimes it is desirabled to use a separate i2c controller for ddc
> access.  This adds support for the ddc-i2c-bus property of the
> hdmi-connector node, using the specified controller if provided.
>
> Signed-off-by: Mans Rullgard <mans@mansr.com>

Applied to drm-misc-next, thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--kt2o7lx2aymd4u4n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXKH85QAKCRDj7w1vZxhR
xbXaAQCGK31yUk1DBfUh/T87sMiTXy4iJq4WOr7YmCYjwsCcnQEAztujDc4uy4fE
sIzsrKLwxnwZtrYRo4L+XnPRyZRbGQ4=
=Ka+e
-----END PGP SIGNATURE-----

--kt2o7lx2aymd4u4n--
