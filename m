Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92737C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 09:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 558E120678
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 09:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IxSIQ26r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfK0Jod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 04:44:33 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33990 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfK0Jod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 04:44:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=IxSIQ26rUhAtDgNrOM63lKcRo
        zmmz2KZXA07dfQvpYQCT1iFwE8RUxnpZe0IeUeK/itnlBhIA1sNVGg7DG3SD4HoczoGEmXxGBYMiv
        NPX7XusTThdDloqEQ7V0Z4LrKto0SZgYzuZLFw4ttMisDAttwu9otuaIRmlbv/s+ecjrCEouJQaQV
        DU5Gfijc1xV6LxwMU7q2bUFil/pSVRFpn+20dd/0m6N6YfAUw2Y4MwAQ8XDhJmzNc4Da/zYbVXYxy
        IT2+5nHWlNdRuGO0EzF/YrF3//OdqHJXKj0W4d+n5XZIHHN5nP4xczhBACRyGsofbyeeDtYSDGzQ0
        6s2ZXvnzg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iZts6-0005U7-4D; Wed, 27 Nov 2019 09:44:30 +0000
Date:   Wed, 27 Nov 2019 01:44:30 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH v2] fs/splice: ignore flag SPLICE_F_GIFT in syscall
 vmsplice
Message-ID: <20191127094430.GA20895@infradead.org>
References: <157374079193.8131.5211902043079599773.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157374079193.8131.5211902043079599773.stgit@buzz>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
