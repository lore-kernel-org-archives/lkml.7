Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D60BC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 09:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D274320659
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 09:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gcZyCCGA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbfJOJtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 05:49:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:32936 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbfJOJtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 05:49:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iLMQKatiwvmPrwWuwQxcJveEkDv9TiO2EFbewgDr+68=; b=gcZyCCGAQeLk9LoG7AOw7UZ95
        JZHC1GNV88yfq9xMeFJ7UoOd2eKyYNXecyWMJ9IQBU1LR/vovsLZoWnXcFb4OpGsi36AP3Cxnftme
        Tsrnn/cmGj6ygAsXeUvcDlyoC+FMPdbjbwwZIWNvN8+Y2nkglNaRnntggsl52WNw5rg0NVP4dnexG
        z/BeWPuyarynMhNbLqJI14KBpMIdgtp1vAf3qYCrwNXIrg5RpCjuo0MIcVbw3ufGJ2c2DmrXQTqhQ
        Z0hlo3jQ99S4O8zKh/nsU0bZf/BALDbIr37UmOurmTQuRMzU6IbHXIfPYGtcH/L0JsyXEvkr7BICW
        7nVdJ5SdQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKJSO-0005Ro-9G; Tue, 15 Oct 2019 09:49:32 +0000
Date:   Tue, 15 Oct 2019 02:49:32 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: Re: [PATCH] sh: use dma_to_phys() instead of dev->dma_pfn_offset
Message-ID: <20191015094932.GA20762@infradead.org>
References: <20191011165129.29655-1-nsaenzjulienne@suse.de>
 <20191015074354.GB3464@infradead.org>
 <453a9a954f4967a68a7023c8c79a39fdcb69254a.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <453a9a954f4967a68a7023c8c79a39fdcb69254a.camel@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 10:05:52AM +0200, Nicolas Saenz Julienne wrote:
> I see, well I guess this one will get ignored too :)
> 
> > Here is the last one:
> > 
> > http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/sh-dma-remap
> 
> I'd be happy with your series too.

Let's see if we can make any progress this merge window..

> In case you're wondering why I want this: I'm interested in supporting multiple
> dma-ranges in DT. So I was looking at the amount of work needed to centralize
> usage of dev->dma_pfn_offset. This one patch seemed trivial enough to send
> right away.

Sounds useful, thanks!
