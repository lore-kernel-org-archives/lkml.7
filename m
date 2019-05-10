Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546F2C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 17:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26502217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 17:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ChcGxHz1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfEJRlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 13:41:52 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60864 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727488AbfEJRlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 13:41:52 -0400
Received: from zn.tnic (p200300EC2F0F4000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:4000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 72FF21EC09A3;
        Fri, 10 May 2019 19:41:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1557510111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=woBta16CIlbP3jCTjLLZyi/UgLJeGjPQxBvByWnfnQQ=;
        b=ChcGxHz1mrje4YpxM4LjkKgIYuUb94lpj7SpJUBVWCchvxaFgy5t1XqHYhyDEfLKi2nTNN
        0CW5gmdqsQ1Wmlhm0puOrAJlmKmAXUCGabNMvb7N5GWw1D3W2UkYjaJnJ+HG+0l6EhXodQ
        /bNBuKfgezcbSE9pA/eUYjVmm8VSy/E=
Date:   Fri, 10 May 2019 19:41:46 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Xiaochen Shen <xiaochen.shen@intel.com>,
        Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 02/13] selftests/resctrl: Add basic resctrl file
 system operations and data
Message-ID: <20190510174146.GD29927@zn.tnic>
References: <1549767042-95827-1-git-send-email-fenghua.yu@intel.com>
 <1549767042-95827-3-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1549767042-95827-3-git-send-email-fenghua.yu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 09, 2019 at 06:50:31PM -0800, Fenghua Yu wrote:
> From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
> 
> The basic resctrl file system operations and data are added for future
> usage by resctrl selftest tool.
> 
> Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
> Signed-off-by: Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>

And while feedback from Andre is being addressed, you those SOB chains
need to be fixed.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
