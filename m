Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF64C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 21:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49ABA21670
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 21:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556572552;
	bh=liOus8Ly+bpu6viBpzPWrLRMDt87tcUyWDJ4Qcdli5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=me7thsuRYV1qCZx3JnWybDASJ7xJvTEFIrhYpZEOD+cvjSnKIEtLAgk8Z9k2hyETV
	 1VYc1CFThOsFSqeNWuK8vyk5vLSLPKGVr+qtBYJI3yc5ic1l20LIvf8e3cqmH+Qo8A
	 JxKEw1s5632UkgT0g2axx7Jgakc/Fv3Y4PoFxJWM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729448AbfD2VPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 17:15:46 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40725 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbfD2VPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 17:15:45 -0400
Received: by mail-oi1-f196.google.com with SMTP id y64so4010898oia.7;
        Mon, 29 Apr 2019 14:15:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=koMqFVq+sZtTFE9lQzOVI0CiiGelX/b7gktI+eHUpmg=;
        b=PEOQQ8GZBjzkgi252/hzzp7aa9ZVl8honj6FKMl0FBHbv4bM+sMVSLSskMdfXp9ZC+
         wUI00YNVevAakayykq/qJ6md6IglnYkeEcA3jKj9g31PzXxlTNk53GrEkDtFKUNYWWqJ
         tEuh2XTm/mMawEJMjlPvK3e/IXHVGX/Bs5TJCcZaXs0Zjx4KiuuHcYvtXKBym0edTsoo
         1gw5gmrOdzgzX43rkC01ncrGYU7jCZxwfPkodmod66PxTQu+rAUsKjv/PPXryFedrOES
         UveO1/9VRBm+OQhvvwmvrscD2J8dizofx9LFYonp/IcD0W9dgFL/ERTRjLPaTSelpcWx
         7RBw==
X-Gm-Message-State: APjAAAWqK/0A/N6N2s46r6L4cgZ8/ygBwiLDRoIjQ7XM5Ppe1QfYrk/Y
        l8eAsGwB6l7lh3y9d3hWyA==
X-Google-Smtp-Source: APXvYqz2TEK23uu2UtgA9T+1nPA3Aim10UWLnbz8RQmwt+Rwp7nNsetW4zP+Fj0IQs/Sa89YglGUrQ==
X-Received: by 2002:aca:c7c5:: with SMTP id x188mr806556oif.48.1556572543997;
        Mon, 29 Apr 2019 14:15:43 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g25sm13852036otl.7.2019.04.29.14.15.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 14:15:43 -0700 (PDT)
Date:   Mon, 29 Apr 2019 16:15:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     robh+dt@kernel.org, jacek.anaszewski@gmail.com, pavel@ucw.cz,
        marek.behun@nic.cz, rdunlap@infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v2 6/7] dt: bindings: lp50xx: Introduce the lp50xx family
 of RGB drivers
Message-ID: <20190429211542.GA28956@bogus>
References: <20190411193848.23140-1-dmurphy@ti.com>
 <20190411193848.23140-7-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411193848.23140-7-dmurphy@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Apr 2019 14:38:47 -0500, Dan Murphy wrote:
> Introduce the bindings for the Texas Instruments LP5036, LP5030, LP5024 and the LP5018
> RGB LED device driver.  The LP5036/3024/18 can control RGB LEDs individually
> or as part of a control bank group.  These devices have the ability
> to adjust the mixing control for the RGB LEDs to obtain different colors
> independent of the overall brightness of the LED grouping.
> 
> Datasheet:
> http://www.ti.com/lit/ds/symlink/lp5024.pdf
> http://www.ti.com/lit/ds/symlink/lp5036.pdf
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  .../devicetree/bindings/leds/leds-lp50xx.txt  | 142 ++++++++++++++++++
>  1 file changed, 142 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-lp50xx.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
