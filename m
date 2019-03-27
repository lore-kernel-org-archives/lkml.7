Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BBBC10F06
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A172075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553730441;
	bh=sjID6mqsUCCT+ummR96JrZy7L8kcQtW4EKILQQjNCMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l2Po0E3dnPZtxIWJkFdyqK9mPFz84n4BB7gfZn89Zh/WsBhizvI/Yep0W2jnvWuxQ
	 vdX3oKEIygdG20bEL11E9PWS5hg2hi9p7xep/6q/o0wcoAlgBxJ/YoN0hKNqgoQxDH
	 6yNugLWO5tp5dZJd4K40Gl2zn6hsqx0z88llNElE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732836AbfC0XrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:47:19 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43841 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387531AbfC0XrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:47:15 -0400
Received: by mail-oi1-f194.google.com with SMTP id 67so14288296oif.10;
        Wed, 27 Mar 2019 16:47:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aF8UbrX+SHdnXSF1IP9nWwxcy7seC6lQAeUB+2U8+8I=;
        b=oZD3lUubDKFeAIoBsbzjH8fODAHJk0kNcAjLkpqKsozlF9+fgena823+rLNFjhP1g7
         dIuIFyCARAD/JSNoO7k4l061KPuzvj9ISRKSyd26j5zByf+B+NjxotN7rOjUIXkV1wSb
         GEigSLRMRBkTgDALEq2xtY55F8aYF4RXZSuNUXtBRbEU0CcFgjrY1C80sEU+L+mgT4x7
         Sjs84kH4mEDYFreOvU9jhfANgEH7g8nQ9zByACWkTY9gawZrEPmkArveQO26kczlw6+0
         /oqrwlEx6Broq8bDJbcwE3uJiqW3AgidaekCHQNRaH1zdX454pdWA/9Pea3XRL3sskry
         ow1w==
X-Gm-Message-State: APjAAAXEGiLgMqyMqgJUb0l5DA/E2TRR7Ef8JBjwlqIDSlMxfGy5GZz7
        sPZILGd+8fHTpRfIVRFSRg==
X-Google-Smtp-Source: APXvYqysBvd7Yy0P+PgpYw/gwpTPVSBRLPuFFs7atAhUyRGAZQ4mlZHlhN9NbJIY93sUucTLndbOZQ==
X-Received: by 2002:aca:c68b:: with SMTP id w133mr21225939oif.58.1553730434872;
        Wed, 27 Mar 2019 16:47:14 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h68sm9714796otb.1.2019.03.27.16.47.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 16:47:14 -0700 (PDT)
Date:   Wed, 27 Mar 2019 18:47:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     jbrunet@baylibre.com, devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: clk: g12a-clkc: add PCIE PLL clock ID
Message-ID: <20190327234707.GA25542@bogus>
References: <20190307141455.23879-1-narmstrong@baylibre.com>
 <20190307141455.23879-3-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307141455.23879-3-narmstrong@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Mar 2019 15:14:54 +0100, Neil Armstrong wrote:
> Add a clock ID for the reference clock feeding the USB3+PCIe Combo PHY.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  include/dt-bindings/clock/g12a-clkc.h | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
