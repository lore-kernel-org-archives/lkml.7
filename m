Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3075AC33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE0F62077B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578575628;
	bh=N89fqm/wSNPygiHhvlyg6BX8W3BVH5DxNVHnix5I0q4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nxxJ4bu7k+K4sbIBMIi3gxAejJh1s0P+gozVhqcRwKPYVbDDynYySX36MrAs0cSHo
	 5UivTjYIS5Mc5ozACtXXxqleNVfXQwcTL8U+VYwWjychrpfE0nCFePmTuBisZq1t7e
	 OTXun52hCA++19Hs5H+EEvNxYng4EzHiEQI7FaZw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730591AbgAINNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 08:13:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:36394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729266AbgAINNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 08:13:46 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B2872072A;
        Thu,  9 Jan 2020 13:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578575626;
        bh=N89fqm/wSNPygiHhvlyg6BX8W3BVH5DxNVHnix5I0q4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VUmOXFJKEVw4ngBhuV61AJyMW263sFDGLq3mPSQlVnntw+BcrUeoN/nPzHQeIMbQk
         DanmK4fpneCdJOfhYjy1YMkRL1yqZ/og4NTxthy+l+mzX+VJG67l+M2mJ6lQgTHvJu
         5ALFsbNQpFxBuIGF6bVy79urSlWQurdkYuutl/Zc=
Date:   Thu, 9 Jan 2020 14:13:43 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Yangtao Li <tiny.windzz@gmail.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, wens@csie.org, anarsoul@gmail.com,
        rui.zhang@intel.com, amit.kucheria@verdurent.com,
        megous@megous.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ARM: dts: sun8i-r40: Add thermal sensor and
 thermal zones
Message-ID: <20200109131343.mjyuj5ed2xwvmwd4@gilmour.lan>
References: <20200106174639.20862-1-tiny.windzz@gmail.com>
 <20200106174639.20862-2-tiny.windzz@gmail.com>
 <20200107075816.ly6exfd4qtvfxxua@gilmour.lan>
 <662e157a-603f-7423-0491-f26f0fc8d7b6@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rudrzmim3rv4efom"
Content-Disposition: inline
In-Reply-To: <662e157a-603f-7423-0491-f26f0fc8d7b6@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rudrzmim3rv4efom
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Daniel,

On Thu, Jan 09, 2020 at 12:51:27PM +0100, Daniel Lezcano wrote:
> On 07/01/2020 08:58, Maxime Ripard wrote:
> > On Mon, Jan 06, 2020 at 05:46:39PM +0000, Yangtao Li wrote:
> >> There are two sensors, sensor0 for CPU, sensor1 for GPU.
> >>
> >> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> >> Tested-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> >> Tested-on: sun8i-r40-bananapi-m2-ultra
> >
> > As far as I know, tested-on is not documented anywhere (and isn't
> > really used either). I've removed it and applied, thanks!
>
> I think this patch should go through my tree as it refers to a commit in
> my branch.

I'm not quite sure to get why. Even though that patch depends on the
one affecting the driver to be functional, it doesn't break anything
when merged through arm-soc, and similarly yours doesn't affect any
other tree if it's merged through your tree, so there's no dependency?

Maxime

--rudrzmim3rv4efom
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXhcnBwAKCRDj7w1vZxhR
xcImAQDNbSqcmxp2wB1rwCZU6HKqVaiK8UsFDVOYa38x/E7CiAEAxs5cMCPyNob1
HngPtTnq7ckkkdz5yvv7IEl2Ak4wcgE=
=9f/6
-----END PGP SIGNATURE-----

--rudrzmim3rv4efom--
