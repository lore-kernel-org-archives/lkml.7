Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7F7C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 01:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD8720896
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 01:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390472AbfFKBMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 21:12:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:48910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389723AbfFKBMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 21:12:06 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 911EC2086A;
        Tue, 11 Jun 2019 01:12:05 +0000 (UTC)
Date:   Mon, 10 Jun 2019 21:12:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 0/4] trace: introduce trace event injection
Message-ID: <20190610211204.76c8ca50@oasis.local.home>
In-Reply-To: <CAM_iQpXg9PrA_T_Argxuc+SST2CqjY=qjQA_pEgBNtC6F_a2Pw@mail.gmail.com>
References: <20190525165802.25944-1-xiyou.wangcong@gmail.com>
        <20190525183715.0778f5e5@gandalf.local.home>
        <CAM_iQpXg9PrA_T_Argxuc+SST2CqjY=qjQA_pEgBNtC6F_a2Pw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jun 2019 14:11:57 -0700
Cong Wang <xiyou.wangcong@gmail.com> wrote:

> On Sat, May 25, 2019 at 3:37 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> > Hi Cong,
> >
> > Thanks for sending these patches, but I just want to let you know that
> > it's currently a US holiday, and then afterward I'll be doing quite a
> > bit of traveling for the next two weeks. If you don't hear from me in
> > after two weeks, please send me a reminder.  
> 
> This is a reminder after two weeks. :) Please review my patches
> when you have a chance.
>

Thanks for the reminder. I'll try to get to it this week.

-- Steve
