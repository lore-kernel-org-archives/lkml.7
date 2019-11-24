Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1962DC432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 21:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEC042071A
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 21:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfKXVmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 16:42:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:51290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726842AbfKXVmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 16:42:15 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B9F62071A;
        Sun, 24 Nov 2019 21:42:14 +0000 (UTC)
Date:   Sun, 24 Nov 2019 16:42:12 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [BUGFIX PATCH 3/3] selftests/ftrace: Do not to use absolute
 debugfs path
Message-ID: <20191124164212.50029da6@oasis.local.home>
In-Reply-To: <157457135713.25666.16389902435164296254.stgit@devnote2>
References: <157457133001.25666.5309062776021151107.stgit@devnote2>
        <157457135713.25666.16389902435164296254.stgit@devnote2>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Nov 2019 13:55:57 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Use relative path to trigger file instead of absolute debugfs path,
> because if the user uses tracefs instead of debugfs, it can be
> mounted at /sys/kernel/tracing.
> Anyway, since the ftracetest is designed to be run at the tracing
> directory, user doesn't need to use absolute path.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
>

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
