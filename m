Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796A3C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 13:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FE1220870
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 13:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfDANVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 09:21:12 -0400
Received: from sauhun.de ([88.99.104.3]:51352 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbfDANVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 09:21:12 -0400
Received: from localhost (p54B331B1.dip0.t-ipconnect.de [84.179.49.177])
        by pokefinder.org (Postfix) with ESMTPSA id 4A2712C7BF4;
        Mon,  1 Apr 2019 15:21:10 +0200 (CEST)
Date:   Mon, 1 Apr 2019 15:21:09 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Steve Twiss <stwiss.opensource@diasemi.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 1/2] rtc: da9063: set range
Message-ID: <20190401132109.GA4570@kunai>
References: <20190321101557.26857-1-alexandre.belloni@bootlin.com>
 <20190401084143.uqbiktkt2vltgrxa@ninjato>
 <CAMuHMdW_Gz4qaRXFeW-h7vNxJ5RwjDXDP4oZZcUaYHcqEC75bA@mail.gmail.com>
 <VI1PR10MB235254A7A95F4045A5410D1EFE550@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
 <CAMuHMdVsp86n_1+c6NZpCG1MwcAzEH7rgaESHfYESb5YcLk6zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
In-Reply-To: <CAMuHMdVsp86n_1+c6NZpCG1MwcAzEH7rgaESHfYESb5YcLk6zw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I was just wondering whether they work for Wolfram, who has a similar
> but different board than I have. Last time I tried, they didn't work for me.

How did you test?


--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyiEEAACgkQFA3kzBSg
Kbbeyw/6AhvZF6LpEYJdHE0ORWh0H/V6e1ReiUl6yhTiSHEy8MF4ypj7U+Cd45Ex
cYIckvis1RiwjwhNGFrIG/EbASKR2ivjX+ntEgYjJCDkXiwUE1kUl9CxdNhpFTqK
H0KLXjlWEZei5jnZafdlpjonDNxyzXjijBbAGnnyF0DLlaaZOVPLbk1IpuU5IPwF
+3xiyaCkFMYONMOJ6/UIbtebmzQlI3NlCjeeCc+UZlIJJKOSjlr3Yb/MUDVYE4sc
mBMLFK8R4NayI4vzMzDhlS3FsKCQsAXaDCmSDHFr4DwWwD5I0F5ELtsz3V7qLSwU
RD2Kq2mWiUXHEMZv35I/yI0YWFe6eETiN5RhYjf9alrFuBX+upJrKu1TrHrx5b4X
Jay8//agSGyNcC0SfGzD6mPOwmlO6OODOyppCwvcxXt9i+eGd4ychmk9Td63+7oi
jhogsJcouvU+bexxWC/2JC+AbktrzJ20mBy08UexftaArcqi7oveJcbch9BQhsDA
kvMh5e1E2osRza7s3c5mdZwRk7Woc4LCToEmxBUQE7p8ga+16zkAm8qeE3WKTazT
SkQtxW5Ng6WRD9jZKNuOkkAABTB5LAWBvsquV5BMB9Yh5v44we9K8x1otpPLkJE1
LKi39LratZ+6AaatrXtCShIcSM+jECGVIaXLkKqkatC+p45IXjs=
=x2K4
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
