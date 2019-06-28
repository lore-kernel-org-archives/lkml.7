Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A90C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 19:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AED53208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 19:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561749762;
	bh=U+J4mDURRTdqdIBfmx1GlPKe4xNfE8V+AJexOwS10t4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LkpagvyJv9r9uiJcv4oGsrSH3WeGxJS5fNOOdjCPQDQ7i44bzkrqx863bIuAOljCP
	 wAeqJUBM37yZtI+nzYX6HqYFRdXD9OtPSw5aKdLNmiEbFSzIcgxJeYl+yaQKFKRIdN
	 aJWEsTaw5xoFdmSky9KxPc+VDhv2eyl3jO9E8tpM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfF1TWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 15:22:41 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38334 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfF1TWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 15:22:41 -0400
Received: by mail-io1-f68.google.com with SMTP id j6so14835735ioa.5;
        Fri, 28 Jun 2019 12:22:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SV3UaGLoeKUQCI7wGZiOfbddOtsjqVsakZX22AHysxE=;
        b=AfS92IuksD4AqsR+XNQaGaqAbBSKk/Ot7d+SNdIKKF5RIa0dQWPBfoZHWqwcqehPvo
         GGqJpQd8X91Vdj0GpfEJiSHcwGfSfgAkmVaHj/WpLG5GshlmejcX17GaOh9LJy7SByPN
         K+E+pFsmgs1JQjNqWNtqYcAEPLH2itf3TudSmUGIbZYjd+ofPKIcOSyVyyuUpSENnRmJ
         2ZitEvjq+cWl9m6jhTdRegKea7LxSkzBLT1xjxh/Ks+NPm22AjAfJDrqQ8rO2AnuFmYe
         xJxh5hrq/jqsNpZc9e2Qokqd8eBm/ADG7rGD5yGG4GswsInyrwh1WEGonQfzBIm/3v0U
         RLjg==
X-Gm-Message-State: APjAAAV4rJo22fDnSMMH1hZxqV8WRTxmq+piH0wNOcFUrPX+0QTb+stF
        aboOIT/R1724axJRNEwv2Q==
X-Google-Smtp-Source: APXvYqzFAiaMqX9Kc+pU35sAZ092vTl08ulqOCvMY9sGS0us9aZUSx2qrN6swZfkkImylaZ6IpC8fg==
X-Received: by 2002:a5d:9bc6:: with SMTP id d6mr1291115ion.160.1561749759989;
        Fri, 28 Jun 2019 12:22:39 -0700 (PDT)
Received: from localhost ([64.188.179.243])
        by smtp.gmail.com with ESMTPSA id c23sm2720600iod.11.2019.06.28.12.22.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 12:22:39 -0700 (PDT)
Date:   Fri, 28 Jun 2019 13:22:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     robh+dt@kernel.org, lee.jones@linaro.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com,
        jacek.anaszewski@gmail.com, pavel@ucw.cz, mark.rutland@arm.com,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dmurphy@ti.com, jonathan@marek.ca
Subject: Re: [PATCH] dt-bindings: backlight: lm3630a: correct schema
 validation
Message-ID: <20190628192238.GA8617@bogus>
References: <20190520085846.22320-1-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520085846.22320-1-masneyb@onstation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 May 2019 04:58:46 -0400, Brian Masney wrote:
> The '#address-cells' and '#size-cells' properties were not defined in
> the lm3630a bindings and would cause the following error when
> attempting to validate the examples against the schema:
> 
> Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.example.dt.yaml:
> '#address-cells', '#size-cells' do not match any of the regexes:
> '^led@[01]$', 'pinctrl-[0-9]+'
> 
> Correct this by adding those two properties.
> 
> While we're here, move the ti,linear-mapping-mode property to the
> led@[01] child nodes to correct the following validation error:
> 
> Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.example.dt.yaml:
> led@0: 'ti,linear-mapping-mode' does not match any of the regexes:
> 'pinctrl-[0-9]+'
> 
> Fixes: 32fcb75c66a0 ("dt-bindings: backlight: Add lm3630a bindings")
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> Reported-by: Rob Herring <robh+dt@kernel.org>
> ---
>  .../leds/backlight/lm3630a-backlight.yaml     | 20 +++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 

Applied, thanks.

Rob
