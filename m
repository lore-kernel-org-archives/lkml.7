Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63859C10F03
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 20:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D5E320851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 20:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbfCGUSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 15:18:11 -0500
Received: from sauhun.de ([88.99.104.3]:54966 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbfCGUSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 15:18:10 -0500
Received: from localhost (p54B334C5.dip0.t-ipconnect.de [84.179.52.197])
        by pokefinder.org (Postfix) with ESMTPSA id 2BCD82E3551;
        Thu,  7 Mar 2019 21:18:08 +0100 (CET)
Date:   Thu, 7 Mar 2019 21:18:07 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Adam Ford <aford173@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, Hoan Tran <hotran@apm.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 10/61] gpio: simplify getting .drvdata
Message-ID: <20190307201807.GA950@kunai>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-11-wsa+renesas@sang-engineering.com>
 <b0c1e303-ca95-8bc8-a5d4-65e75dc8398a@ti.com>
 <CACRpkday+d9iGeX+CRHTEyC=w+oNUK-8oTy0HqugO5PRhHn62w@mail.gmail.com>
 <20180430092947.GC2270@ulmo>
 <CAHCN7xLBa0JxcUs9i6Rr3hUNe5zymfb66icqNK0N3PMo51T-TA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <CAHCN7xLBa0JxcUs9i6Rr3hUNe5zymfb66icqNK0N3PMo51T-TA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> It's been almost a year later, and several Linux revisions, and this
> still seems stuck somewhere/somehow.

I wanted to respin this series once rc1 is released.


--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyBfHsACgkQFA3kzBSg
Kbb87BAAgY8Zdjph2MvnTtWsLVlR20N3tzC48BqMW6+mCkS/GBg4G+shi+L5bN9r
eKruZXQ505sEuRpB/v1PC7QlGJ0Bp5Dk7VVaQolgC7Jx2ubqRYhaW2UWkz3Mr5RO
3yfmDc1jo4B3z7d4Cqyi7qWcFSB2i4hjR/CA6kz0EXC5LcAPTACDSmliFtoZPvQ/
wWbpWQN6kO8JYAluEjxOI+EtQL22fha/FrRKEY91X3yPtIzZYA89ZacOsBlKFBKU
SouRZmq7htq6eatqg7XV4y3X4ZxsOkL0gxWCZiGX4iE9yamM/eF0+6WD6zaVHoKa
W24fFnqyi+yg7sYZ1iNdokb0JHR/sCZJffPjKKD1OnJFjUedXFA1JazIEDfNARyM
/Sh/hrcIb4n6CXe1sQ3YHEZkaLffqICJW+OIEWkUI0kSAbSFnKCVxHVb6F0r/I+Q
PZ3SnruxYHrDWgegpZQkjE9rsZRCkG5KDNZ2fahXW9BUaIXfuWRyzoXaiVW8Matb
vbyKCym1vwq0SxHIGyCqEYK0GBt6Yx9y/JelHChYWyyiKe+g6SLgctFycF8Fn/Fh
sbdGgmrtsg+eIepcAvkw/+fvA3ITCCN0QX9WRzrUjftrG6MRoFni1+ec4nXJkwgI
p+565C1niZxFqf1wRcZT86WxiYI01T0pLi1bKOwunvZ8Riym9b4=
=vuew
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
