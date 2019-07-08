Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76085C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 01:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5486B204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 01:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbfGHBUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 21:20:22 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:37177 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727946AbfGHBTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 21:19:31 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 45hnfn6gBsz9sNf; Mon,  8 Jul 2019 11:19:29 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 2200bbec12c428d7b276fb450e5755cdfe435ae5
In-Reply-To: <5c04f72569b508cd5477fa1bf15f0166d376cd3a.1555427420.git.nishadkamdar@gmail.com>
To:     Nishad Kamdar <nishadkamdar@gmail.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        Uwe =?utf-8?q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Joe Perches <joe@perches.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 3/5] powerpc: Use the correct style for SPDX License Identifier
Message-Id: <45hnfn6gBsz9sNf@ozlabs.org>
Date:   Mon,  8 Jul 2019 11:19:29 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-04-16 at 15:28:57 UTC, Nishad Kamdar wrote:
> This patch corrects the SPDX License Identifier style
> in the powerpc Hardware Architecture related files.
> 
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/2200bbec12c428d7b276fb450e5755cdfe435ae5

cheers
