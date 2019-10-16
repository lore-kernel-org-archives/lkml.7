Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91CEFA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B468E218DE
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571237391;
	bh=TVHkTQZcT9q9ZjJzYOSkolVYYuNP2y6v7NQ51/mM5q8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hbdYdGsXOCJJk/SfgZ9Y0TGO9WauSkhFIIWmowKkWK+zHRjjtKXfeGpNrCHnadQo2
	 tdwrJY5j2s3IFfw+uahOjB01y2XNVYUKWecKt8Cogc71NI2C2ZbPKmSs3fvcBoEW0m
	 XmwwdkaUtszvvarlZFKFn8hKEgil3TlWXm6fKk/A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390237AbfJPOtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 10:49:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:33984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730251AbfJPOtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 10:49:50 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 022C32168B;
        Wed, 16 Oct 2019 14:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571237389;
        bh=TVHkTQZcT9q9ZjJzYOSkolVYYuNP2y6v7NQ51/mM5q8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bcf31tblggd+MJJkjJ9MWL3/6Xm57VNAYnvAEXEXu/qG9MTqKIwOaCCRWRD6tCt+u
         pUnsMBBBwSJMxdN+D/t5cMU9aJACRsrTR5piIFe6N4GEmJ1uGCotm3uyYDWh+9v5lN
         GO/aBm+6T/Z1kI0UaQXd3CDgadNWxjpsme7Jfbg8=
Date:   Wed, 16 Oct 2019 16:49:46 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        wens@csie.org, alistair23@gmail.com
Subject: Re: [PATCH] arm64: dts: sun50i: sopine-baseboard: Expose serial1,
 serial2 and serial3
Message-ID: <20191016144946.p3tm67vh5lqigndn@gilmour>
References: <20191012200524.23512-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="n5scbjei5snz6qva"
Content-Disposition: inline
In-Reply-To: <20191012200524.23512-1-alistair@alistair23.me>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n5scbjei5snz6qva
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Sat, Oct 12, 2019 at 01:05:24PM -0700, Alistair Francis wrote:
> Follow what the sun50i-a64-pine64.dts does and expose all 5 serial
> connections.
>
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  .../allwinner/sun50i-a64-sopine-baseboard.dts | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> index 124b0b030b28..49c37b21ab36 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> @@ -56,6 +56,10 @@
>  	aliases {
>  		ethernet0 = &emac;
>  		serial0 = &uart0;
> +		serial1 = &uart1;
> +		serial2 = &uart2;
> +		serial3 = &uart3;
> +		serial4 = &uart4;
>  	};
>
>  	chosen {
> @@ -280,6 +284,27 @@
>  	};
>  };
>
> +/* On Pi-2 connector */
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart2_pins>;
> +	status = "disabled";
> +};
> +
> +/* On Euler connector */
> +&uart3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart3_pins>;
> +	status = "disabled";
> +};
> +
> +/* On Euler connector, RTS/CTS optional */
> +&uart4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart4_pins>;
> +	status = "disabled";
> +};

Since these are all the default muxing, maybe we should just set that
in the DTSI?

Maxime

--n5scbjei5snz6qva
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXacuCgAKCRDj7w1vZxhR
xakUAQDKMLPFYrXgJoIqujk/rfbeUS2P3a0rGnGDrfrvSZkCMAD+JRTAJwfGyT0T
0GAa8ejfAZiZ2/8OCoW/Y++QrQ3JhA4=
=Q2Sd
-----END PGP SIGNATURE-----

--n5scbjei5snz6qva--
