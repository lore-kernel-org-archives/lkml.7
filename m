Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F67BC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 03:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F24422DD6
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 03:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbfIBD3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 23:29:51 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:32949 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729278AbfIBD3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 23:29:37 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 46MFv35H4Gz9sNf; Mon,  2 Sep 2019 13:29:35 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: a04565741284f695db4cfe5a3e61940d2259cb8f
In-Reply-To: <b095e12c82fcba1ac4c09fc3b85d969f36614746.1566417610.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/8xx: drop unused self-modifying code alternative to FixupDAR.
Message-Id: <46MFv35H4Gz9sNf@ozlabs.org>
Date:   Mon,  2 Sep 2019 13:29:35 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-08-21 at 20:00:34 UTC, Christophe Leroy wrote:
> The code which fixups the DAR on TLB errors for dbcX instructions
> has a self-modifying code alternative that has never been used.
> 
> Drop it.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a04565741284f695db4cfe5a3e61940d2259cb8f

cheers
