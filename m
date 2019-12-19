Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A28C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 13:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4594E20684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 13:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfLSNFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 08:05:05 -0500
Received: from sauhun.de ([88.99.104.3]:48184 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726704AbfLSNFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 08:05:05 -0500
Received: from localhost (p5486C702.dip0.t-ipconnect.de [84.134.199.2])
        by pokefinder.org (Postfix) with ESMTPSA id 518302C2D2A;
        Thu, 19 Dec 2019 14:05:02 +0100 (CET)
Date:   Thu, 19 Dec 2019 14:05:01 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Radu Pirea <radu_nicolae.pirea@upb.ro>
Cc:     linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chirag Parekh <chirag.parekh@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH] i2c: cadence: Added slave support
Message-ID: <20191219130501.GA958@kunai>
References: <20191219124120.53754-1-radu_nicolae.pirea@upb.ro>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <20191219124120.53754-1-radu_nicolae.pirea@upb.ro>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +/**
> + * enum cdns_i2c_mode - I2C Controller current operating mode
> + *
> + * @CDNS_I2C_MODE_SLAVE:       I2C controller operating in slave mode
> + * @CDNS_I2C_MODE_MASTER:      I2C Controller operating in master mode
> + */

Can't the hardware operate as master and slave at the same time?


--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl37dXkACgkQFA3kzBSg
Kbbt0A/9G7dnHkPv6eu3f7KNRWgl+KyWAG1doDbApk+NkT47uu+hfNRDnb3XzAs6
2NsXG9/26GVEJL/ATHPBxWahXHzvvd4Dh2kYx8vUpy09EmlHUEFennlKdWUXAezQ
23SfiuyrbZLJuM+hlEag2FPhIKxdExkotQYa+Qn2TjbR51VAPz0uDK7tzqt/aQ5g
4Q5KYZrUaFlgG6rRSnncOyrZb3GHDXeMS4gQuGu0U1sn9CEcWzswlJHMBug+D+Uy
4HnwS6ADhHbGIqXROqcrAyemGP7WKFwajmJ0dg7nDXFtyU4pZm6zbTtHlKj+r5aJ
VtvXQJSxUxTuy4iQFg0pY0Vs+E1uIsO/TGuVhNh1TrBsLFgn48kIugAsyKE3Fl0F
nDUJvEiuFUa3eWe+fwpECpFxIQkUsF194rWiMJQeNnE3BWN4k+2c/tP/CGy110Ca
0CT+I/aQaFFMbih71E6kzazR+PkmKeFksl+jRp3Uiw8Krg3Gk669FbhySuwTqDeJ
zjfWhKxuc4dkvCuXpxUi2nF4uzF16M2/1ZUL+xP4b4FB4ciHKomK0Du0jShn4zsF
qSNg6udixqR097xmg1UeDqDXtPyJx5iI/txwIAO2w6LKg/WqLSCYph1F15nAeKOb
hKJkSf7g9rrgz5Kd6bf7IVa8ckdh0q1Mtr+XeYe6ubKpB2BM1LE=
=L4Bm
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
