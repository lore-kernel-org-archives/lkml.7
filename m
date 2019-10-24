Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32E2CA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83ADC21872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571915968;
	bh=BSU9ShKnANqrP7yC2NELEyHuN8gCnTBsrG24ZTeZW9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=au8TZC2rk6FXvpcg5N4CV+wC0n7y+H127sh2os2cj4WhV7bp8P7KZmJSDbv7WsHYX
	 /nG+DJcnTqs96ITVLJ8F1oebGyZPTUj6sSv5+o94I5Sv1ywrP8ZXCxqhDHbLrhb9YK
	 Wsyf/FQQSl63A5mKFb4VZfEz7hE3jvSDOZO10Ygw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408169AbfJXLT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 07:19:27 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45338 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfJXLT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 07:19:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hUs9kMq2mPKrvQvT9q8/NbtkacnaWsd9kl1JMDd5J94=; b=bToP3Jv6SYLOWPs8MpGvMY/7b
        QlU0Vud00Dhl6l38d8K/x24mvL/5ht+Vp+HEBgiIqZbmROeCQfEUXB/+VN69SL+AAE6LfllZnNrpJ
        Ahf4DmCYGOH5ogZrZlLYf4ws05t6N3zef9TZdfypJeP6ZLlTKcBoYWg5ovesxygdyu6gg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iNb9G-0003Np-7N; Thu, 24 Oct 2019 11:19:22 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 263F7274293C; Thu, 24 Oct 2019 12:19:21 +0100 (BST)
Date:   Thu, 24 Oct 2019 12:19:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     luhua xu <luhua.xu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com
Subject: Re: [PATCH 1/1] spi: mediatek: add power control when set_cs
Message-ID: <20191024111920.GE5207@sirena.co.uk>
References: <1571834322-1121-1-git-send-email-luhua.xu@mediatek.com>
 <1571834322-1121-2-git-send-email-luhua.xu@mediatek.com>
 <20191023151121.GC5723@sirena.co.uk>
 <1571898319.4311.3.camel@mbjsdccf07>
 <1571911880.4955.11.camel@mbjsdccf07>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="T6xhMxlHU34Bk0ad"
Content-Disposition: inline
In-Reply-To: <1571911880.4955.11.camel@mbjsdccf07>
X-Cookie: What foods these morsels be!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--T6xhMxlHU34Bk0ad
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2019 at 06:11:20PM +0800, luhua xu wrote:

>       (3)Enable spi clk  in  controller->set_cs  callback,  such as
> spi-geni-qcom.c.   =20
>       My patch works the same as (3).For mtk platform, without this
> patch, if user do spi_setup(), cs setting cannot take effect, and reg
> access violation occurs.

Other drivers having problems isn't a good reason to introduce more
drivers with problems.

--T6xhMxlHU34Bk0ad
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2xiLgACgkQJNaLcl1U
h9A/Kwf+IpDhddKQiCGZu0Oyc2g59QHLKn2G271BZAq1tw3Rnnj/s4VqQkyLn/SJ
Spw/eC2ufhZI8/CblwrL5cwx6flAbfOi1EdLDdA26qGeWwso/Qxu2odY24OvV/8M
MZaXuDfYonJssSVXw1ri90G4mkXtMzzVxb4UoA5ssi3UF2JkZWcZ4ePaK3buteIf
lwvnDj4gNJYKDnZcz/wpTbrZoKWTAn2IjthZh2AlDFPCSZx/I0wJ2yU7rWYzS84H
rMbflX/QGmgPTfTtep+TIy2xTqLYGS/7Up7n0F0SLcOdDXCpK+Jo4lNJoeB75Q7Y
zHXfh3e//9ZULctc7j/NvX/TUeanyQ==
=vrlq
-----END PGP SIGNATURE-----

--T6xhMxlHU34Bk0ad--
