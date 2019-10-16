Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42372C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01B2F218DE
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571213218;
	bh=xmK/fcgmX84/0Ee+b2avihtOo5xXFs3Rgwm4HoHFFVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VBTDqTclEK7i0owymTUkAp+CaAwLOUbUpH6eFLGYPLVrb6sRTTkImCFy6KAl7QRYC
	 YoITtiUMnigJLA+gwcWhIB0kvB3pUBObl8/GYZN/ilvD95j50y84Z288ludIWl/awH
	 97m+8ylB0u4inbhb8oloCCc0ITTSwZ8ViJSCjTuI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391445AbfJPIG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 04:06:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:53392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727646AbfJPIG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 04:06:56 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2ACC2168B;
        Wed, 16 Oct 2019 08:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571213216;
        bh=xmK/fcgmX84/0Ee+b2avihtOo5xXFs3Rgwm4HoHFFVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2sCOTIwXhDaoFNm4jG9AqcNOAL5y/DtHUL3wIpBu1vOqVsQv3z5Ng4WSchaVw5fYs
         LRj55cn5IftSfuwc6z3vXQADJOUeQLaEUUZdnE4VX53nAVbIJUr1wgn8+HXfZgMfnk
         35aElQtFqu8ybkI0+QOldoez7AnXNX6/TkcAQm8o=
Date:   Wed, 16 Oct 2019 10:06:53 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     codekipper@gmail.com
Cc:     wens@csie.org, linux-sunxi@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it
Subject: Re: [PATCH v6 2/7] ASoC: sun4i-i2s: Add functions for RX and TX
 channel offsets
Message-ID: <20191016080653.3seixioa2xiaobd7@gilmour>
References: <20191016070740.121435-1-codekipper@gmail.com>
 <20191016070740.121435-3-codekipper@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eqduu55cdk37tzbj"
Content-Disposition: inline
In-Reply-To: <20191016070740.121435-3-codekipper@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eqduu55cdk37tzbj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Wed, Oct 16, 2019 at 09:07:35AM +0200, codekipper@gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> Newer SoCs like the H6 have the channel offset bits in a different
> position to what is on the H3. As we will eventually add multi-
> channel support then create function calls as opposed to regmap
> fields to add support for different devices.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 31 +++++++++++++++++++++++++------
>  1 file changed, 25 insertions(+), 6 deletions(-)
>
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index f1a80973c450..875567881f30 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -157,6 +157,8 @@ struct sun4i_i2s_quirks {
>  	int	(*set_chan_cfg)(const struct sun4i_i2s *,
>  				const struct snd_pcm_hw_params *);
>  	int	(*set_fmt)(struct sun4i_i2s *, unsigned int);
> +	void	(*set_txchanoffset)(const struct sun4i_i2s *, int);
> +	void	(*set_rxchanoffset)(const struct sun4i_i2s *);

The point of removing the regmap_field was that because having a
one-size-fits-all function with regmap_field sort of making the
abstraction was becoming more and more of a burden to maintain.

Having functions for each and every register access is exactly the
same as using regmap_field here, and the issue we adressed is not with
regmap_fields in itself.

If the H6 has a different register layout, then so be it, create a new
set_chan_cfg or set_fmt function for the H6.

Maxime

--eqduu55cdk37tzbj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXabPnQAKCRDj7w1vZxhR
xVgGAQC+c07u++gTF9sgMgydEJb6ZU4fnFFVj0WW2BXaQIv3MAD/fN+TY5xe5CTb
lMZpAVYl2AoGZu9oSTUSKXAUP4bzPwU=
=Qi0K
-----END PGP SIGNATURE-----

--eqduu55cdk37tzbj--
