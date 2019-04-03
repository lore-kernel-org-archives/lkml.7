Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30615C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 19:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 004832084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 19:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfDCTfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 15:35:39 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35720 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfDCTfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 15:35:39 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hBlfP-0007JU-Si; Wed, 03 Apr 2019 19:35:23 +0000
Date:   Wed, 3 Apr 2019 20:35:23 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     NeilBrown <neilb@suse.com>
Cc:     Ian Kent <raven@themaw.net>, Jonathan Corbet <corbet@lwn.net>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/24] Convert vfs.txt to vfs.rst
Message-ID: <20190403193523.GX2217@ZenIV.linux.org.uk>
References: <20190327051717.23225-1-tobin@kernel.org>
 <20190402094934.5b242dc0@lwn.net>
 <20190402164824.GK2217@ZenIV.linux.org.uk>
 <20190402175401.GL2217@ZenIV.linux.org.uk>
 <20190402190811.GM2217@ZenIV.linux.org.uk>
 <5c5e02f8b8add4aa2fc24ba2a0880652529588af.camel@themaw.net>
 <87ftqz29i2.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ftqz29i2.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 11:55:01AM +1100, NeilBrown wrote:

> It seems very likely that this was just a subtlety that I missed.
> I doesn't help that "ino" isn't actually and inode and isn't freed like
> an inode, but that is no excuse.
> 
> When we add the rcu_head linkage to 'struct autofs_info', we might as
> well remove the 'struct inode' from there - it doesn't seem to have been
> used for years.

Umm...  I can do that, but then we get greater potential for conflicts
and the whole thing might be better off in autofs tree.  Ian, up to you -
I can throw both into a never-rebased branch, so you could merge it
into your tree; the first one is -stable fodder, though...
