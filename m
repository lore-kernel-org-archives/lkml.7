Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E132C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D2F2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553026082;
	bh=o4UyRz6g93ADtjVq/HClaAK+YTpkWMBIqC7PYkximTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0KbJiZz6ZX7hXhLh5pIBT/sdXmSOKdq5ExDEGeCnJhNtauWhWjaLmjx5ezxGUatGu
	 dHk7NtIzPiuMAqCrZRxsSvgK154qpDHQDycvjTYKyYxwAw66NemBGlGqPU4UyCiE6D
	 uKKZsWBiP3oY3tHuBSo3zSgL5wquDMxjVRVs32lM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfCSUIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 16:08:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:34322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726824AbfCSUIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 16:08:00 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C72692075C;
        Tue, 19 Mar 2019 20:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553026080;
        bh=o4UyRz6g93ADtjVq/HClaAK+YTpkWMBIqC7PYkximTE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OppUbOy3Yxbrq4Ejx3FzSarYWcNIqYpa6VwBHrlz+dGVfK6C4cyxs83eorktVVnV2
         PbzVWpCwhCKkXVHeuldE1Y+FduNIXlXq48fi0qYq9rKQopCv/JD7T7Xa9rpUFhTIqj
         5GE+qs+Zmc13CTOGhSDvHc+go1wtk3nx5JMWo8uo=
Date:   Tue, 19 Mar 2019 16:07:57 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org
Subject: Re: [PATCH AUTOSEL 4.20 37/60] tmpfs: fix link accounting when a
 tmpfile is linked in
Message-ID: <20190319200757.GB25262@sasha-vm>
References: <20190313191021.158171-1-sashal@kernel.org>
 <20190313191021.158171-37-sashal@kernel.org>
 <alpine.LSU.2.11.1903131248210.1629@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.1903131248210.1629@eggly.anvils>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 12:58:26PM -0700, Hugh Dickins wrote:
>AUTOSEL is wrong to select this commit without also selecting
>29b00e609960 ("tmpfs: fix uninitialized return value in shmem_link")
>which contains the tag
>Fixes: 1062af920c07 ("tmpfs: fix link accounting when a tmpfile is linked in")
>Please add 29b00e609960 for those 6 trees, or else omit 1062af920c07 for now.

I usually look up relevant "Fixes" tags right before I queue patches up
to avoid missing things that came up recently.

I've queued 29b00e609960 on top for all trees, thank you!

--
Thanks,
Sasha
