Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A86C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 01:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0A932173C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 01:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbfEWBA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 21:00:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:39954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727691AbfEWBA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 21:00:57 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E58822089E;
        Thu, 23 May 2019 01:00:55 +0000 (UTC)
Date:   Wed, 22 May 2019 21:00:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Sasha Levin <sashal@kernel.org>, shuah <shuah@kernel.org>,
        Dhaval Giani <dhaval.giani@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Tim Bird <tbird20d@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Carpenter,Dan" <dan.carpenter@oracle.com>, willy@infradead.org,
        gustavo.padovan@collabora.co.uk,
        Dmitry Vyukov <dvyukov@google.com>, knut.omang@oracle.com
Subject: Re: Linux Testing Microconference at LPC
Message-ID: <20190522210054.7ba71b7e@gandalf.local.home>
In-Reply-To: <20190522205847.68e36a7f@gandalf.local.home>
References: <CAPhKKr_uVTFAzne0QkZFUGfb8RxQdVFx41G9kXRY7sFN-=pZ6w@mail.gmail.com>
        <3c6c9405-7e90-fb03-aa1c-0ada13203980@kernel.org>
        <20190516003649.GS11972@sasha-vm>
        <20190522210231.GA212436@google.com>
        <20190522205847.68e36a7f@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 May 2019 20:58:47 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> You have till the end of today to submit a Refereed talk if you want to
> present. Otherwise, Microconferences should only have 5 to 10 minutes
> to present what they want to discuss before a discussion should
> proceed. If you need more than 10 minutes to give your point, then you
> need to try to get a Refereed talk in, and that will give you a full 40
> minutes.

I just found out that we are extending the deadline by one week. You
still have time, but you had better hurry!

-- Steve
