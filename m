Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF93C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F232320645
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rkprz1yV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbfDWRNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 13:13:01 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52242 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbfDWRNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 13:13:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bfxbOld5oy9Owt8ChLuFHnhjLdbxAfrET6dK5MZwYxA=; b=rkprz1yVMMdbuqH4MD0vDW5co
        ti+NsQ7FO4D/QiU/IE1sF1KgxHpAXTXpX9REDFZesfv9FkFTFhi6UGD/jnRZeuNFb6DtNgtjWLDZ2
        iDNsMB+g8/NXepjOCXIh5H/hFzXEY++Ne5sYHky+/c9XEHHFL5M1ccj+DrQy12kr9fOKp4/B1v1Fj
        t/IS2Owgt1mBT6w96w0MpPnZNM9aBZr2HK0+iHbrtCj1f14dwVqylTu9OniU2NCroik7+Ovhf0XXd
        SXK5qPZQVosDdHDvU1p+OFsFSoHu0Xtwo1Bh436gXy9Nig0T4T4ETV3OKFiayiS2aS1ATAz6IcnZh
        p+GlS65ug==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hIyyX-0007DT-D9; Tue, 23 Apr 2019 17:12:57 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0BEA429C30E03; Tue, 23 Apr 2019 19:12:56 +0200 (CEST)
Date:   Tue, 23 Apr 2019 19:12:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     David Howells <dhowells@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 56/79] docs: Documentation/*.txt: rename all ReST
 files to *.rst
Message-ID: <20190423171256.GH12232@hirez.programming.kicks-ass.net>
References: <20190423132100.GB7132@redhat.com>
 <cover.1555938375.git.mchehab+samsung@kernel.org>
 <cda57849a6462ccc72dcd360b30068ab6a1021c4.1555938376.git.mchehab+samsung@kernel.org>
 <20190423083135.GA11158@hirez.programming.kicks-ass.net>
 <20190423125519.GA7104@redhat.com>
 <20190423130132.GT4038@hirez.programming.kicks-ass.net>
 <20704.1556031146@warthog.procyon.org.uk>
 <20190423105415.3a69a0cb@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423105415.3a69a0cb@lwn.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 10:54:15AM -0600, Jonathan Corbet wrote:
> Few people complain about the biggest impediment to the readability of
> text files, though: the use of kerneldoc comments.

I just stopped using kerneldoc.
