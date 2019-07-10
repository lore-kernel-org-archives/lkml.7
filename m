Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086ABC74A36
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 20:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D98B220844
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 20:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfGJUYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 16:24:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:60414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbfGJUYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 16:24:05 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2E5120693;
        Wed, 10 Jul 2019 20:24:03 +0000 (UTC)
Date:   Wed, 10 Jul 2019 16:24:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, bp@alien8.de, mingo@kernel.org,
        luto@kernel.org, torvalds@linux-foundation.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, jgross@suse.com,
        linux-kernel@vger.kernel.org, zhe.he@windriver.com,
        joel@joelfernandes.org, devel@etsukata.com
Subject: Re: [PATCH v2 4/7] x86/entry/64: Update comments and sanity tests
 for create_gap
Message-ID: <20190710162402.174e8221@gandalf.local.home>
In-Reply-To: <20190704200050.477489028@infradead.org>
References: <20190704195555.580363209@infradead.org>
        <20190704200050.477489028@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Jul 2019 21:55:59 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

Very descriptive change log ;-)

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve


> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
