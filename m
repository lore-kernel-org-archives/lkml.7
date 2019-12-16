Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7FEC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 14:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A549207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 14:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbfLPO54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 09:57:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:50488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728086AbfLPO54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 09:57:56 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 629E2206E0;
        Mon, 16 Dec 2019 14:57:55 +0000 (UTC)
Date:   Mon, 16 Dec 2019 09:57:53 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Prateek Sood <prsood@codeaurora.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        kaushalk@codeaurora.org
Subject: Re: [PATCH v3] tracing: Fix lock inversion in
 trace_event_enable_tgid_record()
Message-ID: <20191216095753.29300f1a@gandalf.local.home>
In-Reply-To: <0101016eef175e38-8ca71caf-a4eb-480d-a1e6-6f0bbc015495-000000@us-west-2.amazonses.com>
References: <20191209142314.4f3e04d6@gandalf.local.home>
        <0101016eef175e38-8ca71caf-a4eb-480d-a1e6-6f0bbc015495-000000@us-west-2.amazonses.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Dec 2019 09:15:16 +0000
Prateek Sood <prsood@codeaurora.org> wrote:

> Hi Steve,
> 
> Are you suggesting something like below?
> 
>

Thanks for a reminder, I'll take a look.

-- Steve
