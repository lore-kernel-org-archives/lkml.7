Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264A8C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1CB7204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564516374;
	bh=LZj1ssxbF1pck2U3C4HP9VBYGp7wAm7xUWTbZydbfBQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=GjjFC9ndYuL+FtAwrLM9Zn9KL71atjtRyjZtldNuHl/Yy9McIPEpD70tHlgQcmGeq
	 gCk9pGqXlnleC53O7KsFL85hDC9qFtSLmlgEtUvkRr1dlkvJPqKxKDHLWZ4/jdbEVB
	 vcfBjGZrgu2bBVv+7rsUcEck4G4KsMgwD/crzBA0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfG3Tww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 15:52:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46994 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725209AbfG3Tww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 15:52:52 -0400
Received: from X1 (unknown [76.191.170.112])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 715943332;
        Tue, 30 Jul 2019 19:52:51 +0000 (UTC)
Date:   Tue, 30 Jul 2019 12:52:49 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] linux/coff.h: add include guard
Message-Id: <20190730125249.b899526e44608371fb11e03c@linux-foundation.org>
In-Reply-To: <20190728154728.11126-1-yamada.masahiro@socionext.com>
References: <20190728154728.11126-1-yamada.masahiro@socionext.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jul 2019 00:47:28 +0900 Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> Add a header include guard just in case.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Looks like this file is unused at least in the kernel tree,
> but I am not it is OK to delete it.

arch/alpha/boot/tools/objstrip.c includes it but I don't think it's
actually needed.  Yes, it would be nice to kill coff.h.


