Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4E5C2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 10:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEEA42173E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 10:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576061774;
	bh=W4HJnLLfkz+9pZfBwof/Jhq9AVGDLbtCcfuXGXRk6yU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dDNc33r7QNpA/OM2kQMRHNb0XzdIsWJk7bdTpl+luH8muEBTy64ZpKfNsegOevSLP
	 3BUhQsHcA15S6iVq7YD+niq3GTlnXC9kC61dkANxDjAtsIPXCFZX9g2aVoDawkxEXd
	 BMho+aZKVG4zIWeIteuIRMwJWpepCAlMUm9umeu8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbfLKK4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 05:56:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:58360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728606AbfLKK4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 05:56:13 -0500
Received: from localhost (unknown [171.76.100.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F9282073B;
        Wed, 11 Dec 2019 10:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576061772;
        bh=W4HJnLLfkz+9pZfBwof/Jhq9AVGDLbtCcfuXGXRk6yU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zl2s5hucTbHwpm0KYlr7wLswRS4nTVZV1WCEZAaCdP267v6+TktQNLwB4YM4MLrUs
         yxWU3nFoqNMiY3TF9u8HkWouhfEsH6SVqGr3x3XeNlekcd6QeIuL1BydWX32+VYODC
         nnIk5scymcxAjnCpreCeQhacfuT2byXh0Sx7fx5k=
Date:   Wed, 11 Dec 2019 16:26:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     od@zcrc.me, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] dmaengine: dma-jz4780: Also break descriptor chains on
 JZ4725B
Message-ID: <20191211105608.GH2536@vkoul-mobl>
References: <20191210165545.59690-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210165545.59690-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-12-19, 17:55, Paul Cercueil wrote:
> It turns out that the JZ4725B displays the same buggy behaviour as the
> JZ4740 that was described in commit f4c255f1a747 ("dmaengine: dma-jz4780:
> Break descriptor chains on JZ4740").
> 
> Work around it by using the same workaround previously used for the
> JZ4740.
> 
> Fixes commit f4c255f1a747 ("dmaengine: dma-jz4780: Break descriptor
> chains on JZ4740")

Applied, thanks

-- 
~Vinod
