Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C08AC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD1F21881
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566922670;
	bh=40xNavFCg5EU2zE253SOFYwbtRuJXduJFYY/aER+XSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Jle+wuT+6rEqprsQsIA/95rceL34OtVKYiVso4zcy4waVKvwOyOKa6G4pqKgBuPk6
	 Y4VJyRSUn11MYwYCgW+w7wSG+6Z1qkNIgEmOTc09426MeVCoEnBIr0rTvHTC7U8yRz
	 WK+MnHHe/Zcjjo4da4GfaYR2lEJXVXZIJL1mly+Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730230AbfH0QRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 12:17:49 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34427 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727306AbfH0QRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 12:17:48 -0400
Received: by mail-oi1-f194.google.com with SMTP id g128so15438893oib.1;
        Tue, 27 Aug 2019 09:17:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7muvzMncx4YoE3IQ35DaVbjOS8KQcGXrD0KkrlfBrr8=;
        b=GSu7a6hX6FUj+pPyr9nlU6NtKgCFtzIkagj8xAikCJYR/wpKAxQGduezjhRdKjMnbt
         BMQS4FVLco1IfZ229PafuI33eeaEE+Dv5zHTYOlqq4XZWBInbJspQY8q8tCpgM7ivEpE
         iBqieUZ2ntUUMSOZy7YdfrDm8NN6UjMoa4x2nMF65OspktGYZ5Yi4YpK75ga9KtHwGnG
         e3lNbaKtVyDnTc1rXUq7M9lsDc08X+0SExK4w9molYdayT2NefjM75Rm07LXOEvV8D4C
         4nLZXkZOnAtppjvC3QoEODAO+yaKETkpb91tRSRlk1jQ+V4492Hmr/y25tQRXvEQtmxc
         dOMw==
X-Gm-Message-State: APjAAAUjmmxos7esXOz/GnfV3qZkyS4tEWZ+iPcUod9oyMjmbhiB0zeB
        iNtBfSLY3AnnZVqNP/jk3w==
X-Google-Smtp-Source: APXvYqySoYjSnor6MzzbBz/lQbLzJ0tJ+VwZ2+9peKDYeoigi2IqpZCPnjF5k6qLhms8Egjt860ocg==
X-Received: by 2002:aca:4c44:: with SMTP id z65mr10740973oia.113.1566922663759;
        Tue, 27 Aug 2019 09:17:43 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k67sm5469648otk.26.2019.08.27.09.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 09:17:42 -0700 (PDT)
Date:   Tue, 27 Aug 2019 11:17:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH v2 1/2] mfd: madera: Update DT binding document to
 support clock supplies
Message-ID: <20190827161742.GA7223@bogus>
References: <20190814092140.30995-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814092140.30995-1-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Aug 2019 10:21:39 +0100, Charles Keepax wrote:
> Add the 3 input clock sources for the chip into the device tree binding
> document.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> 
> No changes since v1.
> 
> Thanks,
> Charles
> 
>  Documentation/devicetree/bindings/mfd/madera.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
