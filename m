Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E238C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 16:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D7452087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 16:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfC0Q3O convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 12:29:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbfC0Q3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 12:29:14 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A8742082F;
        Wed, 27 Mar 2019 16:29:13 +0000 (UTC)
Date:   Wed, 27 Mar 2019 12:29:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Divya Indi <divya.indi@oracle.com>
Cc:     linux-kernel@vger.kernel.org, Joe Jin <joe.jin@oracle.com>
Subject: Re: [PATCH] tracing: Kernel access to Ftrace instances
Message-ID: <20190327122912.70bcf31a@gandalf.local.home>
In-Reply-To: <1553106531-3281-2-git-send-email-divya.indi@oracle.com>
References: <1553106531-3281-1-git-send-email-divya.indi@oracle.com>
        <1553106531-3281-2-git-send-email-divya.indi@oracle.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2019 11:28:51 -0700
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
> Signed-off-by: Divya Indi <divya.indi@oracle.com>
> Reviewed-by: Joe Jin <joe.jin@oracle.com>
> ---


I added this to my queue, for 5.2 and then we'll see what it will do.

-- Steve
