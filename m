Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D07C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 09:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE3F2071B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 09:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfKNJHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 04:07:55 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:60617 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726786AbfKNJHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 04:07:52 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47DFxf2Pscz9s7T; Thu, 14 Nov 2019 20:07:49 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 39a963b457b5c6cbbdc70441c9d496e39d151582
In-Reply-To: <1569973038-2710-1-git-send-email-nayna@linux.ibm.com>
To:     Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@ozlabs.org,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Ricther <erichte@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Matthew Garret <matthew.garret@nebula.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Mackerras <paulus@samba.org>, Jeremy Kerr <jk@ozlabs.org>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        George Wilson <gcwilson@linux.ibm.com>
Subject: Re: [PATCH] sysfs: Fixes __BIN_ATTR_WO() macro
Message-Id: <47DFxf2Pscz9s7T@ozlabs.org>
Date:   Thu, 14 Nov 2019 20:07:49 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-10-01 at 23:37:18 UTC, Nayna Jain wrote:
> This patch fixes the size and write parameter for the macro
> __BIN_ATTR_WO().
> 
> Fixes: 7f905761e15a8 ("sysfs: add BIN_ATTR_WO() macro")
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/39a963b457b5c6cbbdc70441c9d496e39d151582

cheers
