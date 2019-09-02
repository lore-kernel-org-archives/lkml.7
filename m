Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2507BC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 14:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9DB121897
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 14:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567435943;
	bh=6PSO/nxxH6E7rH4POLfZSbmsPfvvw27+rlFFBiJXDXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gDZQfAajxorWrI+5h7TVr5FNhMZ1Cc172/4fzGEBDVZly1IlqjVLMlX+hL9oR11/u
	 WyiapI7Z+TVabH35oqrhFNQaTdUIvzQIaGDMr41zN7GtncSAcHHt2RYbWdaJ3dBSAI
	 m9c7AcRm7OWns1Uj82TpZd0LxF6fFm7mqAhDlPJo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731704AbfIBOwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 10:52:22 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42623 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731124AbfIBOwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 10:52:21 -0400
Received: by mail-wr1-f68.google.com with SMTP id b16so14296451wrq.9;
        Mon, 02 Sep 2019 07:52:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rF1ShMFaoBoIJKVAItfKLBMp/S6IYg6UKeE556VZUPk=;
        b=QJ7ujCczJ/qOPsKCQJUSQVa8EAnyud60MITW1KyuxcoJejA0NM6kJhzMyYva1IreDk
         0DvnBBQ/kEfLESFF38HRslIA9OOxxqnPbAfSGJejaY+HEIFRW8Bjd79ALeiavtrND3Tn
         l2FGwrQlMvANDC9LBsXknTw+WFuV3MdVbT/aWs/4VDIYxpzF/TkyluViefdnNsMEB7Zd
         CXBGs6YzPqOqlpYDEKVl+QK1TL9nWhHi/siO8Qj6GsUu4x/r6GzpmcINEctsH9LGQPx5
         pfSPNuF35BT+s2gf7SOWqi7FNZFwtIt+Ey28sEXil5UFAa5oTf9phhCLqD25lxPborvy
         tEcg==
X-Gm-Message-State: APjAAAWY9+FUcl/xflaLer9w77OCpFim3gVoDFaSohDyTtS/MhnEF2El
        icYa208lXp3qZI7A+ppLFashXH4xTw==
X-Google-Smtp-Source: APXvYqwZiS+dbPMJ03rNFquz/jLokONAQC3oPFpXJZ5lBJnRoFoxcmGQRYbJnW7E5Yk7B5rvfbQ0Cw==
X-Received: by 2002:adf:eccb:: with SMTP id s11mr34456316wro.351.1567435939910;
        Mon, 02 Sep 2019 07:52:19 -0700 (PDT)
Received: from localhost ([212.187.182.166])
        by smtp.gmail.com with ESMTPSA id r18sm15631350wmh.6.2019.09.02.07.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 07:52:19 -0700 (PDT)
Date:   Mon, 2 Sep 2019 15:52:18 +0100
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Nicolas Pitre <nico@linaro.org>,
        Sebastian Capella <sebcape@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 1/5] dt-bindings: arm: idle-states: Use "e.g." and "i.e."
 consistently
Message-ID: <20190902145218.GA12862@bogus>
References: <20190830150302.20551-1-geert+renesas@glider.be>
 <20190830150302.20551-2-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830150302.20551-2-geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Aug 2019 17:02:58 +0200, Geert Uytterhoeven wrote:
> Replace abbreviations "eg" and "ie" by "e.g." resp. "i.e." for
> consistency.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  .../devicetree/bindings/arm/idle-states.txt      | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 

Applied, thanks.

Rob
