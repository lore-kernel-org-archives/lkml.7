Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96621C31E48
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6739D21734
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kN2+DuXF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439009AbfFLMch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 08:32:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45266 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436805AbfFLMcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:32:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=y2uhk9OglV5fFk4/ZrfPdWhvtB806R6hS4P/DXRIWCw=; b=kN2+DuXF1HfUzhPRcH63m9hjC
        RGYiploiRLDP6L9YPs8+ApNj0wMNpOOsRU7c2UOX0p0TYBvXlu5QQxvY/DagnaWMNcLuLBnAPOpb3
        ISlF0H8638X4AjSXFw2gD69P4tzg1KROtyiTqTyk5FohX0eI9I8ZUkB2Yzyu81jZL6qv4DCOU41c6
        JlY7BkJ3n8O6gfsFWt0Vf/FYKWq72AJ4GwuNlQvuSXwtVfy68kfT9ZCl8c2u3/5gX25YW5jvlzL7s
        jg99YvS45pOsPwYNI82mosW6wWuNrHegPDkiBXKbE49Ks1H4P6HVaPDgJCrobINVEcNROiv7iUFTV
        /qXXT3wqQ==;
Received: from 177.41.119.178.dynamic.adsl.gvt.net.br ([177.41.119.178] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hb2Qb-0003A7-6Y; Wed, 12 Jun 2019 12:32:33 +0000
Date:   Wed, 12 Jun 2019 09:32:29 -0300
From:   Mauro Carvalho Chehab <mchehab@infradead.org>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ruslan Babayev <ruslan@babayev.com>,
        Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Re: linux-next: build warning after merge of the i2c tree
Message-ID: <20190612093229.7f14a1e2@coco.lan>
In-Reply-To: <20190612120439.GB2805@kunai>
References: <20190611102528.44ad5783@canb.auug.org.au>
        <20190612081929.GA1687@kunai>
        <20190612080226.45d2115a@coco.lan>
        <20190612110904.qhuoxyljgoo76yjj@ninjato>
        <20190612084824.16671efa@coco.lan>
        <20190612120439.GB2805@kunai>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 12 Jun 2019 14:04:39 +0200
Wolfram Sang <wsa@the-dreams.de> escreveu:

> > > OK, so that means I should send my pull request after yours in the next
> > > merge window? To avoid the build breakage?  
> > 
> > Either that or you can apply my patch on your tree before the
> > patch that caused the breakage. 
> > 
> > Just let me know what works best for you.  
> 
> Hmm, the offending patch is already in -next and I don't rebase my tree.
> So, I guess it's the merge window dependency then.
> 
Ok, I'll merge it through my tree then.

Thanks,
Mauro
