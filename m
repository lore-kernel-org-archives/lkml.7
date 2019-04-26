Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D279C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F13D820656
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556306511;
	bh=jfd/Z/q5D+vxcXUc+TDVGMFGFeFqtzjmUbVxJQUgIt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=O0aRwGt/aLuWz7LSHXvMXtfh3iIdKVWWOpvlO8Qduz2QY/liRYCN9+8HXifi77ojO
	 f1MG+efxkMvDsQ3te80k3wiuSEAqqH3MMIC45KwkAmpX513P+JjBUvOjpGb9+jUmPD
	 gd/jsUzRg+qz1PU9X+a0Q+WS7k6VPRiBGjfJa2h4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfDZTVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 15:21:49 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33590 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfDZTVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 15:21:49 -0400
Received: by mail-oi1-f196.google.com with SMTP id l1so1971621oib.0;
        Fri, 26 Apr 2019 12:21:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VoXhCRgnQ0BXVJEsJ1iW9NaaoCf0mNWUu0VHMsWyV8s=;
        b=FCJayr/ElzftKswVx6Hq3cioqXE9MQjYXZaz8seI1J6I5ovU+nddGtji4W4w/tgwGb
         waOJllGOw+oYbndQJgMh90lp1pkkFR/Q8BY4rjEseN8yQnjPh8YWYqGB6uPKOzop36X8
         W/dJGk7459UUJ3mLRO/C6Qic7y420MfOzBLq3su6qQXy57BNY5R+dbuRWacc4NAIdUWy
         HqJqibxrvUcHloyphjS6oduYvbhlF7v8x9jLHCc8OWpZorsWzL8lEA9MjE76C0t0+Eno
         PaLi2+1m4QiCvlZchI6wx6LsjxBScwjeLIktvKx4zvwMZ8YCIaE7RwPVszc4JHckyBGd
         QVMA==
X-Gm-Message-State: APjAAAU1rNAv5tInKzm3pSkaCXaxlm2zPi5Qzy3J/s8Tsld50o9M4D3e
        ZV0Y108m6cVmJiTnyJ5IMw==
X-Google-Smtp-Source: APXvYqwWvMLu7VOouK2GLCPPPxE5LJRjAtXHNpX34GuMmfVekHSvkfgE8su/15F6Ov+s5yT8KMHM5g==
X-Received: by 2002:a54:4384:: with SMTP id u4mr3169113oiv.104.1556306508359;
        Fri, 26 Apr 2019 12:21:48 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p186sm10527148oif.34.2019.04.26.12.21.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 12:21:47 -0700 (PDT)
Date:   Fri, 26 Apr 2019 14:21:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, pavel@ucw.cz, robh@kernel.org,
        dtor@google.com, linux@roeck-us.net, jacek.anaszewski@gmail.com,
        Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v4 13/26] dt-bindings: lm3692x: Add function and color
 properties
Message-ID: <20190426192147.GA4457@bogus>
References: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
 <20190417205439.17685-14-jacek.anaszewski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417205439.17685-14-jacek.anaszewski@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2019 22:54:26 +0200, Jacek Anaszewski wrote:
> Refer to new "function" and "color" properties and mark "label"
> as deprecated.
> 
> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: Dan Murphy <dmurphy@ti.com>
> ---
>  Documentation/devicetree/bindings/leds/leds-lm3692x.txt | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
