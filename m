Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BE3C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB6C20B7C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556305163;
	bh=EiUZ9Qn0g2nkZkWJ5mw7Dz9qrloUhfDu0BRxFyrk0SU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BxZy9rabGbS20yhhX9CqpfjOuiSWwiY7OnFFCs9WhtfQLebBRqjmefW2BaDlQQxNC
	 /dRccOyN6j8ibfFGW+YzoQPkTeVqTR7J2KfCktY3QBW8H8xHMS4QAcV2Ym3Fs+J4ME
	 UbfGWbRCWR3nWMNWE/l2uHT0GOAgL4FxNcowH38I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfDZS7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 14:59:22 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38223 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfDZS7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 14:59:20 -0400
Received: by mail-ot1-f67.google.com with SMTP id t20so3545826otl.5;
        Fri, 26 Apr 2019 11:59:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Tu7GT8F+HdxNfDDeb1vRMaXeiqSVfq6f2sQ6vqcx7Ak=;
        b=uRcB/gHsvDP0PFDNhTJkCsCfVe+z14ryHBRUMUz1oIkIO4rMZ2jYmYCKCoGjkTl9EN
         jdj9wFQSVi9PmNDgAD4k1CbDuL0gEUSfSYOcbjSW14BAWajqEmw896Shuz0JhTmuxlDj
         LLVlKgqX3cBW1gwCIOPy5DjkJ4GTj5ikk+67MCeHftJa7ISKs1yGV9wusXRXW8t4oLsC
         F8hKxyjo5VgGObOqhP82gGjqikOlXTbYvVE/N1Mw9U2wdNDtGNKpSqW8LgE2uwkRx7M1
         lnocqcNvnYPkjdTwxMq63UI/Imx0+cDHTLK5sYZqY9Y9XKHZsljdIMvVueoRZ5yjPWsB
         WcsQ==
X-Gm-Message-State: APjAAAUEdT7fS5Vw9eF/CQKcKf+j1kkAvE8zVq/ly4gzspcbGgyJhBO9
        u90x6vfpG9duCFHBcXhTeg==
X-Google-Smtp-Source: APXvYqz0d0Zcfhq8YXYXTLVHXaK2GqaEv+mvYtnipaYt2BoYO096f+a+jJGPZiJNT2t5FuUjk37LWg==
X-Received: by 2002:a9d:6355:: with SMTP id y21mr5757878otk.354.1556305160042;
        Fri, 26 Apr 2019 11:59:20 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 189sm11049208oii.58.2019.04.26.11.59.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 11:59:19 -0700 (PDT)
Date:   Fri, 26 Apr 2019 13:59:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, pavel@ucw.cz, robh@kernel.org,
        dtor@google.com, linux@roeck-us.net, jacek.anaszewski@gmail.com,
        Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v4 11/26] dt-bindings: lp8860: Add function and color
 properties
Message-ID: <20190426185918.GA30491@bogus>
References: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
 <20190417205439.17685-12-jacek.anaszewski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417205439.17685-12-jacek.anaszewski@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2019 22:54:24 +0200, Jacek Anaszewski wrote:
> Refer to new "function" and "color" properties and mark "label"
> as deprecated.
> 
> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: Dan Murphy <dmurphy@ti.com>
> ---
>  Documentation/devicetree/bindings/leds/leds-lp8860.txt | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
