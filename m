Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D3FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 234CA20879
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553532759;
	bh=ybU7r+76kzhq4f+CrI/2NL4khhqXfEcTc/1tgHMwTv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vGFNfHVWhZqvm5rt22Ke67qcJACapB4EuWS1C4kxdCxc/lzrqtIa8AonSwXbr1gg0
	 dN6l5DGeb0cmHVBbtJewtdfVQlEt3+6d/jTMWCnZNBYK5F/MQluXHqTDTZr11iPBDR
	 chgHSVlcYLY8vKauSaNszMT5CBpu/dlhPbkOrdRY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbfCYQwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:52:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38143 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfCYQwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:52:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id k11so3611753wro.5;
        Mon, 25 Mar 2019 09:52:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1Tm39GqRBHEezd9J++lwHbAdYBP0HBub4ZQAOjnxpho=;
        b=gp6WCLPiNqfqmOIpk4KDZh6VjJkI5IbwemNcTLtgnFdJlBmmYfJ6j7QOMBNFKmn9Vk
         sQROcBaQoDT65xnGUrvpkHg/OrX9yfjQUbWhkbVjMqAdNbRouNyDmXFW07xUTkLN1+VR
         qSXuiieYGvdjDxTyaZPnHP/uEp69sYQTqOOd+c2dCo4sxbTeC8FH1EeBausBk7KwBWGq
         EBUAakXGgukq7Ug/eh4UXgZ7p1HAdYwhjVxWimWJo1fQYrW+iHuJm+0PoJ2tpcgwXqgf
         SDAwKE2n9WkZ/hMcIw1r5ar5ipj5rD9fC29BF4L/P0knMT0pWHU+PA9xzV66m/UJ66f2
         mdUQ==
X-Gm-Message-State: APjAAAV2+agJJ+gXRORSCxFi0YF2jFoSIQmi23tks2wnLe1fM+6FkRmZ
        FytxEMDlJfI4N7OVwLWrjEA=
X-Google-Smtp-Source: APXvYqw8o5JM7QGXoq8KEVz91yI+BGb0vDXtORn0/lC3nDW6yTyHiZYWWqG5unqLBTVkVxdrVf8p6A==
X-Received: by 2002:adf:afd7:: with SMTP id y23mr15960719wrd.254.1553532755622;
        Mon, 25 Mar 2019 09:52:35 -0700 (PDT)
Received: from kozik-lap ([194.230.155.153])
        by smtp.googlemail.com with ESMTPSA id k4sm8668725wro.33.2019.03.25.09.52.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 09:52:35 -0700 (PDT)
Date:   Mon, 25 Mar 2019 17:52:33 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Benjamin Drung <bdrung@posteo.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: exynos: Fix spelling mistake of EXYNOS5420
Message-ID: <20190325165233.GA16322@kozik-lap>
References: <bb0903e066484e02f5dcd0e9cbe94a491a179fba.camel@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bb0903e066484e02f5dcd0e9cbe94a491a179fba.camel@posteo.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 03, 2019 at 09:13:30PM +0100, Benjamin Drung wrote:
> The SoC name EXYNOS5420 was misspelled.
> 
> Signed-off-by: Benjamin Drung <bdrung@posteo.de>
> ---
>  arch/arm/boot/dts/exynos5420.dtsi | 2 +-

Sorry for late apply but you never sent it to samsung-soc maling list so
it was not present on Patchwork (and somehow slipped through my filters).

The easiest way is to use scripts/get_maintainers.pl - it will print all
necessary Cc-addresses.

Thanks, applied now.

Best regards,
Krzysztof

