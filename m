Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61A6C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 17:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9210B2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 17:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="pr1jTCYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbgAGRqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 12:46:35 -0500
Received: from mail.skyhub.de ([5.9.137.197]:36858 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728292AbgAGRqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 12:46:34 -0500
Received: from zn.tnic (p200300EC2F0FB400396D31B560FFF95B.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:b400:396d:31b5:60ff:f95b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7EFC11EC0CD3;
        Tue,  7 Jan 2020 18:46:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1578419192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8goxpw3j//lKsOPB5Ju+xSGr7snlVBx4ue2F2yqHxQM=;
        b=pr1jTCYieK5XA20cshoM7ZUqUw9mwUwvPGhB01bfMrinWfiSEq/OTu3WUgw2gfQd9d0OBT
        3v8luk3B0x78SRb1o4MtbuqxeIiefigXugjlDzKJM7+OUbX698pgbMG3xoBMbTNhSC28lL
        LRqxRlob0wwfkVObHWRPC5eO+JAAwpo=
Date:   Tue, 7 Jan 2020 18:46:25 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>
Cc:     Vijay Thakkar <vijaythakkar@me.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        Jon Grimm <jon.grimm@amd.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/3] perf vendor events amd: latest PMU events for
 zen1/zen2
Message-ID: <20200107174625.GI29542@zn.tnic>
References: <20191227125536.1091387-1-vijaythakkar@me.com>
 <20200106221754.GB16851@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200106221754.GB16851@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2020 at 07:17:54PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Dec 27, 2019 at 07:55:33AM -0500, Vijay Thakkar escreveu:
> > This series of patches brings the PMU events for AMD family 17h series
> > of processors up to date with the latest versions of the AMD processor
> > programming reference manuals.
> > 
> > The first patch changes the pmu events mapfile to be more selective for
> > the model number rather than blanket detecting all f17h processors to
> > have the same events directory. This is required for the later patch
> > where we add events for zen2 based processors.
> > 
> > The second patch adds the PMU events for zen2.
> 
> Borislav, can you ack these, or point to someone who can double check
> this and the other 2 patches?

Hey acme, HNY! :-)

That should be Kim who's already on the Cc list.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
