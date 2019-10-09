Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7503AC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 23:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 460DB206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 23:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570663451;
	bh=/GpAflxlNzcb4NyyWw/yIpiUwQMk4tD3nZH9dA59YkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d+Y/fHmqRiGMEdelyhTUIYoC9P5ppPoUVBiaH+YMO+TcwTwB2XZYEiUbl3UEGRUTc
	 ppGV9mqtOLmj2PNxHCMJFs896MafBOAubM4IScKuIceqLCY66Ql5TVh4cPz1EjvdkC
	 O2FEsV7sXK4xBm8PoK8J4KmoQOOo9wAXUWHwPjU0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732372AbfJIXYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 19:24:10 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35859 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732302AbfJIXYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 19:24:09 -0400
Received: by mail-oi1-f195.google.com with SMTP id k20so3293598oih.3;
        Wed, 09 Oct 2019 16:24:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p2uJpsQDzBJSTPb7rB4lvdIue52gGSFXlWMh9zAidkg=;
        b=XBhCoPU8ODRuHCdRJpAUNhwJ3o8WjKHdoqzB6Desx5LhKi6W7BOjgcLoGylOgG0q2X
         5zghZo9PAY0HuOg4BZObtJ9Y6sg8Jwe9NZ94/UP68YDOpIuLzD9YvntE1qd+ZReyL8YY
         ZVMjuYUJ3x0lDO96Ly8BB6fsKvUeVCMavZHC9RFNyY12P+yV08lkRkI+qakzCqu5JDuA
         lsL9X3nHLuFIAxIi4+2fK2A6yUznx9BQ59t30aM50ZEjte41Utho8ea6CYijUW63iTUG
         X4BcrG4UviizaurYMZecTNlDMXGKvjqWWBRkKrSE0gF0+XmzjztoYu2r/C6EAElusZMC
         Hk5A==
X-Gm-Message-State: APjAAAXpbPlFjiCHf6902DzvLFsTg/5Y0YRHpqXND0A77ggKJKnLEQ+N
        3XMG6zZt51++dFZe7oLi9Y37VOA=
X-Google-Smtp-Source: APXvYqyu5GHQOmYGTor2YwQOdGRtJ6pDl9wBprjRBzw+/WUDC90fPs49BB/yoDtbgT39eTC9L7GMOw==
X-Received: by 2002:a54:460c:: with SMTP id p12mr4815506oip.62.1570663447561;
        Wed, 09 Oct 2019 16:24:07 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 38sm1173699otw.28.2019.10.09.16.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 16:24:07 -0700 (PDT)
Date:   Wed, 9 Oct 2019 18:24:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Mark Rutland <mark.rutland@arm.com>, Peter Rosin <peda@axentia.se>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v6 2/2] dt-bindings: at24: add new compatible
Message-ID: <20191009232406.GA23532@bogus>
References: <20191002072047.20895-1-brgl@bgdev.pl>
 <20191002072047.20895-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002072047.20895-3-brgl@bgdev.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  2 Oct 2019 09:20:47 +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> arch/arm/boot/dts/at91-dvk_som60.dt.yaml uses the compatible string
> 'giantec,gt24c32a' for an at24 EEPROM with a fallback to 'atmel,24c32'.
> 
> Add this model as a special case to the binding document.
> 
> Reported-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  Documentation/devicetree/bindings/eeprom/at24.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Applied, thanks.

Rob
