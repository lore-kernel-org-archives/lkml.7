Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E69DC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 21:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 446912173E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 21:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbfH2VDa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 17:03:30 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:46406 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfH2VDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 17:03:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id BFE666083139;
        Thu, 29 Aug 2019 23:03:27 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id UvgXmJNLFfTl; Thu, 29 Aug 2019 23:03:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 80C88608313E;
        Thu, 29 Aug 2019 23:03:27 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0-XjAj7s1amn; Thu, 29 Aug 2019 23:03:27 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 56B0F6083139;
        Thu, 29 Aug 2019 23:03:27 +0200 (CEST)
Date:   Thu, 29 Aug 2019 23:03:27 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Dark <dark@volatile.bz>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>
Message-ID: <1408538854.76578.1567112607283.JavaMail.zimbra@nod.at>
In-Reply-To: <20190829165442.3a3425ad@TheDarkness>
References: <20190829135001.6a5ff940@TheDarkness.local> <899887272.76523.1567104513068.JavaMail.zimbra@nod.at> <20190829165442.3a3425ad@TheDarkness>
Subject: Re: [PATCH v2] um: Rewrite host RNG driver.
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF60 (Linux)/8.8.12_GA_3809)
Thread-Topic: Rewrite host RNG driver.
Thread-Index: Oma/16tRMf5Dqk+nSnu/JJtVBEaoAw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
>> ----- Ursprüngliche Mail -----
>> > Von: "Dark" <dark@volatile.bz>
>> > +	// Returning -EAGAIN to userspace is not nice.
>> > +	if (err == -EAGAIN)
>> > +		return 0;
>> 
>> Hmm, doesn't this result in a short read?
>> The current drives sets the calling task to sleep and wakes
>> it up as soon data is available again. I'd assumes ti have the
>> same behavior for the new driver.
>> 
>> Thanks,
>> //richard
> 
> Clearly this patch needs a lot more work before I submit it. I'll
> take some time to polish it up and then resubmit it if that's fine.

No need to worry, take your time. Thanks a lot for working on this driver!

Thanks,
//richard
