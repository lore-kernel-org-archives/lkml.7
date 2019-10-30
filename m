Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB01CA9EC6
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 21:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A79312080F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 21:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VRHi7s/T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfJ3V0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 17:26:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35738 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbfJ3V0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 17:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QAldfIZdfUsmWLWzOiJRMY3GvzhRHkvLuPhvI79W9ls=; b=VRHi7s/T9ZtPoBK3F7Zs53zRF
        0HzDQB8rdbAdmMQDaExnfod3SW5ufMCnQtNUPbS9BA9yqOBc+3xTdK2CG1yswov9gBhCZGlfEfB8n
        F2zlBgq3kUJvY8Trzov/KUZW8WjNokCsscCRmSWfWs87P8kviNeGwZigv+P58wvHeaeG7Q8nwQKFV
        zBiXmHIZiiDTzemVEabr73lBZUrlbuVdnGTKba7hh/gbbRSbmYYS8lSd3I+3vifR+nmkkO+FIMFKf
        wNcfJb371tEGed8DqE6Q3fRnTxqce3X79Br6nXU9iS2DyX1dRdVLXXMSPmo5e0qB3odoXy3xWus6Y
        RgDgqjylA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iPvTj-0004rm-0j; Wed, 30 Oct 2019 21:26:07 +0000
Date:   Wed, 30 Oct 2019 14:26:06 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: SGI-IP27: fix exception handler replication
Message-ID: <20191030212606.GB4251@infradead.org>
References: <20191030105819.11266-1-tbogendoerfer@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030105819.11266-1-tbogendoerfer@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 11:58:19AM +0100, Thomas Bogendoerfer wrote:
> Commit b3ffcd0d800c ("mips/sgi-ip35: Initial rough-in of minimal platform
> definition.")

I can't actually find that commit anywhere.
