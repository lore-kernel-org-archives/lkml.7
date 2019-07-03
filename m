Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA5BC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF9E21850
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfGCO1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:27:02 -0400
Received: from ozlabs.org ([203.11.71.1]:52459 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbfGCO1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:27:02 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 45f3Mn0SQ5z9s4V; Thu,  4 Jul 2019 00:27:00 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: f079bb3c5f2978b2c1a13098ab2a8c32e5d1ee3d
In-Reply-To: <4464516c0b6835b42acc65e088b6d7f88fe886f2.1557235811.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/ftrace: Enable C Version of recordmcount
Message-Id: <45f3Mn0SQ5z9s4V@ozlabs.org>
Date:   Thu,  4 Jul 2019 00:27:00 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-05-07 at 13:31:38 UTC, Christophe Leroy wrote:
> Selects HAVE_C_RECORDMCOUNT to use the C version of the recordmcount
> intead of the old Perl Version of recordmcount.
> 
> This should improve build time. It also seems like the old Perl Version
> misses some calls to _mcount that the C version finds.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f079bb3c5f2978b2c1a13098ab2a8c32e5d1ee3d

cheers
