Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24ED6CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 23:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F38AA20882
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 23:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730537AbfJUXVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 19:21:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:40538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729270AbfJUXVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 19:21:50 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAA9920882;
        Mon, 21 Oct 2019 23:21:49 +0000 (UTC)
Date:   Mon, 21 Oct 2019 19:21:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v3] tracing: Introduce trace event injection
Message-ID: <20191021192146.0d651ce2@oasis.local.home>
In-Reply-To: <CAM_iQpU3dqvUR0Qp6ZdZrAiyT_t_uFk4K79vcT2Q_-EjqBCGbw@mail.gmail.com>
References: <20190904211456.31204-1-xiyou.wangcong@gmail.com>
        <CAM_iQpUiOi8JDBqAtMHii5UHK3D6WQkk_G5DriJ9Y0yTYbWf3Q@mail.gmail.com>
        <CAM_iQpU3dqvUR0Qp6ZdZrAiyT_t_uFk4K79vcT2Q_-EjqBCGbw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2019 13:41:51 -0700
Cong Wang <xiyou.wangcong@gmail.com> wrote:

> On Mon, Sep 23, 2019 at 2:13 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> >
> > Hi, Steven
> >
> > Any reviews for V3? I've addressed your concern about Kconfig.
> >  
> 
> Ping..

Sorry, I still haven't forgotten about you. Just trying to deal with
other fires at the moment.

-- Steve
