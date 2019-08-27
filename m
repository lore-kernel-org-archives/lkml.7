Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDC4C3A5A4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 22:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA7A02064A
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 22:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566944670;
	bh=oixX6KuRujFMeX2OPQsYTU2rzNOfXO5xB8JaYvDRRqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=h7J9C1Ix1A7+KkG6u/Ddw2VH3nOrBaklole8E7jwAeMD5EDhkMMOsEc9Ly69Uwn5l
	 X1zbBC2ClX04VlRJgfGj8kG0DakFVVFmCWuhNBQPj6tiF9BU0wxN64UiCtAhU8HBBF
	 Ah9tGONnVqovBG3tNZRg/lfgXupIao3qJoZL2iHQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfH0WY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 18:24:29 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38120 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfH0WY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 18:24:29 -0400
Received: by mail-ot1-f68.google.com with SMTP id r20so778519ota.5;
        Tue, 27 Aug 2019 15:24:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mjdVVMQDkqNGF0eOBZhI/HxQmymiMnbH3eAi/1SeQc4=;
        b=WSE2LCreLFoxO4tp1I7WE7b67w6kzvZUD3LROkETpJIqdTHsP9sZB+agvo4ACaRv7S
         SBCQBEakvOo9UYxYA1Sr5u8h/EcsE8lT60t6V6TRz18XiJ5e/ITLZLyC5SXN5Ic4nkrY
         oj0Zzj1LSpVfkHd1u6cIKRS0SngELA/wM6f39AbfkQp6eP3aaVJvRH32Gn/QudSxPoq+
         HxGEW5HhvcTpZhrEyZ/B/vlu5+3yEf9YRvdKEszlH585DAm3pfr6vZ6y2Cv3f+EKG5YG
         3gP2ZBuGfH8rAjfjlgRqkaOgqV0bNlHfN+F7pGPkuAu6nHjkfcpQ+ZjSku5m8i/OMZ2l
         97AA==
X-Gm-Message-State: APjAAAWpvd/FUYn79eBWrDgwgvu+8IpS/MPEZbzVNthLwBKFvpS08fbh
        Wy3NaGSpVcMdMmhFdT9Blg==
X-Google-Smtp-Source: APXvYqwk+lluzv6pKjU/kkkAdMVAJPZi8mAQRb45qY3E88UmalXi1rmX7cue6EBW5ApX5eQDaCXD7w==
X-Received: by 2002:a9d:7092:: with SMTP id l18mr749674otj.217.1566944668217;
        Tue, 27 Aug 2019 15:24:28 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g93sm269906otb.39.2019.08.27.15.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 15:24:27 -0700 (PDT)
Date:   Tue, 27 Aug 2019 17:24:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Olof Johansson <olof@lixom.net>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH v2 05/20] dt-bindings: phy-mmp3-usb: Add bindings
Message-ID: <20190827222427.GA16221@bogus>
References: <20190822092643.593488-1-lkundrak@v3.sk>
 <20190822092643.593488-6-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822092643.593488-6-lkundrak@v3.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Aug 2019 11:26:28 +0200, Lubomir Rintel wrote:
> This is the PHY chip for USB OTG on MMP3 platform.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> 
> ---
> Changes since v1:
> - s/usbphy@/usb-phy@/
> - Dropped a reference to Documentation/phy.txt
> 
>  .../devicetree/bindings/phy/phy-mmp3-usb.txt        | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-mmp3-usb.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
