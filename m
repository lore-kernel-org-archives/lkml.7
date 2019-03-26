Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2879EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD1BF2063F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="WnGfmgUw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731661AbfCZPrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:47:17 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36918 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731374AbfCZPrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 11:47:17 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D4ED41EC0104;
        Tue, 26 Mar 2019 16:47:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553615236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=rbczpiy8yZiVoMpgtFDjWCR7U46lNRe4EfbgAA+wZTU=;
        b=WnGfmgUwKuOW5E/DnUBrb1ttHZl2SzpY2bgnG/Ghwcv2Pddli+qZyb3iUDZVjd24tyEk7m
        3Y5gMVlxi3QLzBbaX/iLWslBvB6b9irxNwTkdNy4vahmTDUkEHgFrvc+kMne/9okfhwqiq
        NPEnJkmdMSF0HmjVHUEECDvCqGhygUo=
Date:   Tue, 26 Mar 2019 16:47:19 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "rafal@milecki.pl" <rafal@milecki.pl>,
        "clemej@gmail.com" <clemej@gmail.com>
Subject: Re: [PATCH v4 1/2] x86/MCE: Add function to allow filtering of MCA
 errors
Message-ID: <20190326154719.GL1867@zn.tnic>
References: <20190325163410.171021-1-Yazen.Ghannam@amd.com>
 <20190326075651.GB1867@zn.tnic>
 <SN6PR12MB2639C80DA928C41AA678DFB6F85F0@SN6PR12MB2639.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SN6PR12MB2639C80DA928C41AA678DFB6F85F0@SN6PR12MB2639.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 11:41:05AM +0000, Ghannam, Yazen wrote:
> They don't apply cleanly to v4.14 anymore because of the recent header change.
> 
> I figured they would need to be fixed up and submitted separately to older stable
> versions. Is that okay?

Ah yes, right.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
