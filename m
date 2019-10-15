Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11291ECE58F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D55282084B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571159461;
	bh=wTDik904/kYpwrWAkIHjCVNdcDY8SPqfe+djb+UuTN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eLGLLLgcY/ym1Z0Z/NK1IzKXKHDcE7uvKoo1fna9I/JWsdIypoTNw5p04g2Jyvs1B
	 dpQZpBW3lAQSYiJFCsXQKdha6Iq47H5RHzDNWCWJ4Q06YoM3p7ozyAhQo73WWZynle
	 hgCkNMaOF+jR5j8VkKYXjGyDW8olvwg5+56PQe/E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbfJORLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 13:11:01 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37332 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbfJORLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 13:11:00 -0400
Received: by mail-oi1-f195.google.com with SMTP id i16so17504820oie.4;
        Tue, 15 Oct 2019 10:10:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sHvL2755l1wK28oCVPLb2FpzLhuPdUG7orNUoD4vL0s=;
        b=CjZk3U6Ph6UgtVU9jos5/MSD6XwzPo51GC9DIJb0FLqekgdnmoMZJzGM8qYl70j37u
         TVxk/mrhLIHZ9lYPSewRTtItsC/7bLH5L4hVYBOyw2k1Kh6IgalqPcaaBdpDZU7AcUiG
         HLOUsSwuBrQggW51zwB6iRSAjzRbEIid0MIF+euy9x8L789hfIsxpDH9B14TQXzK/qn+
         dzKuQGy3ADPj6keML52r3Pt/deCwIOUD6/7tAy744QNeK3yOMuG3oIxPouWHF9c3BE4k
         RniAWx6hjiIREBNK4EGDT9dSnsP7qCL8Q/tii/8qpDavoP1QBBzIM1N36cCtiyDs8xU1
         xY4g==
X-Gm-Message-State: APjAAAWe9UwTWjMo+16dTzcw6efFtylZihTvd5hCr0lU7qOSuJlAGy+S
        MTj57c+g9jTwqkIqGI6Omg==
X-Google-Smtp-Source: APXvYqwAdhK4wmfBuECugKN7hmoEcKhxuh3sBgPmjAEK2iKSpPvHvbMjZohPd0JB3bp+PLEPFwCj8w==
X-Received: by 2002:a05:6808:114:: with SMTP id b20mr30366866oie.114.1571159459445;
        Tue, 15 Oct 2019 10:10:59 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t18sm6857275otd.60.2019.10.15.10.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 10:10:58 -0700 (PDT)
Date:   Tue, 15 Oct 2019 12:10:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: rtc: s3c: Use defines instead of clock
 numbers
Message-ID: <20191015171057.GA11141@bogus>
References: <20191002160744.11307-1-krzk@kernel.org>
 <20191002160744.11307-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002160744.11307-2-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  2 Oct 2019 18:07:42 +0200, Krzysztof Kozlowski wrote:
> Make the examples in S3C RTC bindings more readable and bring them
> closer to real DTS by using defines for clocks.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/rtc/s3c-rtc.yaml | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 

Applied, thanks.

Rob
