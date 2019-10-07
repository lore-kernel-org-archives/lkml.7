Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FC0ECE58D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 09:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EADBF21841
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 09:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570442249;
	bh=N7TilIZJRyBGNXrbLXhsC9CeGmoiTg58DVlKiVeC7Us=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0DSCbQqNGNwXGshDhIRhpdRxptcZbARMSv3mbBREjnFlU2hxqJOYN9aiIUehZWXwF
	 VpikQkg94FcOoANxzoYUSJ2Tv6r62/XCMz3J/Pi7KyPVzsLnPYa3aZGFCSZO3F67HI
	 azZmilXH7CUz4mP2lp7hspMZGIxCfpAC0jKG6/nE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbfJGJ52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 05:57:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727347AbfJGJ52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 05:57:28 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09D44206C2;
        Mon,  7 Oct 2019 09:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570442247;
        bh=N7TilIZJRyBGNXrbLXhsC9CeGmoiTg58DVlKiVeC7Us=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GpeZmRy0IvGEHQa8Rioc5vEKWtHKllHQNCioRJvpXVIEtSi8J6eUPik8We8iboQ7H
         VB4nlpmjftttHBoX1U9AZEDGgp7HGVpH5ok+DYNi3smmnkQaBx5oOPyIFb7y05P+zz
         NaG8ElXfEzrVRrKJxtK47Tq/gaxUtZpx06HkrF10=
Date:   Mon, 7 Oct 2019 11:57:14 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: allwinner: a64: orangepi-win: Enable audio
 codec
Message-ID: <20191007095714.zzgl33jecjtt4fxv@gilmour>
References: <20191003222130.2015617-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tozf5qau77iuy2yh"
Content-Disposition: inline
In-Reply-To: <20191003222130.2015617-1-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tozf5qau77iuy2yh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 04, 2019 at 12:21:30AM +0200, Jernej Skrabec wrote:
> This patch enables internal audio codec on OrangePi Win board by
> enabling all relevant nodes and adding appropriate routing. Board has
> on-board microphone (MIC1) and 3.5 mm jack with stereo audio and
> microphone (MIC2).
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Applied, thanks!
Maxime

--tozf5qau77iuy2yh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXZsL+gAKCRDj7w1vZxhR
xRFoAQDZj50jh00cXZhTNvZIc5yBehvsimL9KoSEBtoolyIcKgD9E4sIC0dDrmMM
0VTV65p1tY7e+MdoKuy/z1F20RbaTgY=
=YcBb
-----END PGP SIGNATURE-----

--tozf5qau77iuy2yh--
