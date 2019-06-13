Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A22C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 21:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEF962133D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 21:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560461658;
	bh=t1ePPuE0FeS6cNVEXfvF5ypiF0tBhOnAgVeOoLza0Qg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jl3qkYYGF5zCUQmIW1M+X6ePvOqK/P7s2jPi8pcx3nPlFlACtzTxqo3Jg097tcez+
	 HjQcdn8u6a9/GLaYWwtDIXX9YEV4XKfkvSM0vQsNxddQhwQSS2X8YWGnmSgM3qMAEk
	 y/DsRfcEeIX7fxZStEeCFi8OzXEyQDiIfXY6M140=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfFMVeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 17:34:16 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36482 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfFMVeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 17:34:16 -0400
Received: by mail-qt1-f194.google.com with SMTP id p15so177373qtl.3;
        Thu, 13 Jun 2019 14:34:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QU5VwK4qUMJTAGJQYoXGc7EJj8v3djQznJbv6zS3tOw=;
        b=sBtVMD7LjTgvItC3OILGv5f1xWhaR2oYs4j+u1tKgYLyobxzIlVcj6o0DwhKY61W+L
         UL16264Ic0RylDxFMZA6hqC+MO0kZg/VXWsHU75rlcpF9AdArm9crDbHunFjTBw8AsPR
         8i/EktjoSAd233C7JEm76ZGUKkWVxerMzWVeph5EO5FxNpXOsmzUxKPYtNZew1tpMky1
         ArilRl/8tDLNYkUM/U2UTu6UfjbLn+23ext0p0N6jiqK7tg11RSax84vm9glFC2h4QVc
         7L+XTolaIO6ryXjkVwsBB8Aw6QBJsS44JYlrRcErM1JesnygxAK8RhdLRWgYs/qJCGcn
         XT8w==
X-Gm-Message-State: APjAAAXYXJZAnA/E9f+uO5EpV12NaOJqjPmqlw+S/Guuo/JlVgxIYyRo
        tqTmKT/0eXEv/L9ncps1Ag==
X-Google-Smtp-Source: APXvYqyPivTtN/7LKKaFByzkQq8Qw9rNWiWAzIBAtjTFOBr0sH2mtqlMI0zW7+liNdFD4B1MN1wqgQ==
X-Received: by 2002:ac8:2a88:: with SMTP id b8mr16632237qta.331.1560461654761;
        Thu, 13 Jun 2019 14:34:14 -0700 (PDT)
Received: from localhost ([64.188.179.243])
        by smtp.gmail.com with ESMTPSA id y129sm395225qkc.63.2019.06.13.14.34.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 14:34:14 -0700 (PDT)
Date:   Thu, 13 Jun 2019 15:34:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     devicetree@vger.kernel.org, Chuanhong Guo <gch981213@gmail.com>,
        Weijie Gao <hackpascal@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: ralink: add mt7621-clk.h for device tree binding
Message-ID: <20190613213412.GA4156@bogus>
References: <20190516072731.21957-1-gch981213@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516072731.21957-1-gch981213@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 May 2019 15:25:51 +0800, Chuanhong Guo wrote:
> This patch adds dt binding header for mediatek,mt7621-pll which
> was added in:
> commit e6046b5e69a0 ("MIPS: ralink: fix cpu clock of mt7621 and add dt clk devices")
> 
> Signed-off-by: Weijie Gao <hackpascal@gmail.com>
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> ---
> 
> checkpatch.pl shows a warning that the line referencing old commit
> is over 75 chars but if I shink it down anyhow it gave me an error
> saying I should use a proper style for commits. So I chose to ignore
> the warning and fix the error.
> 
>  include/dt-bindings/clock/mt7621-clk.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 include/dt-bindings/clock/mt7621-clk.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
