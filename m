Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA2FC17442
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 03:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA6C2196E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 03:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573615298;
	bh=bQFk3ld2rDVrbWbkcAfKuIPNaNAuTTmtxal+zD1t0io=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yFUcLyoO0zyVT/ku2jyJdhOwFl2bKCdTHlMBUXhls0DBalxXOHogNojdEhB+sCGC0
	 eM08V1TmCx6mSLcXVHyf/YhdLbDnbR1I3WQ//JSJYUm/QjWbDjpplPmmpAt85l5Bai
	 3CARzpdo4mLRt1O4CBqyZkdgo4haNUMB0pRNthx8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfKMDVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 22:21:37 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40074 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbfKMDVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 22:21:36 -0500
Received: by mail-ot1-f67.google.com with SMTP id m15so371496otq.7;
        Tue, 12 Nov 2019 19:21:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZpV1BsOVjY8q8m9cj3xdi1GErJhtJv7dWu4+vEcZ+LU=;
        b=tKN6nP5oIC8i+LZ/mzld99wsbFF+M8YSEsKF2D44YaMi72GufuKFv87XrZM9mRWzW0
         PXlAWP7gUto2LnQP8xAnl+ony2nudL8urudiv5lHfOVR6vg2Sfdp08xHE8TasiYlxRKp
         cRy2bVxU20c/E+AP9gvXkQdRDKF/g4e+8TKYwyxF1ubbiaoQxGVAdh9zUwfRbBwQoHL3
         x2xBjj98jtIkJcTmj6ubsLCGzNXEARWa/LuN6xcYFDMegyzECvbzDMFwsGigYxGFKzI0
         pF1pPkFTxVNthh2Cst28QaxaMTfbS/TA6nSkxxrumGgStc3+9yea61OUzKOTUB6ieWN2
         Oy7g==
X-Gm-Message-State: APjAAAXkLu7AuCblwe6WnC0djKROQ2EGnjixW6MsERl1QR/x+dOT+ZBt
        Kf3rFgpWseyGtI4qUa0TzA==
X-Google-Smtp-Source: APXvYqyGSOaOY6zYR3u9pUTxpKNtPkaV8wIzmQP3ltkXxEBF05SZjChVa48v9pS0fFiji5WzBFYwMw==
X-Received: by 2002:a9d:6452:: with SMTP id m18mr820905otl.325.1573615295837;
        Tue, 12 Nov 2019 19:21:35 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z2sm325119otp.2.2019.11.12.19.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 19:21:35 -0800 (PST)
Date:   Tue, 12 Nov 2019 21:21:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marian Mihailescu <mihailescu2m@gmail.com>
Cc:     linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, kgene@kernel.org,
        Marian Mihailescu <mihailescu2m@gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: gpu: mali-midgard: add samsung
 exynos 5420 compatible
Message-ID: <20191113032134.GA22574@bogus>
References: <20191106225527.9121-1-mihailescu2m@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106225527.9121-1-mihailescu2m@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Nov 2019 09:25:26 +1030, Marian Mihailescu wrote:
> Add "samsung,exynos5420-mali" binding
> 
> Signed-off-by: Marian Mihailescu <mihailescu2m@gmail.com>
> ---
>  Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Applied, thanks.

Rob
