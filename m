Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800D0C48BE0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 12:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 553AA2084E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 12:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561118786;
	bh=6Xy5QXXBwxgPq6XWIndAOwXvjNxtgD83yFkqktAytVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1jmJiO571kFxkGkUE3w6Kuzc/TI0D6luK4lQmRHyychzPDzg3HovX9BIpFlfzYT+L
	 XJqjrj86LrqHXxTnpII9CYse1H5PGfNjnf4gPTtLN9ZSqCyyoDPNyz7v1Gccqx07xK
	 d5p44Aah0huGthdUMzONqn71JYh2w7QBp6DIrnWk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfFUMGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 08:06:25 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46148 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfFUMGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 08:06:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6Xy5QXXBwxgPq6XWIndAOwXvjNxtgD83yFkqktAytVU=; b=sk+VLDjQ4XzED7IkqO695oVfl
        bwg3tzlU1zAZDGoE4t1NXUU64XCbmYfAcTrjgXz4JiU8VdvyR6RV9cJ+jJeqTwh3fjk5M4CsKSpsJ
        gDpUV1VVVPh21eb2ty1LnJhgKs8wU7C9PWClMZES13+IinHVnUuu53h4fA57Oun8/SUmQ=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1heIJ2-0002R1-5K; Fri, 21 Jun 2019 12:06:12 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 3689A440046; Fri, 21 Jun 2019 13:06:11 +0100 (BST)
Date:   Fri, 21 Jun 2019 13:06:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Waibel Georg <Georg.Waibel@sensor-technik.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Subject: Re: [PATCH] gpio: Fix return value mismatch of function
 gpiod_get_from_of_node()
Message-ID: <20190621120610.GG5316@sirena.org.uk>
References: <1560938081892.33415@sensor-technik.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3d1h++6StbrqEHAg"
Content-Disposition: inline
In-Reply-To: <1560938081892.33415@sensor-technik.de>
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3d1h++6StbrqEHAg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 19, 2019 at 09:54:48AM +0000, Waibel Georg wrote:
> In case the requested gpio property is not found in the device tree, some
> callers of gpiod_get_from_of_node() expect a return value of NULL, others
> expect -ENOENT.
> In particular devm_fwnode_get_index_gpiod_from_child() expects -ENOENT.
> Currently it gets a NULL, which breaks the loop that tries all
> gpio_suffixes. The result is that a gpio property is not found, even
> though it is there.

Acked-by: Mark Brown <broonie@kernel.org>

--3d1h++6StbrqEHAg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0MyDIACgkQJNaLcl1U
h9Ce/gf/YPxi8n+w5bYAPtpy4hSIHZ/x4vLS/FxaCkM3TdPBix4ZZyClGg1pQMb3
/VzCXGrjhUGQ7SRmqEAPKnzhZZsPU7QwbMOWwdM6s0tNeTL3qR6s1ZupYXSo3M8P
X62jCDKfmUFr7ilslBjtgljbsw95j5b5qKBt3rCnsvQP7zYR4go8NLxYD0hrPK2Z
hnZherbhbmIZo1Dn5n0rpdK7Ci3mXR3E7Mt/qHVHgCR43xHk1QPIChvzzoC/G05Z
Sz34TnSTJo2qukyYhzL7ThMpaVxgkUKSTGZJsT/p79oO8OHpRrW3QVvoRp9dj2cY
bYGkcmlParaEOWVxkdXg2j3i4NNbLw==
=cGhj
-----END PGP SIGNATURE-----

--3d1h++6StbrqEHAg--
