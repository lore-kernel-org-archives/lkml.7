Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30719C33C9B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 09:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE09D20848
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 09:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578301480;
	bh=R3lW9glk35yqVg/VMUPlgtgKJaOq6vpMeSYGhqpP9W4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LsQxcxLseU4HFwjRpM/Cd0BmwbFhoK7ERZzQu0vMcb6pyEPirZIxhoq4QhptMSe/T
	 MJ22uREMwlph75nDc5MRRR9aLPSetHgW2rmsQXubdd6K4omgggOLjenr7XJeRVXc8T
	 ymBGYab8gNzy+StUXLCMoRX1mndoxq3WJZhD0vDg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgAFJEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 04:04:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:41070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbgAFJEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 04:04:38 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE63420848;
        Mon,  6 Jan 2020 09:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578301478;
        bh=R3lW9glk35yqVg/VMUPlgtgKJaOq6vpMeSYGhqpP9W4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RwJnsuwNw5lvNc/hFugCS7jH+AyWz2EosczmYU1b8bPv1vbkOR4XE2DCDW3aAClCw
         aXWledUZ14t5ahd869zvO3QR59ypBL0kpmWBIeeO86x93qf+tzi96P+OmpwjCZDIdI
         SFh4KFbMsLJBSkt6GcPjGzpaekhawhtF/FIYXQAg=
Date:   Mon, 6 Jan 2020 10:04:36 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: allwinner: sun50i-a64: Use macros for newly
 exported clocks
Message-ID: <20200106090436.lz7kndaozhjwwpux@gilmour.lan>
References: <20200106090030.9165-1-wens@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="z7uhvbuxo4svguyf"
Content-Disposition: inline
In-Reply-To: <20200106090030.9165-1-wens@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--z7uhvbuxo4svguyf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 06, 2020 at 05:00:30PM +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
>
> A few clocks from the CCU were exported later, and references to them in
> the device tree were using raw numbers.
>
> Now that the DT binding header changes are in as well, switch to the
> macros for more clarity.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
Maxime

--z7uhvbuxo4svguyf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXhL4IwAKCRDj7w1vZxhR
xWXbAP9Ors18Np2z+FcY5vnpLSAVawSLtt6//SNXrjCIJVWkyAD/Zm/E8yIG+xZN
5azAfdesLHweGYLYYFn1bz6nco+2vQM=
=tHnk
-----END PGP SIGNATURE-----

--z7uhvbuxo4svguyf--
