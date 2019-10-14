Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B35CC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 11:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C72B207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 11:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731594AbfJNLu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 07:50:29 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47642 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730369AbfJNLu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 07:50:29 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9EBoLXN012795
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Oct 2019 07:50:22 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 1CDA7420287; Mon, 14 Oct 2019 07:50:21 -0400 (EDT)
Date:   Mon, 14 Oct 2019 07:50:21 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [REGRESSION] kmemleak: commit c566586818 causes failure to boot
Message-ID: <20191014115021.GA5564@mit.edu>
References: <20191014022633.GA6430@mit.edu>
 <20191014070312.GA3327@iMac-3.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014070312.GA3327@iMac-3.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 08:03:14AM +0100, Catalin Marinas wrote:
> Thanks for the report. I have a fix already:
> 
> http://lkml.kernel.org/r/20191004134624.46216-1-catalin.marinas@arm.com
> 
> I was hoping Andrew had sent it to Linus before -rc3 but it doesn't seem
> to be in mainline yet.

Thanks for the pointer to the fix!  Does that mean that the workaround
is to increase the kmemleak pool size?  I had been using the default
(16000) and it seems surprising that that it wasn't enough to even get
the kernel through a standard boot sequence.  Should we perhaps
increase the default mempool size?

							- Ted
