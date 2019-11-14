Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97A9C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 09:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 903B5206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 09:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfKNJIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 04:08:31 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:59753 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727281AbfKNJI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 04:08:27 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47DFyH4L62z9sPT; Thu, 14 Nov 2019 20:08:23 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 1a8916ee3ac29054322cdac687d36e1b5894d272
In-Reply-To: <46b003b9-3225-6bf7-9101-ed6580bb748c@linux.ibm.com>
To:     Eric Richter <erichte@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>, linuxppc-dev@ozlabs.org,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Nayna Jain <nayna@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>, Jeremy Kerr <jk@ozlabs.org>,
        Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [PATCH v10a 1/9] powerpc: detect the secure boot mode of the system
Message-Id: <47DFyH4L62z9sPT@ozlabs.org>
Date:   Thu, 14 Nov 2019 20:08:23 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-11-05 at 23:00:22 UTC, Eric Richter wrote:
> From: Nayna Jain <nayna@linux.ibm.com>
> 
> This patch defines a function to detect the secure boot state of a
> PowerNV system.
> 
> The PPC_SECURE_BOOT config represents the base enablement of secure boot
> for powerpc.
> 
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> Signed-off-by: Eric Richter <erichte@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1a8916ee3ac29054322cdac687d36e1b5894d272

cheers
