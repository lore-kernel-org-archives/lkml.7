Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E197FC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8E9D20665
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404990AbfGXUNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:13:30 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:51162 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404887AbfGXUNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 16:13:25 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 85A5B15431990;
        Wed, 24 Jul 2019 13:13:24 -0700 (PDT)
Date:   Wed, 24 Jul 2019 13:13:24 -0700 (PDT)
Message-Id: <20190724.131324.1545677795217357026.davem@davemloft.net>
To:     matorola@gmail.com
Cc:     ldv@altlinux.org, hch@lst.de, khalid.aziz@oracle.com,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        sparclinux@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/16] sparc64: use the generic get_user_pages_fast code
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CADxRZqx-jEnm4U8oe=tJf5apbvcMuw5OYZUN8h4G68sXFvDsmQ@mail.gmail.com>
References: <20190717215956.GA30369@altlinux.org>
        <20190718.141405.1070121094691581998.davem@davemloft.net>
        <CADxRZqx-jEnm4U8oe=tJf5apbvcMuw5OYZUN8h4G68sXFvDsmQ@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 24 Jul 2019 13:13:24 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anatoly Pugachev <matorola@gmail.com>
Date: Wed, 24 Jul 2019 22:32:17 +0300

> the first test where it was discovered was done on my test LDOM named
> ttip, hardware (hypervisor) is T5-2 server, running under Solaris 11.4
> OS.
> ttip LDOM is debian sparc64 unstable , so with almost all the latest
> software (gcc 8.3.0, binutils 2.32.51.20190707-1, debian GLIBC
> 2.28-10, etc..)
> 
> For another test, i also installed LDOM with oracle sparc linux
> https://oss.oracle.com/projects/linux-sparc/ , but I've to install a
> more fresh version of gcc on it first, since system installed gcc 4.4
> is too old for a git kernel (linux-2.6/Documentation/Changes lists gcc
> 4.6 as a minimal version), so I choose to install gcc-7.4.0 to /opt/
> (leaving system installed gcc 4.4 under /usr/bin). Compiled and
> installed git kernel version, i.e. last tag 5.3.0-rc1 and ran the
> test. Kernel still produced oops.

I suspect, therefore, that we have a miscompile.

Please put your unstripped vmlinux image somewhere so I can take a closer
look.

Thank you.
