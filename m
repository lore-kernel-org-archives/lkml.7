Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E994DC17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 00:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D7A2184C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 00:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573520163;
	bh=EgcXPkRcFzzSP/5tJczvfXCkrgf+Z8YwY8DLVs/PB30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SYWhU0AgurXgA3K6DNmJ+2WaObHVzapGjCFPmejSbA6Ul+R3aR474e71u6SD6ZgA9
	 RjniVtE+Om2XhJ7wAnIBdc3x3UStQAVGPOtfzj3kTD6bLtjs5gIovw1yrJgU9Tt6DR
	 inqxcIXmJr2pLBJgkNi1FuKF68+1+usMZTIey/Vo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfKLA4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 19:56:03 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44650 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfKLA4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 19:56:02 -0500
Received: by mail-oi1-f194.google.com with SMTP id s71so13244964oih.11;
        Mon, 11 Nov 2019 16:56:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w0hUYi0aGomUJ4biwZlamKptJP2MsFJNZc7O1AJ4TG8=;
        b=n3/Ie6gj1I+OnH8jn9MUn8iBqTaaYNtnM91vbTZToTjWi9ITlMrP2qFC5EFD4jIFLN
         OjM1H0aOmQLtmWnDOHJBfEAY0nqiYzp1/L2oFLLEWE1pBRNYWg1I1NOwEFvh3my/m0Ve
         1f3d8U+QvHvzd0BGZ49peo3GcLU19XnMVdYH6pIOH2xBH/T3NMMnevAQ2mTGOJH17oIR
         8kFl+rtPIpL1U+8UPVGKPjKyAAPlyZlE6VomZ4I0sqeY53AR+uwG8alStqsm1hsch/Kq
         QVM3YfgI3x4aJ+hJmc0TBYr29jfGpzOrjtzlWXJwpQ0osRBpiHmjK+yPS/FEqN5vi5Vw
         IrXg==
X-Gm-Message-State: APjAAAUR5MJUSdSg31TRG6fg27kGvc4RGkALg5WYog2JLdSlavWMFbz+
        OyBWMJUUZdJInkT6JniJxQ==
X-Google-Smtp-Source: APXvYqx2Uo0z2A9826gykm3QcmFFSP9JCMB+Kt9j4tuCDauBT2sxNJmHkIGIBoEtHY81NCmQmfLNug==
X-Received: by 2002:a05:6808:906:: with SMTP id w6mr1541050oih.162.1573520161596;
        Mon, 11 Nov 2019 16:56:01 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e19sm5332044otj.51.2019.11.11.16.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 16:56:01 -0800 (PST)
Date:   Mon, 11 Nov 2019 18:56:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chunyan Zhang <chunyan.zhang@unisoc.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: Re: [PATCH v2 4/5] dt-bindings: serial: Add a new compatible string
 for SC9863A
Message-ID: <20191112005600.GA9055@bogus>
References: <20191111090230.3402-1-chunyan.zhang@unisoc.com>
 <20191111090230.3402-5-chunyan.zhang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111090230.3402-5-chunyan.zhang@unisoc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Nov 2019 17:02:29 +0800, Chunyan Zhang wrote:
> 
> SC9863A use the same serial device which SC9836 uses.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  Documentation/devicetree/bindings/serial/sprd-uart.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
