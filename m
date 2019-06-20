Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA3AC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 20:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E090020652
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 20:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfFTUQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 16:16:35 -0400
Received: from ms.lwn.net ([45.79.88.28]:47676 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbfFTUQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 16:16:35 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 89F71536;
        Thu, 20 Jun 2019 20:16:34 +0000 (UTC)
Date:   Thu, 20 Jun 2019 14:16:33 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     James Morse <james.morse@arm.com>
Cc:     linux-doc@vger.kernel.org, x86@kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Babu Moger <Babu.Moger@amd.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Documentation: x86: resctrl_ui.txt fixes and
 clarification
Message-ID: <20190620141633.74b09dcf@lwn.net>
In-Reply-To: <20190607151409.15476-1-james.morse@arm.com>
References: <20190607151409.15476-1-james.morse@arm.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  7 Jun 2019 16:14:05 +0100
James Morse <james.morse@arm.com> wrote:

> While updating resctrl_ui.rst for arm64 support these things stuck
> out as being unclear or no longer true.
> 
> (I've shortened the CC list to just RDT+Documentation)
> 
> 
> Thanks,
> 
> James Morse (4):
>   Documentation: x86: Contiguous cbm isn't all X86
>   Documentation: x86: Remove cdpl2 unspported statement and fix
>     capitalisation
>   Documentation: x86: Clarify MBA takes MB as referring to mba_sc
>   Documentation: x86: fix some typos
> 
>  Documentation/x86/resctrl_ui.rst | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)

I've applied this set, sorry for the delay.

Thanks,

jon
