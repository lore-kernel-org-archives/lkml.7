Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2EBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 22:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 496A62075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 22:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="X5TSQOBh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732481AbfCZW6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 18:58:38 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48762 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731690AbfCZW6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 18:58:38 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E525F1EC038F;
        Tue, 26 Mar 2019 23:58:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553641117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3geUmwL1QK37XEVpKsXlOMw/ajp1f+leX3QY5g0TNK4=;
        b=X5TSQOBhSZkcDq02kaJVLcYrBFCwzB8dusw6kgfdC7Ezm0kCg6AtDMmBygcVaOVIGcsTV+
        aFWtkSfG55QtwMamcoQbTzJbrlom32keagw7PhzCyKJgH7cSKXjiC5++0xjVm1ILxrK+ll
        fpBCJRNqTR3nSrHizdXZ8w8WlLIrdb0=
Date:   Tue, 26 Mar 2019 23:58:40 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EDAC/amd64: Use maximum channel count for the EDAC
 channel layer size
Message-ID: <20190326225839.GQ1867@zn.tnic>
References: <20190325203319.7603-1-Yazen.Ghannam@amd.com>
 <20190326155511.GM1867@zn.tnic>
 <SN6PR12MB263952B80F35F51AECB6AFFAF85F0@SN6PR12MB2639.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SN6PR12MB263952B80F35F51AECB6AFFAF85F0@SN6PR12MB2639.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 07:15:29PM +0000, Ghannam, Yazen wrote:
> Just tested on a fully populated system. Everything seems to be okay.

Thanks, queued.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
