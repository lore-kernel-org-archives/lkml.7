Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB905C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9347B20693
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556306612;
	bh=A0qDuTuzJnPlnW23Kd981lFWv5Ao/Ru3JmbTeM36W30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bv6Jn8XIFXdvQr+BSzGbxi/eEi26MTDrdFO1E0PMfVsmegJf5eaYVQzHMBjVeVSh1
	 dKa53p+Qa6CziMlYqT+FXdcQ+jJ/wla5dvYnQ5qWCT3aG4SZjPaVcs/WYu6/DA5hSU
	 +V2FHshEeam4n/Sq49MPDKunRlOYFnw4Lk7EqC0o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfDZTXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 15:23:31 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46350 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbfDZTXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 15:23:31 -0400
Received: by mail-ot1-f65.google.com with SMTP id s24so3557489otk.13;
        Fri, 26 Apr 2019 12:23:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1eKnfG3pVCcFvC3cLn1HItuRP8jzlLj09956Pi3hors=;
        b=TuPcIn/hgUp0S8thIWYKxE6+P59SO66DCxKTIaz0z7+0Djc0OOJoQr1v+wGoDKVgGi
         4taL1NsPgSGN6DgRyhcdej5WjQFm4pyDHrzRY81GsNiTHsXafxIgKj7COkSYC9f7Qc3f
         HOtsY1amtLeZwptEVMDv20UDN7hspAj+k1nRcMt2JDY/FY9ZOF7i27a9uih3E4WCNS/+
         DC/4LafKhdrW929oBC/dJDZQ1S7EK3iJB+4y3O1FHxk1S4U2GuYtX7VH3pn/Z7U9k8ds
         RwfLxtT/B1vTVT7JmdIzDpiO4AYIFXuAw3hqfq9dx+jcwXWSQHFQKAzJXPgEcwH7ynbZ
         dNCg==
X-Gm-Message-State: APjAAAUqMCsjSxZZV4zZZTkfMoY/QuJYt3IzZx/YgGl+PhBhcuv7iIHs
        MWmgReGh47H5VrHOndzySw==
X-Google-Smtp-Source: APXvYqxgS5ejdxSTZ9Sr83yMKChZKraqdyh/qARazNe1VdEV2lnYyxZPiALxISaG3JB/LntWZX6Eew==
X-Received: by 2002:a9d:4e4:: with SMTP id 91mr1443710otm.62.1556306610344;
        Fri, 26 Apr 2019 12:23:30 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 189sm10738558oid.35.2019.04.26.12.23.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 12:23:29 -0700 (PDT)
Date:   Fri, 26 Apr 2019 14:23:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, pavel@ucw.cz, robh@kernel.org,
        dtor@google.com, linux@roeck-us.net, jacek.anaszewski@gmail.com,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v4 23/26] dt-bindings: leds-gpio: Add function and color
 properties
Message-ID: <20190426192329.GA8254@bogus>
References: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
 <20190417205439.17685-24-jacek.anaszewski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417205439.17685-24-jacek.anaszewski@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2019 22:54:36 +0200, Jacek Anaszewski wrote:
> Refer to new "function" and "color" properties and mark "label"
> as deprecated.
> 
> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../devicetree/bindings/leds/leds-gpio.txt         | 23 +++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
