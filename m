Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0EAC3A5A6
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E63E72184D
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729940AbfH0JwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 05:52:14 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33423 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728808AbfH0JwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 05:52:13 -0400
Received: by mail-ed1-f66.google.com with SMTP id s15so30581027edx.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 02:52:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rc+av+2pK1nD1xvCN1Qm/YJr4PtOyial+kNBUV8i24U=;
        b=sI5AneQzcPvaoxGO0av9sTzc9/p288FuWa7T3gsskgDA+BCX/jDqUP8GguHQiJHlN5
         nxotJcQmS4KHs4a0wWkakg6W2G8CsRpoX7luK94BLuH07i/ZgvTQRuM9vZVeyKLRDkYz
         fjBu3HFZQ2dm7L+dUl2KHyBNyGqEElmzYxIgmbm+HxOC3lipvOJPJk5HVTHVivCC2mWv
         Vs1sTjeVbeqe3Ftc7G1MaT7Zb8wBtAJidoC9gOsoRT57sU2ZC/yBome/wAQQ4wxuMGm/
         O8J1VAYV9RN74Zr74RUSVl8vje1Tv2AbD3VGFSdV89YUHJdmE8fT0EGYE5RNocmW6bcK
         O+UQ==
X-Gm-Message-State: APjAAAVmus/iqwvMWq298mMIbKZIRdE7x7KG+mj8kjU8/HSL4+big9dn
        SNl1NtJDN60Bfe0kjXxBPzlnE8DYiOs=
X-Google-Smtp-Source: APXvYqwDGJh86yyfoimefYGxQ1g75jvplmAUt+FcEqni+FsxWB/VM6BXQgkiZr968JZEAdpU0UZpZA==
X-Received: by 2002:a17:906:2310:: with SMTP id l16mr20821471eja.0.1566899531239;
        Tue, 27 Aug 2019 02:52:11 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id oo19sm3383313ejb.38.2019.08.27.02.52.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2019 02:52:10 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id m125so2311544wmm.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 02:52:10 -0700 (PDT)
X-Received: by 2002:a1c:4c06:: with SMTP id z6mr26674457wmf.47.1566899530466;
 Tue, 27 Aug 2019 02:52:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190827093206.17919-1-mripard@kernel.org> <20190827093206.17919-2-mripard@kernel.org>
In-Reply-To: <20190827093206.17919-2-mripard@kernel.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 27 Aug 2019 17:51:59 +0800
X-Gmail-Original-Message-ID: <CAGb2v64u+Q87woZpVbRLfwn=ocbx9QJeANYiALZ7x7rdDFXc=w@mail.gmail.com>
Message-ID: <CAGb2v64u+Q87woZpVbRLfwn=ocbx9QJeANYiALZ7x7rdDFXc=w@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: sun4i: Revert A83t description
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Code Kipper <codekipper@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 5:32 PM Maxime Ripard <mripard@kernel.org> wrote:
>
> From: Maxime Ripard <maxime.ripard@bootlin.com>
>
> The last set of reworks included some fixes to change the A83t behaviour
> and "fix" it.
>
> It turns out that the controller described in the datasheet and the one
> supported here are not the same, yet the A83t has the two of them, and the
> one supported in the driver wasn't the one described in the datasheet.
>
> Fix this by reintroducing the proper quirks.
>
> Fixes: 69e450e50ca6 ("ASoC: sun4i-i2s: Fix the LRCK period on A83t")
> Fixes: bf943d527987 ("ASoC: sun4i-i2s: Fix MCLK Enable bit offset on A83t")
> Fixes: 2e04fc4dbf50 ("ASoC: sun4i-i2s: Fix WSS and SR fields for the A83t")
> Fixes: 515fcfbc7736 ("ASoC: sun4i-i2s: Fix LRCK and BCLK polarity offsets on newer SoCs")
> Fixes: c1d3a921d72b ("ASoC: sun4i-i2s: Fix the MCLK and BCLK dividers on newer SoCs")
> Fixes: fb19739d7f68 ("ASoC: sun4i-i2s: Use module clock as BCLK parent on newer SoCs")
> Fixes: 71137bcd0a9a ("ASoC: sun4i-i2s: Move the format configuration to a callback")
> Fixes: d70be625f25a ("ASoC: sun4i-i2s: Move the channel configuration to a callback")
> Reported-by: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index a6a3f772fdf0..498ceebd9135 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -1106,18 +1106,18 @@ static const struct sun4i_i2s_quirks sun8i_a83t_i2s_quirks = {
>         .has_reset              = true,
>         .reg_offset_txdata      = SUN8I_I2S_FIFO_TX_REG,
>         .sun4i_i2s_regmap       = &sun4i_i2s_regmap_config,
> -       .field_clkdiv_mclk_en   = REG_FIELD(SUN4I_I2S_CLK_DIV_REG, 8, 8),
> -       .field_fmt_wss          = REG_FIELD(SUN4I_I2S_FMT0_REG, 0, 2),
> -       .field_fmt_sr           = REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 6),
> -       .bclk_dividers          = sun8i_i2s_clk_div,
> -       .num_bclk_dividers      = ARRAY_SIZE(sun8i_i2s_clk_div),
> -       .mclk_dividers          = sun8i_i2s_clk_div,
> -       .num_mclk_dividers      = ARRAY_SIZE(sun8i_i2s_clk_div),
> -       .get_bclk_parent_rate   = sun8i_i2s_get_bclk_parent_rate,
> -       .get_sr                 = sun8i_i2s_get_sr_wss,
> -       .get_wss                = sun8i_i2s_get_sr_wss,
> -       .set_chan_cfg           = sun8i_i2s_set_chan_cfg,
> -       .set_fmt                = sun8i_i2s_set_soc_fmt,
> +       .field_clkdiv_mclk_en   = REG_FIELD(SUN4I_I2S_CLK_DIV_REG, 7, 7),
> +       .field_fmt_wss          = REG_FIELD(SUN4I_I2S_FMT0_REG, 2, 3),
> +       .field_fmt_sr           = REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 5),
> +       .bclk_dividers          = sun4i_i2s_bclk_div,
> +       .num_bclk_dividers      = ARRAY_SIZE(sun4i_i2s_bclk_div),
> +       .mclk_dividers          = sun4i_i2s_mclk_div,
> +       .num_mclk_dividers      = ARRAY_SIZE(sun4i_i2s_mclk_div),
> +       .get_bclk_parent_rate   = sun4i_i2s_get_bclk_parent_rate,
> +       .get_sr                 = sun4i_i2s_get_sr_wss,
> +       .get_wss                = sun4i_i2s_get_sr_wss,

You want sun4i_i2s_get_sr and sun4i_i2s_get_wss here.

Otherwise, with both patches applied, I2S on the A83T returns to normal.

Tested-by: Chen-Yu Tsai <wens@csie.org>

on the Bananapi-M3 with a PiFi DAC v2.0 (has PCM5122) connected.
16bit stereo 44.1kHz, 48kHz, and 96kHz samples tested.

> +       .set_chan_cfg           = sun4i_i2s_set_chan_cfg,
> +       .set_fmt                = sun4i_i2s_set_soc_fmt,
>  };
>
>  static const struct sun4i_i2s_quirks sun8i_h3_i2s_quirks = {
> --
> 2.21.0
>
