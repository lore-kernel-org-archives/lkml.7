Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LOTS_OF_MONEY,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E347C606CF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 23:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2877D216FD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 23:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfGHXDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 19:03:52 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:36096 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbfGHXDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 19:03:51 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 64690296E2;
        Mon,  8 Jul 2019 19:03:46 -0400 (EDT)
Date:   Tue, 9 Jul 2019 09:03:44 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Joshua Thompson <funaho@jurai.org>,
        Laurent Vivier <lvivier@redhat.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] m68k/mac: Revisit floppy disc controller base
 addresses
In-Reply-To: <CAMuHMdW_ScrApPH1YZb8+64+wZjq9BGuF18KCF7--9D2gneXrg@mail.gmail.com>
Message-ID: <alpine.LNX.2.21.1907090902100.41@nippy.intranet>
References: <224218b529a5abb1d5dd5ce2103b685a10866577.1550182390.git.fthain@telegraphics.com.au> <CAMuHMdW_ScrApPH1YZb8+64+wZjq9BGuF18KCF7--9D2gneXrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jul 2019, Geert Uytterhoeven wrote:

> I guess the others do have aliases at 0x50000000? ...
> 

Right. Otherwise mac_scsi wouldn't work. See also, arch/m68k/mac/config.c:

                 * GMFH says that $5000 0000 - $50FF FFFF "wraps
                 * $5000 0000 - $5001 FFFF eight times" (!)
                 * mess.org says IIci and Color Classic do not alias
                 * I/O address space.

-- 
