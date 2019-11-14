Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B60DC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 19:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F19E20729
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 19:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfKNTrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 14:47:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:32898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbfKNTrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 14:47:41 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DD3920725;
        Thu, 14 Nov 2019 19:47:40 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1iVL5e-0001vl-TW; Thu, 14 Nov 2019 14:47:38 -0500
Message-Id: <20191114194636.811109457@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 14 Nov 2019 14:46:36 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [RFC][PATCH 0/2] ftrace: Add modify_ftrace_direct()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As discussed with Alexei, here's a simple implementation of
modify_ftrace_direct() without the need for any architecture changes.

Steven Rostedt (VMware) (2):
      ftrace: Add modify_ftrace_direct()
      ftrace/samples: Add a sample module that implements modify_ftrace_direct()

----
 include/linux/ftrace.h                |  6 +++
 kernel/trace/ftrace.c                 | 78 +++++++++++++++++++++++++++++++
 samples/ftrace/Makefile               |  1 +
 samples/ftrace/ftrace-direct-modify.c | 88 +++++++++++++++++++++++++++++++++++
 4 files changed, 173 insertions(+)
 create mode 100644 samples/ftrace/ftrace-direct-modify.c
