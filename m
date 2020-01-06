Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F4EC32771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 08:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7C102465E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 08:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578300723;
	bh=E+6+jXxqoUF8JBv1qsja8+TZpcYAmNNZ5HQDABfvKuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KEMsgoRUOYMqmOdGAA3CJ/UDIn2zxzCbMMSPysLa+Yz2g9Oz1Okw5jdUURAzMSZOz
	 JfBAHKHjR34oeKCL7CT9nsEDxYMHaMc6x3loZ2prGOqVzu6xMcU114+9sbUZU9KG5V
	 6nk15x1HKlaeHkialB3zhMMRvOAHJ7/Svywm7mg0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgAFIwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 03:52:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:57294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgAFIwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 03:52:02 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C12BE20848;
        Mon,  6 Jan 2020 08:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578300722;
        bh=E+6+jXxqoUF8JBv1qsja8+TZpcYAmNNZ5HQDABfvKuI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h4xlslVdQiv8N7fhoPP8JaP1b9TB5P6wsd2h1uTZhbj6lyDVHVZ+WMhTITIGHQLuQ
         60WtDtaXaJXoqrGGifMzcOYrMX54CAUZKQR3hmCsLrSFYvf/l3v40R3HgK7XW57zO/
         ZBUDURZ8mB6nyLnIqnrs6aRuRuzkGsa5swSDFxP4=
Date:   Mon, 6 Jan 2020 09:51:59 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] dt-bindings: bus: sunxi: Add R40 MBUS compatible
Message-ID: <20200106085159.oirhyvxov6c4lzs6@gilmour.lan>
References: <20200106084240.1076-1-wens@kernel.org>
 <20200106084240.1076-4-wens@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fzzjkvck4wgddh6g"
Content-Disposition: inline
In-Reply-To: <20200106084240.1076-4-wens@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fzzjkvck4wgddh6g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 06, 2020 at 04:42:36PM +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
>
> Allwinner R40 SoC also contains MBUS controller.
>
> Add compatible for it.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

--fzzjkvck4wgddh6g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXhL1LwAKCRDj7w1vZxhR
xWpOAP4whnttbvE2hfVbsNwjE7RNPqRTYADXuBxx1mgcnvmu2wD/XEaXL0cTGKKp
YA8JcPr/DbtfRVazD96m/sWxWyu/UAQ=
=z178
-----END PGP SIGNATURE-----

--fzzjkvck4wgddh6g--
