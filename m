Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD469C433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 09:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 800E9208C3
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 09:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfHJJJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 05:09:08 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:41771 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbfHJJJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 05:09:08 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 465GWN1PVZz9sN6;
        Sat, 10 Aug 2019 19:09:04 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     christophe.leroy@c-s.fr, segher@kernel.crashing.org, arnd@arndb.de,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        kbuild test robot <lkp@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v3] Revert "powerpc: slightly improve cache helpers"
In-Reply-To: <20190809220348.127314-1-ndesaulniers@google.com>
References: <20190809220301.Horde.AR6y4Bx4WGIq58V9K0En9g4@messagerie.si.c-s.fr> <20190809220348.127314-1-ndesaulniers@google.com>
Date:   Sat, 10 Aug 2019 19:09:02 +1000
Message-ID: <87o90xs7yp.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Desaulniers <ndesaulniers@google.com> writes:
> This reverts commit 6c5875843b87c3adea2beade9d1b8b3d4523900a.
>
> Work around Clang bug preventing ppc32 from booting.
>
> Link: https://bugs.llvm.org/show_bug.cgi?id=42762
> Link: https://github.com/ClangBuiltLinux/linux/issues/593
> Debugged-by: Nathan Chancellor <natechancellor@gmail.com>
> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> Reported-by: kbuild test robot <lkp@intel.com>
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> Changes V2 -> V3:
> * Just revert, as per Christophe.
> Changes V1 -> V2:
> * Change to ouput paremeter.

Thanks. I actually already had this revert in my tree since ~10 days
ago, but hadn't pushed it yet because the discussion was ongoing.

So I'll just use that version, and ask Linus to pull it.

cheers
