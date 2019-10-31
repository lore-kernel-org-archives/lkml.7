Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914F3CA9EC7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 01:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5899220874
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 01:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572486791;
	bh=URBSmu6OiJ+FEUgwhQ/RHgs7YGynWuZQ6yJNH/NdOYo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=s/7gWeuxpIixgJ2F5v51BB8G8lEhiR+VGHfjyyAK3vZCS4nPgAPry5Ky6VHL7fzQd
	 Q27CxOyV8qrDBzZP4Z5Vm9qDHO8RDlXdD0uBrt42WLb5SM8cSb5LS6zaBpRVy+8r8s
	 0HBUlLh8hkXFmpvcvHk39X9RfsYQwu9IwIf0t9p8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfJaBxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 21:53:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:56466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbfJaBxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 21:53:10 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D3602080F;
        Thu, 31 Oct 2019 01:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572486787;
        bh=URBSmu6OiJ+FEUgwhQ/RHgs7YGynWuZQ6yJNH/NdOYo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iGKfW31d7qGcARhBSAzQxOBLQn/dCL82lvBprLnWzX5XoAwPnoF2RrQ1HG2Bu6meu
         +34QEr984x+fQw75FaA/ijzSXqwVHQ8Sei9CzsTHjH/tQHOb1GcR6oXscfByuZ9Ksj
         jQ/Hm/HTZ9CLc++H+jpMq2wBLrUC3z6tg8Wr9fPw=
Date:   Wed, 30 Oct 2019 18:53:06 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 1/3] arch: ipcbuf.h: make uapi asm/ipcbuf.h
 self-contained
Message-Id: <20191030185306.a75acc68ed2b911970ccd4b8@linux-foundation.org>
In-Reply-To: <CAK7LNASrZpJ0J7N_YvSza2QQ_cQQ+Z04Cf5-Or4ivKMb9UVuMQ@mail.gmail.com>
References: <20191030063855.9989-1-yamada.masahiro@socionext.com>
        <CAK7LNASrZpJ0J7N_YvSza2QQ_cQQ+Z04Cf5-Or4ivKMb9UVuMQ@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2019 10:33:00 +0900 Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> Hi Andrew,
> 
> I think this patch has already been picked up to your tree,
> but I noticed a typo in the commit message just now.
> Please see below.
> 
> ...
>
> > Include <asm/posix_types.h> to make it self-contained, and add it to
> 
> Include <linux/posix_type.h> to make ...
> 
> Could you please fix it up locally?

No probs, done.
