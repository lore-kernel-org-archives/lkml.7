Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D3DC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 07:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE13212F5
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 07:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404491AbfFKHia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 03:38:30 -0400
Received: from verein.lst.de ([213.95.11.211]:48858 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403920AbfFKHia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 03:38:30 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 829D868B02; Tue, 11 Jun 2019 09:38:02 +0200 (CEST)
Date:   Tue, 11 Jun 2019 09:38:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Christoph Hellwig <hch@lst.de>, Michal Simek <monstr@monstr.eu>,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-m68k@lists.linux-m68k.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org
Subject: Re: binfmt_flat cleanups and RISC-V support
Message-ID: <20190611073802.GB21522@lst.de>
References: <20190610212015.9157-1-hch@lst.de> <6e5fb7db-1d6f-7d49-553c-edc18f14f641@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e5fb7db-1d6f-7d49-553c-edc18f14f641@linux-m68k.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 04:51:02PM +1000, Greg Ungerer wrote:
> Hi Christoph,
>
> On 11/6/19 7:20 am, Christoph Hellwig wrote:
>> below is a larger stash of cleanups for the binfmt_misc code,
>> preparing for the last patch that now trivially adds RISC-V
>> support, which will be used for the RISC-V nommu series I am
>> about to post.
>
> Whole series looks pretty good. Just the one comment I made.
>
> I normally take these through the m68knommu git tree,
> if you have no problem with that I'll push it in there.
> It will hit linux-next from there.

Yes, that's fine.  We'll need it to bring up riscv nommu support,
but there is no actual dependency on the patches for it to compile,
just for it to actually be useful.

Btw, it seems like the uclinux-dev list is dead, is there a replacement
for it?
