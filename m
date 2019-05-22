Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53055C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 12:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33031217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 12:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbfEVMHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 08:07:41 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:55878 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728584AbfEVMHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 08:07:41 -0400
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23992796AbfEVMHinZXz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org> + 1 other);
        Wed, 22 May 2019 14:07:38 +0200
Date:   Wed, 22 May 2019 13:07:38 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Serge Semin <fancer.lancer@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: TXx9: Fix boot crash in free_initmem()
In-Reply-To: <20190522081535.16583-1-geert@linux-m68k.org>
Message-ID: <alpine.LFD.2.21.1905221301430.25412@eddie.linux-mips.org>
References: <20190522081535.16583-1-geert@linux-m68k.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 May 2019, Geert Uytterhoeven wrote:

> Looks like arch/mips/dec/prom/memory.c needs a similar but more
> complicated fix, due to declance handling?

 Thanks for the heads-up!  I think the declance hack should go away.  It 
should have gone long ago, but ISTR there used to be a problem with making 
such a large contiguous physical memory allocation in the modular case.  
Maybe it's not anymore these days.  I'll look into it when I get a chance 
to poke at hardware, which I have no access to at the moment.

  Maciej
