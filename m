Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B936C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDB482183F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="F0029qvp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388282AbfDRI31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 04:29:27 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35290 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728074AbfDRI30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 04:29:26 -0400
Received: from zn.tnic (p200300EC2F112E00DC490119D3A149FB.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:2e00:dc49:119:d3a1:49fb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 359911EC09A0;
        Thu, 18 Apr 2019 10:29:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555576165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=POqX4Q5FgqQNgEngCcbvbvUDVv+RO+wNFujoXWoSaQU=;
        b=F0029qvpiotoVbNvRMuxD+T5gU/jc2hWHg20Ku72SCRwauu2NcMTgWJyIXtWP9hfbVuLgR
        Xva98GYx5wwk0rnTOWrwAriYySGPM/upXnj6NLYTXV7QTlYfXCXiYOkMjKshEcGB9+JgKZ
        lp4ooEO+qWCwAaPU21GpWxCWOqC+/f0=
Date:   Thu, 18 Apr 2019 10:29:19 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Xiaochen Shen <xiaochen.shen@intel.com>
Cc:     tony.luck@intel.com, x86@kernel.org, mingo@redhat.com,
        reinette.chatre@intel.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        fenghua.yu@intel.com, linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/cache] x86/resctrl: Initialize a new resource group
 with default MBA values
Message-ID: <20190418082919.GC27160@zn.tnic>
References: <1555499329-1170-3-git-send-email-xiaochen.shen@intel.com>
 <tip-47820e73f5b3a1fdb8ebd1219191edc96e0c85c1@git.kernel.org>
 <0ab6a79f-d1ae-1c99-1447-722f18405309@intel.com>
 <20190418072845.GA27160@zn.tnic>
 <27c69929-58ee-0a96-0953-e7cfa8976e78@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <27c69929-58ee-0a96-0953-e7cfa8976e78@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 04:20:57PM +0800, Xiaochen Shen wrote:
> Should I submit a separate fixing patch for __init_one_rdt_domain()?

You don't have to send a separate patch just for removing an excessive
newline. Simply next time someone is touching the code around there,
that newline can be removed too.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
