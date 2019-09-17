Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B55C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 22:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3BEF20678
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 22:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbfIQWl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 18:41:59 -0400
Received: from pc-246-229-214-201.cm.vtr.net ([201.214.229.246]:46348 "EHLO
        mail.test.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725801AbfIQWl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 18:41:58 -0400
X-Greylist: delayed 390 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Sep 2019 18:41:57 EDT
Received: by mail.test.com (Postfix, from userid 1001)
        id 044E81387; Tue, 17 Sep 2019 17:35:24 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.test.com (Postfix) with ESMTP id 006B1F38;
        Tue, 17 Sep 2019 17:35:24 -0500 (CDT)
Date:   Tue, 17 Sep 2019 17:35:24 -0500 (CDT)
From:   Christoph Lameter <cl@linux.com>
X-X-Sender: cl@lameter.cl
To:     David Rientjes <rientjes@google.com>
cc:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org,
        penberg@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: fix -Wunused-function compiler warnings
In-Reply-To: <alpine.DEB.2.21.1909171423000.168624@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.21.1909171734490.9525@lameter.cl>
References: <1568752232-5094-1-git-send-email-cai@lca.pw> <alpine.DEB.2.21.1909171423000.168624@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Sep 2019, David Rientjes wrote:

> On Tue, 17 Sep 2019, Qian Cai wrote:
>
> > tid_to_cpu() and tid_to_event() are only used in note_cmpxchg_failure()
> > when SLUB_DEBUG_CMPXCHG=y, so when SLUB_DEBUG_CMPXCHG=n by default,
> > Clang will complain that those unused functions.
> >
> > Signed-off-by: Qian Cai <cai@lca.pw>
>
> Acked-by: David Rientjes <rientjes@google.com>

Ditto

