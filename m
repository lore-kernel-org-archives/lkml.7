Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A26C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 22:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5603320725
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 22:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573770465;
	bh=08fnnqS7Zn4/LMs0wyS+HRQLQJVRn3gxe2zAVaXDe9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1VOMSDR2GfpgKfXWAIwuZliNffE7UASlwaKAgIMcnd9vWWrnMW3OElXGI8Z8Y60S7
	 NkwRmzeENPl1xspwQlaAio/k0T92UpR/GNhUQ43XJHL2CLUX42DkJoTbGRBkWRD14t
	 wYbrAJQQe0/zEvl1cpeV3gPygoVpo9jAYB/4gpRY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfKNW1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 17:27:44 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38050 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfKNW1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 17:27:44 -0500
Received: by mail-oi1-f194.google.com with SMTP id a14so6847998oid.5;
        Thu, 14 Nov 2019 14:27:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:content-language
         :user-agent;
        bh=Cq0LD8yuKCnh2UTHogff41GNJ+0SDF9ePhudesBQyZU=;
        b=WvZCgKlaOzUkP79yPt1v+h/oC06X77/+nValeo+eeKpeAY8wm7kXGM2kgefx/tWvzU
         nEzjIjTPcGU2nVBr9KvOVQql6yT23TFhI8WERBt+x0vXA4RYFNFGxvgX2dyCGyV4IVMN
         BwJe5BREBOxKJegwaXe6N3C1+EkNIYk6d3MgUADE2cYEERJsQv2DdWKHcb2/fAW7TZrg
         B9JYQq8mBl826vE8fmSr2i7PxEAE2HukgmRPT8CBjdlLRLEHG/y0jS8tsC33AHK47v17
         OROT4BrkElZU6+9OeA2pWX8z26sGeVov4m09tUyV3Al3BrgQjh5q20P5ZLz3BLQiWDn0
         42MQ==
X-Gm-Message-State: APjAAAUolgfVMcRSblBinpzFHRJpxc24S7yN3pBsD82qIqBgProkt3fN
        +bpxe6g8FTIUSBBz6nORnA==
X-Google-Smtp-Source: APXvYqx1PQt5sf4JKKbpGfkraBP3rybv7qUasEttesaViZEp6krjgQxVXIm2ZR69LyO0X3dVn2oYyg==
X-Received: by 2002:a05:6808:5c3:: with SMTP id d3mr5373342oij.81.1573770462944;
        Thu, 14 Nov 2019 14:27:42 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m11sm2217136otp.15.2019.11.14.14.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 14:27:42 -0800 (PST)
Date:   Thu, 14 Nov 2019 16:27:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Eugen.Hristev@microchip.com
Cc:     robh+dt@kernel.org, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Eugen.Hristev@microchip.com
Subject: Re: [PATCH 3/4] dt-bindings: ARM: at91: Document SAMA5D27 WLSOM1 and
  Evaluation Kit
Message-ID: <20191114222741.GA28212@bogus>
References: <1573543139-8533-1-git-send-email-eugen.hristev@microchip.com>
 <1573543139-8533-3-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573543139-8533-3-git-send-email-eugen.hristev@microchip.com>
Content-Language: en-US
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Nov 2019 07:19:54 +0000, <Eugen.Hristev@microchip.com> wrote:
> 
> From: Eugen Hristev <eugen.hristev@microchip.com>
> 
> Document device tree binding of SAMA5D27 WLSOM1 - Wireless module;
> and SAMA5D27 WLSOM1 EK - Wireless module evaluation kit, from Microchip.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>  Documentation/devicetree/bindings/arm/atmel-at91.yaml | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
