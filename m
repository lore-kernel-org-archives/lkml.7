Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325CCC48BD9
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C30421670
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561557297;
	bh=DEW9/Pka8ixAFoE+Z18Rieqa5+oQZpIVKjuTWnRCmdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ywc72D1+Qy6VDVW9+DpIfNUX8EgG4M8aB6Q/fRmk7PEEWqTgnAWZeFGqPsO5X4ocI
	 TwVtMLY8jO4FawjPwSgLmtQu6WOuMqgShGRlJ/AHXJjtXjIqpgrK+Zrt46FJSp5IGX
	 GDRzJkwKN1y4Qspz8o3lk4qNBhVCjHCZi6RD1nmk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbfFZNy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 09:54:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:48626 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727750AbfFZNyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 09:54:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D2ABDAE3F;
        Wed, 26 Jun 2019 13:54:52 +0000 (UTC)
Date:   Wed, 26 Jun 2019 15:54:50 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Barret Rhoden <brho@google.com>
Cc:     linux-mm@kvack.org, Pingfan Liu <kernelfans@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Tony Luck <tony.luck@intel.com>, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/2] x86, numa: always initialize all possible nodes
Message-ID: <20190626135450.GW17798@dhcp22.suse.cz>
References: <20190212095343.23315-1-mhocko@kernel.org>
 <20190212095343.23315-2-mhocko@kernel.org>
 <34f96661-41c2-27cc-422d-5a7aab526f87@google.com>
 <20190502130031.GC29835@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502130031.GC29835@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 02-05-19 09:00:31, Michal Hocko wrote:
> On Wed 01-05-19 15:12:32, Barret Rhoden wrote:
> [...]
> > A more elegant solution may be to avoid registering with sysfs during early
> > boot, or something else entirely.  But I figured I'd ask for help at this
> > point.  =)
> 
> Thanks for the report and an excellent analysis! This is really helpful.
> I will think about this some more but I am traveling this week. It seems
> really awkward to register a sysfs file for an empty range. That looks
> like a bug to me.

I am sorry, but I didn't get to this for a long time and I am still
busy. The patch has been dropped from the mm tree (thus linux-next). I
hope I can revisit this or somebody else will take over and finish this
work. This is much more trickier than I anticipated unfortunately.

-- 
Michal Hocko
SUSE Labs
