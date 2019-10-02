Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76998C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 10:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C73821A4C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 10:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570012607;
	bh=OTtxUEjlO9HcUPpiugCSBkopkvyXz2JCDw8OEY6QwX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UZIP7DqyiS3PEN8eYpy+DOjyvhblvsX945CP8bfNQTce+584XK7Bo9siAwfGTRKhn
	 WA5NjNiU1jeLHr9cIdon/s5TixRtuYHWdDczZdAXCy+CW44eJ4At7lMkxtB3Wwtxw8
	 5KJoNgrfKoI4tqoHTsi5iyOHJaC6K7iBRND10320=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbfJBKgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 06:36:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:58968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbfJBKgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 06:36:45 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DBAC218DE;
        Wed,  2 Oct 2019 10:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570012605;
        bh=OTtxUEjlO9HcUPpiugCSBkopkvyXz2JCDw8OEY6QwX8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dop77VND9yEdv1ixP06TuVIV/36nU/gRS6iesokjS2CL7ZPgJdrbgDpvt2Aoxzgu2
         d5u137d5vOTMdKWAjM2hICqZFYPs7zzfRGPDLEKyrpW0K9Z2k28AGKCwWGyw0Bwo42
         t1VdFm3KNA9hZoIoMuUDxnLyR/+3oztIWtrtXmsE=
Date:   Wed, 2 Oct 2019 12:36:42 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 0/3] drm/sun4i: dsi: misc timing fixes
Message-ID: <20191002103642.jlbs44v4kwnxhrge@gilmour>
References: <20191001080253.6135-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6keczcenlhnwont6"
Content-Disposition: inline
In-Reply-To: <20191001080253.6135-1-icenowy@aosc.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6keczcenlhnwont6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Tue, Oct 01, 2019 at 04:02:50PM +0800, Icenowy Zheng wrote:
> This patchset fixes some portion of timing calculation in sun6i_mipi_dsi
> driver according to the BSP driver.
>
> Two of the patches are reverting, one is fixing some misread of the BSP
> source code, another is fixing a wrong refactor that actually breaks the
> formula.
>
> The other non-reverting patch is fixing a porch error which is usually
> seen in the original driver commit. Most of porch errors are then fixed,
> but this one gets ignored.
>
> By applying these patches, several DSI panels are tested to be driven
> properly by the timing provided by the vendor, including the LCD panel
> of PinePhone "Don't Be Evil" DevKit, the final PinePhone panel and the
> panel on PineTab. Without these patches they need dirty timing hacks to
> work.

Thanks for going after that issue. Can you provide references to the
BSP on the various patches?

Ideally, having the panel drivers, and the panel datasheet would help.

Thanks!
Maxime

PS: where can we get one of those devices?

--6keczcenlhnwont6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXZR9ugAKCRDj7w1vZxhR
xY0/AQC5eQr1MF2JwZuR7J6/60HoAsW6kKoOVaBBWurj6iMNTAD+JwOOdlDSQqrT
fievw3+uVVe3O0xnWQxGHYInw9LB6g4=
=q4a2
-----END PGP SIGNATURE-----

--6keczcenlhnwont6--
