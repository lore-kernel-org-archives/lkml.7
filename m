Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC12C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 22:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9686B2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 22:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbfC0WRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 18:17:35 -0400
Received: from sauhun.de ([88.99.104.3]:39446 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbfC0WRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 18:17:34 -0400
Received: from localhost (p5486CE6B.dip0.t-ipconnect.de [84.134.206.107])
        by pokefinder.org (Postfix) with ESMTPSA id 132EB2E35A2;
        Wed, 27 Mar 2019 23:17:33 +0100 (CET)
Date:   Wed, 27 Mar 2019 23:17:32 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Shreesha Rajashekar <shreesha@broadcom.com>
Subject: Re: [PATCH v5 1/8] i2c: iproc: Extend I2C read up to 255 bytes
Message-ID: <20190327221732.GB15396@kunai>
References: <20190214175725.60462-1-ray.jui@broadcom.com>
 <20190214175725.60462-2-ray.jui@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Content-Disposition: inline
In-Reply-To: <20190214175725.60462-2-ray.jui@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +		if (!((readl(iproc_i2c->base +
> +		M_FIFO_CTRL_OFFSET) >>
> +		M_FIFO_RX_CNT_SHIFT) &
> +		M_FIFO_RX_CNT_MASK))

Don't be too strict with the 80 char limit. I think the above is hardly
readable...

> +			break;
> +
> +		msg->buf[iproc_i2c->rx_bytes] =
> +			(readl(iproc_i2c->base + M_RX_OFFSET) >>
> +			M_RX_DATA_SHIFT) & M_RX_DATA_MASK;

... this here is MUCH better.

Rest looks good.


--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyb9nwACgkQFA3kzBSg
KbYzdg//TqhPqqJ8jsf33y2YrdjFG4eYNsHy58/R6LsqUp47WsYfxCSK+pIqGFds
w7Tr35HB0oOQCqxAMnsV0hJV1bdITMR3N5KpW2LPL4YHBOIfsdtwJShPjo/n7vJE
XLCEWto8fyIxjFYu/VfIPpeFyMK0djtvnAr1aT0Hu7iJbNuqPtgK0Htu5YqJUAHF
+KqsZtyIue8+16veAvEJ7jzQl7XcXkejpak1oOBrm69i3tvi5P0HK0wRTAninCZn
v1GgOWnoP0iltCJpSDiZIRtEWcstGvx9vuHCu1DI9b/f7bk9F1Qh4V6Vwuot2JiF
oG+J6UptJjoK90ZSBY4Z2yiDRU+qVYAwjskY2PLeG2AgMYP47LhZ7RDzfcNtJmiE
fA+cwS3GhqIiFZbo0FPP1nKMvaJHr4xm0RDgPoTvmqxAUt5BwIMM2V8/ZnI8rlvW
GVPoX9W2V4z5W8BF6/QXaaYk1QY6WLnTEgi31fofCbnYyxSre0MwvvtUzfiVdCr9
IKQKV4N1s4MDYk6nOQ6x+rGa0tmJrw2wP8UJBGD4vl/TtSrCHmd8IJAE9xF/A85v
7L0NpRIomYRXpeJRtm7mYsr8Nl/HY5nXGgK+eKScXanv7kV81P88dF+KrFDh2Ymg
+tB0iOV1QGcCKxNEx0h73cs1nhTfQLL2lCZpz3d0XntkA1q2Ysg=
=5U3k
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--
