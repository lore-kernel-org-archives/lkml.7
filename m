Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59237C282DC
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 06:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18D2321855
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 06:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554530806;
	bh=DtSIeCPbNFcH3bLaH6PaMSfEMVnP+RQBrBP7jaSxvg8=;
	h=Date:From:Subject:References:In-Reply-To:Cc:CC:To:List-ID:From;
	b=bLr58iMytd67tgj68ESsWzd42hrdXaNSRAoFt83ol4Hu2In3V9aufY1tLAYsQwrPJ
	 9ZLmT3QriFqh0H3Qc27orpNZ/X5ueiU6gtB14bNUr6axk0Q4q4eJ2AdxVXZd76Bvac
	 VThUgoTQgZNtMnszlVKtrDWaNdSfZ4wXjGZT0OVU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfDFGGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 02:06:44 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38930 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfDFGGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 02:06:42 -0400
Received: by mail-pl1-f194.google.com with SMTP id b65so4178008plb.6;
        Fri, 05 Apr 2019 23:06:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:cc:cc:to;
        bh=bbAmIJbldZbCy78uIOjJhwTCss+Q8NR0NoedSxbMP8I=;
        b=KFkYENYMw22/No1O1cGPFopYRexDXPZBvl1GcyG4ZEi6el2mEsKAlgP0ABX5wIfs28
         qJpj/q/PH1eHQVt9Z2b82jQLSwj0XgHN9+yVDGb7X1ZCuUnAJk1UbprfZqCbnovtKp0i
         pvzvL4J1sAV1BLqIZdOHybursuOKf3k274JXe57Hz8smBotID+GFCw0+OBW51pUI+uhD
         owfi9RddYTVZQ4jSCJHJQE/jsUjhW4KB2IYw/+V8YUnLhIXzHXj+DMbEuH71hufBPwrb
         7GE6DyxEXcPzj84ei33YlVTxh3tgONi8EjsjUviVUwyDkSiXDzDkBBB2pHhZGeM3K+Xw
         6JGg==
X-Gm-Message-State: APjAAAWtzi/Pfi2tGkVZJlRmz383Vo1De6bnYUBbtkcq0svsF379D7qv
        4CN2Mb+UFZSnkQrOBeoATQ==
X-Google-Smtp-Source: APXvYqwY7Lb+RTif6ZGt9tBCJY59HlWPeTd238xBmW5o0ZXev57FbIpv07rogAXRSQrsFezP0BcU6Q==
X-Received: by 2002:a17:902:b706:: with SMTP id d6mr17348748pls.250.1554530801653;
        Fri, 05 Apr 2019 23:06:41 -0700 (PDT)
Received: from localhost ([210.160.217.71])
        by smtp.gmail.com with ESMTPSA id n5sm28635257pgp.80.2019.04.05.23.06.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 23:06:40 -0700 (PDT)
Message-ID: <5ca841f0.1c69fb81.3c62c.c015@mx.google.com>
Date:   Sat, 06 Apr 2019 01:06:39 -0500
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 3/3] dt-bindings: iio: adc: Add AD7616 ADC documentation
References: <20190402131841.8430-1-beniamin.bia@analog.com> <20190402131841.8430-3-beniamin.bia@analog.com>
In-Reply-To: <20190402131841.8430-3-beniamin.bia@analog.com>
Cc:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <biabeniamin@outlook.com>,
        Beniamin Bia <beniamin.bia@analog.com>
To:     Beniamin Bia <beniamin.bia@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Apr 2019 16:18:41 +0300, Beniamin Bia wrote:
> Document support for AD7616 Analog to Digital Converter.
> 
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

