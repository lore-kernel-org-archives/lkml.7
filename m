Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195D0C3A5A8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 03:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7D3F21874
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 03:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbfIBD3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 23:29:41 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:57283 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728926AbfIBD3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 23:29:39 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 46MFv46j2Qz9sPJ; Mon,  2 Sep 2019 13:29:36 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: f7a0bf7d904e902e13024986b7b357181ee30849
In-Reply-To: <d644eaf7dff8cc149260066802af230bdf34fded.1566834712.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] powerpc/32s: add an option to exclusively select powerpc 601
Message-Id: <46MFv46j2Qz9sPJ@ozlabs.org>
Date:   Mon,  2 Sep 2019 13:29:36 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-08-26 at 15:52:13 UTC, Christophe Leroy wrote:
> Powerpc 601 is rather old powerpc which as some important
> limitations compared to other book3s/32 powerpcs:
> - No Timebase.
> - Common BATs for instruction and data.
> - No execution protection in segment registers.
> - No RI bit in MSR
> - ...
> 
> It is starting to be difficult and cumbersome to maintain
> kernels that are compatible both with 601 and other 6xx cores.
> 
> Create a compiletime option to exclusively select either powerpc 601
> or other 6xx.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f7a0bf7d904e902e13024986b7b357181ee30849

cheers
