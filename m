Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9C6C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 06:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 713F721855
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 06:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554530796;
	bh=3nd5kautVwujlwh/z37660NTnV5xS2aFrGMR6riaifE=;
	h=Date:From:Subject:References:In-Reply-To:Cc:Cc:To:List-ID:From;
	b=URbAFjmVk03uYqvN5sUiV2McmqohX7ZC4MoG8Zm14SzPvSLOEKeS+CqaAHNDRRo/f
	 OwPcLCsMrS6nL04ndnzt3pcdsq/ICdoiSLocyy+MrhO7c+b5AJpU6DuZnqJbwlepv3
	 p0kbAvWgioflWMzkYGloaZcRyhCXGieIU4lgzPZc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfDFGGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 02:06:34 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45330 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbfDFGGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 02:06:33 -0400
Received: by mail-pl1-f196.google.com with SMTP id bf11so4165962plb.12;
        Fri, 05 Apr 2019 23:06:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:cc:cc:to;
        bh=6tRZMZTM3gHeV1Jl/jbgl4DxlSQZQ0iKL3rwmSzooEA=;
        b=Y26GQzchopXiRKpFFG/1/15yXOiCyQ8EPigYOCKdHZMwsmzrsih1Jukpbaq79knWV6
         uztb74oAwAgfTX7y6nWWvWTkibXKIC8zNxo7ZxQJ2q8JRBURNlfIMhTlaL18MTBFZ879
         6otXYStiV37oPEqHJ0siQQiaqkjzsgIgLBO3RfigL6Rlt9KIDKtOqkhPavnmecIfR3/o
         mgDcPlc2FmsG5fF8VTPM86IzcOWpNug1QtZhAhXVwdDej0z4JZxb3K+sUgvmN2UUV+kR
         mjkWe8n7L6ZgpEZURyg85dN9H51zUrqNN+hhfdFGeewAJ87wwua5jNzoJGavtKDq65b5
         DeIA==
X-Gm-Message-State: APjAAAV0dyxmHJpxr1o1iBNjw2ag5B4Z15htXmOS41Wm0JGahJcK3fup
        ojWchM/eMPHPsF2CsaTHYQ==
X-Google-Smtp-Source: APXvYqwpVXvh6ti7NmxNGLM5TPUsmIfil+GQQZWO+iDzCxThAt3cR2AcL0teA0k0MPHCdySseOROow==
X-Received: by 2002:a17:902:b706:: with SMTP id d6mr17348222pls.250.1554530792824;
        Fri, 05 Apr 2019 23:06:32 -0700 (PDT)
Received: from localhost ([210.160.217.71])
        by smtp.gmail.com with ESMTPSA id h4sm31530339pfo.119.2019.04.05.23.06.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 23:06:32 -0700 (PDT)
Message-ID: <5ca841e8.1c69fb81.fc058.3930@mx.google.com>
Date:   Sat, 06 Apr 2019 01:06:30 -0500
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 1/7] dt-bindings: Add panel-timing subnode to simple-panel
References: <20190401171724.215780-1-dianders@chromium.org> <20190401171724.215780-2-dianders@chromium.org>
In-Reply-To: <20190401171724.215780-2-dianders@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sean Paul <seanpaul@chromium.org>
Cc:     linux-rockchip@lists.infradead.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        =?UTF-8?q?Enric=20Balletb=C3=B2?= <enric.balletbo@collabora.com>,
        mka@chromium.org, Doug Anderson <dianders@chromium.org>,
        Eric Anholt <eric@anholt.net>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>
To:     Douglas Anderson <dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  1 Apr 2019 10:17:18 -0700, Douglas Anderson wrote:
> From: Sean Paul <seanpaul@chromium.org>
> 
> This patch adds a new subnode to simple-panel allowing us to override
> the typical timing expressed in the panel's display_timing.
> 
> Changes in v2:
>  - Split out the binding into a new patch (Rob)
>  - display-timings is a new section (Rob)
>  - Use the full display-timings subnode instead of picking the timing
>    out (Rob/Thierry)
> Changes in v3:
>  - Go back to using the timing subnode directly, but rename to
>    panel-timing (Rob)
> Changes in v4:
>  - Simplify desc. for when override should be used (Thierry/Laurent)
>  - Removed Rob H review since it's been a year and wording changed
> Changes in v5:
>  - Removed bit about OS may ignore (Rob/Ezequiel)
> 
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Eric Anholt <eric@anholt.net>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Jeffy Chen <jeffy.chen@rock-chips.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Stéphane Marchesin <marcheu@chromium.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: devicetree@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-rockchip@lists.infradead.org
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  .../bindings/display/panel/simple-panel.txt   | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

