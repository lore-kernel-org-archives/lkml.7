Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36299C10F0B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 007A72133D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbfDAPwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 11:52:07 -0400
Received: from sauhun.de ([88.99.104.3]:52324 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbfDAPwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 11:52:07 -0400
Received: from localhost (p54B331B1.dip0.t-ipconnect.de [84.179.49.177])
        by pokefinder.org (Postfix) with ESMTPSA id 073F22C7BF4;
        Mon,  1 Apr 2019 17:52:04 +0200 (CEST)
Date:   Mon, 1 Apr 2019 17:52:04 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 1/2] rtc: da9063: set range
Message-ID: <20190401155204.GA5964@kunai>
References: <20190321101557.26857-1-alexandre.belloni@bootlin.com>
 <20190401084143.uqbiktkt2vltgrxa@ninjato>
 <CAMuHMdW_Gz4qaRXFeW-h7vNxJ5RwjDXDP4oZZcUaYHcqEC75bA@mail.gmail.com>
 <VI1PR10MB235254A7A95F4045A5410D1EFE550@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
 <CAMuHMdVsp86n_1+c6NZpCG1MwcAzEH7rgaESHfYESb5YcLk6zw@mail.gmail.com>
 <20190401132109.GA4570@kunai>
 <CAMuHMdV79HAn8jpodQcripAViCqBh3rFGZ39oEiSiP8nC+UyTA@mail.gmail.com>
 <20190401150741.vwqzzngnma4jvkid@ninjato>
 <20190401151628.GK3430@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
In-Reply-To: <20190401151628.GK3430@piout.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > [=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] Running 7 tests from 2 test cases.
> > [ RUN      ] rtc.date_read
> > rtctest.c:49:rtc.date_read:Current RTC date/time is 01/01/2000 04:06:40.
> > [       OK ] rtc.date_read
> > [ RUN      ] rtc.uie_read
> >=20
> > And here it blocks forever. Any pointers?
> >
>=20
> This means that you don't get any interrupt from your RTC (and that I

Thought so. Well, somehow makes sense that no interrupt gets through,
and not only alarm interrupts...

> have to fix the timeout for uie_read).

:) I am happy to test.


--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyiM58ACgkQFA3kzBSg
KbYfDQ//ZjO3ON7QbF0ACxSfCLxNY+P//qZ3kPdyL88iBdeywV2+0T8Fsuj7YiUl
XS6N9JVoq3q7yrjsCjqT61zrUq/qI2D93euhkwV9nWp1kRAldv3aAdIyNICzJ2wX
uyxJI1p1q+6jymUsYCKILfLb3Q1xsiYcCQK5luJpHinAw9nxYjVt5y6OJ/tY9Fz4
wOyU/P4E6wDcr4o3W+hFSRB6qfIpJXrUOBp1aey3mIbEvaGGKl3PYSD8WOmsZa32
qD9VjgucnNjpGi+fsCFKcr8nfQTX6JzXGwZ7bbyWNKW366N71Cp1Yxr++AFU43Ae
JJhLV5YsRqmvCIVWq8Et82Lf9QtBhZzNw5KV4K5sH+3VoOHe8HNobV6ONtlKrhqj
r820GWpNig4C+YgdKnNXLiNovZTsFYH4sOrRLIOvP91ansH89g5eWU6k3157wUDZ
BkMDywheZ+mqyrX5Bp7SHVEd5G1E7Z34iLhH+dKRDRLwvnxSonCDVbcUZuOyeFiP
AHOUuOsZxNlL21bcM6xJmsqyk92X2dsYeH4KIPiv0HXfutJXc1p8rWBaHmUEnSnA
PBCrmg/OzSamkZMgIFvpdLeXvBfFsXe1IdgGFZI0olRgakhq9ZERKcUe0Yk7rYzq
xQY3yQTu4AZFoj6wPCgZNb+r3UMVvE0M5GFGcaWCgiygMxK8yOg=
=Zo+a
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
