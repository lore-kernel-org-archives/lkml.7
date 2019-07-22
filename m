Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D8CC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 23:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C369D21955
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 23:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563839294;
	bh=tve6vRGy1hYeRoFtLdpdlo7UJFc7CAK0i0NPXWvKs3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=a2qZJMA+jynjKL8No8t49RLK3Ib99UxE3mTQoDf/PTN9eFXAuXEkiw7eXYzoXSG1l
	 3+5FLthwvGDtjEpGXFN+o6M4dfgxuvlQa3udqe0zQR7wXDuJvV+mqMRJUaalX6jBf7
	 //JlkR3+Mr3d86o2D75RhghnhyJwKVekTZGe/BsU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731996AbfGVXsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 19:48:13 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37349 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731206AbfGVXsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 19:48:12 -0400
Received: by mail-io1-f67.google.com with SMTP id q22so77894065iog.4;
        Mon, 22 Jul 2019 16:48:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z5dGHdXeC8C6M1Pe5s8pfnDnKQmDihjKHC9kjuo+Il4=;
        b=TPS9eLE75C/acSYjsS4+bFKW36G/Fb/TBuEi5+AokIIQuUohFur43qyJ0NM7ujDQsv
         9clgZ+6SrkGYRaNY/hXful+4tSekd5EirifGwNtKOfe9RLQo9dO95ralMJ8ZLrYVtctI
         idZkBWMW8f5kebV8iB9zS+WIlx0ZQyJ+Qht7E6FPI5v1vdtLJ8WDTBGikYNfAH1RGKmD
         e2igpsn+3gL6H91palTq1uJAv6xOc0xV4lnXdq2SRVwFaou8fu2R1OFin74std090kPR
         cexc1lh2e227HVE0lzeB39vRvesdZc8KKK+OXawrb+Cit/MyYpChnTO9asLqvyXxvHrZ
         8msQ==
X-Gm-Message-State: APjAAAVvMxu+5rZ/DZvCrW8Tdz63uWLRSweqhRH06hXpQ2sgdtB8nDpA
        0tEfVPowZNesiKxMtDN3bg==
X-Google-Smtp-Source: APXvYqw4b2UbLlSXGAhGzcm+i9ZSSI5DoDGtdkU/i/35wi+A6iRGqdOoCN9TZMz4vEDsJGzUqNOo0w==
X-Received: by 2002:a02:bb08:: with SMTP id y8mr31151132jan.51.1563839291717;
        Mon, 22 Jul 2019 16:48:11 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id j25sm53735053ioj.67.2019.07.22.16.48.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 16:48:11 -0700 (PDT)
Date:   Mon, 22 Jul 2019 17:48:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     mchehab@kernel.org, robh+dt@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        c.barrett@framos.com, a.brela@framos.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH 1/3] dt-bindings: media: i2c: Add IMX290 CMOS sensor
 binding
Message-ID: <20190722234810.GA22419@bogus>
References: <20190703190230.12392-1-manivannan.sadhasivam@linaro.org>
 <20190703190230.12392-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703190230.12392-2-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  4 Jul 2019 00:32:28 +0530, Manivannan Sadhasivam wrote:
> Add devicetree binding for IMX290 CMOS image sensor.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../devicetree/bindings/media/i2c/imx290.txt  | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/imx290.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
