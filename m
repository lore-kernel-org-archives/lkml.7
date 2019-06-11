Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12DCC31E44
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 21:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8704620874
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 21:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407750AbfFKVwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 17:52:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:39590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407165AbfFKVwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 17:52:40 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3A1720866;
        Tue, 11 Jun 2019 21:52:39 +0000 (UTC)
Date:   Tue, 11 Jun 2019 17:52:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Preisner <linux@tpreisner.de>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: add simple oneshot function tracer
Message-ID: <20190611175237.0ea4fa4f@gandalf.local.home>
In-Reply-To: <20190611203312.13653-1-linux@tpreisner.de>
References: <20190529104552.146fa97c@oasis.local.home>
        <20190611203312.13653-1-linux@tpreisner.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jun 2019 22:33:11 +0200
Thomas Preisner <linux@tpreisner.de> wrote:

> However, due to there not being any mechanism (that I am aware of) to
> activate such stat tracers via kernel commandline this oneshot profiler
> is now always active when selected. Therefore, it is no longer possible
> to disable this tracer during runtime and thus, allocated memory is no
> longer freed.

What do you mean? The function profile has its own file to enable it:

 echo 1 > /sys/kernel/tracing/function_profile_enabled

And disable it:

 echo 0 > /sys/kernel/tracing/function_profile_enabled

-- Steve

