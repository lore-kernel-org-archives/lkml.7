Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C6CCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 241EF21D7F
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572015385;
	bh=aF6JPZTJ/gBdIJwVCjuZWdvm5qo4nqf8GBjBjU4VHfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rSw/eTDyWgvlnkP8hrDYii97mR5fYHC6NB5n6iBdHvfSlGgZYX4mBOX7pdKUFa5aS
	 HxuSMEhHSu5sdcWmfExo0QVRTMrnWyKZ05/jDpMptWb9ljIoHehbDHruSMlkKKa4wA
	 V8fp7HqDbkfdyQtKVqglOPHOrom8TA+DXob5LuMk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440534AbfJYO4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 10:56:24 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35222 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440507AbfJYO4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 10:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aF6JPZTJ/gBdIJwVCjuZWdvm5qo4nqf8GBjBjU4VHfM=; b=KhSrz89GlOX23Pdcc/m/CEld3
        js2tGCBFwjdMJJ34KizZkriCuEs4NYx5Ro5d1rNJ46rh8JBbTBv6pFyOMal5DlyU5GMO4Y0rIho2S
        bxS3FKE8dzctMQEiLrCHnnYT5RqBoJcg0csb+wB6zSoSWXrJOd9CcxKeM9J0iHNnbCQFg=;
Received: from host86-174-61-171.range86-174.btcentralplus.com ([86.174.61.171] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1iO10k-00075b-CM; Fri, 25 Oct 2019 14:56:18 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id B0C42D020AD; Fri, 25 Oct 2019 15:56:17 +0100 (BST)
Date:   Fri, 25 Oct 2019 15:56:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     daniel.thompson@linaro.org, arnd@arndb.de,
        linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, baohua@kernel.org,
        stephan@gerhold.net
Subject: Re: [PATCH v3 10/10] mfd: mfd-core: Move pdev->mfd_cell creation
 back into mfd_add_device()
Message-ID: <20191025145617.GI4568@sirena.org.uk>
References: <20191024163832.31326-1-lee.jones@linaro.org>
 <20191024163832.31326-11-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NzX0AQGjRQPusK/O"
Content-Disposition: inline
In-Reply-To: <20191024163832.31326-11-lee.jones@linaro.org>
X-Cookie: Keep out of the sunlight.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NzX0AQGjRQPusK/O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 24, 2019 at 05:38:32PM +0100, Lee Jones wrote:
> Most of the complexity of mfd_platform_add_cell() has been removed. The
> only functionality left duplicates cell memory into the child's platform
> device. Since it's only a few lines, moving it to the main thread and
> removing the superfluous function makes sense.

Reviewed-by: Mark Brown <broonie@kernel.org>

--NzX0AQGjRQPusK/O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2zDRAACgkQJNaLcl1U
h9DO/Af/VagCkEQfGNe1Ncjxx+a7IFEhDSC4yzx8fMlWxETMK9yPwOBSBkR89NQZ
pzaIK3X35Zh9LM/H8ptRf7FeKzJ8BeO3j0ck1uCAcJrvT3O4vzso8kdC1jwVQ/O0
hHd/+39lnnDfsP3OhZjMtAGu9EZy9klwIrHmj7PKXtJ2Cn3jXUlb4qUSBujNtEHY
TXtxGhUrHPpJBEjchkG/36VYbRhG241EBxxPriQ5vRC5dm4YIbdpkeiYLQhB0Js2
tYQPsXSkGg7flTuGEtPZMhKXHt2TnzzKPmUcK3R4ikyCvO8Lt9g6VDIUiaeRM+jS
wb1JBPSFwuy5dYVsQ9L1Til/GDq6Aw==
=LFpK
-----END PGP SIGNATURE-----

--NzX0AQGjRQPusK/O--
