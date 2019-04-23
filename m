Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB35C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5DFA20674
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H2HIjKph"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfDWHOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:14:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35730 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfDWHOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 03:14:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SDlbfGGT6h+AH6jrlBAq/GN8velgMypb49RBj12dJJc=; b=H2HIjKphtjzOGFQrLmcu0oOFr
        5r3bAwWLkfQXSq9ayF7kYfnbhUjaU+tcCP3tyTatUyrT8kjp/mZymokWA2BvbP6qQr3yKHCAQRtUk
        /rdcDAeYXJDTVFa2DQ/xmqKnEtwTMu84elAhhsiAvLjU/eBU1t8FRYkPWntVgG8l+g30dwUwM/5/Z
        hlGqromgmM12sN2kE/0UwWS7366vJVO7iwyegEIytfYJEpPnGAAAwBc+VfAch2uGo4VcQ9qlP5wZU
        cFF1btw7ENuY8StXWiv/d74Z1+44bgUKCwY2vlR27IP+fhLq0QnZWB5h0llfduvDthG5CrdmkV0J7
        6BHcgY35Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hIpco-0006EN-T8; Tue, 23 Apr 2019 07:13:54 +0000
Date:   Tue, 23 Apr 2019 00:13:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-parisc@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
Subject: Re: DISCONTIGMEM is deprecated
Message-ID: <20190423071354.GB12114@infradead.org>
References: <20190419094335.GJ18914@techsingularity.net>
 <20190419140521.GI7751@bombadil.infradead.org>
 <20190421063859.GA19926@rapoport-lnx>
 <20190421132606.GJ7751@bombadil.infradead.org>
 <20190421211604.GN18914@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190421211604.GN18914@techsingularity.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2019 at 10:16:04PM +0100, Mel Gorman wrote:
> 32-bit NUMA systems should be non-existent in practice. The last NUMA
> system I'm aware of that was both NUMA and 32-bit only died somewhere
> between 2004 and 2007. If someone is running a 64-bit capable system in
> 32-bit mode with NUMA, they really are just punishing themselves for fun.

Can we mark it as BROKEN to see if someone shouts and then remove it
a year or two down the road?  Or just kill it off now..
