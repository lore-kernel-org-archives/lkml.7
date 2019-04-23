Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6977DC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 19:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33837218B0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 19:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556048175;
	bh=homOGiSWUmVMiXCPq82PV0fxTwCNqp5r+hDdwni2ywg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=TtBOdBum86QIMDaxFayqW2wSwrKn/Ihdxnl9n7LYe++Sa4W0fsYo2CWs7JzAhOcP0
	 n7/UyKzTuWIyj7IqH2ik/XKE+aQl7UToGRd/HBwwVXiQYw4ARNSNkjV+n3lpBiInSi
	 IrO4BXPe5rQvjDrEqTs2KHwhM8RKuSIDIVHF3O3c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfDWTgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 15:36:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57466 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfDWTgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 15:36:13 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CBE39B7D;
        Tue, 23 Apr 2019 19:36:12 +0000 (UTC)
Date:   Tue, 23 Apr 2019 12:36:11 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linuxppc-dev@lists.ozlabs.org, Jason Baron <jbaron@akamai.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] powerpc: select DYNAMIC_DEBUG_RELATIVE_POINTERS
 for PPC64
Message-Id: <20190423123611.1f7276cc4eb9f7a7005899a9@linux-foundation.org>
In-Reply-To: <b5304c4c-736a-fd8b-e025-4ea040f5c346@c-s.fr>
References: <20190409212517.7321-1-linux@rasmusvillemoes.dk>
        <20190409212517.7321-11-linux@rasmusvillemoes.dk>
        <b5304c4c-736a-fd8b-e025-4ea040f5c346@c-s.fr>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Apr 2019 17:37:33 +0200 Christophe Leroy <christophe.leroy@c-s.fr> wrote:

> > --- a/arch/powerpc/Kconfig
> > +++ b/arch/powerpc/Kconfig
> > @@ -155,6 +155,7 @@ config PPC
> >   	select BUILDTIME_EXTABLE_SORT
> >   	select CLONE_BACKWARDS
> >   	select DCACHE_WORD_ACCESS		if PPC64 && CPU_LITTLE_ENDIAN
> > +	select DYNAMIC_DEBUG_RELATIVE_POINTERS	if PPC64
> 
> Why only PPC64 ? Won't it work with PPC32 ? Or would it be 
> counter-performant on 32 bits ?

Ditto arm and i386?
