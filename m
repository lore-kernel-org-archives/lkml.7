Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA56C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB9C2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfKOQDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 11:03:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:59696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727423AbfKOQDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 11:03:23 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41D06206D4;
        Fri, 15 Nov 2019 16:03:22 +0000 (UTC)
Date:   Fri, 15 Nov 2019 11:03:20 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, saiprakash.ranjan@codeaurora.org
Subject: Re: [RFC 1/2] docs: ftrace: Clarify the RAM impact of
 buffer_size_kb
Message-ID: <20191115110320.55b3d9cb@gandalf.local.home>
In-Reply-To: <20191115155955.4khvnlnzjhnp5bxa@ubuntu1804-desktop>
References: <cover.1573661658.git.frank@generalsoftwareinc.com>
        <0e4a803c3e24140172855748b4a275c31920e208.1573661658.git.frank@generalsoftwareinc.com>
        <20191113113730.213ddd72@gandalf.local.home>
        <20191114202059.GC186056@google.com>
        <20191114163639.4727e3ed@gandalf.local.home>
        <20191115042428.6xxiqbzhgoko6vyk@ubuntu1804-desktop>
        <20191115083000.76f89785@gandalf.local.home>
        <20191115155955.4khvnlnzjhnp5bxa@ubuntu1804-desktop>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Nov 2019 10:59:55 -0500
"Frank A. Cancio Bello" <frank@generalsoftwareinc.com> wrote:

> I feel that adding:
> 
> "A few extra pages may be allocated to accommodate buffer management
> meta-data."
> 
> between the two sentences that I quoted will address the issue. If
> that is OK with you I will proceed to package this change in a new
> patchset along with a few fixes of typos that I spotted in other
> parts of the doc.

Yep, I'm OK with that.

Thanks!

-- Steve
