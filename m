Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507EEC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 164502075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556559062;
	bh=/cIJ2/sFBEhyIzzyKgFRdVZ2ayO43W+7j2E9kbEzzFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jz8PVptgGgx3zcLBd50bHDVGlXUJ+RuKCQlgL3Kim3XALDng2KmYdy/NeZJ0P/4EM
	 JbJkvZY8LbiPF6EziyuXLr3a0s0OLV49Dy4NojC3oiRpeq3+lYbglNlay0wSANs95P
	 LYmWUqCU1+vTXpCTWsPShdG2+0KYrEcAX8+eO00A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbfD2RbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 13:31:01 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:32960 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728798AbfD2RbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 13:31:00 -0400
Received: by mail-ot1-f67.google.com with SMTP id s11so5059227otp.0;
        Mon, 29 Apr 2019 10:31:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kqlQKcbLQtWgsHH7jStK2tGblJ8h/2QtS+03XVpeQ5k=;
        b=T2ZuOvfI+dvR86B4opZAAd+479etPgK0FBrU2Y9MUfo4+Hz0h6qW7EBpCaSUeQTTPQ
         NyMVUeJutCk5htDIc5Z3c9ndjy6cctd0JjJu2PQNsEkRe/OvKccs6WyHlkphaq7tv1sV
         VBXcdSJpeb1C6yCAUgKwxfmdjAeQBx3+XareFnH2CSzicmKJzy8C5hqxKEaBKPszvhVx
         dlav0Sg9Z5jiCiZoBxUPTkgofTYu3WkEs49Gsl9h7GfhUPAhbi+KzB8HH8mGr9RnlpAb
         PUrAChgAAHo7fvTXGfK9R5pawuSv26N7FlGcy0sONqmbHHQTNaecBCFgE8FIos/T73TL
         kPqg==
X-Gm-Message-State: APjAAAWrKjCONF/de+UtOsHK9bG9BPgW9LbZawrAy5LyBtSCx9W7gm7t
        mW78xFkK5LYvnr/jbxlXS6UfR30=
X-Google-Smtp-Source: APXvYqwyYM9k4u6YRL+yB0UqgHYntZv3yKNe8phFsDIwXO8jk85ccZ7idhXk05QFaTvS4aqmlaID4g==
X-Received: by 2002:a9d:22a6:: with SMTP id y35mr4666155ota.118.1556559059740;
        Mon, 29 Apr 2019 10:30:59 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q26sm2590468otk.74.2019.04.29.10.30.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 10:30:59 -0700 (PDT)
Date:   Mon, 29 Apr 2019 12:30:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     robh+dt@kernel.org, jacek.anaszewski@gmail.com, pavel@ucw.cz,
        lee.jones@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH] dt-bindings: mfd: LMU: Fix lm3632 dt binding example
Message-ID: <20190429173058.GA27596@bogus>
References: <20190405141907.3348-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405141907.3348-1-dmurphy@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Apr 2019 09:19:07 -0500, Dan Murphy wrote:
> Fix the lm3632 dt binding examples as the LCM enable GPIOs
> are defined as enable GPIOs per the regulator/lm363x-regulator.txt
> bindings document.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  Documentation/devicetree/bindings/mfd/ti-lmu.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
