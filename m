Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17114C2D0D1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF7D2146E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfLSRA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 12:00:28 -0500
Received: from ms.lwn.net ([45.79.88.28]:37334 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbfLSRA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 12:00:27 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id F41BF2E5;
        Thu, 19 Dec 2019 17:00:26 +0000 (UTC)
Date:   Thu, 19 Dec 2019 10:00:25 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
Cc:     hirofumi@mail.parknet.co.jp, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] Documentation: filesystems: convert vfat.txt to RST
Message-ID: <20191219100025.255003e6@lwn.net>
In-Reply-To: <20191121130605.29074-1-dwlsalmeida@gmail.com>
References: <20191121130605.29074-1-dwlsalmeida@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Nov 2019 10:06:05 -0300
"Daniel W. S. Almeida" <dwlsalmeida@gmail.com> wrote:

> From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
> 
> Converts vfat.txt to the reStructuredText format, improving presentation
> without changing the underlying content.
> 
> Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
> -----------------------------------------------------------
> Changes in v2:
> Refactored long lines as pointed out by Jonathan
> Copied the maintainer
> Updated the reference in the MAINTAINERS file for vfat
> 
> I did not move this into admin-guide, waiting on what the 
> maintainer has to say about this and also about old sections
> in the text, if any.

This one, too, could user a bit less markup, and more consistent markup.
If you have to mark up literal text, for example, it should be ``literal``,
not *emphasis*.  But please think about whether it needs marking up at all.

I have one other thing here, that could use input from the vfat maintainer:

[...]

> +BUG REPORTS
> +===========
> +If you have trouble with the *VFAT* filesystem, mail bug reports to
> +chaffee@bmrc.cs.berkeley.edu.
> +
> +Please specify the filename and the operation that gave you trouble.
> +
> +TEST SUITE
> +==========
> +If you plan to make any modifications to the vfat filesystem, please
> +get the test suite that comes with the vfat distribution at
> +
> +`<http://web.archive.org/web/*/http://bmrc.berkeley.edu/people/chaffee/vfat.html>`_
> +
> +This tests quite a few parts of the vfat filesystem and additional
> +tests for new features or untested features would be appreciated.

What are the chances that the above email address works at all, especially
given that the associated web page has to be dug out of the wayback
machine?  We should really try to avoid perpetuating obviously wrong
information when we can.  Hirofumi, do you have any thoughts on what might
replace this section?

Thanks,

jon
