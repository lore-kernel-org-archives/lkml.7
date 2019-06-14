Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AE6C31E4D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02DE22183E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="DqI2VOou"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfFNRwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 13:52:05 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56698 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbfFNRwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:52:04 -0400
Received: from zn.tnic (p200300EC2F097F008D9D08C27DC27982.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:7f00:8d9d:8c2:7dc2:7982])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DF1021EC0B6E;
        Fri, 14 Jun 2019 19:52:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560534723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ZhNpbjZ/sBf+ed16pzSV5IxgxQnNnZX7AhIWlrWLi88=;
        b=DqI2VOouM8YhCWnmDBm5e1AV0aRPDsWP4C3Kf1OGU8kjkdlZ1PuyqQC3ZCounMOdi5KV/k
        4Y1ReZB1sPHffVjWWQeKASgC1QJFFZtoxmYwFnbTeYe/7+ytsQ7vFrZbjczA9cv8k82jcj
        Dr6mcduvELwG/yL6Qzfn+SPXXS2zqq8=
Date:   Fri, 14 Jun 2019 19:51:59 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, puwen@hygon.cn, bhelgaas@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] x86/amd_nb: Make hygon_nb_misc_ids static
Message-ID: <20190614175159.GO2586@zn.tnic>
References: <20190614155441.22076-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190614155441.22076-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 11:54:41PM +0800, YueHaibing wrote:
> Fix sparse warning:
> 
> arch/x86/kernel/amd_nb.c:74:28: warning:
>  symbol 'hygon_nb_misc_ids' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
	       ^^^^^^^^^^^^^^^^^

Ha, what is that? :)

A new test bot?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
