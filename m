Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7513C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD8792133D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbfDBLOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 07:14:08 -0400
Received: from sauhun.de ([88.99.104.3]:39032 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbfDBLOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 07:14:08 -0400
Received: from localhost (p5486CD10.dip0.t-ipconnect.de [84.134.205.16])
        by pokefinder.org (Postfix) with ESMTPSA id B5ED92CF606;
        Tue,  2 Apr 2019 13:14:05 +0200 (CEST)
Date:   Tue, 2 Apr 2019 13:14:05 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Steve Twiss <stwiss.opensource@diasemi.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 1/2] rtc: da9063: set range
Message-ID: <20190402111405.GF2960@kunai>
References: <20190401150741.vwqzzngnma4jvkid@ninjato>
 <20190401151628.GK3430@piout.net>
 <20190401155204.GA5964@kunai>
 <20190401185346.GP3430@piout.net>
 <20190401193424.sqnapthocznhjqok@ninjato>
 <20190402085325.GT3430@piout.net>
 <20190402093359.GB2960@kunai>
 <20190402095115.GW3430@piout.net>
 <DB7PR10MB2348398516E5744F4CF8C18BFE560@DB7PR10MB2348.EURPRD10.PROD.OUTLOOK.COM>
 <20190402104230.GY3430@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s5/bjXLgkIwAv6Hi"
Content-Disposition: inline
In-Reply-To: <20190402104230.GY3430@piout.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s5/bjXLgkIwAv6Hi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> But my plan is to actually expose the capability to userspace and the
> core so this doesn't have to be handled in the driver.

I like that plan!


--s5/bjXLgkIwAv6Hi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyjQ/MACgkQFA3kzBSg
Kba5ow/9Fo2PNskxo3AavU2EcI4+s5aL5aktQrpF01RkKgIsKgNhcUiiXXaMn7zB
vYqqAPMECD3sdO2KGfPUmf5Kt8LzZ8Jsx3x0mUtilcSJknFayb8+GI9pjfoR54E5
50ridWlLH/LV2vv8HuINHmhUtEsh7NG6MNGeJI76BsCi9OuXoytXdCy+ur8//BGT
MpLpqAvkNF13Fxg9N4zz7MJsrObK6XAw5Xl1FSQGHeTbTBhjSz1/vdi6n3clrSvf
ER/BPBw3HC1ymdQ81mFGCtGFL0VmEcYPyakq94HTN8779RkIwRPt/xQnqv7xUYbN
31g8Lqz6YfnxHyG9FLufhXrYJELAvG0p3NmNle2kbuR7n7pKi+3PSNCT9tpWLeKe
gdiwgT4PNKHu+xz2iqsddfngojWAeJ/MdYgvZa4tkCW/ZZpJPQRGO8HPjLDUYq5C
bcBU6KPU57roAJ2jc7dlKbZGTZ6TfIPiQF0wLxquJswpcDMu3Iv5AgZ+EjpvmvIo
mW9ktJIHLKy8cnHFHF+yJJx/nDi9zk/r5l2uvM/Nl5avBzIA9ey83gMkhTfGrXBZ
6tu+QUd4Lmre1hdzhpppa9lskOt6b6fq11ef3jW634F6Aoo3LJv+fXfcuvfob00O
Sv7CPYytf369GqhzgAqWiP6x5eqigh+RT6zRxO4we4ZDh4BfN3c=
=c+C4
-----END PGP SIGNATURE-----

--s5/bjXLgkIwAv6Hi--
