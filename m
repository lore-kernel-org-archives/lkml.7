Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4535BC28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 10:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E58E214AE
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 10:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="AJxQgB9I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfFHKYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 06:24:31 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:54298 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfFHKYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 06:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1559989469; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w3rZE9BJ6KZXA1Xlh+CLSTAVP0jC40SGcntIVXjMdFk=;
        b=AJxQgB9IAOiUj/O82HTtRcWBdoRbygdau3nQ5iw2VWjXJuuJLRrdhkDnBhoPhDDzdLIwqH
        Bb3YiboMj0cKoFJSVNMYt5UwOfRd488v/C97bxWrwzAAugSpV4peJfdrszgzjDWHlmAFlQ
        TqYDI5Rhxx6wO2RdCk4dHVHtnECuELc=
Date:   Sat, 08 Jun 2019 12:24:25 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/3] ASoC: jz4740-i2s: Make probe function
 __init_or_module
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     od@zcrc.me, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Message-Id: <1559989465.1815.8@crapouillou.net>
In-Reply-To: <20190607161500.17379-1-paul@crapouillou.net>
References: <20190607161500.17379-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I misunderstood what __init_or_module was for. Please ignore this=20
patchset. Sorry for the noise.


Le ven. 7 juin 2019 =E0 18:14, Paul Cercueil <paul@crapouillou.net> a=20
=E9crit :
> This allows the probe function to be dropped after the kernel finished
> its initialization, in the case where the driver was not compiled as a
> module.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  sound/soc/jz4740/jz4740-i2s.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/sound/soc/jz4740/jz4740-i2s.c=20
> b/sound/soc/jz4740/jz4740-i2s.c
> index 13408de34055..1f596770b01a 100644
> --- a/sound/soc/jz4740/jz4740-i2s.c
> +++ b/sound/soc/jz4740/jz4740-i2s.c
> @@ -492,7 +492,7 @@ static const struct of_device_id=20
> jz4740_of_matches[] =3D {
>  MODULE_DEVICE_TABLE(of, jz4740_of_matches);
>  #endif
>=20
> -static int jz4740_i2s_dev_probe(struct platform_device *pdev)
> +static int __init_or_module jz4740_i2s_dev_probe(struct=20
> platform_device *pdev)
>  {
>  	struct jz4740_i2s *i2s;
>  	struct resource *mem;
> --
> 2.21.0.593.g511ec345e18
>=20

=

