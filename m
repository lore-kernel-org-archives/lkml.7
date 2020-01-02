Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400B3C2D0C2
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 18:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14E5B20866
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 18:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbgABSBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 13:01:52 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57836 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728001AbgABSBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 13:01:49 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 002I0Y6w020811
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Jan 2020 13:00:35 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 3EE664200AF; Thu,  2 Jan 2020 13:00:34 -0500 (EST)
Date:   Thu, 2 Jan 2020 13:00:34 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Qian Cai <cai@lca.pw>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org,
        pmladek@suse.com, "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, dan.j.williams@intel.com,
        Peter Zijlstra <peterz@infradead.org>, longman@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] char/random: silence a lockdep splat with printk()
Message-ID: <20200102180034.GA197330@mit.edu>
References: <20191205010055.GO93017@google.com>
 <4F9E9335-334B-4600-8BC3-4AF91510D113@lca.pw>
 <1CA39814-DE67-4112-8F97-D62B9F47FF9D@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1CA39814-DE67-4112-8F97-D62B9F47FF9D@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2020 at 10:42:51AM -0500, Qian Cai wrote:
> 
> Not sure if Ted is still interested in maintaining this file as he had no feedback for more
> than a month. The problem is that this will render the lockdep useless for a general
> debugging tool as it will disable the lockdep early in the process.
> 
> Could Andrew (since the free page shuffle will call get_random) or Linus pick this up
> directly with the approval from one of the printk() maintainers above?

Sorry, things have been busy with the Chistmas holidays and getting
the ext4 tree ready for the merge window.  I'll take a look at this in the next day or two.

    	      	    	    	  - Ted
