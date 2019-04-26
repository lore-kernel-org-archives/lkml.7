Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED51C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8AAA205ED
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfDZHhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 03:37:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:35940 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725921AbfDZHhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 03:37:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 14929ADE2;
        Fri, 26 Apr 2019 07:37:33 +0000 (UTC)
Date:   Fri, 26 Apr 2019 09:37:32 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the printk tree
Message-ID: <20190426073732.mjen7hqw3skhb67x@pathway.suse.cz>
References: <20190425233049.7e2283b0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425233049.7e2283b0@canb.auug.org.au>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2019-04-25 23:30:49, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   e43bb4d0feb8 ("vsprintf: Consistent %pK handling for kptr_restrict == 0")
> 
> Fixes tag
> 
>   Fixes: commit ef0010a30935de4e0211 ("vsprintf: don't use 'restricted_pointer()' when not restricting")
> 
> has these problem(s):
> 
>   - leading word 'commit' unexpected

Thanks for the report! I have just fixed it.

Best Regards,
Petr
