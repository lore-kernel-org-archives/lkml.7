Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5771FC6194
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 00:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C269217F5
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 00:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573087800;
	bh=qfAeIeJF84yk0dgobnufzyXJTK7V4Vx1cm0wfboOIjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dRxxf+bP3mdyZnuW9NncoNAAvAzLViyyUVjpm1TN6FRDJljdzKOm35MutTx6Ma0l7
	 YyXBbMo5KwB3fSUr4s0oS7HDbIlysStx2tAmoHQAViRXodv7u5B6HAxSoCumCZKvMq
	 NBa7W0gIXRjKvtsRIM/MFMaPQD7zWUcBFqws0zPQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732793AbfKGAt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 19:49:59 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40260 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbfKGAt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 19:49:59 -0500
Received: by mail-ot1-f65.google.com with SMTP id m15so493607otq.7;
        Wed, 06 Nov 2019 16:49:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=03TG5cWDWne6nkKlrNqGSCYmvO7qLOJ0BW7qiU4GeRs=;
        b=IUZl9NFp5VFa14sMkT1nP5kJe3QDEoghWUpFFkXx6X9uQ7sEjpVT1buHDoCoQY8JCF
         uqvIMMKLKBI6CBIhQFdIrUoFC+FZu0gmUub3rVqFh/LfMQyw8FSPU/Y+IJVL7HC54cwQ
         nbphxN1ubBkvTO2VYn5P+WCR+OQzPWsFovn1w6fbHtFai4V19TrcdW0HPLmNhMYXxBWn
         29tUXjQU7OBplx6NoTeItFHtFRrOcAg1BoCmXjkldGJinCE+gkXUT2h6puT7f3pjtMdt
         CdWXnXq1MRR/HchFxosU9D+z0X0QJEdFjfgH70UCN/43krN/DSoN/qtKAxFvFXgzn7qD
         +F0A==
X-Gm-Message-State: APjAAAWKMym4yJtQHulC1MN7qPTuuHKbE3lxtaiLpwEGdpgB84APQvgc
        G9NUBZJNMd0TqFG2GsfsGw==
X-Google-Smtp-Source: APXvYqxXodxtZVuB44wwraBQ5zOpfvccHHai1qcHi4L/3qIqi9+33+rNMEMa7tKD92BvdXzY+qopZA==
X-Received: by 2002:a05:6830:1aef:: with SMTP id c15mr545142otd.200.1573087798238;
        Wed, 06 Nov 2019 16:49:58 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n9sm237259otn.4.2019.11.06.16.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 16:49:57 -0800 (PST)
Date:   Wed, 6 Nov 2019 18:49:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     agross@kernel.org, robh+dt@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        swboyd@chromium.org, Rajendra Nayak <rnayak@codeaurora.org>,
        Joerg Roedel <joro@8bytes.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v4 03/14] dt-bindings: arm-smmu: update binding for qcom
 sc7180 SoC
Message-ID: <20191107004957.GA21454@bogus>
References: <20191106065017.22144-1-rnayak@codeaurora.org>
 <20191106065017.22144-4-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106065017.22144-4-rnayak@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  6 Nov 2019 12:20:06 +0530, Rajendra Nayak wrote:
> Add the soc specific compatible for sc7180 smmu-500
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> ---
> v4: Updated yaml, sorted.
> 
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

As this one is dependent on my tree, I've applied it.

Rob
