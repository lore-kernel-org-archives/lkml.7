Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEE7C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43E0F2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554240134;
	bh=KC6MHSot9P/wc1EbQ8B05h05KHQOkZfOi9okVVBBapM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=WmqYSNFDqAtTOetLMW4VT1DE5TYQJSpV2mkfvwHgWq3Jz74MBRrnwaSqTBT/hjmuz
	 FQwNyVjM6huT22CCJp0kOAYwWjpPzKSSy6qR7Wohw0hGUH7c7pW2C28TiHGgF7yfHS
	 Q+rceZ7aiTOFiJCG+aL3nTzDRCjtjOS//ljM0P4o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfDBVWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 17:22:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47692 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfDBVWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 17:22:12 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 311E2E7C;
        Tue,  2 Apr 2019 21:22:11 +0000 (UTC)
Date:   Tue, 2 Apr 2019 14:22:10 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Waiman Long <longman@redhat.com>
Cc:     "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Takashi Iwai <tiwai@suse.de>, Davidlohr Bueso <dbueso@suse.de>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [RESEND PATCH 2/3] ipc: Conserve sequence numbers in
 ipcmni_extend mode
Message-Id: <20190402142210.ba29c7dfc10d5a315a1c39dd@linux-foundation.org>
In-Reply-To: <20190329204930.21620-2-longman@redhat.com>
References: <20190329204930.21620-1-longman@redhat.com>
        <20190329204930.21620-2-longman@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Mar 2019 16:49:29 -0400 Waiman Long <longman@redhat.com> wrote:

> From: Manfred Spraul <manfred@colorfullife.com>
> 
> Rewrite, based on the patch from Waiman Long:
> 
> ...
>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Original-patch-from: Waiman Long <longman@redhat.com>
> Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
> Acked-by: Waiman Long <longman@redhat.com>

I added your Signed-off-by: to this.  Because you contributed and
because you were on the patch delivery path (either of these require a
SOB).

And I removed the Original-patch-from line.  The changelog already says
that and Original-patch-from isn't a standard changelog tag.
