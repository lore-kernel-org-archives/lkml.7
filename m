Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55483C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D30B2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551378196;
	bh=VLU9DprE/AM+9vvusMSHIdJVB5RFGYqnShT96kCG/rA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JYVqEa/hmWERu5i5ear7GbUv4/rIJ9qZcJV0vRHYW6JxUn3UMntZvFHB6qlhrR5G7
	 FNjWSUNEm90K5XxFHOtIyC1EcZSSsiaIqEfCHwjlc4Ji67OgEUjQp+rDCFUVJImRdQ
	 ayUglHW7crHjZr2FCBuVsyk0bLg1hdbRphNWwCBs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732978AbfB1SXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:23:14 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43818 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbfB1SXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 13:23:14 -0500
Received: by mail-oi1-f193.google.com with SMTP id i8so17275352oib.10;
        Thu, 28 Feb 2019 10:23:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bFFvBVoBhmge3SUaDzTJ53Yvmjzga/qiBIN7du0ol3E=;
        b=ftO8OvdnYVn90j+B0SAVa8XN4AjA74Yzb8l43XRdHlxgZgPnT72guz2kAqzu3loPYI
         0cNkcLQrRto5OIo9uJiWlgyCr3H1CwJBpZNQG7J5eJm37n2rutWwrrr+X44uT71qFOo7
         v6U9gVwQsLs04MZ0ER3wcee7bUVIaLF8aNfGXARIcijZFzM3f4Qz89S5wjDROok/toEb
         y3vPrjsKWW3sNx9onOLyMmr4LzUCvoKJBs/zYCbGOcJs6htHNs/kWJ9tKkX8HvBMMN8e
         8j5kKuIZZ6YvWjbELKMuVoGhKlzHu6/Qfc66GSypWc8cpsMEloTvooKZZQBTIdDpyll6
         M0wQ==
X-Gm-Message-State: AHQUAuZHYkdu+mN2HErZCm565tiunyNkVRuVh86MAvVM7cmYwpjGrGyE
        3/rqBsf81Gsn7tcCO5SuUw==
X-Google-Smtp-Source: AHgI3IZZwqiSDSHdiLTQNK+lTbSlVFdwpLSc+EkLTLQ/vi4TxOYnxH29YumU2rsa6/ESEyKH2fjZ7A==
X-Received: by 2002:aca:f2c4:: with SMTP id q187mr698559oih.168.1551378193592;
        Thu, 28 Feb 2019 10:23:13 -0800 (PST)
Received: from localhost (ip-184-203-129-180.hstntx.spcsdns.net. [184.203.129.180])
        by smtp.gmail.com with ESMTPSA id y37sm8754967ota.17.2019.02.28.10.23.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 10:23:12 -0800 (PST)
Date:   Thu, 28 Feb 2019 12:23:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: clock: exynos: Add ADC clock ID to
 Exynos5410
Message-ID: <20190228182311.GA18866@bogus>
References: <20190212175052.6310-1-krzk@kernel.org>
 <20190212175052.6310-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212175052.6310-3-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2019 18:50:50 +0100, Krzysztof Kozlowski wrote:
> Add ID for TSADC clock to Exynos5410.  Choose the same value of ID as in
> Exynos5420 to make it simpler/compatible in future (although clock
> driver code is not shared).
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  include/dt-bindings/clock/exynos5410.h | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
