Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF36BC31E50
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 13:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA9272080A
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 13:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfFONgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 09:36:04 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:60713 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbfFONgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 09:36:04 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 45Qz5G0cJmz9sNC; Sat, 15 Jun 2019 23:36:01 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 2305ff225c0b1691ec2e93f3d6990e13a2e63c95
X-Patchwork-Hint: ignore
In-Reply-To: <20190604111632.22479-1-yamada.masahiro@socionext.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] ocxl: do not use C++ style comments in uapi header
Message-Id: <45Qz5G0cJmz9sNC@ozlabs.org>
Date:   Sat, 15 Jun 2019 23:36:01 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-06-04 at 11:16:32 UTC, Masahiro Yamada wrote:
> Linux kernel tolerates C++ style comments these days. Actually, the
> SPDX License tags for .c files start with //.
> 
> On the other hand, uapi headers are written in more strict C, where
> the C++ comment style is forbidden.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>
> Acked-by: Andrew Donnellan <ajd@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/2305ff225c0b1691ec2e93f3d6990e13

cheers
