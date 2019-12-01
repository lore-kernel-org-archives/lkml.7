Return-Path: <SRS0=SILN=ZX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3FFC432C0
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 01:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2234220833
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 01:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qZo76Hd8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfLABYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 20:24:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40374 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbfLABYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 20:24:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Z3Q2gHwuTgcwkkb63P8mi7j2VkryTyk9Hd1yWB9qFeU=; b=qZo76Hd8zxV1YC6OoiLTiBPoM
        rkLkJzcXNPI8COwC8lKDVbelTtlJKTo5WmmIrapbdN5lqDJbpEFKgi9t9UJqerYeYiDY4uMeY9W2Z
        1djYBOYI/f3f98HS5IjYSPeNKXj4ivw6YpBHBiH8FYjGj4Fmp5KiC9IRgWRNWBFxZakQI6Ul59TXf
        daPvO0bgP3nwim1SUMF9BdmdmJGHuKTvUGN9Y6zLVLlxz7+K1pe2KX+ANfLh85Vc2BtBcK4Kb77eC
        2RhbosA/WHGUgDt5wl6mLe8IZjGd4AKE2ZfkxvQdQZwAP7iHokmW+h1Foh8BDxpnBQHBHDdk4OjEt
        2EFKgn1jw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ibDyJ-0006Dg-TT; Sun, 01 Dec 2019 01:24:23 +0000
Date:   Sat, 30 Nov 2019 17:24:23 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: {standard input}:211: Error: operand out of range (128 is not
 between -128 and 127)
Message-ID: <20191201012423.GK20752@bombadil.infradead.org>
References: <201912010830.w1kwu40L%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201912010830.w1kwu40L%lkp@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 01, 2019 at 08:53:31AM +0800, kbuild test robot wrote:
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   32ef9553635ab1236c33951a8bd9b5af1c3b1646
> commit: 5a74ac4c4a97bd8b7dba054304d598e2a882fea6 idr: Fix idr_get_next_ul race with idr_remove
> date:   4 weeks ago
> config: arc-defconfig (attached as .config)
> compiler: arc-elf-gcc (GCC) 7.4.0

Still don't care.  You need to drop this broken compiler from your test cases.

