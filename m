Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6282AC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF0320717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556217271;
	bh=bIBQVXd/KNA6jqyx9hv3g+WsCnVoK1JvpJ9uIFeUzt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YttDu3HMSUYCMfp98M3piXMzWHcYevhC6uM+3Qt7wZctaUypvhGgly8t04iH4J6VN
	 ZMnsDz0pBPWTTDMQ9gQfnSuRBQKrSDk4MbRXuFA0yOmtm3HU859++Jef2Ty5Rn1O1E
	 cig39vNIv4s370Q9HpX+Uevv8F03+pw9433KSTlA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730612AbfDYSea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:34:30 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45591 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbfDYSe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:34:29 -0400
Received: by mail-ot1-f65.google.com with SMTP id e5so377069otk.12;
        Thu, 25 Apr 2019 11:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JucYdQOjktWK4R4Dnhp8S1uhnfEWCyEkBMWf5UPjo1Y=;
        b=OAsHDxi3Tv+iOpEtZFzR/VOVUgzBxmYLLjAD9RigNIBwrJcLDz51ieokJ0LqLZEeOD
         ysumXyXSc/gERIGr0NbnJpxE2RaXZ3yqada6KCWBuLkWxCSjmhjU9bVVszd70TE7yE6P
         c614xAB+vv6w2ayPrnAxIzshI/pk2L65+9lkPLOypibzizTlxjIlNgu0OqeOP2wiO1vN
         utGkoVYHYcYwAhMip2T9bx4Ck4lpJblRcdvj7GU4W6eq2YxHvf74XJ12xTUtiZkqAhIb
         ljwXSHpvj1leNoXXD+wSNu/9WVUUSxU4fLd8HvuPhwz/t3ZdFuMVHst34y5qaPac/Xz6
         46Vw==
X-Gm-Message-State: APjAAAWWlWtaUwvr455gJwRbiLIYSwpycsiYJNu1fLJ70Kc2z9sHfU4W
        wDmBk1JcBqsjgWFGxZ97GQ==
X-Google-Smtp-Source: APXvYqxAcFZBguZUxwdDfCR6ntakTeh7eJunfev9fdspBZ0ROsSZ5AvcBTNvYIL+RYSaH+Aymge7Gg==
X-Received: by 2002:a9d:560e:: with SMTP id e14mr24327581oti.31.1556217268573;
        Thu, 25 Apr 2019 11:34:28 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x29sm11153512ote.41.2019.04.25.11.34.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 11:34:27 -0700 (PDT)
Date:   Thu, 25 Apr 2019 13:34:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v10 02/11] dt-bindings: power: supply: add DT bindings
 for max77650
Message-ID: <20190425183426.GA30229@bogus>
References: <20190423090451.23711-1-brgl@bgdev.pl>
 <20190423090451.23711-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423090451.23711-3-brgl@bgdev.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Apr 2019 11:04:42 +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Add the DT binding document for the battery charger module of max77650.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  .../power/supply/max77650-charger.txt         | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/max77650-charger.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
