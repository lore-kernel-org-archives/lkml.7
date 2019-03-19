Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7775DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D7DA2177E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfCSUQ5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 16:16:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727017AbfCSUQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 16:16:57 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97582213F2;
        Tue, 19 Mar 2019 20:16:56 +0000 (UTC)
Date:   Tue, 19 Mar 2019 16:16:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Divya Indi <divya.indi@oracle.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Kernel access to ftrace instances
Message-ID: <20190319161655.2824746c@gandalf.local.home>
In-Reply-To: <1552692925-17240-2-git-send-email-divya.indi@oracle.com>
References: <1552692925-17240-1-git-send-email-divya.indi@oracle.com>
        <1552692925-17240-2-git-send-email-divya.indi@oracle.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Mar 2019 16:35:25 -0700
Divya Indi <divya.indi@oracle.com> wrote:

> Ftrace provides the feature “instances” that provides the capability to
> create multiple Ftrace ring buffers. However, currently these buffers
> are created/accessed via userspace only. The kernel APIs providing these
> features are not exported, hence cannot be used by other kernel
> components.
> 
> This patch aims to extend this infrastructure to provide the
> flexibility to create/log/remove/ enable-disable existing trace events
> to these buffers from within the kernel.
> 
>

Thanks for sending this. I'm currently working on some other changes,
but will look in this when I'm finished with the other work. Should be
within this week.

-- Steve
