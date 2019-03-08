Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB35C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 14:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E0DB2087C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 14:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oR0ck+s4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbfCHOxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 09:53:04 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43914 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbfCHOxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 09:53:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=et6ZcJXKfG7Bkud/U0MftJGtak0Hx1U6biZruJhpmpw=; b=oR0ck+s4Ijc+b2Ko8EqqVad3N
        ZPgdcptFtSYb96l5evfCW734lGip4NcnFJTNuhgXXXryrNph2OKswIVaJEDPe/FJR718FzF7mCx3M
        c4+irsxvHHi+6crtRrkxO7lHcNgoRUXXnMGsXoIXUj37NIlfcJTpT3YiIVP5qu+JmlxbP3fsob60Y
        QxYSKs44d9fYyjd8BF+KgL51KFltu9ObcjeXEKFz2j//wBSl5YPOEspLPsunYEmroqwD0f1PHCzBZ
        M/HDZQzzEJCH4qI4RuH7sxjKgTEFHEUpzBR02u+MTSrhlgfrR+GRC1YmICCcaSB5C2zmwBPW0uUtE
        m5j2PVp3A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h2Gru-0003VH-Fg; Fri, 08 Mar 2019 14:53:02 +0000
Date:   Fri, 8 Mar 2019 06:53:02 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Joe Perches <joe@perches.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RISC-V: Use IS_ENABLED(CONFIG_CMODEL_MEDLOW)
Message-ID: <20190308145302.GA13397@infradead.org>
References: <66af3908ab0a63a6768f3d75a87abf4056a9f8cf.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66af3908ab0a63a6768f3d75a87abf4056a9f8cf.camel@perches.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 03:56:34PM -0800, Joe Perches wrote:
> IS_ENABLED should generally use CONFIG_ prefaced symbols and
> it doesn't appear as if there is a CMODEL_MEDLOW define.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
