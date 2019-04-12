Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D13C10F13
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 03:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4129C2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 03:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfDLDCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 23:02:44 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:49041 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfDLDCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 23:02:43 -0400
X-Originating-IP: 50.39.168.148
Received: from localhost (50-39-168-148.bvtn.or.frontiernet.net [50.39.168.148])
        (Authenticated sender: josh@joshtriplett.org)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id B9EB4E0004;
        Fri, 12 Apr 2019 03:02:40 +0000 (UTC)
Date:   Thu, 11 Apr 2019 20:02:38 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     linux-kernel@vger.kernel.org, keescook@chromium.org
Subject: Re: [PATCH v4 0/5] init: Do not select DEBUG_KERNEL by default
Message-ID: <20190412030237.GB1577@localhost>
References: <20190412014355.25307-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190412014355.25307-1-okaya@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 01:43:50AM +0000, Sinan Kaya wrote:
> CONFIG_DEBUG_KERNEL has been designed to just enable Kconfig options.
> Kernel code generatoin should not depend on CONFIG_DEBUG_KERNEL.
> 
> Proposed alternative plan: let's add a new symbol, something like
> DEBUG_MISC ("Miscellaneous debug code that should be under a more
> specific debug option but isn't"), make it depend on DEBUG_KERNEL and be
> "default DEBUG_KERNEL" but allow itself to be turned off, and then
> mechanically change the small handful of "#ifdef CONFIG_DEBUG_KERNEL" to
> "#ifdef CONFIG_DEBUG_MISC".
> 
> Sinan Kaya (5):
>   init: Introduce DEBUG_MISC option
>   powerpc: Replace CONFIG_DEBUG_KERNEL with CONFIG_DEBUG_MISC
>   mips: Replace CONFIG_DEBUG_KERNEL with CONFIG_DEBUG_MISC
>   xtensa: Replace CONFIG_DEBUG_KERNEL with CONFIG_DEBUG_MISC
>   net: Replace CONFIG_DEBUG_KERNEL with CONFIG_DEBUG_MISC

I noticed one minor typo in patch 1/5, with that fixed, for the whole
series:

Reviewed-by: Josh Triplett <josh@joshtriplett.org>
