Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D59C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 09:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F270206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 09:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfKNJJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 04:09:29 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:34023 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbfKNJHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 04:07:48 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47DFxZ3TnGz9sPV; Thu, 14 Nov 2019 20:07:46 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: bbbd7f112c7b0af32f7b3c725b2c41e93cf181f6
In-Reply-To: <20190828060737.32531-1-thuth@redhat.com>
To:     Thomas Huth <thuth@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Sam Bobroff <sbobroff@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] powerpc: Replace GPL boilerplate with SPDX identifiers
Message-Id: <47DFxZ3TnGz9sPV@ozlabs.org>
Date:   Thu, 14 Nov 2019 20:07:46 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-08-28 at 06:07:37 UTC, Thomas Huth wrote:
> The FSF does not reside in "675 Mass Ave, Cambridge" anymore...
> let's simply use proper SPDX identifiers instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/bbbd7f112c7b0af32f7b3c725b2c41e93cf181f6

cheers
