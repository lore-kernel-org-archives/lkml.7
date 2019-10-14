Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34EFC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 16:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71CF22133F
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 16:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n/lIHHXX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387563AbfJNQRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 12:17:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57078 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729271AbfJNQRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 12:17:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BSWaZ0k4tF/ISmBhPnDVCnPcq36aoFu3RAfsJrYKtl4=; b=n/lIHHXXiirtJVnDS3dTJCkmN
        E66uJqEep2ZDkZcKUKIIZR1xvtTdWZciuyXLT7ybpQie8tuWILwNsQezKjkcW7gQ04wVZBgOBlxuc
        6DqojZ7lQrD2OG53EItLB+AxKkMq9O3QZDL/uEJ1aPSS+I0FNgdpZja32oEqUrIz+L3vHsg5+gDPN
        QSyYj0aDN4sw6y7Zt4NFO9qZwbnbX2tMFo92vCfw5e4oWi7r4Vhr7Givik8X5oCrWE/6ZL1WWDGz4
        5f/EhxhMwHGssA509XHVhbGE3MixeO585yaRoR7PWit1v9M546vLSCTsvB2pQeId43kONbg0Sh2sn
        fpp+QbetQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iK32N-00034o-Ss; Mon, 14 Oct 2019 16:17:35 +0000
Date:   Mon, 14 Oct 2019 09:17:35 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@lists.codethink.co.uk,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: add kernel/fork.c function definitions
Message-ID: <20191014161735.GA9498@infradead.org>
References: <20191009140637.12443-1-ben.dooks@codethink.co.uk>
 <20191009153316.GA25186@infradead.org>
 <12dd599c-e7e8-2cdb-4363-fdf18c023bef@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12dd599c-e7e8-2cdb-4363-fdf18c023bef@codethink.co.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 02:44:25PM +0100, Ben Dooks wrote:
> Does anyone have a preference to where these should go?

Maybe include/linux/thread_info.h ?
