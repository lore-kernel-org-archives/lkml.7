Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D5DC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 12:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA5023407
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 12:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567081621;
	bh=/W7R9xxzqDBq436VEwzf8668PhZ5y/XAYp7b/rtwcaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=e6H99bYc+LZh0xgUFz8RsrZuFcqSgw6boOaZWVMOwskNkkcAO+CRIZb4QU02XQtm2
	 KWDrX7z5cn364hoCviPBtuGc2f98gp24xLK4+efT6uUbhwmHa9fBZBWO6hUr644WTS
	 /+93hWUaTUDhufh+dsM+PUtsg8gQ+2C0liIvRFnQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfH2M1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 08:27:01 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33815 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfH2M1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 08:27:00 -0400
Received: by mail-ot1-f65.google.com with SMTP id c7so3229103otp.1;
        Thu, 29 Aug 2019 05:27:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JISakUM5CfOU3yuiNb3Jx9kDoSgKiU08qnHS4spuyBM=;
        b=hyj0BFcrPhbvBEizPlqt74ZLL/7SqPhr7D72DbGqGGH6pLIdN15B9qsCpNLzNbpK+k
         24yBFgmm6ljcUyQ3A8paTPJRXwmzxDnnACOXu37eyBeKsAPaApa8YI5FM8LgRbQGD6GF
         H98Hu61ncpHqHtgmM3z0qmCiAV8s9RGQZ2M3blUVLkb9fKkblaqR+VYSz8ieXDRkal3N
         a90dfSamtQy6/bV+ymu91Y1kuIEkIEuh9DuHCbX2XvU33/6wxtqQVrWOZSv22X4zWvV3
         rMmZ/9J1mXzdhojoZmY3hlAJUJhMTALpYGPhKA/7/3RrWbleoptTY6TVJaoMvS+zFlzd
         TVpg==
X-Gm-Message-State: APjAAAVa9lH2fyJD+9z3mEd96CJXevHtGV484UVN2ByfAtTAUMc/p7pd
        VmCaIgjcAtNTJNreAa3M4g==
X-Google-Smtp-Source: APXvYqxQFzYed8B8VKY779L9N8Rwlqs155UUnDupIGmcQZ1ooy42GSMcysJRv7n+ECaVUK2B9ONlyQ==
X-Received: by 2002:a9d:7dc6:: with SMTP id k6mr6756221otn.99.1567081619385;
        Thu, 29 Aug 2019 05:26:59 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a94sm708682otb.15.2019.08.29.05.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 05:26:58 -0700 (PDT)
Date:   Thu, 29 Aug 2019 07:26:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: arm: amlogic: add Amlogic SM1 based
 Khadas VIM3L bindings
Message-ID: <20190829122658.GA10660@bogus>
References: <20190828141816.16328-1-narmstrong@baylibre.com>
 <20190828141816.16328-3-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828141816.16328-3-narmstrong@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 04:18:15PM +0200, Neil Armstrong wrote:
> The Khadas VIM3 is also available as VIM3L with the Pin-to-pin compatible
> Amlogic SM1 SoC in the S905D3 variant package.
> 
> Change the description to match the S905X3/D3/Y3 variants like the G12A
> description, and add the khadas,vim3l compatible.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
