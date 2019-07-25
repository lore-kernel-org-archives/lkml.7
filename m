Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5736BC76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 20:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA80218DA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 20:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="AoFQG+T5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfGYUov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 16:44:51 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:18009 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbfGYUov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 16:44:51 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d3a14c00000>; Thu, 25 Jul 2019 13:44:48 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 25 Jul 2019 13:44:50 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 25 Jul 2019 13:44:50 -0700
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 25 Jul
 2019 20:44:50 +0000
Subject: Re: [PATCH 1/1] x86/boot: clear some fields explicitly
To:     "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <john.hubbard@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190724231528.32381-1-jhubbard@nvidia.com>
 <20190724231528.32381-2-jhubbard@nvidia.com>
 <B7DC31CA-E378-445A-A937-1B99490C77B4@zytor.com>
 <alpine.DEB.2.21.1907250848050.1791@nanos.tec.linutronix.de>
 <3831bbff-631a-2e62-9e82-e2b6181421c8@zytor.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <06cbabb1-d3bc-5ed5-8cbe-bee361bb3c5b@nvidia.com>
Date:   Thu, 25 Jul 2019 13:44:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3831bbff-631a-2e62-9e82-e2b6181421c8@zytor.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1564087488; bh=CXyERdNl1CMXkfeZaHjH/C+QCLOvYJu7e2BNpcRBjgQ=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=AoFQG+T5X4RrOKaIRnplb7fGsq1JwI3MWQF942xidQY02vkh8mVen/1k7O95OmJZk
         cUblEAKFYm6osIkDMoKQguuKSj1qS+9PM7M/QjTUL+k5JJ+0k/FLqX/Zdly5sBO2c8
         Z/m0/wvIskbu6zMTyKen0OCz+apjGyGx0zDCawKqW+yrsCixAUPNSnYnZwgQp6YypK
         e5JEeKv03jg5pK5PfCxoEz5fF+Pe15B9Qmq6nxui9xmO0GMt3D1LqSfdbHflrP0Xfa
         gn2oqU1WxY9gBPzMMi1uMJRxzj7jpVZFdnHlQRptX3wfPmkSYWbhV5AT0yXIusrkaC
         OKuUM7FDsy4Gw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/19 1:38 PM, H. Peter Anvin wrote:
> On 7/25/19 12:22 AM, Thomas Gleixner wrote:

> The easy way would be to put in a suitable cast to clear the warning -- I
> would not be surprised if an explicit cast to something like (void *) would
> quiet the warning, or else (yuck) put in an explicit (well-commented) #pragma
> to shut it up.
> 

I wish. The first thing I tried was a (void*) cast, and the second thing
was declaring a void pointer instead. But the new compiler is fiendishly 
clever, and figured me out in both cases. 

The #pragma I haven't tried, it seems like a bit too far.

thanks,
-- 
John Hubbard
NVIDIA
