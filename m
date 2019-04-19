Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEB1C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F980204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbfDSS3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:29:39 -0400
Received: from sauhun.de ([88.99.104.3]:50784 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727768AbfDSS3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:29:36 -0400
Received: from localhost (p5486CC46.dip0.t-ipconnect.de [84.134.204.70])
        by pokefinder.org (Postfix) with ESMTPSA id AFC8A2E354E;
        Fri, 19 Apr 2019 20:29:33 +0200 (CEST)
Date:   Fri, 19 Apr 2019 20:29:33 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Raag Jadav <raag.jadav@einfochips.com>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i2c: at91: fix TXRDY interrupt spam
Message-ID: <20190419182933.24pdqa73iu7wz74c@ninjato>
References: <1555680298-518-1-git-send-email-raag.jadav@einfochips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qtvxrzjs5n7q77of"
Content-Disposition: inline
In-Reply-To: <1555680298-518-1-git-send-email-raag.jadav@einfochips.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qtvxrzjs5n7q77of
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> *************************************************************************************************************************************************************
> eInfochips Business Disclaimer: This e-mail message and all
> attachments transmitted with it are intended solely for the use of the
> addressee and may contain legally privileged and confidential
> information. If the reader of this message is not the intended
> recipient, or an employee or agent responsible for delivering this
> message to the intended recipient, you are hereby notified that any
> dissemination, distribution, copying, or other use of this message or
> its attachments is strictly prohibited. If you have received this
> message in error, please notify the sender immediately by replying to
> this message and please delete it from your computer. Any views
> expressed in this message are those of the individual sender unless
> otherwise stated. Company has taken enough precautions to prevent the
> spread of viruses. However the company accepts no liability for any
> damage caused by any virus transmitted by this email.
> *************************************************************************************************************************************************************

Your patch might be correct, but as a general rule we do not accept it
with a disclaimer like this. I mean we spread your patch all over the
world if it is accepted :) Could you ask your company to drop the
disclaimer when employees communicate with free software projects? Or if
it is OK with them if you use another email address?

Oh, and your mail had no To: header, please use the i2c-list next time.


--qtvxrzjs5n7q77of
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAly6E4gACgkQFA3kzBSg
KbZwBw/+M5rrKbDEcWUlL/kFHEr3e+Z6Ya64LulfpCSAgsalaufAUaOMcr88UQAK
40uTdyrGL+hnr1s2A9K9sGnkmKs0omrasWis26PYxyduVawzhCV/nXAS8RhlRFOA
ou6XOyh1Fey4otajXXQQUwOVJ9RvELYDxqx1f9Un1lhzTUx51glLt3BfxeukgckV
QUykOrJU4dEFwEOX8i8UZZk/MQS8d/x4SDMou/E8IKCHW3h34kTd4WT/z+9CVdgf
xtD7TZNEsJv0zf1vcCFY1xoTmJL8TWG9f/c2WVYXyMzyNn1fQDfs8Q57L5oDEz3y
1Swzt7ZjZTFRZ9Tc6jZVWP3yERk8+tCilKnuESbVyozrA6awyZYpA25nXjB9gozb
5LVAdWQnMrRnvT54NH2YZlflM4ST6BLajZmFOZ6EAOjUzLgFP1IZnP13Hs5tQjtg
xEvnA7kaNe24JJSXnqfRUyHBTCBDOh30BBGD5ccLEzkdqHauHLAa9bHF99HgeNp+
GFzPhOYXYZ6+5vfZhWQJb5UvyfQCBFgQeW2L8alNYZloPicn71Ecm/6oSKn547O2
PEgWmnz6345/nhnRpLsXAGX6INEEsxafSq+ClWAKn9aIce2BW/aS0LgvkWSFHI4U
QKcA7odUeK3/pMzIsT5VZfNSV7bUNX+Tgz1yRYGb8+Epz8CElNU=
=R7nI
-----END PGP SIGNATURE-----

--qtvxrzjs5n7q77of--
