Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LOTS_OF_MONEY,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB5DC0650E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 23:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B672070D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 23:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfGGX5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 19:57:03 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:48980 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbfGGX5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 19:57:03 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id CA6282836D;
        Sun,  7 Jul 2019 19:56:59 -0400 (EDT)
Date:   Mon, 8 Jul 2019 09:56:57 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Laurent Vivier <lvivier@redhat.com>,
        Joshua Thompson <funaho@jurai.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] m68k/mac: Revisit floppy disc controller base
 addresses
In-Reply-To: <224218b529a5abb1d5dd5ce2103b685a10866577.1550182390.git.fthain@telegraphics.com.au>
Message-ID: <alpine.LNX.2.21.1907080956450.12@nippy.intranet>
References: <224218b529a5abb1d5dd5ce2103b685a10866577.1550182390.git.fthain@telegraphics.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

I just noticed that this patch didn't appear in v5.2. Would you please 
take a look?

-- 

On Fri, 15 Feb 2019, Finn Thain wrote:

> Rename floppy_type macros to make them more consistent with the scsi_type
> macros, which are named after classes of models with similar memory maps.
> 
> The documentation for LC-class machines has the IO devices at offsets
> from $50F0 0000. Use these addresses (consistent with mac_scsi resources)
> because they may not be aliased elsewhere in the memory map, e.g. at
> offsets from $5000 0000.
> 
> Add comments with controller type information from 'Designing Cards and
> Drivers for the Macintosh Family', relevant Developer Notes and
> http://mess.redump.net/mess/driver_info/mac_technical_notes
> 
> Adopt phys_addr_t to avoid type casts.
> 
> Cc: Laurent Vivier <lvivier@redhat.com>
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> Acked-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  arch/m68k/include/asm/macintosh.h |  10 +--
>  arch/m68k/mac/config.c            | 128 +++++++++++++++---------------
>  2 files changed, 69 insertions(+), 69 deletions(-)
> 
