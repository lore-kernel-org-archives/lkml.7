Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D868C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 157A520818
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554905282;
	bh=i4dHT4ibwSYl3XrxVP0zmBLNUAQ54jVI1SBrlEIK82g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TY7Qoy1jnNIoOeKQ8/FIluuou/p4OwKdZVVhA4tFRQisYbnfyfHuj9mNbY8+0hvbF
	 0Oc4GquJCH0ugFQXJTBxV12OzOYF9MBWdZ4ycferSnFAXo7MS+8qkq1ktvH86mPW16
	 GP8tLKJxmjVlMYtNrLYuOKsF35zdigk+UQI7mRHo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732568AbfDJOIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 10:08:00 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38495 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729946AbfDJOIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 10:08:00 -0400
Received: by mail-ot1-f66.google.com with SMTP id e80so2028560ote.5;
        Wed, 10 Apr 2019 07:07:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DtrUml0mzaurwWxpooSkRDdxwOyemSBwP6zZRHr5fz4=;
        b=Qo9QegL8eeEwR6bH+Zf+wYGIn81t4FcjBjLrkF3XwOMdF6BiIr8OOQu+5WT+T6O3x7
         Y3jlFeWUkNVcmdZTTEAQAulKaodZApOTiaHilyXyW7irSRL+CKtmqmVy4GwqyPKjnofo
         V3hICjYRPr+VHMLDm6Pr1z+A7mbirFK/JlD5MmByJO5GxxEgapZtKm+CMfzaIIuW6Fo8
         Y4uEQruJ4zOA2uCq7BxvDXIu//lc8IBU6OQYHJTXNHoFnl5xgYDafe5uMMxe5jNGBFdU
         oPb4zBRhiLqmHpazUBTCTHxjMaODGV7fL10LrAyMf0EXdKmR4SZpoEnCMGZU9s2Hh+2O
         lq2w==
X-Gm-Message-State: APjAAAVfCPvvub+78/tP6MmKCq88t7HSyb88abQBKKsRCD6Akw9DryEc
        LMUvOmf6uZis8w+U8LvJAZevziQ=
X-Google-Smtp-Source: APXvYqw4LaO744267VQAAghjElvMUyeks4I8AeRlYqp3XNJwqOuwLzMvcveTYk0G0gcrUd1jUO6QgA==
X-Received: by 2002:a9d:871:: with SMTP id 104mr26927420oty.315.1554905279065;
        Wed, 10 Apr 2019 07:07:59 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m63sm7909843otc.76.2019.04.10.07.07.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 07:07:58 -0700 (PDT)
Date:   Wed, 10 Apr 2019 09:07:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Mark Rutland <mark.rutland@arm.com>, Bin Liu <b-liu@ti.com>,
        od@zcrc.me, linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 1/3] dt-bindings: usb: Add usb-phy property to the
 jz4740-musb node
Message-ID: <20190410140757.GA19016@bogus>
References: <20190404094739.23503-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404094739.23503-1-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  4 Apr 2019 11:47:37 +0200, Paul Cercueil wrote:
> Add a required 'usb-phy' property, to obtain a phandle to the USB PHY
> from devicetree.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Notes:
>     v2: Change "usb-phy" DT property to "phys"
> 
>  Documentation/devicetree/bindings/usb/ingenic,jz4740-musb.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
