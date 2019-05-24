Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D343BC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 12:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB9220863
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 12:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391596AbfEXMbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 08:31:49 -0400
Received: from outbound-smtp25.blacknight.com ([81.17.249.193]:35270 "EHLO
        outbound-smtp25.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389057AbfEXMbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 08:31:49 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp25.blacknight.com (Postfix) with ESMTPS id A0B75B8888
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 13:31:47 +0100 (IST)
Received: (qmail 20124 invoked from network); 24 May 2019 12:31:47 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.225.79])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 24 May 2019 12:31:47 -0000
Date:   Fri, 24 May 2019 13:31:46 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Oleksandr Natalenko <oleksandr@redhat.com>
Cc:     Justin Piszcz <jpiszcz@lucidpixels.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: 5.1 and 5.1.1: BUG: unable to handle kernel paging request at
 ffffea0002030000
Message-ID: <20190524123146.GP18914@techsingularity.net>
References: <CAO9zADzXTQpv5cGp61BzsVPvWQz5xbSJv_N71jBa3zopr7CB=Q@mail.gmail.com>
 <20190520115608.GK18914@techsingularity.net>
 <CAO9zADzz9QJ9Rp_Acy5GRggfYZzDwYYNWhCvPc9XHd+G=gS5zw@mail.gmail.com>
 <20190521124310.GM18914@techsingularity.net>
 <20190524114329.hujd3qvtusz6uyfk@butterfly.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20190524114329.hujd3qvtusz6uyfk@butterfly.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 01:43:29PM +0200, Oleksandr Natalenko wrote:
> > Please use the offset 0xb9
> > 
> > addr2line -i -e /usr/src/linux/vmlinux `printf "0x%lX" $((0x$ADDR+0xb9))
> > 
> > -- 
> > Mel Gorman
> > SUSE Labs
> 
> Cc'ing myself since i observe such a behaviour sometimes right after KVM
> VM is launched. No luck with reproducing it on demand so far, though.
> 

It's worth testing the patch at https://lore.kernel.org/lkml/1558689619-16891-1-git-send-email-suzuki.poulose@arm.com/T/#u

-- 
Mel Gorman
SUSE Labs
