Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA88CC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C039520656
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556306521;
	bh=1F2khgkoRKIsFiYJXgLMqb+Cy5iX+vMC6/M4MrRrk/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=z07U/N0BvttEPSdC1KMZfW6O8mpxdNpEQhRemLikheApOQjlt4PkrON5VWMF4Vgij
	 5Gi4ktsBUHKGzQYypTAyp5f+Fyn0+3l5KBm7Ehl4U/jjlw7YI5h5ojez5DFvVajZgY
	 1Gz8z6R26kEFmLur/7T+asDh8VAXB9FroW6TojGE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfDZTWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 15:22:00 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46551 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfDZTWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 15:22:00 -0400
Received: by mail-oi1-f194.google.com with SMTP id l12so3772915oie.13;
        Fri, 26 Apr 2019 12:21:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6HMDm93S/0eVZkdQMavmbUXv+egbHgwsW3EPun1qeXU=;
        b=aWbKy1FCgxJmHr5hOMVqaxaqEAhlii43PHDH5wT3PBBNQT1K72kwhCxkTAmHoEJeQM
         kYIfHynS5RMH6jT78sDndQu5Ni2oooOHmPz8U7+AoC2fUZWU9sQ49i6+nKkWbkNZiYFz
         PS/eaMDzD/do2sBgbKyjTgRVolk+3hBf/dEwCZAfpw8wdZeAPLd85uNy0F4JTWVdtR+U
         wGS7AqKwhWdazgV+8AOFGjDjUE5Y5zCHoTG7UePxUmSGlOSjQh/OzWE1X8XQTCHHX13G
         Sj8cXCswNHwYpldVg1Alg8/bIGMI2UDFdc9nw2JFLg2P+O7zaJNARLsfj/7h8et/TtjF
         5Hag==
X-Gm-Message-State: APjAAAXCLc1AeQk/jgH9JtHG/zkKsa3EuMLyxg0TXQFv9wxg4RG68kwG
        sfz4opP56ILZNz+GlDnTrg==
X-Google-Smtp-Source: APXvYqyhvCTH/4nCu1UVFz5SbcqBnWN4uHAmPySndPfOOZ7wooYMuHLLdWc2VJpVfQjxqNNCojKNnw==
X-Received: by 2002:aca:5946:: with SMTP id n67mr2217199oib.48.1556306519012;
        Fri, 26 Apr 2019 12:21:59 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l49sm10263829otc.19.2019.04.26.12.21.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 12:21:58 -0700 (PDT)
Date:   Fri, 26 Apr 2019 14:21:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, pavel@ucw.cz, robh@kernel.org,
        dtor@google.com, linux@roeck-us.net, jacek.anaszewski@gmail.com,
        Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v4 15/26] dt-bindings: lm36010: Add function and color
 properties
Message-ID: <20190426192157.GA4890@bogus>
References: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
 <20190417205439.17685-16-jacek.anaszewski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417205439.17685-16-jacek.anaszewski@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2019 22:54:28 +0200, Jacek Anaszewski wrote:
> Refer to new "function" and "color" properties and mark "label"
> as deprecated.
> 
> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: Dan Murphy <dmurphy@ti.com>
> ---
>  Documentation/devicetree/bindings/leds/leds-lm3601x.txt | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
