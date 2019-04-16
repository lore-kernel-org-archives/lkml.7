Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DC3C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1934C2073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="XdKpRYWi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730115AbfDPRgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:36:15 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33552 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbfDPRgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:36:14 -0400
Received: from zn.tnic (p200300EC2F0D69007D63E3F8FEB0C818.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:6900:7d63:e3f8:feb0:c818])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4926B1EC013F;
        Tue, 16 Apr 2019 19:36:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555436173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ykjnn/Aq2Yrz8tdKYd5DAYPvURZoxP6Lmn6+XzTvZbQ=;
        b=XdKpRYWizTchkbEwO0u8aUf7JngS7CHdR7SDhJByW35pqxVxvPN8QisRjT/Xu3Hn84OUDe
        yqfgbM2+nj6zGpgllcKWOtj2dxLJdKM14O9/eAlEr1rVY5MzSTJC79Y6k4paWqNKtvOLxV
        GTLsHE5xcRmv9DSFCKhJyf+EKkFOEcU=
Date:   Tue, 16 Apr 2019 19:36:09 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 4/6] x86/MCE: Make number of MCA banks per_cpu
Message-ID: <20190416173609.GJ31772@zn.tnic>
References: <20190411201743.43195-1-Yazen.Ghannam@amd.com>
 <20190411201743.43195-5-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190411201743.43195-5-Yazen.Ghannam@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 08:18:03PM +0000, Ghannam, Yazen wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> The number of MCA banks is provided per logical CPU. Historically, this
> number has been the same across all CPUs, but this is not an
> architectural guarantee. Future AMD systems may have MCA bank counts
> that vary between logical CPUs in a system.
> 
> This issue was partially addressed in
> 
> commit ("006c077041dc x86/mce: Handle varying MCA bank counts")

Add that to your .gitconfig:

[alias]
        one = show -s --pretty='format:%h (\"%s\")'

so that you can quote commits properly:

$ git one 006c077041dc73b9490fffc4c6af5befe0687110
006c077041dc ("x86/mce: Handle varying MCA bank counts")

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
