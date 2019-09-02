Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0F7C3A5A7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 03:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB02217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 03:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbfIBDGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 23:06:19 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:41187 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729061AbfIBDGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 23:06:18 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 46MFN82G7vz9sDB; Mon,  2 Sep 2019 13:06:16 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 70ed86f4de5bd74dd2d884dcd2f3275c4cfe665f
In-Reply-To: <20190829155021.2915-2-maxiwell@linux.ibm.com>
To:     "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>,
        linuxppc-dev@ozlabs.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linux-arch@vger.kernel.org, andmike@linux.ibm.com,
        linuxram@us.ibm.com, linux-kernel@vger.kernel.org,
        kvm-ppc@vger.kernel.org, cclaudio@linux.ibm.com,
        "Maxiwell S . Garcia" <maxiwell@linux.ibm.com>,
        bauerman@linux.ibm.com
Subject: Re: [PATCH v2 1/2] powerpc: Add PowerPC Capabilities ELF note
Message-Id: <46MFN82G7vz9sDB@ozlabs.org>
Date:   Mon,  2 Sep 2019 13:06:16 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-29 at 15:50:20 UTC, "Maxiwell S. Garcia" wrote:
> From: Claudio Carvalho <cclaudio@linux.ibm.com>
> 
> Add the PowerPC name and the PPC_ELFNOTE_CAPABILITIES type in the
> kernel binary ELF note. This type is a bitmap that can be used to
> advertise kernel capabilities to userland.
> 
> This patch also defines PPCCAP_ULTRAVISOR_BIT as being the bit zero.
> 
> Suggested-by: Paul Mackerras <paulus@ozlabs.org>
> Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>
> [ maxiwell: Define the 'PowerPC' type in the elfnote.h ]
> Signed-off-by: Maxiwell S. Garcia <maxiwell@linux.ibm.com>

Series applied to powerpc topic/ppc-kvm, thanks.

https://git.kernel.org/powerpc/c/70ed86f4de5bd74dd2d884dcd2f3275c4cfe665f

cheers
