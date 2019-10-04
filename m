Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF63C4CED1
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65717222C0
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570200208;
	bh=RS/QreI9KmconcTWVyRwlk+qQShgIpvjIs4buQB51zk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mdolWAI57SYXrAYhlyt5VgtH3BpZXJoQGOoXtRiiymu+6P8SAu4FMyvAhsKyu9UQ4
	 9X0Vj3SqXmvmc8oP1+UbbEXlh/lnu3yhR8T3bfV1bIwHrGu1gIvhcWzGySREwQDWDl
	 34Zqodr5Fq267yOMgQTa3d3w+Xbzfc8Z4J5c0/OI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389182AbfJDOn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 10:43:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:49842 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388724AbfJDOn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 10:43:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9C2E2AC69;
        Fri,  4 Oct 2019 14:43:25 +0000 (UTC)
Date:   Fri, 4 Oct 2019 16:43:25 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Daniel Colascione <dancol@google.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>, Qian Cai <cai@lca.pw>,
        Tim Murray <timmurray@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH] Make SPLIT_RSS_COUNTING configurable
Message-ID: <20191004144325.GP9578@dhcp22.suse.cz>
References: <CAKOZuesMoBj-APjCipJmWcAgSzkbD1mvyOp0UvHLnkwR-EU4Ww@mail.gmail.com>
 <1C584B5C-E04E-4B04-A3B5-4DC8E5E67366@lca.pw>
 <CAKOZuesKY_=qkSXfmDO_1ALaqQtU0kz5Z+fBh05c8BR7oCDxKw@mail.gmail.com>
 <20191004123349.GB10845@dhcp22.suse.cz>
 <20191004132624.ctaodxaxsd7wzwlh@box>
 <CAKOZuesqgEBSNvpsdw1QhVvYBNBUjAL0pu1x_b-C5q22Z7BZ4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOZuesqgEBSNvpsdw1QhVvYBNBUjAL0pu1x_b-C5q22Z7BZ4g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 04-10-19 06:45:21, Daniel Colascione wrote:
[...]
> Nobody has demonstrated that split RSS accounting actually helps in
> the real world. But I've described above, concretely, how split RSS
> accounting hurts. I've been trying for over a year to either disable
> split RSS accounting or to let people opt out of it. If you won't
> remove split RSS accounting and you won't let me add a configuration
> knob that lets people opt out of it, what will you accept?

What is an argument to keep it around?

-- 
Michal Hocko
SUSE Labs
