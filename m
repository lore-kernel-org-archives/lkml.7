Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAB3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB8E2083D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731004AbfB1Lsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 06:48:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:47168 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725896AbfB1Ls3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 06:48:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A80DAAF3B;
        Thu, 28 Feb 2019 11:48:28 +0000 (UTC)
Date:   Thu, 28 Feb 2019 12:48:28 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend] lib/vsprintf: Remove %pCr remnant in comment
Message-ID: <20190228114828.5f7gaccttgob26qa@pathway.suse.cz>
References: <20190228105315.744-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228105315.744-1-geert+renesas@glider.be>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2019-02-28 11:53:15, Geert Uytterhoeven wrote:
> Support for "%pCr" was removed, but a reference in a comment was
> forgotten.
> 
> Fixes: 666902e42fd8344b ("lib/vsprintf: Remove atomic-unsafe support for %pCr")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

I have commited it into printk.git, branch for-4.22 (aka for-5.1).

Thanks for re-sending. I am sorry that the first mail somehow
fallen through the cracks.

Best Regards,
Petr
