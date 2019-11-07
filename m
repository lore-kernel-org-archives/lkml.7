Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3811FC6194
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 00:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A4B1217F5
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 00:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573087650;
	bh=mcFchNCnDk3gGwC0UM2UC5PCxmjjBV+JRBmQa0Z4BG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RsVIFKilEysPabDd38AJrtxj3WbuUWPwgn1tl1SdhbMMzpcL2ajeAIt1zHqq5xleX
	 O6XyBCBFJiazvrGZFQd2D3vpAwpgBNYIFuxXygoOQ81TfB1pkBsNItDcnp+x3GaUOx
	 qK/czVht5KO7mhU50ajl3yLoEmPBS9sKGjwb5M0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732844AbfKGAr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 19:47:29 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34091 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728369AbfKGAr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 19:47:29 -0500
Received: by mail-ot1-f65.google.com with SMTP id t4so519661otr.1;
        Wed, 06 Nov 2019 16:47:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WcWv7dAa4gDC9Dj8dsxQt4ikuyFHBF7nAdUcoszfsjg=;
        b=uizpXGayOy7FXZYW65hEUmKfzsIJfAZTPxolJZGUCDOGTIZy7Mx7+V86I80jHd64G+
         J8PZiJ313c91/S9KQwV/pz9cX8DEfC2Kppbp2DztHJ+IKHJUDYySFyP5bpTqpMZ3lYK5
         IZZSs6qSywzbdKkvpwOcpnQdqSGmGmuawkRpIsc1rrZEJWxDirMpaXKhKkuMb9z03CHw
         wacoLTZiph/cxlvtSSnay+c2GhWy9UDWWfcZ73Vq1wslVnRq58HP7W2SFz5QvQcFzuA4
         vhBOv2lo0Hmz3n90kPjtG2zT2xHBQ2B8EMuYDDooWbzzQMFvRJR+VYvEJFFK5zZ3bQ80
         qsGA==
X-Gm-Message-State: APjAAAVmWmbKtFbHBLMFQg/gzvr9fVLdj3mBnS9J4Q3xi+gErrW9u5rc
        pHrsZFS0D2Hv5TbGrXUaBg==
X-Google-Smtp-Source: APXvYqx/PPUxyzMJ2UiB0lM6YzOXjzkStNCIKXOPQAPgny5GbITC1e39/CkGcee8FOwtWVmeH0EOgQ==
X-Received: by 2002:a05:6830:22ef:: with SMTP id t15mr508005otc.256.1573087648454;
        Wed, 06 Nov 2019 16:47:28 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o2sm144650oih.19.2019.11.06.16.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 16:47:27 -0800 (PST)
Date:   Wed, 6 Nov 2019 18:47:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Jeffery <andrew@aj.id.au>
Subject: Re: [PATCH 4/4] dt-bindings: fttmr010: Add ast2600 compatible
Message-ID: <20191107004727.GA18425@bogus>
References: <20191106060301.17408-1-joel@jms.id.au>
 <20191106060301.17408-5-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106060301.17408-5-joel@jms.id.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  6 Nov 2019 16:33:01 +1030, Joel Stanley wrote:
> The ast2600 contains a fttmr010 derivative.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  Documentation/devicetree/bindings/timer/faraday,fttmr010.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
