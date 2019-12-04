Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E39C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F37220659
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KiqVQ3CN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbfLDQiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 11:38:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33328 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbfLDQiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 11:38:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xfQ+lvUckzKsMaIRi5u6tGdP1WAeCSU0z6SwMQ1YJQQ=; b=KiqVQ3CNjf8gnnkRJKo5pHlR4
        QDak0t6lU5vhwqYeZ18k8nyIs15u43dpLYok/4dekdwgUDnUygmGi3ov0GVdn5xBYdhrocmf5ZKjc
        yn7UVv4OKzaVTaQgkUeSBO/9XvndNRyj0SIEOkNTdtUmE2xuz7oWH4EU530hCH9MVvufi5Xv+CGji
        F1DC4qTo81eOU3zaRS+UYcMO57SAWAn/R/KPrO1RfLY7OSwrGY43fn2OOvlTh551uk1Q7lesgF+l0
        Kmjf4hEn67t3Y0PduP/co9t5LWpv8xVgg7EFbo8otmAIUsF9hr2tT35kHBG6mV7a3JZdscOh9xUxs
        IY97wPMbw==;
Received: from [2601:1c0:6280:3f0::3deb]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1icXfH-0006Mi-5r; Wed, 04 Dec 2019 16:38:11 +0000
Subject: Re: [PATCH] Documentation: filesystems: automount-support: Change
 reference to document autofs.txt to autofs.rst
To:     madhuparnabhowmik04@gmail.com, corbet@lwn.net, mchehab@kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <20191204100941.6268-1-madhuparnabhowmik04@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <09c9f538-8698-37c4-c5c0-2107a96ae859@infradead.org>
Date:   Wed, 4 Dec 2019 08:38:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191204100941.6268-1-madhuparnabhowmik04@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/19 2:09 AM, madhuparnabhowmik04@gmail.com wrote:
> From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> 
> This patch fixes the following documentation build warning:
> 
> Warning: Documentation/filesystems/automount-support.txt references
>  a file that doesn't exist: Documentation/filesystems/autofs.txt
> 
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> ---
>  .../filesystems/automount-support.txt         |    2 +-
>  doc.txt                                       |  492 ++
>  four.txt                                      | 7656 +++++++++++++++++
>  fs/nfs/dir.c                                  |    2 +-
>  scripts/pnmtologo                             |  Bin 0 -> 18112 bytes
>  5 files changed, 8150 insertions(+), 2 deletions(-)
>  create mode 100644 doc.txt
>  create mode 100644 four.txt
>  create mode 100755 scripts/pnmtologo

Hi,

It seems that there are some files in this patch that should not be here.

-- 
~Randy

