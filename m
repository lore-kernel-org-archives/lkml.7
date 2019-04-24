Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22519C282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC59208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556140656;
	bh=yhp46mg3Uxs3DPwFeEDrlniIULfxLjxvfc4gfLUfJaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=q5+t1Go7mcZXkWJfQMrGKcs4HImT9AhimSjnDfRnB6SE8L+IJSa0h8JurOxsZ2+2r
	 jYFgfT04dRrCalC6q5qrotH7ya0nSHCu0l+1WAqJUZ7UDJwN7r0RH4RuboTQRDrYUd
	 /GARyXXREDtfDTDaOEA+DzPU6M8o9Dku+m1KhaY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbfDXVRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 17:17:35 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45261 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfDXVRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 17:17:34 -0400
Received: by mail-ot1-f65.google.com with SMTP id e5so17461787otk.12;
        Wed, 24 Apr 2019 14:17:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e3Cis35Mfz6t7nF4S+SO9f70xq+1VEeZzlg0kG0AVac=;
        b=h5MC45YSluJixcP0kT9cCAj6M2OTAMGR3dKjz7Xkj0LwJy5JDRFccAjMs8HQmJwoV1
         3+2myHpxOnl5KnCaiToOoDdNuEOUA7BBi4YbjP9DsNPb4xQm7Gq8PxpSDhhne81M4J3W
         LXGQINPyeS0H4V/FcuIxIQ26wmKIoZBcAmCZMuBgI0ZpTZBohwfyZugJ71uUoYZoR9E1
         DKgMPjExSPjZRNbbnGnjMmLWJHB3oNDUls/1nD9Vlv6Nuj+C0jNNwyMCccDXckysX6Cj
         3bL3JL17JKfx9UKW3Kd9MvmZEogxey2LNQxd5TXolp7KSbQpD0vjtLbM76kgg/BEEaX0
         DHLQ==
X-Gm-Message-State: APjAAAWD9tiulG3xp6OpacfydmLmPzw5R989e1V+l+ycOKwFmokjcrj7
        aSpNqzn6achemoDcwa2rEA==
X-Google-Smtp-Source: APXvYqxl/dhWOIJl2SBI0DXQnsZ9JJOKnj3Ki0iEyBxamnsPQkKBxF8gFIHiSCzgMdpVsaYq4B0j5w==
X-Received: by 2002:a05:6830:1d4:: with SMTP id r20mr21805112ota.106.1556140653581;
        Wed, 24 Apr 2019 14:17:33 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 96sm8366512otf.17.2019.04.24.14.17.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 14:17:32 -0700 (PDT)
Date:   Wed, 24 Apr 2019 16:17:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        andrew@aj.id.au, joel@jms.id.au, robh+dt@kernel.org,
        mark.rutland@arm.com, mchehab@kernel.org, hverkuil@xs4all.nl,
        Eddie James <eajames@linux.ibm.com>
Subject: Re: [PATCH v2 3/4] media: dt-bindings: aspeed-video: Add missing
 memory-region property
Message-ID: <20190424211732.GA18914@bogus>
References: <1556119020-7609-1-git-send-email-eajames@linux.ibm.com>
 <1556119020-7609-4-git-send-email-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556119020-7609-4-git-send-email-eajames@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Apr 2019 10:16:59 -0500, Eddie James wrote:
> Missed documenting this property in the initial commit.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
> Changes since v1:
>  - Add missing semi-colon
> 
>  Documentation/devicetree/bindings/media/aspeed-video.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
