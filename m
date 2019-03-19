Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BFCC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0180A2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbfCSObN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:31:13 -0400
Received: from sauhun.de ([88.99.104.3]:45220 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbfCSObM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 10:31:12 -0400
Received: from localhost (p5486CE21.dip0.t-ipconnect.de [84.134.206.33])
        by pokefinder.org (Postfix) with ESMTPSA id 911AD2C3F83;
        Tue, 19 Mar 2019 15:31:09 +0100 (CET)
Date:   Tue, 19 Mar 2019 15:31:09 +0100
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
Message-ID: <20190319143109.djd5z4pw5twom3og@ninjato>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-11-wsa+renesas@sang-engineering.com>
 <b0c1e303-ca95-8bc8-a5d4-65e75dc8398a@ti.com>
 <CACRpkday+d9iGeX+CRHTEyC=w+oNUK-8oTy0HqugO5PRhHn62w@mail.gmail.com>
 <20180430092947.GC2270@ulmo>
 <CAHCN7xLBa0JxcUs9i6Rr3hUNe5zymfb66icqNK0N3PMo51T-TA@mail.gmail.com>
 <20190307201807.GA950@kunai>
 <e7cadedc-b8ca-36d5-88dd-447fbeaac27a@metux.net>
 <20190307205814.GB950@kunai>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kg3zuuvvtizrfheo"
Content-Disposition: inline
In-Reply-To: <20190307205814.GB950@kunai>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kg3zuuvvtizrfheo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2019 at 09:58:14PM +0100, Wolfram Sang wrote:
> On Thu, Mar 07, 2019 at 09:53:50PM +0100, Enrico Weigelt, metux IT consul=
t wrote:
> > On 07.03.19 21:18, Wolfram Sang wrote:
> > >=20
> > >> It's been almost a year later, and several Linux revisions, and this
> > >> still seems stuck somewhere/somehow.
> > >=20
> > > I wanted to respin this series once rc1 is released.
> > >=20
> > Maybe just rebase and repost ?
>=20
> Then I'd miss all the new drivers which may need this fixed. Coccinelle
> makes respinning a breeze, so no problem with that.

Because coccinelle didn't find anything in drivers/gpio, I wondered what
case you are referring to? Invoking this (as of v5.1-rc1) gives:

$ git log --oneline --grep "simplify getting" drivers/gpio
7ddb7dce0ab6 gpio: gpio-tegra: simplify getting .driver_data
38ccad0243f9 gpio: gpio-zynq: simplify getting .driver_data
a3f4f728d3bb gpio: gpio-omap: simplify getting .driver_data
11868645c5b5 gpio: gpio-mxc: simplify getting .driver_data
ea5ec5e3aeab gpio: gpio-lynxpoint: simplify getting .driver_data
deb19ac533ac gpio: gpio-dwapb: simplify getting .driver_data


--kg3zuuvvtizrfheo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyQ/SgACgkQFA3kzBSg
Kbad6w/8DIvvd6HUXyP6xnHWqariF69h83z8gzbiUlkDkSFgIjTJ5f3SadnJfyOX
6Q0F6rpp6rRSObAf5hkqej0mH5sAb9qynPGfnvmNr9bLQACtVv2CoKKncHR0BCGr
6IMGySJSZjE3rgQVA1BB0Q4Dx+DJV4t2IRWEfOdSB75ZCbkSeoivaPpoHiiHEhMT
DTJzP+qPF1hBE2vqjrjUrWCddubCd5S8iWOCSmdqz0OCKaChHvAlVzqWwjR0W4rF
uk/cU0VKvgFJicf/kaWo1g20KQvmOAajfqKUYA3nhVBdON9JsqIB8lAGAG+rTeUV
VaDNwUBMyTQYIGAO13dqGB9lGzs7Hm6lFJn/I9aT4Wt+Mdt25GflU02+oZzmA37m
et1CARlq+dl9J7DV0iNTAdfqx6egH/pXSYoHDghGLNjbIaLLSQB8VBTnuUWee51/
FmshV6qcg0qiM06+Q+CXvhvINzL/6YqCg73f3KKqtYYZ6MRL0h7sGguykbsTj3Z1
bTgDsDe8EsjdigRUoY7PB1+db79MMDLP9TcnPx1s5WAZaQogOxWt3kxbUII2eqss
ZfQL+of3tntrs2n/CGuN+ic9H+BRsavpr3oAsib2ZUZDNZlmTd0jgCG8mj1XXCmY
+dUsy643lIPeKzgaYV+T3nLvHTv2oH3iMTpmBq994pM8Bysn6s4=
=AXa/
-----END PGP SIGNATURE-----

--kg3zuuvvtizrfheo--
