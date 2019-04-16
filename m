Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E417C282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09DE220857
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555397679;
	bh=Zu9rrMFkcVvad8CThfYywPplWrCzx7RSQhgl8pxB4X0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tglqqzh7WL4OVcGFPGNlp9/usagXhqqtb39EVht6TtP/D1yQlVbSoFa7KBrYAnd4x
	 vAIonYUwVQPL3D0U1NJMCcaezYxsldhlui6q49Zil2eZVnSyC2HGiXOGTI/yp9rztP
	 3+LY2IKLo4NhEnf9ltfuQqd7koFAFlPrIBOkRzeU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbfDPGyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 02:54:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:43348 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726768AbfDPGyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 02:54:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 99D90ACD0;
        Tue, 16 Apr 2019 06:54:35 +0000 (UTC)
Date:   Tue, 16 Apr 2019 08:54:32 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Tony Luck <tony.luck@intel.com>, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 0/2] x86, numa: always initialize all possible nodes
Message-ID: <20190416065432.GC11561@dhcp22.suse.cz>
References: <20190212095343.23315-1-mhocko@kernel.org>
 <20190226131201.GA10588@dhcp22.suse.cz>
 <20190415114209.GJ3366@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415114209.GJ3366@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot to cc Andrew. Now for real.

Andrew please note that Dave has reviewed the patch
http://lkml.kernel.org/r/77b364e5-a30c-964a-6985-00b759dac128@intel.com

Or do you want me to resubmit?

On Mon 15-04-19 13:42:09, Michal Hocko wrote:
> On Tue 26-02-19 14:12:01, Michal Hocko wrote:
> > On Tue 12-02-19 10:53:41, Michal Hocko wrote:
> > > Hi,
> > > this has been posted as an RFC previously [1]. There didn't seem to be
> > > any objections so I am reposting this for inclusion. I have added a
> > > debugging patch which prints the zonelist setup for each numa node
> > > for an easier debugging of a broken zonelist setup.
> > > 
> > > [1] http://lkml.kernel.org/r/20190114082416.30939-1-mhocko@kernel.org
> > 
> > Friendly ping. I haven't heard any complains so can we route this via
> > tip/x86/mm or should we go via mmotm.
> 
> It seems that Dave is busy. Let's add Andrew. Can we get this [1] merged
> finally, please?
> 
> [1] http://lkml.kernel.org/r/20190212095343.23315-1-mhocko@kernel.org

-- 
Michal Hocko
SUSE Labs
