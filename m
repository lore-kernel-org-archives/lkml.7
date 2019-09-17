Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1973C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 20:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7367F2189D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 20:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568752088;
	bh=N4IH8eB+lg5VSJLEqbnTKq5b591rwo1ADVfnNxjRyfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EBPdM3MUlXqZwMipi/xjJpeKSsYZhZzbWZQ3+/T6zzgHtuzDVkqFhGeGLU8HGvOvC
	 c5FBBmLJ0DbSnR8NFOSvBQye/mrzSCo+n4XqNYM4cJsr20kHlmnzOiX/71JgqOASY/
	 9khxjvJSSzms8WcTnoUphM+VMAXpgO/iTgM/vB4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbfIQU2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 16:28:07 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43764 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbfIQU2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 16:28:07 -0400
Received: by mail-ot1-f65.google.com with SMTP id b2so4252772otq.10;
        Tue, 17 Sep 2019 13:28:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OmuRgprkyi1Y3BeLYMvuW7iFWGhTnGC5Ky9VxrWaoyo=;
        b=gZa1+qwHGJTQ98GRc558+mNH0n9sllWgdK/oy0R3JJyuSYFB5wzmx+KAa6AEL/UOEw
         KvThji1bLAaQCxLe/MHgOz8NWW1VRv+g6ccKOhvxaGbhY9tsQqkRIetfY3Grbe1ySVo0
         AWKOB5IepfkJUIbgnVM8ihkPhvAp+PZ3/wruyBto9b/xz38QlS6+O4KaGis/pwMWFYl+
         YQygHPSwIPEC0rts0bStmcRvK8/VhoUGCMcp8cfUGIy/oc51ftwGno82B5XaoZljNSOu
         SBiiZauHO9Q7CxepwxQrNB38pB/k039r92/of5LPR7F9ax+t2JAxlLST48ETG5DJWf3L
         FS2g==
X-Gm-Message-State: APjAAAU7eKFWcsMk3/Yib3AF5ogGitoA7EBBjpUuYVSGhFWghytSbU73
        9bnoVcNDSPntQuG6yr5Qw1+O+a169A==
X-Google-Smtp-Source: APXvYqyDocPQdmogtqeo027e5xyEsYwS3WJPg0YHLQKJqNfJBn/Ya6ZQgcgCgmx8DGlTDSU3zwJlJw==
X-Received: by 2002:a9d:3647:: with SMTP id w65mr588936otb.70.1568752086445;
        Tue, 17 Sep 2019 13:28:06 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n13sm1000400otl.8.2019.09.17.13.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 13:28:05 -0700 (PDT)
Date:   Tue, 17 Sep 2019 15:28:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 04/11] dt-bindings: phy-mtk-tphy: add a new reference
 clock
Message-ID: <20190917202805.GA13405@bogus>
References: <1567149298-29366-1-git-send-email-chunfeng.yun@mediatek.com>
 <1567149298-29366-4-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567149298-29366-4-git-send-email-chunfeng.yun@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Aug 2019 15:14:51 +0800, Chunfeng Yun wrote:
> Usually the digital and analog phys use the same reference clock,
> but on some platforms, they are separated, so add another optional
> clock to support it.
> In order to keep the clock names consistent with PHY IP's, use
> the da_ref for analog phy and ref clock for digital phy.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2: fix typo of analog and needed
> ---
>  Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
