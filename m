Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75770C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39F7921883
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566898541;
	bh=QwBJ6oW0mDUbmXmBZq/xOiSb0AoEWSa+i67Fo2EQs3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QI71u8EkMpTaiF/hhJPytpnpSfWK2mvFTanla6cYgCGjz8L+pswaVVvuCMHRO9Nmg
	 4AH7RTB8NJwgi3q8GLtancV5e6nYqxjZOFrkF7lbhAKABvDjTvYDEwbDWsh5iJQM2D
	 ij4W6C4rQup/62wZ0BSHPPvzuSbCvaK7Bn2wSqzo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729902AbfH0Jfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 05:35:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:57346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726833AbfH0Jfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 05:35:40 -0400
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C22D2186A;
        Tue, 27 Aug 2019 09:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566898538;
        bh=QwBJ6oW0mDUbmXmBZq/xOiSb0AoEWSa+i67Fo2EQs3E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IBElxmoUKNRUm9l3uA8x2MyS+ZMpfcJG5jPMcXf/AbP8WeAt4AK0moq7YYtVCyMi3
         +WABBe3yhR0HqCC4213+rKtjpwTL8ALAwhzGjnw5yiBdZrBXKUzg70rj1OhmcRmOM1
         SBZPITCAS7sME54Y/kLDWZ6+0EI5Yz4Kn9JxqPu4=
Date:   Tue, 27 Aug 2019 11:35:36 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Code Kipper <codekipper@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/21] ASoC: sun4i-i2s: Number of fixes and TDM Support
Message-ID: <20190827093536.rl6fjuvctjwd33as@flea>
References: <cover.e08aa7e33afe117e1fa8f017119d465d47c98016.1566242458.git-series.maxime.ripard@bootlin.com>
 <CAGb2v64xOcs3Vi5k3yUwMiUrzZMuJ5vZ3kxp9w1=CQDrkn3cgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zfutohgftfydg3jy"
Content-Disposition: inline
In-Reply-To: <CAGb2v64xOcs3Vi5k3yUwMiUrzZMuJ5vZ3kxp9w1=CQDrkn3cgA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zfutohgftfydg3jy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Tue, Aug 27, 2019 at 04:20:24PM +0800, Chen-Yu Tsai wrote:
> Hi everyone,
>
> On Tue, Aug 20, 2019 at 3:25 AM Maxime Ripard <mripard@kernel.org> wrote:
> >
> > From: Maxime Ripard <maxime.ripard@bootlin.com>
> >
> > Hi,
> >
> > This series aims at fixing a number of issues in the current i2s driver,
> > mostly related to the i2s master support and the A83t support. It also uses
> > that occasion to cleanup a few things and simplify the driver. Finally, it
> > builds on those fixes and cleanups to introduce TDM and DSP formats support.
> >
> > Let me know what you think,
> > Maxime
> >
> > Marcus Cooper (1):
> >   ASoC: sun4i-i2s: Fix the MCLK and BCLK dividers on newer SoCs
> >
> > Maxime Ripard (20):
> >   ASoC: sun4i-i2s: Register regmap and PCM before our component
> >   ASoC: sun4i-i2s: Switch to devm for PCM register
> >   ASoC: sun4i-i2s: Replace call to params_channels by local variable
> >   ASoC: sun4i-i2s: Move the channel configuration to a callback
> >   ASoC: sun4i-i2s: Move the format configuration to a callback
> >   ASoC: sun4i-i2s: Rework MCLK divider calculation
> >   ASoC: sun4i-i2s: Don't use the oversample to calculate BCLK
> >   ASoC: sun4i-i2s: Use module clock as BCLK parent on newer SoCs
> >   ASoC: sun4i-i2s: RX and TX counter registers are swapped
> >   ASoC: sun4i-i2s: Use the actual format width instead of an hardcoded one
> >   ASoC: sun4i-i2s: Fix LRCK and BCLK polarity offsets on newer SoCs
> >   ASoC: sun4i-i2s: Fix the LRCK polarity
> >   ASoC: sun4i-i2s: Fix WSS and SR fields for the A83t
> >   ASoC: sun4i-i2s: Fix MCLK Enable bit offset on A83t
> >   ASoC: sun4i-i2s: Fix the LRCK period on A83t
> >   ASoC: sun4i-i2s: Remove duplicated quirks structure
>
> Unfortunately the patches that "fix" support on the A83T actually break it.
> The confusion stems from the user manual not actually documenting the I2S
> controller. Instead it documents the TDM controller, which is very similar
> or the same as the I2S controller in the H3. The I2S controller that we
> actually support in this driver is not the TDM controller, but three other
> I2S controllers that are only mentioned in the memory map. Support for this
> was done by referencing the BSP kernel, which has separate driver instances
> for each controller instance, both I2S and TDM.
>
> Now to remedy this I could send reverts for all the "A83t" patches, and
> fixes for all the others that affect the A83t quirks. However the fixes
> tags existing in the tree would be wrong and confusing. That might be a
> pain for the stable kernel maintainers.
>
> Any suggestions on how to proceed?

I've just sent two patches to address that (adding a comment in the
process so that hopefully it doesn't happen again).

Let me know if it works, and sorry for the mess :/
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--zfutohgftfydg3jy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXWT5aAAKCRDj7w1vZxhR
xdWcAP92UC8ohpBC1hEZ+YE9YtL68wqEMKjjgaiRbBPuMCI9tQEAvzYPAtyZtF9A
o8AofY1070asyuWTmZNoBs4WWZOnHQ4=
=P/nX
-----END PGP SIGNATURE-----

--zfutohgftfydg3jy--
