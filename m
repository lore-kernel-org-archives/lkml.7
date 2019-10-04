Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC0EC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 19:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE99222C2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 19:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KQAWFSXe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730340AbfJDTHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 15:07:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59748 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbfJDTHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 15:07:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7gattgm+JvBkKytQq1U5t6bSLwzlmt3/1F4dY6lkecs=; b=KQAWFSXenFYeworaI57NHtkR8
        HF8/ZTI2KYgmwCwj6wTesPxAb56ku2VXonNWWuFtuPWklADPs5fYVPxcw3IrLQWSxFlEtc9+7LFFE
        dmpjCwm66SxM46bTzg6Be9eN481ynzQLVmWKDfq/UnC+JXIVYi3GxB56gGoTaqF/vPitr5DHSVklR
        q3HnJhbT8UvP7gKeF6PmxceI+yKY1hTWusaHcLtDlE0GpAqN5K8JhZniEqryJKC0T5AhsXI+hq5Ql
        5I5tExSqI7ok2POseN8ZlviSxTcfzAtqFd2+XkbEoyxn6Qkmn+6/sDjKeMI/wlantNw90K6ZGpFs9
        6VVQ+v8eg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iGSvD-0004t7-V0; Fri, 04 Oct 2019 19:07:23 +0000
Date:   Fri, 4 Oct 2019 12:07:23 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] docs: remove :c:func: from genericirq.rst
Message-ID: <20191004190723.GJ32665@bombadil.infradead.org>
References: <20191004163955.14419-1-corbet@lwn.net>
 <20191004163955.14419-2-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004163955.14419-2-corbet@lwn.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 10:39:54AM -0600, Jonathan Corbet wrote:
>  To make the transition to the new model easier and prevent the breakage
> -of existing implementations, the :c:func:`__do_IRQ` super-handler is still
> +of existing implementations, the __do_IRQ() super-handler is still
>  available. This leads to a kind of duality for the time being. Over time
>  the new model should be used in more and more architectures, as it
>  enables smaller and cleaner IRQ subsystems. It's deprecated for three

...

> @@ -369,7 +369,7 @@ handler(s) to use these basic units of low-level functionality.
>  __do_IRQ entry point
>  ====================
>  
> -The original implementation :c:func:`__do_IRQ` was an alternative entry point
> +The original implementation __do_IRQ() was an alternative entry point
>  for all types of interrupts. It no longer exists.

I think someone needs to rationalise these two paragraphs ;-)

__do_IRQ indeed no longer exists (since 2011).  It should probably be
removed from the documentation too.
