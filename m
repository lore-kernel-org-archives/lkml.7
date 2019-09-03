Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47774C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A1B422CF8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567509110;
	bh=XV8/zx6g8/AyT8+mhJ3ErDDqQNVTJnFz4VFatasleQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ehp/QR17RY9DYbffwS/zWGLr3X50OsJIAEKucxxDnsQtjvR7pjBj7PXKWkwUqqdFU
	 cZN1Wz9atg61UkAMcebcIZMBiQiuKe0MYM0iocV6iQthm/2trZ6Edp9SVuGf1tCgGY
	 xFTxYgKTQsjNW6wXvrbk4fpU4qCzUtl5upmsiR6E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbfICLLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 07:11:48 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60166 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfICLLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 07:11:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=argzVRzEFGHYFQGslpYsGNYzeGLhmYgxsVk0qESpcFs=; b=KRtF4qyyrckBy6LvG/OfuR/yD
        q0f225FApjOQ1n6sOGWqYVrIxkUDW0Lft7ypc7AFuKKvN7CgqMAbmlC6T5HxNtSuflXp3++C/2lLr
        aTNA8zWHeBFrmjj0jowjC1kwcZAS0FJZQoZADL4f3rwb8pM4SUKXLAt62pp01iGhNn4tQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i56ip-00083y-67; Tue, 03 Sep 2019 11:11:39 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 4BC7A2742D32; Tue,  3 Sep 2019 12:11:38 +0100 (BST)
Date:   Tue, 3 Sep 2019 12:11:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     David Yang <yangxiaohua@everest-semi.com>,
        Daniel Drake <drake@endlessm.com>,
        Hans de Goede <hdegoede@redhat.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] ASoC: es8316: judge PCM rate at later timing
Message-ID: <20190903111138.GA6247@sirena.co.uk>
References: <20190831162650.19822-1-katsuhiro@katsuster.net>
 <20190902120248.GA5819@sirena.co.uk>
 <1a3c5934-4731-d474-e9d5-795e8337b180@katsuster.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <1a3c5934-4731-d474-e9d5-795e8337b180@katsuster.net>
X-Cookie: The revolution will not be televised.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 03, 2019 at 04:19:10AM +0900, Katsuhiro Suzuki wrote:
> On 2019/09/02 21:02, Mark Brown wrote:

> > The best way to handle this is to try to support both fixed and variable
> > clock rates, some other drivers do this by setting constraints based on
> > MCLK only if the MCLK has been set to a non-zero value.  They have the
> > machine drivers reset the clock rate to 0 when it goes idle so that no
> > constraints are applied then.  This means that if the machine has a

> In my understanding, fixed and variable clock both use set_sysclk() for
> telling their MCLK to codec driver. For fixed MCLK cases we need to
> apply constraint but for variable MCLK cases we should not set
> constraints at set_sysclk(). How can we identify these two cases...?

Like I say it's usually done by settingthe MCLK to 0 when not in use and
then not applying any constraints if there's no MCLK set.

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1uSmcACgkQJNaLcl1U
h9BHBwf/URm9L7YnJCv+tUQB+bbOzUTiUQOR23hSvxTvO+aMMjXRaNFKTTj+1ZV4
h876xX+RykF8GgLvEOKMdkcmbk0UHdpj350OOLBI/8LQ3Ir/FhSHk1FVV4KM+n2V
hYBfz48cTj39UvNutOrZu7YdAG2zT3e6zgtIH3qMNj+E0CP2Xr+5qggA6QPo3d44
erXRwSRS94Og2G1bKm+Zm9wF7w/JJA766ige3ROWWgpZ+TF/QkZIlv2wczUha1U3
qFcgjJymaUV2D7RAF7R1MqlvAFSc9gqommoGhN3SebKsDt1lF2zH0sFkAqjQ1LDg
V1ET11vnqFz1nqWhMYfbcR4i1A3ofw==
=2Fmo
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
