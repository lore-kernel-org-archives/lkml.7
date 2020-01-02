Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FCEC3276D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 09:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA6CA21734
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 09:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577957431;
	bh=ph0Q4sVVHmPTWO2WvokDdOrhzisfVS7J7uED9CccCzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=umGW7NZ/Avp7LFPfaULa7uzJIIPjK+VERDqOUImHesKkB81mWrHNN5HqedxLrYBKL
	 kBWzB6viK7T70BlDoxpTztpW0fWwEZzFV1XX9IxdKeuwztGnRCLKZWYR6LRoEbTqAs
	 F6HeQC5acvRLStAYFSo1Lteg67HdLfDBeZsL50E0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbgABJaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 04:30:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:55522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727801AbgABJaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 04:30:30 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85A8520866;
        Thu,  2 Jan 2020 09:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577957430;
        bh=ph0Q4sVVHmPTWO2WvokDdOrhzisfVS7J7uED9CccCzc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=onBLeU3oBuFFk4MiR7WjNJBfnnVybOzgnmvvy8pL05HxVM/WZYxBG8kURNqU5HGNl
         9miZ9isKVzDm3b1D9Boy31+TFfplbz8Fpszr0dCEjmwY9yUtUmWYorzQDaGYoPuwGg
         ea/wVmGa/RFKpbXZjwO4PTDLKF1IZlIhU2NQ4Rj8=
Date:   Thu, 2 Jan 2020 10:30:27 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     linux@armlinux.org.uk, wens@csie.org, catalin.marinas@arm.com,
        will@kernel.org, clabbe.montjoie@gmail.com, plaes@plaes.org,
        shawnguo@kernel.org, olof@lixom.net, Anson.Huang@nxp.com,
        dinguyen@kernel.org, leonard.crestez@nxp.com,
        marcin.juszkiewicz@linaro.org, aisheng.dong@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        anarsoul@gmail.com, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, p.zabel@pengutronix.de,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: sunxi: Enable CONFIG_SUN8I_THERMAL
Message-ID: <20200102093027.tfs7qde2bnen7wnj@gilmour.lan>
References: <20191229111707.16574-1-tiny.windzz@gmail.com>
 <20191229111707.16574-2-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xq3543oi35jh4lug"
Content-Disposition: inline
In-Reply-To: <20191229111707.16574-2-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xq3543oi35jh4lug
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 29, 2019 at 11:17:07AM +0000, Yangtao Li wrote:
> Many sunxi based board needs CONFIG_SUN8I_THERMAL for thermal support.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Applied both, thanks!
Maxime

--xq3543oi35jh4lug
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXg24MwAKCRDj7w1vZxhR
xddIAP4kjfpx7F958ZqZ38Qsbux5R89DGxYs7EJiKjlaK3GHDQD/cYwNoqMtuwGe
Mn0/B8dq8QAx9w6gXPQn9yaaWgdQdAQ=
=tpOZ
-----END PGP SIGNATURE-----

--xq3543oi35jh4lug--
