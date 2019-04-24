Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE6DC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31FA521773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbfDXOTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:19:40 -0400
Received: from outbound-smtp25.blacknight.com ([81.17.249.193]:53309 "EHLO
        outbound-smtp25.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725935AbfDXOTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:19:40 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp25.blacknight.com (Postfix) with ESMTPS id 54E43B8783
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 15:19:38 +0100 (IST)
Received: (qmail 21430 invoked from network); 24 Apr 2019 14:19:38 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.225.79])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 24 Apr 2019 14:19:38 -0000
Date:   Wed, 24 Apr 2019 15:19:36 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/Kconfig: make SPARSEMEM default for 32-bit
Message-ID: <20190424141936.GU18914@techsingularity.net>
References: <1556112252-9339-1-git-send-email-rppt@linux.ibm.com>
 <1556112252-9339-2-git-send-email-rppt@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1556112252-9339-2-git-send-email-rppt@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 04:24:11PM +0300, Mike Rapoport wrote:
> Sparsemem has been a default memory model for x86-64 for over a decade
> since the commit b263295dbffd ("x86: 64-bit, make sparsemem vmemmap the
> only memory model").
> 
> Make it the default for 32-bit NUMA systems (if there any left) as well.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
