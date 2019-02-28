Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B23C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BC4A218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551370461;
	bh=WvxG+fvPmfQLklqZfG7Wx1UiGcnq4GgnqCNwYMlnixs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1n7Z/sK9TQIWKiXAuxNfH0PqUSFuIhJdSMK4zKNxzdO93+eKLmoL4OLGF45VBLmk1
	 IUThyXPL5Cv+hRn6pqC9+fdrX/efN+wLwJ3B6UERGp4NGJAm+uCi8Sb4heq6pRazR3
	 Ghfq+olw9CReDEnhSZXvK3daKdAVR52POm5OgkZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731979AbfB1QOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 11:14:20 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41939 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbfB1QOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 11:14:19 -0500
Received: by mail-oi1-f193.google.com with SMTP id e7so16925332oia.8;
        Thu, 28 Feb 2019 08:14:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1yCi+l0d1N6btSY7Y2t5Y16kw8CGpCXoapPCxC+MkEY=;
        b=VE8B0rDnTPiVQSgjg1xB/KazxtP/BGBGFPNt0gaNGAkOuwjrTNQpvGCnLEbGQZLkKV
         E7uNaTT7918MP9CSv0cRhMZA+pzVSnTy/6PrmGSN6bqVSL3NUvxJIgiv5kxnXFnmuPpv
         RsCNY429wEhWa9YepaCP8KJeXYICsFI15kepyQTDvR+yztfTMp/ZygB8SQOoreFUGuDJ
         jJD28m5i8byZtm7WY7Aj4Di+olw7MHaHUmcigwGSzoAG4NlI8l20KsG50/wVlTRiTEuf
         Z7jcxm5f0WapxZlDJOx72X63vKl7OfGakpJnrd05GmaV3VXWfL7e0pGkdR/SHrodDcqz
         B9Lg==
X-Gm-Message-State: AHQUAubuIxBUeNAKgBBS0dWouT3cpHQ8OVo4JN2hFv+0P66x64a0yD2f
        59QRgJvGG6obbxEJY9MAcw==
X-Google-Smtp-Source: APXvYqxRQNXOjRsvjDpIrKJLiOc4GbYNNivGHurUh9td6dPe4XeFtFVT7nqTOS0r6w/SfLVNMP9D9A==
X-Received: by 2002:aca:7201:: with SMTP id p1mr283553oic.159.1551370458595;
        Thu, 28 Feb 2019 08:14:18 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m65sm2837868oia.15.2019.02.28.08.14.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 08:14:17 -0800 (PST)
Date:   Thu, 28 Feb 2019 10:14:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com, devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] dt-bindings: usb: dwc2: Add Amlogic G12A DWC2
 Compatible
Message-ID: <20190228161417.GA31632@bogus>
References: <20190212151413.24632-1-narmstrong@baylibre.com>
 <20190212151413.24632-4-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212151413.24632-4-narmstrong@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2019 16:14:08 +0100, Neil Armstrong wrote:
> Adds the specific compatible string for the DWC2 IP found in the
> Amlogic G12A SoC Family.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  Documentation/devicetree/bindings/usb/dwc2.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
