Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16356C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 23:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA9232072E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 23:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbgAFXdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 18:33:20 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:47531 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726599AbgAFXdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 18:33:19 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47sBdn5hHgz9sRG; Tue,  7 Jan 2020 10:33:17 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: c3aae14e5d468d18dbb5d7c0c8c7e2968cc14aad
In-Reply-To: <20191209200338.12546-1-natechancellor@gmail.com>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/44x: Adjust indentation in ibm4xx_denali_fixup_memsize
Message-Id: <47sBdn5hHgz9sRG@ozlabs.org>
Date:   Tue,  7 Jan 2020 10:33:17 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-12-09 at 20:03:38 UTC, Nathan Chancellor wrote:
> Clang warns:
> 
> ../arch/powerpc/boot/4xx.c:231:3: warning: misleading indentation;
> statement is not part of the previous 'else' [-Wmisleading-indentation]
>         val = SDRAM0_READ(DDR0_42);
>         ^
> ../arch/powerpc/boot/4xx.c:227:2: note: previous statement is here
>         else
>         ^
> 
> This is because there is a space at the beginning of this line; remove
> it so that the indentation is consistent according to the Linux kernel
> coding style and clang no longer warns.
> 
> Fixes: d23f5099297c ("[POWERPC] 4xx: Adds decoding of 440SPE memory size to boot wrapper library")
> Link: https://github.com/ClangBuiltLinux/linux/issues/780
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c3aae14e5d468d18dbb5d7c0c8c7e2968cc14aad

cheers
