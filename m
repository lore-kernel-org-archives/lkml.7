Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FEBC32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 13:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98450215EA
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 13:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731135AbfI3NDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 09:03:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:45112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731121AbfI3NDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 09:03:09 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E4FB2086A;
        Mon, 30 Sep 2019 13:03:08 +0000 (UTC)
Date:   Mon, 30 Sep 2019 09:03:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masanari Iida <standby24x7@gmail.com>
Cc:     rdunlap@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ktest: Fix some typos in sample.conf
Message-ID: <20190930090306.0d9918bb@gandalf.local.home>
In-Reply-To: <20190930124925.20250-1-standby24x7@gmail.com>
References: <20190930124925.20250-1-standby24x7@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Sep 2019 21:49:25 +0900
Masanari Iida <standby24x7@gmail.com> wrote:

> This patch fixes some spelling typo in sample.conf
> 
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>

Thanks for the patch. I'll add it to my queue.

-- Steve
