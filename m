Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5BAC28CC0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 00:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DEC026359
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 00:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oNyfOy2o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfEaApZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 20:45:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42794 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfEaApZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 20:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LInI00vBigO+dJHdTLFg3h8dwMwZuftDBuiIhZvYL84=; b=oNyfOy2o6ei201o3XOziKAhUJ
        LML8GPVdJLcIjyqYy1pIoOtqFlI6EWfxMWNekx/NnrmVwTVkTLpKsDOAXi1ammeknONcOAGTibbF1
        VAKcfyAn/XoSoN1bE+/JKLbecqmmVy7w9eco4Da37cUskIuBbvZGbu8jl42V3ycAvkgAI/tvfilvo
        Gwbmp0WBLZnVYkaFjFqPfTpbTjLlgveh5DxyBCKdI3n0Rsk0B0h4hlkUgYprMxDOEAF0txHU/UYMy
        N60dcgjzm6RSB2fcFQW5+/v7lRf5T6+hYOoGcLP+hcDlxyiSKLM7oOT1sP9w4YGMbhAORq67j9USn
        HzRyaS5Gw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hWVfg-0003yE-En; Fri, 31 May 2019 00:45:24 +0000
Subject: Re: [PATCH RFC] Rough draft document on merging and rebasing
To:     Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
References: <20190530135317.3c8d0d7b@lwn.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7979b995-6b03-783b-e3d7-0023fabc43bc@infradead.org>
Date:   Thu, 30 May 2019 17:45:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190530135317.3c8d0d7b@lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/19 12:53 PM, Jonathan Corbet wrote:
> +  git merge v5.2-rc1^0

That line is presented in my email client (Thunderbird) as

     git merge v5.2-rc1{superscript 0}

Could you escape/quote it to prevent that?

> +
> +The "^0" will cause Git to do a fast-forward merge (which should be
> +possible in this situation), thus avoiding the addition of a spurious merge
> +commit.


-- 
~Randy
