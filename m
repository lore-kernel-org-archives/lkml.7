Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED35C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 14:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 058982187F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 14:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgAGOWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 09:22:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:38780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727658AbgAGOWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 09:22:32 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D293D20715;
        Tue,  7 Jan 2020 14:22:31 +0000 (UTC)
Date:   Tue, 7 Jan 2020 09:22:30 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Antonio Borneo <antonio.borneo@st.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH] tracing: Fix printing ptrs in preempt/irq
 enable/disable events
Message-ID: <20200107092230.473d7fc1@gandalf.local.home>
In-Reply-To: <dc9a1a6a32b0e028837a315834c4723ed44dbac5.camel@st.com>
References: <20191127154428.191095-1-antonio.borneo@st.com>
        <20191204092115.30ef75c9@gandalf.local.home>
        <20191221234741.GA116648@google.com>
        <20191223151301.20be63f7@gandalf.local.home>
        <dc9a1a6a32b0e028837a315834c4723ed44dbac5.camel@st.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jan 2020 10:21:55 +0100
Antonio Borneo <antonio.borneo@st.com> wrote:

> There are other cases where the trace buffer is under stress, e.g. during function tracing.
> Would it be useful to only store the offset in such cases too?

It could be possible but may require another event type and an option,
as it may break existing tooling.

-- Steve

