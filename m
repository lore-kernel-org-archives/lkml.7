Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EA5C10F06
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 10:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D79D206DD
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 10:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfCaKNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 06:13:05 -0400
Received: from ozlabs.org ([203.11.71.1]:52373 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbfCaKNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 06:13:04 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 44XBB65zQyz9sRW; Sun, 31 Mar 2019 21:13:02 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: ce9afe08e71e3f7d64f337a6e932e50849230fc2
X-Patchwork-Hint: ignore
In-Reply-To: <1552059204-18626-1-git-send-email-ego@linux.vnet.ibm.com>
To:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Michael Bringmann <mwb@linux.vnet.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     "Pavithra R. Prakash" <pavrampu@in.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: Re: pseries/energy: Use OF accessor functions to read ibm, drc-indexes
Message-Id: <44XBB65zQyz9sRW@ozlabs.org>
Date:   Sun, 31 Mar 2019 21:13:02 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-03-08 at 15:33:24 UTC, "Gautham R. Shenoy" wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> In cpu_to_drc_index() in the case when FW_FEATURE_DRC_INFO is absent,
> we currently use of_read_property() to obtain the pointer to the array
> corresponding to the property "ibm,drc-indexes". The elements of this
> array are of type __be32, but are accessed without any conversion to
> the OS-endianness, which is buggy on a Little Endian OS.
> 
> Fix this by using of_property_read_u32_index() accessor function to
> safely read the elements of the array.
> 
> Fixes: commit e83636ac3334 ("pseries/drc-info: Search DRC properties for CPU indexes")
> Cc: <stable@vger.kernel.org> #v4.16+
> Reported-by: Pavithra R. Prakash <pavrampu@in.ibm.com>
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> Reviewed-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/ce9afe08e71e3f7d64f337a6e932e508

cheers
