Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BFBC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 388682133F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="BM4EX49b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbfFZOcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 10:32:01 -0400
Received: from mail.kapsi.fi ([91.232.154.25]:37557 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727323AbfFZOcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:32:00 -0400
X-Greylist: delayed 1205 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Jun 2019 10:31:59 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=MIME-Version:Content-Type:Date:Cc:To:From:Subject:Message-ID:
        Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=keTA49kcFTmiW+xDiXyC1TWyuwYvwy0XCF0h+Kehxjk=; b=BM4EX49b7qlwytNWNpmgO9+Y8M
        1GD3OyaUVCs1KegazXc1JsEeeRq8VErYh3GpA+lPa2UNikAlX5HSzmyHgcMqXB9R7QlDAeuMYf6Vf
        LYRCo3j3hPdiScV9T4RNBdNgKSSThOGV5U+VnFU9RNFKtOcA9Ds+R5VE8WGujYvxfB62ZKXa5tUvO
        nJAXaN+x65x8Kl6t870yr7I5H2Mdc5HzyIQnhkkSMtE4NIwIqBe4fdoUyUASVgcXzXbAP9TGMVtgw
        yLV+EZhzkDfcOndj+O+LYQkqfNS1Zh5l/ElaZLeijv3vK5C+c6lZqpHBU0tmlhecKm2/uBoiBQ8Hq
        icSvWITg==;
Received: from [2001:999:82:7295:8199:173e:7dbf:6fc5] (helo=jsakkine-mobl1)
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <jarkko.sakkinen@iki.fi>)
        id 1hg8eO-0006dp-Ug; Wed, 26 Jun 2019 17:11:53 +0300
Message-ID: <c9c1e7f83a55bc5fb621e2e4e1dab90c5b3aac01.camel@iki.fi>
Subject: On Nitrokey Pro's ECC support
From:   Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 26 Jun 2019 17:11:46 +0300
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-5zfw+oGv//ZvawvgHwv9"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:999:82:7295:8199:173e:7dbf:6fc5
X-SA-Exim-Mail-From: jarkko.sakkinen@iki.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5zfw+oGv//ZvawvgHwv9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

I was getting myself a smartcard stick and looked for options from [1].
The documentation says that Nitrokey Pro does not support ECC while it
actually does [2]. I was already canceling my order when Jan Suhr, the
CEO of that company, kindly pointed out to me this.

[1] https://www.kernel.org/doc/html/latest/process/maintainer-pgp-guide.htm=
l
[2] https://shop.nitrokey.com/shop/product/nitrokey-pro-2-3

/Jarkko

--=-5zfw+oGv//ZvawvgHwv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRE6pSOnaBC00OEHEIaerohdGur0gUCXRN9IgAKCRAaerohdGur
0kmSAQDB06lSbBGO3TqrgxTFhdezWcVxXl9lJ9kdDIu4kR1b8wEA3IQKv9+KGXoN
HrGHyxmcchSzm03XAKFzO+r17q5+aAw=
=+ngF
-----END PGP SIGNATURE-----

--=-5zfw+oGv//ZvawvgHwv9--

