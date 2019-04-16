Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1482AC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF63920821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730280AbfDPT7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 15:59:25 -0400
Received: from ms.lwn.net ([45.79.88.28]:40246 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728032AbfDPT7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 15:59:25 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id BB011537;
        Tue, 16 Apr 2019 19:59:24 +0000 (UTC)
Date:   Tue, 16 Apr 2019 13:59:23 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     shuah <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc: kselftest: Fix KBUILD_OUTPUT usage instructions
Message-ID: <20190416135923.4e9d32e4@lwn.net>
In-Reply-To: <90615fb4-ff56-af72-f4ea-f3dbc3db26df@kernel.org>
References: <20190416142651.7048-1-shuah@kernel.org>
        <20190416092610.78b462de@lwn.net>
        <90615fb4-ff56-af72-f4ea-f3dbc3db26df@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2019 09:50:16 -0600
shuah <shuah@kernel.org> wrote:

> >> +Build and run from KBUILD_OUTPUT directory (make KBUILD_OUTPUT=)::
> >>   
> >> -  $ make KBUILD_OUTPUT=/tmp/kselftest kselftest
> >> +  $ export KBUILD_OUTPUT=/tmp/kselftest; make kselftest  
> > 
> > Is there a particular reason why this variable needs to be set in the
> > environment rather than just in make?  More importantly, though, I don't
> > think this would work if you run it from the KBUILD_OUTPUT directory.  What
> > you're really doing is running with a separate output directory, right?
> >   
> 
> That is correct. I am matching the instructions in the main Makefile:
> 
> # kbuild supports saving output files in a separate directory.

So my concern was right, then: this is not a way to "run from the
KBUILD_OUTPUT" directory; that seems certain to confuse people.  I'll
apply the patch so that the commands are right, but that could maybe use
some tweaking.

Thanks,

jon
