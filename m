Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E11C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4284F2084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554104269;
	bh=9PI20ABRGAX6xgvkQO8THWSWNw21WhgwxePzfgRfUlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1gL663PXhRc2E2zXXuAP5Mv/G21XrLy3f33LfMCBTC/8rBIh98vjaJEf/KzZdeAxN
	 vEWaVVeAjbQtABWjxvCEs+6Y+Y14LsyskDUmlp57llce19ZLA+krUzbNS8nwKajIHa
	 w1H4WVsjGUpobKFxvyh0+7jY77VCtJJr9EFf7uag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731957AbfDAHhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 03:37:48 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45424 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731769AbfDAHhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 03:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QsHyMZioDLzr+1d8u8zH8WO4Ys7dvTYpXPrQeb0FPHI=; b=b3A6HaxcwLNhxinCa2V2A0NbE
        SRCYYL0Dk/vqqZTpj0IFvgO058zNebOEn8Xj6dYuSQjnsMA2WhaPyE5I2hZ1PhrtZmd5nklbOg2lf
        2gjPlvncvuOd+kAY/Jdk11yzcDHOHJjcEo74hwvxJRMiQ8fmGtoy334lvqENv9IeB3hrk=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hArVc-00087A-4T; Mon, 01 Apr 2019 07:37:32 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 99D1B440082; Mon,  1 Apr 2019 08:37:23 +0100 (BST)
Date:   Mon, 1 Apr 2019 14:37:23 +0700
From:   Mark Brown <broonie@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, talho@nvidia.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kyarlagadda@nvidia.com,
        ldewangan@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V1 19/26] DT bindings: spi: add spi client device
 properties
Message-ID: <20190401073723.GH2059@sirena.org.uk>
References: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
 <1553666207-11414-19-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h3LYUU6HlUDSAOzy"
Content-Disposition: inline
In-Reply-To: <1553666207-11414-19-git-send-email-skomatineni@nvidia.com>
X-Cookie: Use extra care when cleaning on stairs.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h3LYUU6HlUDSAOzy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 26, 2019 at 10:56:40PM -0700, Sowjanya Komatineni wrote:
> This patch adds below cs timing properties to allow SPI master configuring
> setup, hold and time interval between two SPI transactions to meet specific
> SPI client device requirements.
>  CS setup time
>  CS hold time
>  CS inactive delay
> DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
> 	t=1553666253; bh=TbJVgRAIkjok3TkKNkfcvYc4WGyZhOpiH6sUZvadGrQ=;
> 	h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
> 	 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
> 	 Content-Type;
> 	b=Tud9guY5XCzkjKA2k2n0+xO/vTfMTNhH1e0viAyYmlgoG/j+uSBAAmOeZucVUlmEa
> 	 rwqxlSm+rkYMUfgSWqmJXqEjgRIAqMhA32FOJmhgpblGwYUR22hnbdhbk4TcqMNsIO

Something got corrupted?

> +spi-client device controller properties:
> +- nvidia,cs-setup-clk-count: CS setup timing parameter.
> +- nvidia,cs-hold-clk-count: CS hold timing parameter.
> +- nvidia,cs-inactive-cycles: CS inactive delay in terms of clock between
> +  transfers.

Why are these being done as nVidia specific properties rather than
generic ones and why are these being configured in DT rather than by the
client driver?  If the devices have particular timing requirements for
chip select presumably that's going to apply no matter what controller
or system they're used with so it seems best to configure this in the
client driver and have an API that any controller can implement.

--h3LYUU6HlUDSAOzy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyhv7IACgkQJNaLcl1U
h9AEqgf/YoGQ0dATzvZWKHgwUBIvOTH/AvNUrsaqqDJPL+MuDNSk3AR3ABYp4iVw
4KXFTefhstBK8FL36SVtPHBREKKHdjjOZy+2TuyKAE/4h8yZ8+L95ilY8c3J/DIa
8FvTv+ACN95gjeHTt0rWvcX5BEHVfwNAmhbGgMChjno3kqr77jnJFt+XziSKsolc
Uhf6veVqDGRVIc7dgBjh1cR2O0iSDfiyN/1OOj1YXuCa57pge6c6T6K20uvO+WxA
wMQvPYEkyxJr7hCAvXrkXQOgLe7LI0jKgh8n0ftFVJD22gI1ykQ8LxFKdh7LM7Je
ULFzhu6rWw/4dOE1orrBUi1ffduWWQ==
=JrKD
-----END PGP SIGNATURE-----

--h3LYUU6HlUDSAOzy--
