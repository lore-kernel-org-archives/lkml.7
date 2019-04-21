Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6E5C282E4
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 14:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E3E2086A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 14:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbfDUOS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 10:18:59 -0400
Received: from ozlabs.org ([203.11.71.1]:55747 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbfDUOS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 10:18:57 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 44nBf73PQyz9s8m; Mon, 22 Apr 2019 00:18:55 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 6917735e8f905da1f62ccdf62830b185524835c7
X-Patchwork-Hint: ignore
In-Reply-To: <1553345455-32085-1-git-send-email-jagdsh.linux@gmail.com>
To:     jagdsh.linux@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
        npiggin@gmail.com, hristophe.leroy@c-s.fr, arnd@arndb.de,
        anton@ozlabs.org, paul.burton@mips.com, mikey@neuling.org,
        akpm@linux-foundation.org, mwb@linux.vnet.ibm.com
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Jagadeesh Pagadala <jagdsh.linux@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: arch/powerpc: Remove duplicate headers
Message-Id: <44nBf73PQyz9s8m@ozlabs.org>
Date:   Mon, 22 Apr 2019 00:18:55 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-03-23 at 12:50:55 UTC, jagdsh.linux@gmail.com wrote:
> From: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
> 
> Remove duplicate headers which are included twice.
> 
> Signed-off-by: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6917735e8f905da1f62ccdf62830b185

cheers
