Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2987C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 971B9206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="GhwVO3GD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfC1NDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 09:03:17 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53096 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbfC1NDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 09:03:17 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0F7131EC0943;
        Thu, 28 Mar 2019 14:03:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553778196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qbv9AHGYcfJ1x+KFg0pur/Cu2rhy6nYViDKJcMNfbsM=;
        b=GhwVO3GD3MudLAFRqZjV6jbSH5J+2yap4aT8Ft1/+J7y3BdmcugyIV2yNQfY93ib3hsP0w
        3oZ4szXZMx2XMWYiezGeMzYm8ltD4BuBQ7WgPDVDCiVLOZNt11ljGXmVYfWE//hLic7dEt
        UR3YUJsm1avAjCsfe6+bykM4A9UvqSk=
Date:   Thu, 28 Mar 2019 14:03:17 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] x86/boot: Support nocfg parameter for earlyprintk
Message-ID: <20190328130317.GG22720@zn.tnic>
References: <20190319184325.72807-1-andriy.shevchenko@linux.intel.com>
 <20190319184325.72807-8-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190319184325.72807-8-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 09:43:25PM +0300, Andy Shevchenko wrote:
> If by BIOS or by other means the serial port is configured
> user might want to skip reconfiguration in the boot code.

That needs more explanation: how can that happen? How is the user
supposed to know whether the serial port is configured in order to use
this cmdline param?

Why can't the kernel detect whether the serial port is configured and
not touch that configuration?

A lot of why's and head scratching...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
