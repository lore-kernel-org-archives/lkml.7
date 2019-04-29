Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84ED4C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E892147A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556559349;
	bh=4q7D1RIy2PDm4okkJz7V0QHhRcQbreOxigDXu5/zr+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mnZkvRnpkkFxQkSqcgnHFN5mj+1ey/nN+aQ2OeDFk/1qufbAclhmltoCkAlLNx84q
	 AGIWmnjbdLnmaWd7f6a9TePlseEkTwpLhBmmlQqMC15xVFUEKBmPajRwAflKF47H7X
	 nBpaVBwwgDeOxRX8nYthZc+9mF7OL07tfV1ilk4g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbfD2Rfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 13:35:46 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34181 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728839AbfD2Rfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 13:35:45 -0400
Received: by mail-oi1-f195.google.com with SMTP id v10so9013949oib.1;
        Mon, 29 Apr 2019 10:35:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5my8Cn6Y2HODVuVBQINEOeT+yTibXOX7mtG9Sio7Q0E=;
        b=LfSBNr0/70Av5NAeTEn3aOdnp0WdBklm01BymQi1imk7RivX15OEXlMtuJcsaE423+
         GwXnOV2yx81a/QTcGGKXWWx/OTs3oTTFMOgRbqH5p6zspV+/A9bKG/rI7Amt0vGnWw4C
         KMrU3PVBSj98wDG+piD9QnW7HPumplWZw4d0p8iC/dh/2IZwy/XVdNCmz8o4d7TXnCae
         olw5oraqah1MmbG4xdt6jv6PtNaGPiLm32FTxr6etSBPUW0xPy1ADOnv+85xgmrMEvMG
         yaMYzClxQwaSMMuKFB1E7ADhCFwg5U//rHc7mwSYWyyc2/DHf3jphVq0EL7hBvMPEFY0
         87lA==
X-Gm-Message-State: APjAAAXOh3JLlMnF1+BB64M9Ha9b9tS75SYj850G8H+Y8QuMPdhE09lD
        owu1mdUICVy06WMEl6qOgQ==
X-Google-Smtp-Source: APXvYqwObFMf5MsBWU0lmxv2jIpKllIDnzZvko6iCmt8LLZUNAsA23aXPX+A4t6zBy6L1b1EpsGZbw==
X-Received: by 2002:aca:b944:: with SMTP id j65mr178617oif.58.1556559344792;
        Mon, 29 Apr 2019 10:35:44 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u127sm641756oif.14.2019.04.29.10.35.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 10:35:44 -0700 (PDT)
Date:   Mon, 29 Apr 2019 12:35:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Otavio Salvador <otavio@ossystems.com.br>
Cc:     linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        Otavio Salvador <otavio@ossystems.com.br>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: fsl: Add support for
 imx6ul-pico-dwarf
Message-ID: <20190429173543.GA4192@bogus>
References: <20190407193723.3351-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190407193723.3351-1-otavio@ossystems.com.br>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  7 Apr 2019 16:37:22 -0300, Otavio Salvador wrote:
> From: Fabio Estevam <festevam@gmail.com>
> 
> Add support for TechNexion's imx6ul-pico-dwarf board.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
> ---
> 
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
