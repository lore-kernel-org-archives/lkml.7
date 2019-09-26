Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA049C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 20:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E0BC21A4A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 20:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="gcmPxCth"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbfIZUJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 16:09:24 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:56792 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbfIZUJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 16:09:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 5175C3F486;
        Thu, 26 Sep 2019 22:09:21 +0200 (CEST)
Authentication-Results: pio-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b="gcmPxCth";
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qHKroFvcWLXm; Thu, 26 Sep 2019 22:09:20 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 460793F31C;
        Thu, 26 Sep 2019 22:09:14 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 7413A3601AA;
        Thu, 26 Sep 2019 22:09:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1569528554; bh=3l8scdJAPzeKA98DGCU5rWJe1BLj1pdf1s3/XvaFYIM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gcmPxCth95u3iGJfWJgByzgw5oVdwb+RepRSGLIODhe5//VGMSDj32YlGikCTRRhj
         lVpHXYknWBI43AymxkHDLUi1mox2Nt6EnuRk9fUVfg55a8znxCBTiiMHdAkL9XbI6z
         ftWhUKod23N7nvDRnZ/2dpoh8BqzWhIE2uw3siGA=
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
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <a48a93d2-03e9-40d3-3b4c-a301632d3121@shipmail.org>
Date:   Thu, 26 Sep 2019 22:09:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wifjLeeMEtMPytiMAKiWkqPorjf1P4PbB3dj17Y3Jcqag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/26/19 9:19 PM, Linus Torvalds wrote:
> On Thu, Sep 26, 2019 at 5:03 AM Thomas Hellström (VMware)
> <thomas_os@shipmail.org> wrote:
>> I wonder if I can get an ack from an mm maintainer to merge this through
>> DRM along with the vmwgfx patches? Andrew? Matthew?
> It would have helped to actually point to the patch itself, instead of
> just quoting the commit message.
>
> Looks like this:
>
>       https://lore.kernel.org/lkml/20190926115548.44000-2-thomas_os@shipmail.org/
>
> but why is the code in question not just using the regular page
> walkers. The commit log shows no explanation of what's so special
> about this?
>
> Is the only reason the locking magic? Because if that's the reason,
> then afaik we already have a function for that: it's
> __walk_page_range().
>
> Yes, it's static right now, but that's imho not a reason to duplicate
> all the walking (badly).
>
> Is there some other magic reason that isn't documented?
>
>                Linus

There is a discussion around this subject in

https://lore.kernel.org/lkml/20190926115548.44000-1-thomas_os@shipmail.org/

The main point is that there is an assert in pud_trans_huge_lock() that 
the mmap_sem is held, and we don't have it. Presumably we should be able 
to get away with the i_mmap_lock, but in addition I would have had to 
include the walk_as_pte_range() as the walk::pmd_entry anyway, so the 
amount of duplicated page walk code isn't that big.

That said, if people are OK with me modifying the assert in 
pud_trans_huge_lock() and make __walk_page_range non-static, it should 
probably be possible to make it work, yes.

Thanks,
Thomas


