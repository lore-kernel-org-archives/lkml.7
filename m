Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF39C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F18F21873
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554014522;
	bh=25yGKxFovaYR79MEN8X4lYakOMdDtS2F0u3+hDJDAoM=;
	h=Date:From:Subject:References:In-Reply-To:Cc:To:List-ID:From;
	b=e9dA74s1SUakINSSHF7P6sYwgeBG+h0ltlm2vnlQbFKoCIC/s7eUe4pu6YoXGdUc6
	 vh2KgaNzK3te+XRbd5utkTuEKUN8R1LZIyCJbmJ5Q8s1XPtxNkao1/LW4RvXq0mT/0
	 oi9d/2BDDQH2DTSNhmWOtGcO2KWHpEuh2Y04MgHA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731333AbfCaGmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 02:42:01 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36202 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731316AbfCaGl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 02:41:59 -0400
Received: by mail-pf1-f193.google.com with SMTP id z5so1958407pfn.3;
        Sat, 30 Mar 2019 23:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:cc:to;
        bh=D4jQAloilPwVw/0LTu4U9K3SADGn7VURytzcwBVC9Yg=;
        b=KCjRk3JxQqqEa+hJ9bfplSTcBirAF6QO5pbO2lWeJsMzf7j02mtNBV171FoHX7gNOn
         utOu6Lzurh9Mg1K795Ike0AclCtckeVs80ivVMwPm7pyoodngwJHjM9PD0mjB5WlVpLj
         KzN/qSKcS8gnqpq28KU52oDmlOHaLV/uDOEgvqAfmat7puCYOZw0sp00yZDTr13h7JHj
         5KsR/XDyv2ECPRest0HZMuf2Xs1g6Wd7VftnM90i7H2LxLEKjLEkDCbSXZM0La30w+4I
         HI6DQUq2kAQsP9ig71OSVZOZyamCd46penDVGS10t+1qz7lEMnptrB9DYyCpY5+CiLBZ
         x4nw==
X-Gm-Message-State: APjAAAV6Rbbzu1oXqLbwWBDtO85sNla8VJEm82Sw1T5CMB9ZiXxjInvr
        e1SaVy0xg9h/R8mRrY6mZQ==
X-Google-Smtp-Source: APXvYqxoIi0YbosNVAnoBMp3RAa1tuFzmT10zM1SuBKHCmybtMg1A4qw6PbABplK9HLtptDsWMJMMg==
X-Received: by 2002:a63:6fcd:: with SMTP id k196mr42452793pgc.238.1554014518378;
        Sat, 30 Mar 2019 23:41:58 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with ESMTPSA id e23sm8438560pfi.7.2019.03.30.23.41.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 23:41:57 -0700 (PDT)
Message-ID: <5ca06135.1c69fb81.a71f5.6cc6@mx.google.com>
Date:   Sun, 31 Mar 2019 01:41:56 -0500
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: display/panel: Add missing unit names
References: <901e836ea06889a9d91a799102b2a6b836d93dcd.1553529797.git.agx@sigxcpu.org>
In-Reply-To: <901e836ea06889a9d91a799102b2a6b836d93dcd.1553529797.git.agx@sigxcpu.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Fabio Estevam <festevam@gmail.com>
To:     =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2019 17:08:10 +0100, =?UTF-8?q?Guido=20G=C3=BCnther?= wrote:
> Some examples were missing the unit names triggering
> 
>  Warning (unit_address_vs_reg): .../panel: node has a reg or ranges property, but no unit name
> 
> warnings when used verbatim in DTs and running dtc with W=1.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
>  .../devicetree/bindings/display/panel/innolux,p079zca.txt       | 2 +-
>  .../devicetree/bindings/display/panel/innolux,p097pfg.txt       | 2 +-
>  .../devicetree/bindings/display/panel/kingdisplay,kd097d04.txt  | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

