Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA4EC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAE6324C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfFDHqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 03:46:37 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:49895 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbfFDHqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 03:46:36 -0400
X-Originating-IP: 90.88.144.139
Received: from localhost (aaubervilliers-681-1-24-139.w90-88.abo.wanadoo.fr [90.88.144.139])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 4D2541BF203;
        Tue,  4 Jun 2019 07:46:33 +0000 (UTC)
Date:   Tue, 4 Jun 2019 09:46:32 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     codekipper@gmail.com
Cc:     wens@csie.org, linux-sunxi@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it
Subject: Re: [PATCH v4 4/9] ASoC: sun4i-i2s: Reduce quirks for sun8i-h3
Message-ID: <20190604074632.tby6r57vjehb4jne@flea>
References: <20190603174735.21002-1-codekipper@gmail.com>
 <20190603174735.21002-5-codekipper@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7jshcfboaepnhnot"
Content-Disposition: inline
In-Reply-To: <20190603174735.21002-5-codekipper@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7jshcfboaepnhnot
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 03, 2019 at 07:47:30PM +0200, codekipper@gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> We have a number of flags used to identify the functionality
> of the IP block found on the sun8i-h3 and later devices. As it
> is only neccessary to identify this new block then replace
> these flags with just one.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>

This carries exactly the same meaning than the compatible, so this is
entirely redundant.

The more I think of it, the more I fell like we should have function
pointers instead, and have hooks to deal with these kind of things.

I've been working a lot on that driver recently, and there's some many
parameters and regmap_fields that it becomes pretty hard to work on.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--7jshcfboaepnhnot
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXPYh2AAKCRDj7w1vZxhR
xaKlAQD09oK9E3ZBJRJxBZlg7egPOYq9H1Wo09ND2ytEbNrr1QD+MC6qd8dznfXK
puvwjUoowAllTkmYM3ex11Z+Gejg0A4=
=YpYf
-----END PGP SIGNATURE-----

--7jshcfboaepnhnot--
