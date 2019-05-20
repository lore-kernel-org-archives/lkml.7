Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE162C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC53A20815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387929AbfETNSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 09:18:51 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:39103 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbfETNSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 09:18:50 -0400
X-Originating-IP: 90.88.22.185
Received: from localhost (aaubervilliers-681-1-80-185.w90-88.abo.wanadoo.fr [90.88.22.185])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id F2F5F1C0013;
        Mon, 20 May 2019 13:18:46 +0000 (UTC)
Date:   Mon, 20 May 2019 15:18:46 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Convert vendor prefixes to json-schema
Message-ID: <20190520131846.tqx7h7sjyw6sgka5@flea>
References: <20190510194018.28206-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="26jxfkzgkqsicu7x"
Content-Disposition: inline
In-Reply-To: <20190510194018.28206-1-robh@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--26jxfkzgkqsicu7x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Rob,

On Fri, May 10, 2019 at 02:40:18PM -0500, Rob Herring wrote:
> Convert the vendor prefix registry to a schema. This will enable checking
> that new vendor prefixes are added (in addition to the less than perfect
> checkpatch.pl check) and will also check against adding other prefixes
> which are not vendors.
>
> Converted vendor-prefixes.txt using the following sed script:
>
> sed -e 's/\([a-zA-Z0-9\-]*\)[[:space:]]*\([a-zA-Z0-9].*\)/  "^\1,\.\*\":\n    description: \2/'
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> As vendor prefix updates come in via multiple trees, I plan to merge
> this before -rc1 to avoid cross tree conflicts.

I just tried this with the 5.2-rc1 release, and this very
significantly slows down the validation.

With a dtbs_check run on (arm's) sunxi_defconfig, on my core-i5 with 4
threads, I go from 1.30 minutes to more than 12.

Should we improve the dt-validate tool before merging this patch?

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--26jxfkzgkqsicu7x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXOKpNgAKCRDj7w1vZxhR
xaU/AP4sEcxQ75aEnI0xMbq88t3BZzAEW0xMBgZRESwC/0YwUwEA3Wu9L5Uir8PG
cDc3z03Kswww+O1DXoE+XNDbc1gMHwc=
=aMcg
-----END PGP SIGNATURE-----

--26jxfkzgkqsicu7x--
