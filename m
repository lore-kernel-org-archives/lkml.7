Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE80C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD01218FC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbfDXOUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:20:44 -0400
Received: from outbound-smtp24.blacknight.com ([81.17.249.192]:36614 "EHLO
        outbound-smtp24.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725921AbfDXOUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:20:41 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp24.blacknight.com (Postfix) with ESMTPS id 82BBDB879C
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 15:20:39 +0100 (IST)
Received: (qmail 25928 invoked from network); 24 Apr 2019 14:20:38 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.225.79])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 24 Apr 2019 14:20:38 -0000
Date:   Wed, 24 Apr 2019 15:20:37 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/Kconfig: deprecate DISCONTIGMEM support for
 32-bit
Message-ID: <20190424142037.GV18914@techsingularity.net>
References: <1556112252-9339-1-git-send-email-rppt@linux.ibm.com>
 <1556112252-9339-3-git-send-email-rppt@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1556112252-9339-3-git-send-email-rppt@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 04:24:12PM +0300, Mike Rapoport wrote:
> Mel Gorman says:
>   32-bit NUMA systems should be non-existent in practice.  The last NUMA
>   system I'm aware of that was both NUMA and 32-bit only died somewhere
>   between 2004 and 2007. If someone is running a 64-bit capable system in
>   32-bit mode with NUMA, they really are just punishing themselves for fun.
> 
> Mark DISCONTIGMEM broken for now and remove it in a couple of releases.
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Suggested-by: Mel Gorman <mgorman@techsingularity.net>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

It was really Christoph that suggested marking it broken but I do agree
that it should be marked broken to see if anyone complains and if not,
there is no real reason to keep discontig available on x86.

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
