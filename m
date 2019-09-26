Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07077C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 20:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE97121D7C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 20:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="iT1TWL+4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbfIZUzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 16:55:50 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:46424 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727948AbfIZUzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 16:55:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id C92533FBDF;
        Thu, 26 Sep 2019 22:55:48 +0200 (CEST)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=iT1TWL+4;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mCc1skLxnFSs; Thu, 26 Sep 2019 22:55:47 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 15C263FA6C;
        Thu, 26 Sep 2019 22:55:46 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 787EE3601AA;
        Thu, 26 Sep 2019 22:55:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1569531346; bh=QDCzJnIw2NcRoyWGnCmx01s2V3PezimSel1iXciq1+Q=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iT1TWL+4cqBnl+TNn7Xu1wTe3naZCoTfhaRKoWLUMNnSy2L+J9vU1YCwN0qUQPOuP
         r+dn5uLvaChhSo65zGrWGCe6lzIgxh61AHJB3PMZIEFdAnGaU4iOhdTHNI0IH6cmKW
         PFKNh8UtHSPx96Nd6WgYKQT/5JT0kFZfuLoaAK50=
Subject: Re: Ack to merge through DRM? WAS Re: [PATCH v2 1/5] mm: Add
 write-protect and clean utilities for address space ranges
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
References: <20190926115548.44000-1-thomas_os@shipmail.org>
 <20190926115548.44000-2-thomas_os@shipmail.org>
 <85e31bcf-d3c8-2fcf-e659-2c9f82ebedc7@shipmail.org>
 <CAHk-=wifjLeeMEtMPytiMAKiWkqPorjf1P4PbB3dj17Y3Jcqag@mail.gmail.com>
 <a48a93d2-03e9-40d3-3b4c-a301632d3121@shipmail.org>
 <CAHk-=whwN+CvaorsmczZRwFhSV+1x98xg-zajVD1qKmN=9JhBQ@mail.gmail.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <c58cdb3d-4f5e-7bfc-06b3-58c27676d101@shipmail.org>
Date:   Thu, 26 Sep 2019 22:55:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=whwN+CvaorsmczZRwFhSV+1x98xg-zajVD1qKmN=9JhBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/19 10:16 PM, Linus Torvalds wrote:
> On Thu, Sep 26, 2019 at 1:09 PM Thomas Hellström (VMware)
> <thomas_os@shipmail.org> wrote:
>> That said, if people are OK with me modifying the assert in
>> pud_trans_huge_lock() and make __walk_page_range non-static, it should
>> probably be possible to make it work, yes.
> I don't think you need to modify that assert at all.
>
> That thing only exists when there's a "pud_entry" op in the walker,
> and then you absolutely need to have that mmap_lock.
>
> As far as I can tell, you fundamentally only ever work on a pte level
> in your address space walker already and actually have a WARN_ON() on
> the pud_huge thing, so no pud entry can possibly apply.

Well, we're working on supporting huge puds and pmds in the graphics 
VMAs, although in the write-notify cases we're looking at here, we would 
probably want to split them down to PTE level. But if we would want to 
extend that or if we would want to make this interface general, we'd 
probably want to support also a pud_entry callback.

Looking at zap_pud_range() which when called from unmap_mapping_pages() 
uses identical locking (no mmap_sem), it seems we should be able to get 
away with i_mmap_lock(), making sure the whole page table doesn't 
disappear under us. So it's not clear to me why the mmap_sem is strictly 
needed here. Better to sort those restrictions out now rather than when 
huge entries start appearing.

>
> So no, the assert in pud_trans_huge_lock() does not seem to be a
> reason not to just use the existing page table walkers.
>
> And once you get rid of the walking, what is left? Just the "iterate
> over the inode mappings" part. Which could just be done in
> mm/pagewalk.c, and then you don't even need to remove the static.
>
> So making it be just another walking in pagewalk.c would seem to be
> the simplest model.
>
> Call it "walk_page_mapping()". And talk extensively about how the
> locking differs a lot from the usual "walk_page_vma()" things.

Sure. Can do that.

Thanks,

Thomas


