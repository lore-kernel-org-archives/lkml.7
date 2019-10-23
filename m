Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BD2CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 15:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4942721872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 15:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571843492;
	bh=MhzK8x9mtdjy+1jbzsWgerLiUT1hDR2tM/Gu+/kM7aU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TNpm0OWxuLJDkOJ0Q0ucNgYv9iD87F4IrZGzQPr40yDHbpIreohuvIS3rQZBAa3pm
	 1CjdbiFPGD5GayqoRGYrnm12l96+fr5I4JtTrS83zx2FGdnWYBKKdtrvgzdyxNu10M
	 GP+bDBsSt17vCi5Uz21xOioa56nCFMQHPx3CBW20=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392423AbfJWPLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 11:11:31 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48410 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390450AbfJWPLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 11:11:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PhqiM7k8Nuof6KgmdrlTPjIEr+PxrVC9EYrr77F4vhg=; b=JMaBWX29MUdVV8baiU7Nevbin
        qCw2GM3znvT01YwVCdtTXNKQxEV+c5AOrp7J9/YXLTn6OYmG/ZuP7COlZkW/RySoyImpQcofp7DSt
        FhDfOtLOA2iI6rZwfpQyko/4xUr1AF+QgytABppp69cbMC+W3SrOoWqAKveQOfgwlwHzA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iNIIE-0000pA-Ae; Wed, 23 Oct 2019 15:11:22 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 64951274301E; Wed, 23 Oct 2019 16:11:21 +0100 (BST)
Date:   Wed, 23 Oct 2019 16:11:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Luhua Xu <luhua.xu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com
Subject: Re: [PATCH 1/1] spi: mediatek: add power control when set_cs
Message-ID: <20191023151121.GC5723@sirena.co.uk>
References: <1571834322-1121-1-git-send-email-luhua.xu@mediatek.com>
 <1571834322-1121-2-git-send-email-luhua.xu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="L6iaP+gRLNZHKoI4"
Content-Disposition: inline
In-Reply-To: <1571834322-1121-2-git-send-email-luhua.xu@mediatek.com>
X-Cookie: MMM-MM!!  So THIS is BIO-NEBULATION!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--L6iaP+gRLNZHKoI4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 23, 2019 at 08:38:42AM -0400, Luhua Xu wrote:
> From: "luhua.xu" <luhua.xu@mediatek.com>

> Use runtime PM to power spi when set_cs
> As set_cs may be called from interrupt context,
> set runtime PM IRQ safe for spi.

Why might we be trying to set the chip select state while the device is
runtime idle?  It seems like whatever is trying to set the chip select
should be dealing with this, not the chip select operation itself since
that's unlikely to be happening in isolation.

--L6iaP+gRLNZHKoI4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2wbZgACgkQJNaLcl1U
h9ATSQf+OUsqd9lrmv01u0bHiJLMN7oKTLAH9rbukbP246Gj/NJZHv9XEa4/EIG+
PrOIpiUSATTLRjt0aOjWURk0NVAazV0jwYPnXYRkH/kfMQB9Ix7DL9N3fL8munYX
zQm8Ec+DPhLw9B+g+lqoJe22GgsC+68vBXMTUNrFSvOT+yiuuI3452HBWEhGugX/
BGZm/N7Vw25js2S62hMg0PTy0GRbjjdX1GNBhofOefbVBuFcZsVbcfkKNNDFgxUs
Ye6/kVYIiHbQWTjsuiVGhshWe7AM3/MpzohQBr+csZUSxJjEI+TLAYzBMVjE4tc/
tVV/VzlC14zM1pODYKEoGhOsluhPJQ==
=eE5N
-----END PGP SIGNATURE-----

--L6iaP+gRLNZHKoI4--
