Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D35C33C9A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 09:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B770F21734
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 09:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578301429;
	bh=3AZoB5lzq7P9xtp5x7IB8Ry3pqmrEZMSxIru7I6Mayw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qAHALIZ4lZlecr4V17yBl1B7fFUSoZkGH4SFbKJhz5xatbCxWEkxTeGmtpFutFMVw
	 xH6RAl304h/qnXAAvVvl/dMeJ6OOzvHQ3YQxzyWcyweswggcxzTfPNGYKba9GiAeod
	 Ull5yYlEj4rqWeBjwKtmbDKe9E+p2z/FzWxfFJbE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgAFJDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 04:03:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:40526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgAFJDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 04:03:48 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 180B420848;
        Mon,  6 Jan 2020 09:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578301427;
        bh=3AZoB5lzq7P9xtp5x7IB8Ry3pqmrEZMSxIru7I6Mayw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TFdhnAj6rBK3Po0t2XoT3/A4g80GoPtZw8KMSnGYkUvUlhLmhQZl+8pWIy0S3Pai3
         VMDuZpbn0KigLOlyW851x3P+wJOgnmiNJE7iKhdOW8wV3EFzHzvu4EVZM1N9iKn3Di
         XkpfD3pQ26VjyK8eUkv8vLThmC399+j6YbVaVCWI=
Date:   Mon, 6 Jan 2020 10:03:44 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: allwinner: h5: Add Libre Computer ALL-H5-CC
 H5 board
Message-ID: <20200106090344.wlqwlhnshj7c5j6q@gilmour.lan>
References: <20200106085820.7082-1-wens@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wopthskqafqpdmgu"
Content-Disposition: inline
In-Reply-To: <20200106085820.7082-1-wens@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wopthskqafqpdmgu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 06, 2020 at 04:58:20PM +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
>
> The Libre Computer ALL-H5-CC board is an upgraded version of the
> ALL-H3-CC. Changes include:
>
>   - Gigabit Ethernet via external RTL8211E Ethernet PHY
>   - 16 MiB SPI NOR flash memory
>   - PoE tap header
>   - Line out jack removed
>
> Only H5 variant test samples were made available, and the vendor is not
> certain whether other SoC variants would be made or not. Furthermore the
> board is a minor upgrade compared to the ALL-H3-CC. Thus the device tree
> simply includes the one for the ALL-H3-CC, and adds the changes on top.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
Maxime

--wopthskqafqpdmgu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXhL38AAKCRDj7w1vZxhR
xQN7AQDvYzlQWw3vCLjwH1x+5WWoSKJTHRA94foaIILZoivGfAEApMPC1Zqmqddk
ZuBHerNDSThxQgHT2dRhQg380OuJKQM=
=CUUd
-----END PGP SIGNATURE-----

--wopthskqafqpdmgu--
