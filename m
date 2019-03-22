Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29558C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEA602190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="PXrm2wyv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbfCVQqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:46:24 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59666 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727140AbfCVQqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 12:46:23 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 987C61EC09F1;
        Fri, 22 Mar 2019 17:46:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553273182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=I/mK1winYGTelfYEERQPqqxBiib3Z+7kxrgWzE5HFVc=;
        b=PXrm2wyvwLQKcBYdBieIfnhiY2tLDdb2DyJlZFf8YhVTDNLOc+G44vKKRGm5wjEW15GJwC
        acZ8tpBMhNY5XEr94RyTETqlVhFfsH/+jO1f/gQElL5OZc+GDiwXII8IaUf7Ml58+JLBic
        2JSFBOCZQVCg41M2bPMe10wTf8pq1Ss=
Date:   Fri, 22 Mar 2019 17:46:30 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Kim Phillips <kphillips@amd.com>
Cc:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/6] EDAC/amd64: Add Family 17h Model 30h PCI IDs
Message-ID: <20190322164630.GH12472@zn.tnic>
References: <20190228153558.127292-1-Yazen.Ghannam@amd.com>
 <SN6PR12MB2639CDDA70C504DFEF5EE7B8F8420@SN6PR12MB2639.namprd12.prod.outlook.com>
 <ca64e38b-b374-288e-1399-c8e8598fc91c@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ca64e38b-b374-288e-1399-c8e8598fc91c@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 04:33:48PM +0000, Kim Phillips wrote:
> Hi Boris,
> 
> I've tested this patch and it gets rid of a slew of these messages:
> 
> kernel: EDAC amd64: Error: F0 not found, device 0x1460 (broken BIOS?)
> kernel: EDAC amd64: Error: Error probing instance: 0
> 
> So please add my:
> 
> Tested-by: Kim Phillips <kim.phillips@amd.com>
> 
> Thank you,

Thanks but please do not top-post when replying to mails on public
mailing lists.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
