Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370CDC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31CD2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556306632;
	bh=bCIxqL50mcSBSF0qrnm97UOSZpgV+ojUaMs9HKE7F00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=U7bMd5TM4/tSpdb+AEtr8s1zvmXHyDVIFisVLkZok6+qxNjDyhNqFQQr21gVXuoyM
	 iYYn4NwxKsIQxB98FT5d7PXGRTgFU18EZ79BYwQ/fP7b3Dy7wv53DLa73md/HEetk1
	 cSkZZSzNkMBmhtiOLDIRD0dGHVq8foEOJChI7SbY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfDZTXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 15:23:51 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36161 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfDZTXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 15:23:50 -0400
Received: by mail-oi1-f195.google.com with SMTP id l203so3843143oia.3;
        Fri, 26 Apr 2019 12:23:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4aIwxpR0+71nFfLUyGRgXjEyjm6+FGgNL7eNRgevc6I=;
        b=J2qGGpK3rgRYsFX4SYrYqazFWgKualAGZuqUlNVWk5dxNxlJCjs4VmAev9zqzTjcZm
         Wyeqx80RyvGzcUhVgRH0rzJrNejruTzEcwnV8Di0Aonnu/BcY1FlXOcswv8O+WNxfjVQ
         80XadUubhDj/3NP9CmspH/ozdX0EOwXBmIYWS06VspBo7jeV+0ExYf5r7I7WEICYs1II
         N+7HEZ9w3fKPfFS1BIM+7h8AMd9xcFmgHwZMFAam1HbtIZg4ZeILEENuW5TurJQQr2pD
         QxoxVIFhxRzRRano35FgLDCQENVkTkm06gcgdT8YTxfXzWVEhtwxSsHlaQ3SuBDOFBp+
         HrGA==
X-Gm-Message-State: APjAAAUBtpgK59VMrbR/oBXfgCGlwgM+CCj7HpwtXkHkUeh8KNBKviMx
        1+O+ZPLP9nwFFJKNR+uvhg==
X-Google-Smtp-Source: APXvYqx8EsSvl/BMA5aEmefVlVdKYFEN+5OTIuZXtoG3pCpH3UDtP2qQwLG/IBzIfuwckcyaiumNwg==
X-Received: by 2002:a54:4f18:: with SMTP id e24mr7771930oiy.87.1556306629577;
        Fri, 26 Apr 2019 12:23:49 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k14sm2794427otl.72.2019.04.26.12.23.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 12:23:48 -0700 (PDT)
Date:   Fri, 26 Apr 2019 14:23:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, pavel@ucw.cz, robh@kernel.org,
        dtor@google.com, linux@roeck-us.net, jacek.anaszewski@gmail.com,
        Simon Shields <simon@lineageos.org>
Subject: Re: [PATCH v4 25/26] dt-bindings: an30259a: Add function and color
 properties
Message-ID: <20190426192348.GA8913@bogus>
References: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
 <20190417205439.17685-26-jacek.anaszewski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417205439.17685-26-jacek.anaszewski@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2019 22:54:38 +0200, Jacek Anaszewski wrote:
> Refer to new "function" and "color" properties and mark "label"
> as deprecated.
> 
> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: Simon Shields <simon@lineageos.org>
> ---
>  .../devicetree/bindings/leds/leds-an30259a.txt     | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
