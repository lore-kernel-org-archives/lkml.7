Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A9EC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 183162084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbfDBKaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 06:30:24 -0400
Received: from sauhun.de ([88.99.104.3]:38740 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfDBKaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 06:30:24 -0400
Received: from localhost (p5486CD10.dip0.t-ipconnect.de [84.134.205.16])
        by pokefinder.org (Postfix) with ESMTPSA id 8636C2CF606;
        Tue,  2 Apr 2019 12:30:21 +0200 (CEST)
Date:   Tue, 2 Apr 2019 12:30:21 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Steve Twiss <stwiss.opensource@diasemi.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 1/2] rtc: da9063: set range
Message-ID: <20190402103021.GE2960@kunai>
References: <CAMuHMdVsp86n_1+c6NZpCG1MwcAzEH7rgaESHfYESb5YcLk6zw@mail.gmail.com>
 <20190401132109.GA4570@kunai>
 <CAMuHMdV79HAn8jpodQcripAViCqBh3rFGZ39oEiSiP8nC+UyTA@mail.gmail.com>
 <20190401150741.vwqzzngnma4jvkid@ninjato>
 <20190401151628.GK3430@piout.net>
 <20190401155204.GA5964@kunai>
 <20190401185346.GP3430@piout.net>
 <20190401193424.sqnapthocznhjqok@ninjato>
 <20190402085325.GT3430@piout.net>
 <DB7PR10MB2348E32107CAFBB68AC1C35AFE560@DB7PR10MB2348.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="phCU5ROyZO6kBE05"
Content-Disposition: inline
In-Reply-To: <DB7PR10MB2348E32107CAFBB68AC1C35AFE560@DB7PR10MB2348.EURPRD10.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--phCU5ROyZO6kBE05
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Apologies, I am unable to test this on DA9063 AD silicon since I no longer have
> that variant.

Geert and I have boards with these. I am happy to help, and I guess
Geert, too.


--phCU5ROyZO6kBE05
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyjObwACgkQFA3kzBSg
KbbMQw/9HKxUwLaYbwwwwnFEMjzTGFL9aISD8FExXfjVMuVrxg7SwbpeNiQe1Cuj
FHlXkhu1g5LYex+/YDsgdTpMMxci5qPQCRnZN+NHbA64IhJqQ8pPzOWbVkJ7xQRN
BS3a0BLV3ZqjmXuMmhMJcpD4I/m10WxDrOa6Ndjg8y2+aV98lRYVvpCLWUE5feGo
prRRVUYI/Ju2wZDUBjaKcIWlFAXpgzzAOIG+qas2uSEM9SIsRsY8Dxmi8yJ6dC4U
ogqFiGb0YMPb8l1nrprtJv3S3/OwfsWyFg3RP6jdZG27CoHMhXzJ1awd3q10YfBb
IByUC8sFyjiZjyAgLPZQvZ/5Mrs+d5xiJvAWgrEwpv3pP0haZ+OLPdgPvs4ZPjHm
HOSD4tU3JoI7h/6PKkJtx0NJ92SMgxXOvzhoT9mvTPuG16h7sKI1b9ZTsBubfAkR
YQiEOuKszsB3vqL35oMjLa4Zqi5ptKaVPqhnt8N9P0R0mrEsYoj4MNf62t4mFoh9
jrXEXNGf6/FXvFzhWhELwp4VmVG5KA2CDwfDtORDA+OVmXB6VKsznWDYGfFd++BT
C/Z0q90Yy5ehmjr5c0s8GlU8ezGF3y/m2jM9tejQBbX3OxUM0/+Z2tFdLYSIai1f
yN79jWG6UxYOCwlXSIaDJ+MnJPaDRnAZFmLY0Ld5m1zFFBgsiVo=
=kcSN
-----END PGP SIGNATURE-----

--phCU5ROyZO6kBE05--
