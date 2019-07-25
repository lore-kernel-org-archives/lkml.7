Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04643C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 21:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A0322BF5
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 21:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfGYVet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 17:34:49 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:37064 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfGYVes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 17:34:48 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id B223E80348;
        Thu, 25 Jul 2019 23:34:45 +0200 (CEST)
Date:   Thu, 25 Jul 2019 23:34:44 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: .h.s files spam
Message-ID: <20190725213444.GA19265@ravnborg.org>
References: <20190725195633.GA15202@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725195633.GA15202@avx2>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10
        a=E8ANUszqdy4T9cFckbYA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexey

On Thu, Jul 25, 2019 at 10:56:33PM +0300, Alexey Dobriyan wrote:
> What are these files for?
> 
> 	$ cat ../obj/include/linux/kernel.h.s
>         .file   "null"
>         .text
>         .ident  "GCC: (Gentoo 9.1.0-r1 p1.1) 9.1.0"
>         .section        .note.GNU-stack,"",@progbits
> 
> 	$ find ../obj/ -type f -name '*.s' | wc -l
> 	4047
> 
> It is "allyesconfig" in case someone is going to reproduce it.

The files are created by the new headers-test-y stuff.
We now verify that a big part of the header files in include/*
are self-contained. (They include all their dependencies).
The header-test-y support is also enabled for the rest of the kernel,
but used only in very few places outside include/* as of today.

	Sam
