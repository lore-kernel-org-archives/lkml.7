Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA3EC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 15:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1812421BF2
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 15:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WY6tCtRo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387886AbfHGPLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 11:11:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33598 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729714AbfHGPLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 11:11:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qNky4UNJfhbaacqAKPCp1Cl/iNKLfOo72Ypj0bndXBI=; b=WY6tCtRotzKTFTGqidAnSGXlR
        213xSXqebqIXDv0n3X6EupaDMeXze0yMpcbn6ON+Z2ieSbg6eAiELkkVrjVPeIEgbJyguwULVr6Ks
        qbkWwxLEuUIigtlIuNxZDfZsl+Sn9NJu8C1bYGcKfJknsrJ9f5tk6CC9srZAM62OuD0VSwrSqYfRh
        WnLi+sjttk850La810W1krlCZ8m7OYPXWFAud3XSRJDveTkYep5BXDDbTk06DA3yxC4clJZHlkxJz
        dRxo67TYYEjsls/wHXjBZWRTIsY21t1p6IIsmqIDwPmxtARnYw1F4cy+agJIz5UtcIToY0SB91q3n
        kByFPx/Qg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=[192.168.1.17])
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hvNag-0004IV-RD; Wed, 07 Aug 2019 15:11:02 +0000
Subject: Re: linux-next: Tree for Aug 7 (mm/khugepaged.c)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Song Liu <songliubraving@fb.com>
References: <20190807183606.372ca1a4@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c18b2828-cdf3-5248-609f-d89a24f558d1@infradead.org>
Date:   Wed, 7 Aug 2019 08:11:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190807183606.372ca1a4@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/19 1:36 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20190806:
> 

on i386:

when CONFIG_SHMEM is not set/enabled:

../mm/khugepaged.c: In function ‘khugepaged_scan_mm_slot’:
../mm/khugepaged.c:1874:2: error: implicit declaration of function ‘khugepaged_collapse_pte_mapped_thps’; did you mean ‘collapse_pte_mapped_thp’? [-Werror=implicit-function-declaration]
  khugepaged_collapse_pte_mapped_thps(mm_slot);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


-- 
~Randy
