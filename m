Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BCCC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 16:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0109B20863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 16:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574785646;
	bh=lsycWwVLMBQX+2olUenNQAufGZbjMZxM0wg2GgODZi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uz52MkzdaJrXKWGrAkfzKwivfZDBvbj5v87ndu3eG8VPSA88aQiu0gmLe7r/2DHaz
	 shD9470XLzFlEdww41NPvZNmId4gnoxYXj49+BZMbJcW/8CMEhmowzVJDvq8GITuAb
	 H71LXyxJqTSyRhfgkXlmlPiKW26SkFoAPeKlOmOc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbfKZQ1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 11:27:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:42556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727333AbfKZQ1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 11:27:24 -0500
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FE5320862;
        Tue, 26 Nov 2019 16:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574785644;
        bh=lsycWwVLMBQX+2olUenNQAufGZbjMZxM0wg2GgODZi0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mVc129KGwONqZlfcjKgKn/s3RnfMsjMPnSnShfcFgr9/TQs3j4NVIwdjcb50L8EpJ
         CHPxlI7uWH4PWJZBsQkbX07vLBctI6Kj2ZQuYlqxgfFCtwABRHpmaO5UKug6/t0lvj
         amEY5DsmnldMfat9dqYEGAt8vcwNzw/9yKIk1ayk=
Date:   Tue, 26 Nov 2019 17:27:21 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Stefan Mavrodiev <stefan@olimex.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 1/1] arm64: dts: allwinner: a64: olinuxino: Add VCC-PG
 supply
Message-ID: <20191126162721.qi7scp3vadxn7k2i@gilmour.lan>
References: <20191126110508.15264-1-stefan@olimex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="duhffbtvsspnw6ng"
Content-Disposition: inline
In-Reply-To: <20191126110508.15264-1-stefan@olimex.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--duhffbtvsspnw6ng
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Stefan,

On Tue, Nov 26, 2019 at 01:05:08PM +0200, Stefan Mavrodiev wrote:
> On A64-OLinuXino boards, PG9 is used for USB1 enable/disable. The
> port is supplied by DLDO4, which is disabled by default. The patch
> adds the regulator as vcc-pg, which is later used by the pinctrl.
>
> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
> index 01a9a52edae4..c9d8c9c4ef20 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
> @@ -163,6 +163,10 @@
>  	status = "okay";
>  };
>
> +&pio {
> +	vcc-pg-supply=<&reg_dldo4>;

The equal sign should have spaces around it.

Also, can you please list all the bank supplies while you're at it?

Thanks!
Maxime
>

--duhffbtvsspnw6ng
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXd1SaAAKCRDj7w1vZxhR
xXArAP9pNq5XxgsrXMmqOM0FNRQA+MWaUyrJ8bzIKdPtsY1+xwD8DA+PgzubuRzo
DT9smxFVEkQUm5d3dPI79hLwkAlgfAM=
=l4bs
-----END PGP SIGNATURE-----

--duhffbtvsspnw6ng--
