Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77478C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 22:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F44C20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 22:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Ham9qmNF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfFMWXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 18:23:05 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47066 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbfFMWXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 18:23:04 -0400
Received: from zn.tnic (p200300EC2F06D5002DB642DF7EFF7228.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:d500:2db6:42df:7eff:7228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 52B441EC02FE;
        Fri, 14 Jun 2019 00:23:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560464583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=IO33KnvmZahzxGnM+KPqWV4c6LOFfLrThEc6ocuLA5w=;
        b=Ham9qmNFD9ov9SgCiizWBhlk/gFGYkIlphb0AHfKOnFZXyuci4f8YyxEtEBG7+SimlJva5
        QyZf7/zkDEbk4TvAR5uf5VrGvaz5QP+z6Z33mDT8w26LjxdIHUFvrwKeX3iBz9A+Y9w/cv
        PkWh20h+RV4aNVI2wHV95qCpupKN2BM=
Date:   Fri, 14 Jun 2019 00:22:55 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/8] EDAC/amd64: Support more than two controllers for
 chip selects handling
Message-ID: <20190613222255.GH11598@zn.tnic>
References: <20190531234501.32826-1-Yazen.Ghannam@amd.com>
 <20190531234501.32826-3-Yazen.Ghannam@amd.com>
 <20190613141715.GD11598@zn.tnic>
 <SN6PR12MB263987AAB225A09527C4D736F8EF0@SN6PR12MB2639.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SN6PR12MB263987AAB225A09527C4D736F8EF0@SN6PR12MB2639.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 08:58:16PM +0000, Ghannam, Yazen wrote:
> The first patch is meant as a fix for existing systems, and this patch
> is to add new functionality.
>
> I can merge them together if you think that's more appropriate.

Is it fixing such a critical issue that it needs to be a separate patch?
If so, it should be CC:stable.

But I think we've survived without it just fine so why bother. But maybe
there's an aspect I'm missing...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
