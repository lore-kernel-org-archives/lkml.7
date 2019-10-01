Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA51C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 22:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA9EC21A4A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 22:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569968333;
	bh=GY7thRGOZ1r2xDbR89w74dCj0DAS+2dYgM86S+SMG8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=USy4oe+LVq/sF0oylur/LYpDmmCCRPrezM7oXCDjclyKTWsumBx27paPPFphaDlZ1
	 299r6U5OccCBgacGBMTLWx+TaswIHC7ACpzvyBXp3UIvuArvkwlIVBSbpx9O6ptzUp
	 N2JaQBH82TkIMMj2wwiRQFy8hTLk+AWXkH8ToaUw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbfJAWSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 18:18:52 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40067 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728254AbfJAWSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 18:18:52 -0400
Received: by mail-io1-f68.google.com with SMTP id h144so52144939iof.7;
        Tue, 01 Oct 2019 15:18:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DfJAIFweW93qpKH43bI88X5hOnNXXwnGiqTtHYDlS8Y=;
        b=VXvXMIzbhPVowRddSoxOikvIb+NR19AC1rqSxlXgzODltMGyDxfLp6law3vLKtxw5I
         trgB1ehtviZqnvZOLhZ6AMJQu/lG2iCkEK2r84SWRRh11x6Wf9EHyLNTlUxFIut3gNqc
         fNgbx106PHDuqqI+0H7Vr31pCyoMACVKzRmCJG55+251BAd8cDxDjOqptkfYeZdmXXeI
         D1Rfr9ikcqwQinAkc//tsGfGzcAIyKWqejC/8LcxZ3F+dc/N2qospfMEN6N2OU9/y2Ws
         W8VGxOuIQeA5on1uoHsEGvW1m8mbceR2mfLy27jQPmRz3B//PWK5FSXPMIx0i4BVD9fj
         f8Tg==
X-Gm-Message-State: APjAAAUxL1JpwZA+nKTf5VpZALRwxoE/vV3e1fm3R0PRr1gpbRrp4+ns
        mmQLK5JLQnXOuXCuKtLroQ==
X-Google-Smtp-Source: APXvYqw+cA3p1NFGee+H9razWOXS0gfBSqg2+hdSyzNszuTUWBpTFckUxRqvMV0GBeoX54prTGAuxg==
X-Received: by 2002:a6b:6e02:: with SMTP id d2mr516455ioh.8.1569968331333;
        Tue, 01 Oct 2019 15:18:51 -0700 (PDT)
Received: from localhost ([2607:fb90:1780:6fbf:9c38:e932:436b:4079])
        by smtp.gmail.com with ESMTPSA id e15sm7398438ioe.33.2019.10.01.15.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 15:18:50 -0700 (PDT)
Date:   Tue, 1 Oct 2019 17:18:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stefan Riedmueller <s.riedmueller@phytec.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Andrew Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: arm: fsl: Add PHYTEC i.MX6
 devicetree  bindings
Message-ID: <20191001221848.GA25201@bogus>
References: <1568980346-385840-1-git-send-email-s.riedmueller@phytec.de>
 <1568980346-385840-2-git-send-email-s.riedmueller@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568980346-385840-2-git-send-email-s.riedmueller@phytec.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Sep 2019 13:52:26 +0200, Stefan Riedmueller wrote:
> Add devicetree bindings for i.MX6 based phyCORE-i.MX6, phyBOARD-Mira and
> phyFLEX-i.MX6.
> 
> Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>
> ---
> Changes in v2:
>  - Use seperate description for each board instead of squashing them into
>    the standard board.
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 37 ++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
