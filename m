Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613CECA9ED3
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 01:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2958C214D9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 01:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572917331;
	bh=xNc7zysrkarUrPZ8u/6BnraLE7rzilg3nT6jHMgIwlA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BIRsJm3Fpex9FyJlY3g2xPoyaHW8maoXddNmGn0jg1vFdrmR4FEu8z8OuBIyQ4YjG
	 AayWJsl2yAtaHY3LPx3tOCQ+BdNXDPir4e79raPcB8Cg39W5JgdatzRTBopzhJd6H6
	 o6xQM9bMLT1G+gtZSoaoyKcPCJ7EhegXUMAG+svg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387696AbfKEB2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 20:28:49 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41954 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387639AbfKEB2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 20:28:48 -0500
Received: by mail-ot1-f67.google.com with SMTP id 94so16192845oty.8;
        Mon, 04 Nov 2019 17:28:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M9gg0kIoyQA/b2vVqI7fyQwNx3s6WAOJLTNDodsUmLA=;
        b=NPs5uhDIFNxURteRD/4ErU1UHnjwiLX5n1PM5vtbf0tqVE9fdLfQTHvgA6rOvhQFvg
         vb8ELi8DIa/x+QXyvxfmtCi3Yd5XyBhmUDkgPAiYNZDwtCRr0lrZqBClWsu0Q35oyFEs
         V2O6DUglgrBs7/ZBdACCpVr5i8JZD4IGuXT7ESWNCxLCqqcToUMy2wOuIRfzSfIN9qwv
         4WU2X1BI5mGhGoQhyUpZ2h8LF0iZ32ua7QZfRRYyt+NsEAUGEowJB7sm1YVWbdDhz0Dp
         yT5UHJAB3e/gZxc6ZqVI7LqhvoEAyv5QyTyXY2AVJ4NvYqlH1jCNo8jzVZfhVvT2lgww
         Kvmg==
X-Gm-Message-State: APjAAAXshb6UDpk+xWjVwIqvE/YQp+hQDFyuRaLcewNhr1oAW47ljXun
        DjmVotakbIcyq5wGDoB8Eg==
X-Google-Smtp-Source: APXvYqzcV9ZpMmc/ONyrKnyJvmZg7cRevWB+ivgNxAo/R2LxP++vJQrEsF8NHCoVtWBf91eVXonwCw==
X-Received: by 2002:a9d:6253:: with SMTP id i19mr9512571otk.201.1572917327353;
        Mon, 04 Nov 2019 17:28:47 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y14sm5617491otk.20.2019.11.04.17.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 17:28:46 -0800 (PST)
Date:   Mon, 4 Nov 2019 19:28:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Roger Quadros <rogerq@ti.com>
Cc:     kishon@ti.com, aniljoy@cadence.com, adouglas@cadence.com,
        nsekhar@ti.com, jsarha@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Roger Quadros <rogerq@ti.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 2/3] dt-bindings: phy: ti,phy-j721e-wiz: Add Type-C
 dir GPIO
Message-ID: <20191105012845.GA32522@bogus>
References: <20191028102153.24866-1-rogerq@ti.com>
 <20191028102153.24866-3-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028102153.24866-3-rogerq@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Oct 2019 12:21:52 +0200, Roger Quadros wrote:
> This is an optional GPIO, if specified will be used to
> swap lane 0 and lane 1 based on GPIO status. This is required
> to achieve plug flip support for USB Type-C.
> 
> Type-C companions typically need some time after the cable is
> plugged before and before they reflect the correct status of
> Type-C plug orientation on the DIR line.
> 
> Type-C Spec specifies CC attachment debounce time (tCCDebounce)
> of 100 ms (min) to 200 ms (max).
> 
> Allow the DT node to specify the time (in ms) that we need
> to wait before sampling the DIR line.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Cc: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/phy/ti,phy-j721e-wiz.yaml          | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
