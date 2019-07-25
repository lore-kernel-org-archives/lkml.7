Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7EFC76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 23:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ADF520823
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 23:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbfGYXTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 19:19:02 -0400
Received: from smtprelay0254.hostedemail.com ([216.40.44.254]:35600 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726822AbfGYXTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 19:19:01 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 42B0A181D33FC;
        Thu, 25 Jul 2019 23:19:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: sand48_6b5f3660fae4f
X-Filterd-Recvd-Size: 1709
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Thu, 25 Jul 2019 23:18:57 +0000 (UTC)
Message-ID: <ad5ec66830b502d68e6d3c814706b52490418f0f.camel@perches.com>
Subject: Re: [tip:perf/urgent] perf/x86/intel: Mark expected switch
 fall-throughs
From:   Joe Perches <joe@perches.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Cc:     hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org,
        gustavo@embeddedor.com, torvalds@linux-foundation.org,
        acme@kernel.org, kan.liang@linux.intel.com, namhyung@kernel.org,
        jolsa@redhat.com, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, keescook@chromium.org,
        linux-tip-commits@vger.kernel.org
Date:   Thu, 25 Jul 2019 16:18:56 -0700
In-Reply-To: <20190725173521.GM31381@hirez.programming.kicks-ass.net>
References: <20190624161913.GA32270@embeddedor>
         <tip-289a2d22b5b611d85030795802a710e9f520df29@git.kernel.org>
         <20190725170613.GC27348@nazgul.tnic>
         <20190725173521.GM31381@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-07-25 at 19:35 +0200, Peter Zijlstra wrote:
> Seriously though; I detest these patches and we really, as in _really_
> should have done that attribute thing.

At least it'll be fairly easy to convert to something
sensible later.

Variants of the equivalent of:

s@/* fallthrough */@fallthrough;@

with some trivial whitespace reformatting will read
_much_ better.

It's pretty scriptable.


