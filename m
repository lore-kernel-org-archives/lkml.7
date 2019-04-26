Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7D1C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8179C208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556305135;
	bh=2LXR/MN66uoUr9gyWOQqmpQ0t0XS3daDJJG29XdfRF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JRt4UUM0Pzzm/LwVezQw1hay8plF9F/6NkRBDD0OmPwOUWUewAV6vSyyIaQ7KxUx6
	 kC99aqNJn3o15q+gaX0fpNuF/JSLnlcB9KM5oP5kEmJQO/+PAsrxbHKecyBOUh3Uf4
	 PdID1R2J4yCMRUkzf+juM75GZWRV4YK2FTwY4FkA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfDZS6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 14:58:54 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:32971 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfDZS6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 14:58:53 -0400
Received: by mail-oi1-f195.google.com with SMTP id l1so1919497oib.0;
        Fri, 26 Apr 2019 11:58:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3wgpsllXyOhEHOZXF8Na8CuN4CB/+EEzHMk70K8lsuU=;
        b=ck3x6gC5hyUF7mgX9CupLilrndViTHe4vKD0pyJDLwHzLRy2wybvcSC7vsS2r1j6tu
         kQU3Lr8z9ygxuMPpZlTybhW+QvAzO0XGxo1jxe/l8F2vRKLBXdVO/2AmFsRXFuGgvgdu
         YMaNeMB4gJlS3+RTLzgrzip3y3Q1o/xeBjXIp7wGTMq+mFDy6iG1527ltW2sOg3051ET
         ccOKJ2Vva9TlmDYWKwlN+PRtoYQdGUl1o+H0Exh2DihoQq7x4MTfa4SXd1K4IvvD2l8X
         hG0j0dKaTUzMys2VOIJOjkxxTm8woVx5511JQNbDH3oB52YMvRgcxsmZ4GmLO45dT6nn
         mRCw==
X-Gm-Message-State: APjAAAVeTXULYYGDKo5/EX38Vw6zDr9JTtUzgAol6EGVxrUrfQpRPc5U
        2+Xq3mUyuDnPiz4IGmonPA==
X-Google-Smtp-Source: APXvYqydfsdHRBKeHeqZccYkpZoBo04DXQ/AjOyfsggJCjTgjXzH2SCYturHTo5K6zGnzzsrelK35w==
X-Received: by 2002:aca:6c47:: with SMTP id h68mr8762971oic.57.1556305132973;
        Fri, 26 Apr 2019 11:58:52 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u22sm9917024otk.49.2019.04.26.11.58.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 11:58:52 -0700 (PDT)
Date:   Fri, 26 Apr 2019 13:58:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, pavel@ucw.cz, robh@kernel.org,
        dtor@google.com, linux@roeck-us.net, jacek.anaszewski@gmail.com,
        Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH v4 09/26] dt-bindings: lt3593: Add function and color
 properties
Message-ID: <20190426185851.GA29604@bogus>
References: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
 <20190417205439.17685-10-jacek.anaszewski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417205439.17685-10-jacek.anaszewski@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2019 22:54:22 +0200, Jacek Anaszewski wrote:
> Refer to new "function" and "color" properties and mark "label"
> as deprecated.
> 
> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: Daniel Mack <daniel@zonque.org>
> ---
>  Documentation/devicetree/bindings/leds/leds-lt3593.txt | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
