Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D54FC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A51A206A5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393085AbfIFOna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 10:43:30 -0400
Received: from ms.lwn.net ([45.79.88.28]:36586 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732020AbfIFOna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 10:43:30 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 436F997D;
        Fri,  6 Sep 2019 14:43:29 +0000 (UTC)
Date:   Fri, 6 Sep 2019 08:43:28 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: sysrq: don't recommend 'S' 'U' before
 'B'
Message-ID: <20190906084328.6c052d25@lwn.net>
In-Reply-To: <20190903160840.56652-1-kilobyte@angband.pl>
References: <20190903160840.56652-1-kilobyte@angband.pl>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  3 Sep 2019 18:08:40 +0200
Adam Borowski <kilobyte@angband.pl> wrote:

> This advice is obsolete and slightly harmful for filesystems from this
> millenium: any modern filesystem can handle unexpected crashes without
> requiring fsck -- and on the other hand, trying to write to the disk when
> the kernel is in a bad state risks introducing corruption.
> 
> For ext2, any unsafe shutdown meant widespread breakage, but it's no longer
> a reasonable filesystem for any non-special use.
> 
> Signed-off-by: Adam Borowski <kilobyte@angband.pl>

Makes sense to me.  Applied, thanks.

jon
