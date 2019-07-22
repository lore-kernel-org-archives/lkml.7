Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC696C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F6D21951
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731510AbfGVVuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 17:50:14 -0400
Received: from smtprelay0177.hostedemail.com ([216.40.44.177]:54912 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728303AbfGVVuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 17:50:13 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id C6E5F181D3377;
        Mon, 22 Jul 2019 21:50:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: net82_1eb9f15d55954
X-Filterd-Recvd-Size: 1676
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Mon, 22 Jul 2019 21:50:11 +0000 (UTC)
Message-ID: <d96cf801c5cf68e785e8dfd9dba0994fcff20017.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Added warnings in favor of strscpy().
From:   Joe Perches <joe@perches.com>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Nitin Gote <nitin.r.gote@intel.com>, jannh@google.com,
        kernel-hardening@lists.openwall.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Date:   Mon, 22 Jul 2019 14:50:09 -0700
In-Reply-To: <20190722230102.442137dc@heffalump.sk2.org>
References: <1561722948-28289-1-git-send-email-nitin.r.gote@intel.com>
         <20190629181537.7d524f7d@sk2.org> <201907021024.D1C8E7B2D@keescook>
         <20190706144204.15652de7@heffalump.sk2.org>
         <201907221047.4895D35B30@keescook>
         <15f2be3cde69321f4f3a48d60645b303d66a600b.camel@perches.com>
         <20190722230102.442137dc@heffalump.sk2.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-07-22 at 23:01 +0200, Stephen Kitt wrote:
> How about you submit your current patch set, and I follow up with the above
> adapted to stracpy?

OK, I will shortly after I figure out how to add kernel-doc
for stracpy/stracpy_pad to lib/string.c.

It doesn't seem appropriate to add the kernel-doc to string.h
as it would be separated from the others in string.c

Anyone got a clue here?  Jonathan?



