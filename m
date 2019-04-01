Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B30C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 22:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9754B2084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 22:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554159583;
	bh=HUIt/GMdMIfedRsCvcx60XvZMawRAJlZEzZJAl/WHbE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=s75CMN4jz4qrlHNScXGIz8VTIMs4vCY92XJj17wpktG6ip6zxhxwxRJJUabjZWhTM
	 U3R3otAjb5lmdYr1juReE/XQAEM13fA9RT1c6Os5xeSmV/n58ZDU/UvAnrdiQxgTuX
	 fVc/+jVJDE5ndUe7fx8HBLaS/OnuJZ5BNrwq7jxo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfDAW7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 18:59:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59800 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfDAW7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 18:59:41 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BEA3D1ACD;
        Mon,  1 Apr 2019 22:59:40 +0000 (UTC)
Date:   Mon, 1 Apr 2019 15:59:39 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH v2 0/1] improve vmap allocation
Message-Id: <20190401155939.66ad1f8ad999fde514002e66@linux-foundation.org>
In-Reply-To: <20190401110347.aby2v6tvqfvhyupf@pc636>
References: <20190321190327.11813-1-urezki@gmail.com>
        <20190321150106.198f70e1e949e2cb8cc06f1c@linux-foundation.org>
        <20190401110347.aby2v6tvqfvhyupf@pc636>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Apr 2019 13:03:47 +0200 Uladzislau Rezki <urezki@gmail.com> wrote:

> Hello, Andrew.
> 
> >
> > It's a lot of new code. I t looks decent and I'll toss it in there for
> > further testing.  Hopefully someone will be able to find the time for a
> > detailed review.
> > 
> I have got some proposals and comments about simplifying the code a bit.
> So i am about to upload the v3 for further review. I see that your commit
> message includes whole details and explanation:
> 
> http://git.cmpxchg.org/cgit.cgi/linux-mmotm.git/commit/?id=b6ac5ca4c512094f217a8140edeea17e6621b2ad
> 
> Should i base on and keep it in v3?
> 

It's probably best to do a clean resend at this stage.  I'll take a
look at the deltas and updating changelogs, etc.
