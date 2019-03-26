Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E678BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C08842084B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731859AbfCZQaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 12:30:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:42708 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726177AbfCZQaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 12:30:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 05506AFAC;
        Tue, 26 Mar 2019 16:30:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BD49ADA8D8; Tue, 26 Mar 2019 17:32:06 +0100 (CET)
Date:   Tue, 26 Mar 2019 17:32:06 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Qu Wenruo <wqu@suse.com>
Subject: Re: linux-next: Fixes tag needs some work in the btrfs-kdave tree
Message-ID: <20190326163206.GW10640@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Qu Wenruo <wqu@suse.com>
References: <20190326070924.1857a3fd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326070924.1857a3fd@canb.auug.org.au>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 07:09:24AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   167ab7e5ebbf ("btrfs: reloc: Fix NULL pointer dereference due to expanded reloc_root lifespan")
> 
> Fixes tag
> 
>   Fixes: d2311e698578 ("btrfs: relocation: Delay reloc tree deletion after merge_reloc_roots()")
> 
> has these problem(s):
> 
>   - Subject does not match target commit subject
>     Just use
> 	git log -1 --format='Fixes: %h (%s)'

Will be fixed in the next update, thanks for the report. There was
reference from another repository that had wrong commit id that I fixed
but did not notice the slightly differen subject with ().
