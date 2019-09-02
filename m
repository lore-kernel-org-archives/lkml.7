Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D6FC3A5A5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 15:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C06821744
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 15:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567436400;
	bh=QpUWtTUt7Z08mbsJYP4UjZaxnaxKCCCxxOlVCcK0h5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J9vb3a8zTnfAwpEG0TZml7cLBEvdvtp1ivvWQJyJVOFtOlwQ6nVzh5hmk3LLbn6Nv
	 kfLLE0wOY8UBogO+PPGc5SEmpF6iX+akJtwL6YT2LoxFGGWWN6djspacCvtvPLJx7c
	 oZOOkmV6INZuTTBUUazAD9mQKN/VjTW1ygC8pDVc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731593AbfIBO77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 10:59:59 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50564 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbfIBO77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 10:59:59 -0400
Received: by mail-wm1-f68.google.com with SMTP id c10so3024035wmc.0;
        Mon, 02 Sep 2019 07:59:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PveZWoSRg0Xj/8f3NgdMzEIMdyiWS2QP4VpEM/S33uM=;
        b=NwFMCVMTwMRdMd67UD1SptubFtezmt620SNu5sOH71UqXs8mHkL3kR5o2ihbp9kpMl
         FZL4wM+u8kBV6ZgQmAtTViU5uyE/r4SXeNOHcDxCHMCa+7iPIOgk1BdsJ5rqAlaAdW+E
         dFQ5CCHuV6+xtv+fv84UHp8H6yz69lgFyggcfgXjO+ed+DLcKMpJ3JV95K/MtHDojOZ+
         cTVqE3TVqow3afUUC6tBLOMFifZ9pBWBGVlZyxmS1Z1rXmmCOEbHeXjdhki3hAnvKtbd
         SmoPSYtUvzrqDrrMLt2/lsX72IqCVSxH0yJa4xkfQXAbm94C2Iyebea6ZDNY61EwTAIr
         mP9A==
X-Gm-Message-State: APjAAAWGQHgdiQusz4lNGty4YCzy9odj9COLUPN1mOcllGraBCAQ6s7u
        Qj9s1vnpr5aGlQJ7kOiu+w==
X-Google-Smtp-Source: APXvYqzLMm9WsEO6fsNR/ncTXTXoXpnyrftH4TyDW+mSprCv/cJKvWN/o8bsNiuCBuDlvEb5kvNmXA==
X-Received: by 2002:a7b:c752:: with SMTP id w18mr4816777wmk.63.1567436396991;
        Mon, 02 Sep 2019 07:59:56 -0700 (PDT)
Received: from localhost ([212.187.182.166])
        by smtp.gmail.com with ESMTPSA id z21sm3189944wmf.30.2019.09.02.07.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 07:59:56 -0700 (PDT)
Date:   Mon, 2 Sep 2019 15:59:55 +0100
From:   Rob Herring <robh@kernel.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     p.zabel@pengutronix.de, robh+dt@kernel.org,
        bjorn.andersson@linaro.org, agross@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, Sibi Sankar <sibis@codeaurora.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: reset: aoss: Convert AOSS reset
 bindings to yaml
Message-ID: <20190902145955.GA26470@bogus>
References: <20190901174407.30756-1-sibis@codeaurora.org>
 <20190901174407.30756-2-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901174407.30756-2-sibis@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  1 Sep 2019 23:14:06 +0530, Sibi Sankar wrote:
> Convert AOSS reset bindings to yaml and add SC7180 AOSS reset to the list
> of possible bindings.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  .../bindings/reset/qcom,aoss-reset.txt        | 52 -------------------
>  .../bindings/reset/qcom,aoss-reset.yaml       | 47 +++++++++++++++++
>  2 files changed, 47 insertions(+), 52 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/reset/qcom,aoss-reset.txt
>  create mode 100644 Documentation/devicetree/bindings/reset/qcom,aoss-reset.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
