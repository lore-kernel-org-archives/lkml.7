Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7E1C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 20:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F77520840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 20:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfCGU6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 15:58:18 -0500
Received: from sauhun.de ([88.99.104.3]:55344 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbfCGU6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 15:58:17 -0500
Received: from localhost (p54B334C5.dip0.t-ipconnect.de [84.179.52.197])
        by pokefinder.org (Postfix) with ESMTPSA id 03C7C2E3551;
        Thu,  7 Mar 2019 21:58:14 +0100 (CET)
Date:   Thu, 7 Mar 2019 21:58:14 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Adam Ford <aford173@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
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
Message-ID: <20190307205814.GB950@kunai>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-11-wsa+renesas@sang-engineering.com>
 <b0c1e303-ca95-8bc8-a5d4-65e75dc8398a@ti.com>
 <CACRpkday+d9iGeX+CRHTEyC=w+oNUK-8oTy0HqugO5PRhHn62w@mail.gmail.com>
 <20180430092947.GC2270@ulmo>
 <CAHCN7xLBa0JxcUs9i6Rr3hUNe5zymfb66icqNK0N3PMo51T-TA@mail.gmail.com>
 <20190307201807.GA950@kunai>
 <e7cadedc-b8ca-36d5-88dd-447fbeaac27a@metux.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Content-Disposition: inline
In-Reply-To: <e7cadedc-b8ca-36d5-88dd-447fbeaac27a@metux.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2019 at 09:53:50PM +0100, Enrico Weigelt, metux IT consult =
wrote:
> On 07.03.19 21:18, Wolfram Sang wrote:
> >=20
> >> It's been almost a year later, and several Linux revisions, and this
> >> still seems stuck somewhere/somehow.
> >=20
> > I wanted to respin this series once rc1 is released.
> >=20
> Maybe just rebase and repost ?

Then I'd miss all the new drivers which may need this fixed. Coccinelle
makes respinning a breeze, so no problem with that.


--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyBheIACgkQFA3kzBSg
KbZj9Q/7BfZMRib+CTRXwFZJ3DHfp+wLWcSFipubqzbJkW8tAqgjyYR4X56NSUOo
lwaQ5ymhPZuHGYSPYWBhxLKZSVzVyR1XeTyn7+LLctnA2rtfPS5VxXkbYRdAOsdW
gqRCUiyz5FCuskho/7JwO82N2UBPyH+aOnhkA7nD7Xk2GoFcJXzG7nA/ECqvYOrm
s6PXZb3tYdTmeT1n5t2AA7GrD3z0U6501rulyi+fTfC5L0cE9vX/vWWZe4H1Pi6S
rGKl555Oa4tvXGYcJ2GJQXcbk9Mc2Csgch/jWR3d9mg9L5dVmVrkh1meZA/6VEgT
H/2qvV03XFyCpr9wCOghH/d7LE72MTjWRSlmEKHG52fgYV1+HQrMFGc3OPn+GU6Q
NN9IYpmVGHe0joajA638iPn+EGE+twimvV8vBDvNNXKubt7nxuFxfMNhdnQ7ZmnJ
XTeG4jMiWZx2zOnZc5J2CjKib1mPTtvViI7lLF29t3A19gTst37bsWhZJ31lyh3M
rH6qMapWa9hbkbZikW1EmP1aFRgQAv0xbzq7FnHRppqKkFNNAvQZ+tL8Gm33nUww
1wkTzDJjJljc4/kkkViSKTX+F8TGW6eUcI3upBktCvdI6j/A47wi5c5oZZ8x+dDs
uEIWFWfOkZxPnUGhly24Sd1y4O1sHBnbTwkW+793MERzqD4LwYk=
=4j4A
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--
