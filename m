Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C3AC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C166216F4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566398002;
	bh=QO+p1/85LdqTXyI9zUBJ/aIY/wCtPQIJief+RWd2UrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QozHcB6qYjynBq3IP+R71MOST26L8ZR7L1dpvED7JtGh8mrZaNMlsfyr9vl4jrVGb
	 FdoRASzUSZ7Nn3sas+gQfwKkAk9mX/SwlJqg+ufAF0NR/OqwmOigeKgbBkU7DZHVUK
	 xZotAstJggSN4gSDnTxas1K3njXNcIWAE1opxeAg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbfHUOdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 10:33:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:35388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728964AbfHUOdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 10:33:21 -0400
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B31EB21655;
        Wed, 21 Aug 2019 14:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566398000;
        bh=QO+p1/85LdqTXyI9zUBJ/aIY/wCtPQIJief+RWd2UrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PHZnmkn9zAYlpVwUC319SBmftvtX2tizMVRp2zk2k3EriOA8NLI+X3BAJWW30wuza
         sSunp5GHpstIb3ekTNyky5M7w8XNsyYD4r0idsCwXcCOqD1EtGNerIFaGgZdsNdnjP
         w/ON98/gqARUdfEixQZj25NBbsXVSOG8Tm4VOaUw=
Date:   Wed, 21 Aug 2019 16:33:17 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     wim@linux-watchdog.org, linux-kernel@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: watchdog: Add YAML schemas for the
 generic watchdog bindings
Message-ID: <20190821143317.dkahpwjvgrtqtx4d@flea>
References: <20190819182039.24892-1-mripard@kernel.org>
 <ada53037-898f-7b8c-8a96-b80414563fa7@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3o66cqpsjmmmmqh3"
Content-Disposition: inline
In-Reply-To: <ada53037-898f-7b8c-8a96-b80414563fa7@roeck-us.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3o66cqpsjmmmmqh3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Guenter,

On Tue, Aug 20, 2019 at 08:54:53AM -0700, Guenter Roeck wrote:
> On 8/19/19 11:20 AM, Maxime Ripard wrote:
> > From: Maxime Ripard <maxime.ripard@bootlin.com>
> >
> > The watchdogs have a bunch of generic properties that are needed in a
> > device tree. Add a YAML schemas for those.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
>
> What is the target subsystem for this series ? You didn't copy the watchdog
> mailing list, so I assume it won't be the watchdog subsystem.

Sorry for that :/

It can either go through the DT or watchdog tree. I'll resend it and
let you and Rob figure it out :)

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--3o66cqpsjmmmmqh3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXV1WLQAKCRDj7w1vZxhR
xV7MAP9eNJQeheprjz1a/+LmmPM8s1A06SHcgrdDWaIdjrnr9AEA3opx310odS8e
IIcinBLkTGCtVyqZQn99Bq1LeOvEPgA=
=W2rw
-----END PGP SIGNATURE-----

--3o66cqpsjmmmmqh3--
