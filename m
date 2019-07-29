Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F80C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1BF32067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388225AbfG2Pr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 11:47:27 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:59108 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387495AbfG2Pr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 11:47:27 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hs7rs-000847-6K; Mon, 29 Jul 2019 15:47:20 +0000
Date:   Mon, 29 Jul 2019 16:47:20 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     "zhangyi (F)" <yi.zhang@huawei.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcrl@kvack.org, wangkefeng.wang@huawei.com
Subject: Re: [PATCH] aio: add timeout validity check for io_[p]getevents
Message-ID: <20190729154720.GS1131@ZenIV.linux.org.uk>
References: <1564039289-7672-1-git-send-email-yi.zhang@huawei.com>
 <x49imrqb2e5.fsf@segfault.boston.devel.redhat.com>
 <x49y30gnb16.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x49y30gnb16.fsf@segfault.boston.devel.redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 10:57:41AM -0400, Jeff Moyer wrote:
> Al, can you take this through your tree?

Umm...  Can do, but I had an impression that Arnd and Deepa
had a tree for timespec-related work.  OTOH, it had been
relatively quiet last cycle, so...  If they have nothing
in the area, I can take it through vfs.git.
