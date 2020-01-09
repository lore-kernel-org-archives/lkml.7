Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB70C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6C732077B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731702AbgAIOdB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 09:33:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:36434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727854AbgAIOdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 09:33:00 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B8BF2072E;
        Thu,  9 Jan 2020 14:32:59 +0000 (UTC)
Date:   Thu, 9 Jan 2020 09:32:57 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     yangliuxm34@gmail.com, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, liuyang34@xiaomi.com,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] trace: code optimization
Message-ID: <20200109093257.681271c9@gandalf.local.home>
In-Reply-To: <4f4bed1d-9dc0-0665-4b61-8afc9ebf8201@web.de>
References: <27225bf0ec9b4e2f3d313456aee75e294361d550.1578561009.git.liuyang34@xiaomi.com>
        <4f4bed1d-9dc0-0665-4b61-8afc9ebf8201@web.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jan 2020 14:16:46 +0100
Markus Elfring <Markus.Elfring@web.de> wrote:

> > use scnprintf instead of snprinr and no need to check  
> 
> Will a typo be avoided in the final change description?
> 
> 
> > Signed-off-by: liuyang34 …  
> 
> Will this information need also an adjustment for the desired specification
> of a real name?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=b07f636fca1c8fbba124b0082487c0b3890a0e0c#n458
> 

Correct. Please resend the patch with the typo fix and a real name for
the Signed-off-by.

Thanks!

-- Steve
