Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14BEC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 10:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF2B20863
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 10:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569753705;
	bh=0LLWBqF97fc5Fr5BEVtlP5SMQejKi+dK3TKGxVoEBs4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2rPBMyZ8ntIv9JHe1wAIJ6DhK3VDgrAZwymVl3FIv4DwnrnbFstrX27BRRYnEajkV
	 dfO9GwquCWL/DIPUy1FZzK7IZfreqsLLtPi9/KMxyTSMlq3qb9atzl/yQspahTlPnZ
	 Vlz/2lnlGv6pF2ixBvfdduva0GjAaeqRFebF9e7E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbfI2Kk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 06:40:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:54628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbfI2Kk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 06:40:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C441E20863;
        Sun, 29 Sep 2019 10:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569753658;
        bh=0LLWBqF97fc5Fr5BEVtlP5SMQejKi+dK3TKGxVoEBs4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HXSQ0+QeeX7w9/iF2XyriowDk6kQXrBBO1iriGqYE0/6SpSOeddYZOAYxbig9ajQE
         gBnbvTVWMoPsc1rgrpWMfAfg04/8v0SsXZxtTizCD/Ebe1PPW/gIm5vi1RNrcti9wL
         ua1XFBUuzeZb56R5ifLBC9321FR2q4MoJhHIgrP4=
Date:   Sun, 29 Sep 2019 12:40:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        ndesaulniers@google.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ingo Molnar <mingo@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nadav Amit <namit@vmware.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 1/6] staging: rtl8723bs: replace __inline by inline
Message-ID: <20190929104055.GA1941196@kroah.com>
References: <20190830231527.22304-1-linux@rasmusvillemoes.dk>
 <20190912221927.18641-1-linux@rasmusvillemoes.dk>
 <20190912221927.18641-2-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190912221927.18641-2-linux@rasmusvillemoes.dk>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 12:19:22AM +0200, Rasmus Villemoes wrote:
> Currently, __inline is #defined as inline in compiler_types.h, so this
> should not change functionality. It is preparation for removing said
> #define.
> 
> While at it, change some "inline static" to the customary "static
> inline" order.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
