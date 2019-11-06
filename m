Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FEEC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 18:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD9B0217D7
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 18:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573064031;
	bh=Ta1ybKjmi0q0KWQZNpGJKfbd9zOitUNAQZVj6Hxc294=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=eTpSFO1Ayyoz24wE0ZEWz7SkNgIJIyVthlr+Tl+cOuoF00/TP9VIIa6e5zuXqhnvm
	 kUFpC0nWogxZQiSr9rJx1ROEXpzbmZeHoMbQmcMlfctvnouIwtorvSGcK4W2coOLTC
	 qMS4A+efMsw9fmr3Y6Pv/oYXWbxEiL0P12fYrF8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732487AbfKFSNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 13:13:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:58990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727286AbfKFSNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 13:13:50 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8358D2166E;
        Wed,  6 Nov 2019 18:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573064029;
        bh=Ta1ybKjmi0q0KWQZNpGJKfbd9zOitUNAQZVj6Hxc294=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LdWzgySPOwqFPRp6S8W/AdVCXFeh0qivlwI4NKVsoiWM2TbBGXUlRJIR1GIYzWxcV
         8kGunXPENoww38XldDZxprZcnF4nPE2X9i01z4pWt3OC6eVVUwSZMkMMTI/J/WcgpN
         HMIBcYWinzHjE3tBtxfuy4b1RLfkAtoTZ3GaUzvw=
Date:   Wed, 6 Nov 2019 10:13:49 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot+fb77e97ebf0612ee6914@syzkaller.appspotmail.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH] drm: Limit to INT_MAX in create_blob ioctl
Message-Id: <20191106101349.7dfaa4282db4c7a0239b96f2@linux-foundation.org>
In-Reply-To: <201911060920.71D7E76E@keescook>
References: <20191106164755.31478-1-daniel.vetter@ffwll.ch>
        <201911060920.71D7E76E@keescook>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Nov 2019 09:24:18 -0800 Kees Cook <keescook@chromium.org> wrote:

> > Since this is -mm can I have a stable sha1 or something for
> > referencing? Or do you want to include this in the -mm patch bomb for
> > the merge window?
> 
> Traditionally these things live in akpm's tree when they are fixes for
> patches in there. I have no idea how the Fixes tags work in that case,
> though...

I queued it immediately ahead of
uaccess-disallow-int_max-copy-sizes.patch so all should be good,
thanks.

