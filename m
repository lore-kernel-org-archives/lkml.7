Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FADC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D5820863
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551379424;
	bh=JCphXb/hcKvBuiOcSVjoLg8wJh/vKVmLdfozYHUdQxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mf0dgA8Fy+PJkeL0GTM9eYKWXVg/uUwDRq8ebVtVsalo96onfoyR0JzMDDMn89u4+
	 lur/RPJvTvfSKCajrB6fasGBD5Wz7auJbYxICT9mGsD4yv1aYf1ANh4ivsLdsKQXdt
	 1Cij3ZO9wqyC1nkFajoxaRTkxlLuuNTZSyhx44w8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388324AbfB1Snn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:43:43 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42514 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727754AbfB1Snm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 13:43:42 -0500
Received: by mail-ot1-f66.google.com with SMTP id i5so18586233oto.9;
        Thu, 28 Feb 2019 10:43:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ub9L0bc9x6YR2LlPSYei8XxBJFR/qToweWtSAVu7q1Q=;
        b=FX+MzQWfKp4Abcz0MAIsYdkfpFJ8L1pfHYxzcwJblf/9Kk/SgQoRPjff44sTYjLblN
         Rld2SKQsPX6OcGQSMZe5EFJYl6e3YZXB2ixUq3srK3QZrLeVfLQGlBv5QK5NaUxaAnDS
         tJ/mGn36YSqyoCr7KB7GrA7Q8GlwnM0Y0pq7xyKQRHBCtnviGENhtdCsN6Q+PADUgGbm
         RMWad/0X8+xpqjCG0Sf83aA+e1XxP4mxNyaJUi18F58GHWnRPV5yLWiG0ExSBIO7DciY
         Z8+Hd20JOHGfcpNDvIiTZR0CnmMVo2FmtUMdAENwXfK8Pk4c2dvRS3RKpq1XifQHN8h/
         IhyA==
X-Gm-Message-State: APjAAAX3d7tYBmMw1eQNlBGfva0ZkS6SKjlaYkiJWxHj/lTqj3xGb8hh
        4C6BGaQvulV0xcCX8NdoKV2pBj0=
X-Google-Smtp-Source: APXvYqwfZD7WxP166tjoAjPG0pjbUZFo5Tpx7nJ158vcQDpllmW1TpnbbJG6fx/7x0jrcaeCi+MAhA==
X-Received: by 2002:a9d:73c2:: with SMTP id m2mr716881otk.91.1551379422204;
        Thu, 28 Feb 2019 10:43:42 -0800 (PST)
Received: from localhost (ip-184-203-129-180.hstntx.spcsdns.net. [184.203.129.180])
        by smtp.gmail.com with ESMTPSA id g22sm7620589otp.47.2019.02.28.10.43.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 10:43:41 -0800 (PST)
Date:   Thu, 28 Feb 2019 12:43:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ryder Lee <ryder.lee@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Weijie Gao <weijie.gao@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/3] dt-bindings: soc: fix a typo for MT7623A
Message-ID: <20190228184340.GA16234@bogus>
References: <56a2c38c9efa41be940858e19501fe07fbd5120e.1550233614.git.ryder.lee@mediatek.com>
 <4dc5366741758441388ffd4c976135d28d2ed652.1550233614.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dc5366741758441388ffd4c976135d28d2ed652.1550233614.git.ryder.lee@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Feb 2019 21:50:31 +0800, Ryder Lee wrote:
> From: Ryder Lee <ryder.lee@mediatek.com>
> 
> This fixes a typo for MT7623A
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  Documentation/devicetree/bindings/soc/mediatek/scpsys.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
