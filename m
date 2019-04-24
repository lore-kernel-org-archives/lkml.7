Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C68C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47B72148D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="UOZ3mZTp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbfDXK1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:27:22 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35646 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbfDXK1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:27:22 -0400
Received: from zn.tnic (p200300EC2F08C600E8B1124E8C36361C.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:c600:e8b1:124e:8c36:361c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CF6341EC04B7;
        Wed, 24 Apr 2019 12:27:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1556101640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=KfWxlALbOVtxXtsYMXeHsCeyjTOm/p9jIsu/nfAToj4=;
        b=UOZ3mZTpQn34vgrTY2uaMILw6pneaVgfK1D9JaOK37pHQ4c4MTi8yoUQQrF+37sB2PtM2I
        e+fEfWDV31GztYU99LzbyFpN43TIxgInYWmRpo9frI31uPldiD6ccel8ow6CY/tcaGp99N
        LNjptp2fMNBMx5QItM+Rw2SDCAqQq1U=
Date:   Wed, 24 Apr 2019 12:26:57 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     WANG Chao <chao.wang@ucloud.cn>
Cc:     Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH 3/3] RAS/CEC: immediate soft-offline page when
 count_threshold == 1
Message-ID: <20190424102657.GC30142@zn.tnic>
References: <20190418034115.75954-1-chao.wang@ucloud.cn>
 <20190418034115.75954-3-chao.wang@ucloud.cn>
 <20190420115719.GD29704@zn.tnic>
 <20190424024304.GA53822@WANG-Chaos-MacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190424024304.GA53822@WANG-Chaos-MacBook-Pro.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 10:43:04AM +0800, WANG Chao wrote:
> It looks good to me. Thanks for a better fix.

Latest version:

https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/commit/?h=tip-ras-core-cec&id=aad216775348c4aaf467069c2e5fbf7ff6c27695

I'll post soon after I've hammered more on this thing.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
