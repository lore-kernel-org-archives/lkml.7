Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CAFC43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 23:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71BCF205C9
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 23:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfLHXMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 18:12:01 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:53018 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfLHXMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 18:12:00 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0748815396DF6;
        Sun,  8 Dec 2019 15:11:59 -0800 (PST)
Date:   Sun, 08 Dec 2019 15:11:57 -0800 (PST)
Message-Id: <20191208.151157.1507660154216668008.davem@davemloft.net>
To:     torvalds@linux-foundation.org
Cc:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT] Networking
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAHk-=widRc30Mcec8EwqxuMFr+dAFpM4gJjdVOKWJog4T60qKA@mail.gmail.com>
References: <20191208.012032.1258816267132319518.davem@redhat.com>
        <CAHk-=widRc30Mcec8EwqxuMFr+dAFpM4gJjdVOKWJog4T60qKA@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 08 Dec 2019 15:12:00 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 8 Dec 2019 13:35:08 -0800

> Fix your mindset, and stop sending me garbage.

Sorry.

I was still brainstorming how to fix this properly.


