Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37CFC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 20:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEE2C20709
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 20:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfLWUSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 15:18:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:50452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726787AbfLWUSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 15:18:11 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77136206D3;
        Mon, 23 Dec 2019 20:18:10 +0000 (UTC)
Date:   Mon, 23 Dec 2019 15:18:09 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Antonio Borneo <antonio.borneo@st.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] tracing: Fix printing ptrs in preempt/irq
 enable/disable events
Message-ID: <20191223151809.3db1d86a@gandalf.local.home>
In-Reply-To: <20191223151301.20be63f7@gandalf.local.home>
References: <20191127154428.191095-1-antonio.borneo@st.com>
        <20191204092115.30ef75c9@gandalf.local.home>
        <20191221234741.GA116648@google.com>
        <20191223151301.20be63f7@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Dec 2019 15:13:01 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Does this fix it for you?

I created this BZ so it does not get forgotten about over the New Year
break.

  https://bugzilla.kernel.org/show_bug.cgi?id=205953

-- Steve

