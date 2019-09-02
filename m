Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D84C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A43A7216C8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567431614;
	bh=U93H7YkrVvUP58I65sSKXB50tQJks72DUG7jUhKXOMY=;
	h=Date:From:Subject:References:In-Reply-To:Cc:CC:To:List-ID:From;
	b=fk/rBKWKfezNiVulNmF5LVRvaJA52CeZVJ/TO1b7yxdtsWGQPJcMLLKs8HvQwb8zH
	 xGf6YM2vB56UKpkH6fz8wrc/tUZezTdLbFSQ/eC85y36pgi/Gtt7y4ZbV2Ofix+CCA
	 wdeBQftefvjU087b4NOh0WL1MsIOFd4ez02RG41s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731100AbfIBNjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 09:39:01 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35408 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731044AbfIBNi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 09:38:57 -0400
Received: by mail-wr1-f68.google.com with SMTP id g7so14103041wrx.2;
        Mon, 02 Sep 2019 06:38:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:cc:cc:to;
        bh=nPRUA5yZXmPWTokSGym1lKZ6GQZy5ySBbJLcfcoglsY=;
        b=BFcpCg0LAn+Q+c79wtcXvehQXl8AqZ6jW9xkIm8so5A5qQRk/Bnf4IC9He2z4Mi8FU
         LWbBApIFugWYM6jWqKmyV0F21F/NhsA+hdmdhJUJ8/lwHVsV3xm1WEBfqok4YB5Z+/vG
         rdXJlBOUpvmsDU1j/LDIYsdu9qLYWTfpuiIcjOd4/YKDm3WdzYqnaGV9s3A1TGpMsTm5
         bgnYwuddXFknk+q7+rW7y5Ty9bo6pCTbZ1x2NHNfuQpP43Iz2OlC9dSxXtWU9/Uhsq0i
         6Vs3MyBSf4ceOiTaJICerNTXgmAZL5fNHr2iOhzV96qzsoJ40wMITKqI2n+6UuLb3OHU
         Uqew==
X-Gm-Message-State: APjAAAXLJtbf477yjOyk6n0sUdJjXo/hdGbR07IbIHDcPktiayTJZzS6
        Eyj2AvaK6beJZi9bkU5nnA==
X-Google-Smtp-Source: APXvYqyvbrMPmMiV5b3gWdHNFD445UozayaIuP3ud47MYHnGtI4Z0dvVWaAlPFhYplcTUpqc5ajKFA==
X-Received: by 2002:adf:ff8e:: with SMTP id j14mr35307186wrr.141.1567431534372;
        Mon, 02 Sep 2019 06:38:54 -0700 (PDT)
Received: from localhost ([212.187.182.166])
        by smtp.gmail.com with ESMTPSA id t203sm15258248wmf.42.2019.09.02.06.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 06:38:53 -0700 (PDT)
Message-ID: <5d6d1b6d.1c69fb81.a78b7.2ccb@mx.google.com>
Date:   Mon, 02 Sep 2019 14:38:53 +0100
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH next v11 03/11] dt-bindings: usb: add binding for USB GPIO based connection detection driver
References: <1567070558-29417-1-git-send-email-chunfeng.yun@mediatek.com> <1567070558-29417-4-git-send-email-chunfeng.yun@mediatek.com>
In-Reply-To: <1567070558-29417-4-git-send-email-chunfeng.yun@mediatek.com>
Content-Type: text/plain
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Biju Das <biju.das@bp.renesas.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Min Guo <min.guo@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Aug 2019 17:22:30 +0800, Chunfeng Yun wrote:
> It's used to support dual role switch via GPIO when use Type-B
> receptacle, typically the USB ID pin is connected to an input
> GPIO, and also used to enable/disable device when the USB Vbus
> pin is connected to an input GPIO.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> v11 changes:
>  1. add Reviewed-by Linus
>  2. change compatible as "gpio-usb-b-connector", and remove label
>     in example suggested by Rob
> 
> v9~v10 no changes
> 
> v8 changes:
>  1. rename the title
>  2. change the compatible as "linux,usb-conn-gpio" instead of
>     "linux,typeb-conn-gpio"
> 
> v7 changes:
>  1. add description for device only mode
> 
> v6 changes:
>  1. remove status and port nodes in example
>  2. make vbus-supply as optional property
> 
> v5 changes:
>  1. treat type-B connector as child device of USB controller's, but not
>     as a separate virtual device, suggested by Rob
>  2. put connector's port node under connector node, suggested by Rob
> 
> v4 no changes
> 
> v3 changes:
>  1. treat type-B connector as a virtual device, but not child device of
>     USB controller's
> 
> v2 changes:
>   1. new patch to make binding clear suggested by Hans
> ---
>  .../devicetree/bindings/usb/usb-conn-gpio.txt | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/usb-conn-gpio.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

