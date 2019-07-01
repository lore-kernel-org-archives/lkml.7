Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0834C06511
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 10:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B95052133D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 10:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561976580;
	bh=zbvDsAnFL+cU5JhA5SVIXDMBU4oh+3kSy0SRKAckKV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tG70jVilwFGEP40V40D9mFQTubV+6d6yR/hgS4W6eYruk8YMtPI4cyfwtmIB0n5tP
	 1952TMbmlJJKGaOcOBuDUwxkN4UXE13ruZpanHeTxAYp/c2X6SNifhQmgheLNF8rbY
	 GW8jbBNdZrZRm8Y6plRM8tteC74wS0KtBVvrHWO0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbfGAKW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 06:22:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:36526 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726076AbfGAKW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 06:22:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7BEA0AEE6;
        Mon,  1 Jul 2019 10:22:57 +0000 (UTC)
Date:   Mon, 1 Jul 2019 12:22:56 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>, oleksandr@redhat.com,
        hdanton@sina.com, lizeb@google.com,
        Dave Hansen <dave.hansen@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v3 0/5] Introduce MADV_COLD and MADV_PAGEOUT
Message-ID: <20190701102256.GN6376@dhcp22.suse.cz>
References: <20190627115405.255259-1-minchan@kernel.org>
 <20190701073848.GB136163@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701073848.GB136163@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 01-07-19 16:38:48, Minchan Kim wrote:
> 
> Hi Folks,
> 
> Do you guys have comments? I think it would be long enough to be
> pending. If there is no further comments, I want to ask to merge.

This is definitely on my todo list for this week. But please be patient.
It's been _one_ work day since you posted this last version so I do not
think this is stalling for too long. Sure the current version is
probably not too much different from the previous but I didn't get to
review it in the depth yet. All the code duplication doesn't make it
much easier but I understand your reasoning that sharing more code is
not really straightforward.
-- 
Michal Hocko
SUSE Labs
