Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFA3C606BF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A61821537
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SuZJoN+Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbfGHOmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 10:42:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60370 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729254AbfGHOmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 10:42:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FbVe+96SnHQdB3XrjHSvItUUD9LRS2dN3DEOjB6fZxA=; b=SuZJoN+Qoru93LMevhhWQfOim
        V2QIOqYKMDTCKvDf7k8xEfvTXFkM6TbWL6Nbu8198IgOJ7nRhrTkjJOQXzI0qZhmE8A0bu+PMYl4M
        8qDVIt6fbexi5k9c+Zb2MvIpDiqRWLhvMeP7MmT17s/rDXT8A+XwrI6H3dixLlucPufH6T7wCsQus
        UfrSqqQazKVAw1K5+ggVCoXjhxdKzRda+y8LsXRTt+X4l9HgAXIIsF/FM4+6d1JjmrboRnmiggS9+
        vlcnCwcSjPQBKQ0WLFdq/Dsnk1lRrEIlI/UB46O1KbB0UrMsBIW7PnuD5bzgYmlISbFwZOaxETeVA
        yZaW6tR/g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hkUqN-0008FF-1b; Mon, 08 Jul 2019 14:42:15 +0000
Date:   Mon, 8 Jul 2019 07:42:14 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        will@kernel.org, peterz@infradead.org
Subject: Re: [PATCH] mm: remove redundant assignment of entry
Message-ID: <20190708144214.GD32320@bombadil.infradead.org>
References: <20190708082740.21111-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708082740.21111-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 04:27:40PM +0800, Wei Yang wrote:
> Since ptent will not be changed after previous assignment of entry, it
> is not necessary to do the assignment again.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Acked-by: Matthew Wilcox (Oracle) <willy@infradead.org>
