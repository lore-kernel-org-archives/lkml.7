Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9568FC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 10:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B8B422DBF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 10:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567594220;
	bh=0tkc2jStShXinGVSzG1SMj1S3e4mv0ZyVqBpJ3BnKSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=p2DgVMBcbmGtMctXKhxAQ2oVFj4CA7JmpVati3Wse0O2L7TbY74P3rFwgqpUvCfxl
	 JmvwpDk09H8lqE2rpjROxOOVhCAjDDqu0tCMqT63TwEFXv6d8BhAqcjM4SYhLZlVeS
	 wm4NYnVzRtDFYoKnzO/b8zwg+RQxI3i8N5Z5MqL4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729589AbfIDKuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 06:50:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:32842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726240AbfIDKuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 06:50:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0B5822CED;
        Wed,  4 Sep 2019 10:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567594218;
        bh=0tkc2jStShXinGVSzG1SMj1S3e4mv0ZyVqBpJ3BnKSc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ufhHy86DcEa4OgYPh1cNAq0rNmKo6v9+YtXdTsJ8TYeX643w5eIuYWco04QP9c0QX
         3uHKFSjHM9hATDVq0EzRC6ow0ulmU3Q7goAKmM6ffz3OU4P1tBtQCUDFIYULz8qJ4I
         bawUaSeb/3lNLyxendaa7YlFDdSsE/by9sSuKODo=
Date:   Wed, 4 Sep 2019 12:50:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>
Subject: Re: [PATCH v3] /dev/mem: Bail out upon SIGKILL.
Message-ID: <20190904105015.GA21698@kroah.com>
References: <1566825205-10703-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20190826132916.GB12281@kroah.com>
 <87bb0adb-1d36-6481-6845-a93e5a3e5d17@i-love.sakura.ne.jp>
 <5ea28431-c677-0552-41aa-1c67779e2248@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ea28431-c677-0552-41aa-1c67779e2248@i-love.sakura.ne.jp>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 07:19:47PM +0900, Tetsuo Handa wrote:
> Ping? Syzbot is still reporting this problem.

It's in my queue, give me a chance :)

greg k-h
