Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9682EC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 628182084D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551378165;
	bh=KXUUamm4lOgpukmBbHaWbLfqk/WDtg++1OifGhScH70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=szWxpVSplgHZsmWxT6N5epMfB8f/PMtAdyUtxK2BjiQ6z3T+g6xCsRush+X1Bv5gv
	 GRE/V8nK6KaNi6TMQMVZXyoVAgGzwVCEuj4gatK87XBRrEVNZX6QL8Awwc9efjwQjN
	 G0JoGhTkTQpqWEnPygYss01zux9VEXjD5af9lj3E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388693AbfB1SWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:22:44 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40464 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbfB1SWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 13:22:43 -0500
Received: by mail-ot1-f67.google.com with SMTP id v20so18555071otk.7;
        Thu, 28 Feb 2019 10:22:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ciu4RtKy/TQpYDmARzTmV1mLvriWjUCX/biF69oe3CE=;
        b=aEYb8EYG3hf/kArne+ycMuTP8wGCk/C3wZGUI2MKffpymD3zayoZphGYePCm9RUZp4
         foHMDSvEZpSnKmXPjNUl4JylPtLm+cSmnL0MMatyWVdCzPmeZMK7gnMmmNms/5z7GflH
         kRdZ7oQ/6KGu+TjAfGz8sNfns2h9BD4aCuZxO0PeoJ4oqKguT1weqnoBxJ9Ql1Gw/O2r
         jbRRvZeKoYPgf0WwhDfjIN+sgBIt1POeCF2qT0DugQZ4c0+sJ3CqvwBYSe7pYV60/tKF
         Pmr0fLMJLTViKNkGrQyjUU/mS0rAjq/IiVJm6nPIRNapxdrdEKbZ6xDISif6nxcE6hLd
         LJKA==
X-Gm-Message-State: APjAAAXEa/OSF+TXCFJWGPcrLtu/L4QY5xtape25O4R3tmlYe5VL5EPC
        +lE3ai9NkzXj7TaTDqiRug==
X-Google-Smtp-Source: APXvYqzUGBeVL+BGkD0KXI58J5UvcYFla6rX/zpcID6ahsJQ4loXCVyYVvlP/MFSuhb+LQ/MghsnzA==
X-Received: by 2002:a9d:7547:: with SMTP id b7mr635391otl.244.1551378163006;
        Thu, 28 Feb 2019 10:22:43 -0800 (PST)
Received: from localhost (ip-184-203-129-180.hstntx.spcsdns.net. [184.203.129.180])
        by smtp.gmail.com with ESMTPSA id g80sm7695801otg.38.2019.02.28.10.22.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 10:22:42 -0800 (PST)
Date:   Thu, 28 Feb 2019 12:22:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: clock: exynos: Put CLK_UART3 in order
Message-ID: <20190228182241.GA18048@bogus>
References: <20190212175052.6310-1-krzk@kernel.org>
 <20190212175052.6310-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212175052.6310-2-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2019 18:50:49 +0100, Krzysztof Kozlowski wrote:
> Order the CLK_UART3 by ID.  No change in functionality.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  include/dt-bindings/clock/exynos5410.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
