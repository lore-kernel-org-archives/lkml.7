Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398C7C48BE0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 108F42083B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561125312;
	bh=AlP4bCOPOkaZcp/ELTb4RXzhkWt9BWIm9zyJH72saRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mBi3yhV47uTChJTy/ubZQFk67Y8MdTkI+9RQwi8uJm+bTUsKpIc8mq6DYsFTI3Edc
	 cltxEwIbeeIu/7oS7kSyDRwRXtXo4QDrEL+MM7BaibY3Y1dzExeFtNt75rwh9EphhU
	 kUhgAeIFDHKq9qd83lhOUbt5NyXayJJ8WCestr0o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfFUNzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 09:55:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:49560 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726002AbfFUNzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 09:55:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 06E6FACE1;
        Fri, 21 Jun 2019 13:55:08 +0000 (UTC)
Date:   Fri, 21 Jun 2019 15:55:07 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, brho@google.com, kernelfans@gmail.com,
        dave.hansen@intel.com, rppt@linux.ibm.com, peterz@infradead.org,
        mpe@ellerman.id.au, mingo@elte.hu, osalvador@suse.de,
        luto@kernel.org, tglx@linutronix.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] mm/hotplug: fix a null-ptr-deref during NUMA
 boot
Message-ID: <20190621135507.GE3429@dhcp22.suse.cz>
References: <20190512054829.11899-1-cai@lca.pw>
 <20190513124112.GH24036@dhcp22.suse.cz>
 <1561123078.5154.41.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561123078.5154.41.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 21-06-19 09:17:58, Qian Cai wrote:
> Sigh...
> 
> I don't see any benefit to keep the broken commit,
> 
> "x86, numa: always initialize all possible nodes"
> 
> for so long in linux-next that just prevent x86 NUMA machines with any memory-
> less node from booting.
> 
> Andrew, maybe it is time to drop this patch until Michal found some time to fix
> it properly.

Yes, please drop the patch for now, Andrew. I thought I could get to
this but time is just scarce.
-- 
Michal Hocko
SUSE Labs
