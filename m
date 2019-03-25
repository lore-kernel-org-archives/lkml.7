Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07818C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C765A2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553553227;
	bh=NkjNN91itmpCgzQ02mrlEugByytItO5GM5ctVH7RGgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0gTxLH2fxFYjjwt6xa+FG73ScDrCfYM/7ajxyZpnZq4AIXF01wHaiXE2wmAFttivX
	 rBc3yUZVkoXHpn3381PGpeG7QgDk0X/T7qVGLiX3NKcD65foScVRKNbU8wPjA3M3Pb
	 StVluuwzGR2o0pMo78Jk4gGQJkJI+mXdE83Kwhdo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730461AbfCYWdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:33:46 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39871 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729204AbfCYWdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:33:46 -0400
Received: by mail-ot1-f68.google.com with SMTP id f10so9647691otb.6;
        Mon, 25 Mar 2019 15:33:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8TdxG8TPwVmk0kHINrVKx855EgXVEBRgixfBzpydVGA=;
        b=Dgaeh+uiRnwsZyADB/Wk13BF9ynAabSbnH7b8oFrKwvcYl/CPmmRxWsiX+5IiIk4nU
         dWudN5aYwDb05/s6aVq7+zj5mEq+iSHvj2449ZuE9qsFNMiqMgAoiy3QjKihc2J4i6K8
         RV3wb9INkXtdodi6kq2zm0gSaIQW/LbvHC9p6V7q+FmVXh70ZyofwuXHmvQMRUwymqgh
         DYbOT+1ku9Z5IWAdebF57AaY6mebhtqXwaw1V9EPrF7bHwjyCNmi/C/54UPP4fq0DE3y
         vfr5MvRhG9p9eG2GOBR8bSKvt+u+384sT2jl2LjUpKdWfqY+rRUJMzlQ4/Lvi8K6Pzpk
         oCPg==
X-Gm-Message-State: APjAAAWJ8XorqPD+81iB52HqD0s88HeT0aag7gB4MeYGGV8P/EaYqN7Y
        yH/dS+X+73Ul9AgE2OcLLnBNaSM=
X-Google-Smtp-Source: APXvYqy1nH/q/UDF+aLvpkFVk3qCEZQ1DPFK79e9tFa8n/mxrwC6TRG3JGZ06WnPJLmQvNC5z33sPQ==
X-Received: by 2002:a9d:7f90:: with SMTP id t16mr16140712otp.9.1553553225380;
        Mon, 25 Mar 2019 15:33:45 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q23sm7065037oic.45.2019.03.25.15.33.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 15:33:44 -0700 (PDT)
Date:   Mon, 25 Mar 2019 17:33:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] soc: qcom: rpmpd: Add QCS404 corners
Message-ID: <20190325223343.GA27389@bogus>
References: <20190221064434.2760-1-bjorn.andersson@linaro.org>
 <20190221064434.2760-3-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221064434.2760-3-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2019 22:44:33 -0800, Bjorn Andersson wrote:
> Add the shared cx/mx and the low-power-island's cx and mx power-domains
> found on QCS404.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  .../devicetree/bindings/power/qcom,rpmpd.txt  |  1 +
>  drivers/soc/qcom/rpmpd.c                      | 29 +++++++++++++++++++
>  include/dt-bindings/power/qcom-rpmpd.h        |  9 ++++++
>  3 files changed, 39 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
