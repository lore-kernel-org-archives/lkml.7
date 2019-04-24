Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E6DC282E3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 710F0218FD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbfDXMV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:21:59 -0400
Received: from outbound-smtp16.blacknight.com ([46.22.139.233]:39943 "EHLO
        outbound-smtp16.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729670AbfDXMV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:21:59 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp16.blacknight.com (Postfix) with ESMTPS id 915701C1CFD
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 13:21:57 +0100 (IST)
Received: (qmail 20196 invoked from network); 24 Apr 2019 12:21:57 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.225.79])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 24 Apr 2019 12:21:57 -0000
Date:   Wed, 24 Apr 2019 13:21:56 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-parisc@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
Subject: Re: DISCONTIGMEM is deprecated
Message-ID: <20190424122155.GT18914@techsingularity.net>
References: <20190419094335.GJ18914@techsingularity.net>
 <20190419140521.GI7751@bombadil.infradead.org>
 <20190421063859.GA19926@rapoport-lnx>
 <20190421132606.GJ7751@bombadil.infradead.org>
 <20190421211604.GN18914@techsingularity.net>
 <20190423071354.GB12114@infradead.org>
 <20190424113352.GA6278@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20190424113352.GA6278@rapoport-lnx>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 02:33:53PM +0300, Mike Rapoport wrote:
> On Tue, Apr 23, 2019 at 12:13:54AM -0700, Christoph Hellwig wrote:
> > On Sun, Apr 21, 2019 at 10:16:04PM +0100, Mel Gorman wrote:
> > > 32-bit NUMA systems should be non-existent in practice. The last NUMA
> > > system I'm aware of that was both NUMA and 32-bit only died somewhere
> > > between 2004 and 2007. If someone is running a 64-bit capable system in
> > > 32-bit mode with NUMA, they really are just punishing themselves for fun.
> > 
> > Can we mark it as BROKEN to see if someone shouts and then remove it
> > a year or two down the road?  Or just kill it off now..
> 
> How about making SPARSEMEM default for x86-32?
> 

While an improvement, I tend to agree with Christoph that marking it
BROKEN as a patch on top of this makes sense and wait to see who, if
anyone, screams. If it's quiet for long enough then we can remove it
entirely.

-- 
Mel Gorman
SUSE Labs
