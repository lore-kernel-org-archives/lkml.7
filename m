Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE254C282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 23:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9417F21848
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 23:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UjBwr46C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbfEXXVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 19:21:40 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55760 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfEXXVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 19:21:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XBfCjz3L7g28JeGLcJlNP/XerD1I63TBTPztLXL3giU=; b=UjBwr46CW891EN4AnXcME7qDhs
        5Q4ULMrRQs49bZjXQ8GaqFsEtWBiEmr1qTDWaFAaUqyEFupl8gdDN9yMqqNCfCHCDiHN0UdDRDLHv
        8RLgVBcOW90b3CZ5TaHcAWh24yr9UsyGn1UGU3VCzs02DX/701h71xogjD9udP6YS+7SOV9K4xFLE
        QqbmDibTo825+Iz+R0NFO9idrP5lgrCmQoL2eciTuWTh8HY4H+MR2dod6F13TQOxuRpc5ASzf2XrU
        ZYAR/FtGfTZbna0tayzncpt7BxXhlKS0CyRMkhsfof6hOARRFx0ri7jRXUDWvlHEOor/cOBbMd2jE
        OFaU2SSQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hUJVK-00079M-DV; Fri, 24 May 2019 23:21:38 +0000
Subject: Re: [A General Question] What should I do after getting Reviewed-by
 from a maintainer?
To:     Gen Zhang <blackgod016574@gmail.com>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
References: <20190523011723.GA15242@zhanggen-UX430UQ>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7510e8a7-3567-fc22-d8e3-6d6142c06ff3@infradead.org>
Date:   Fri, 24 May 2019 16:21:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523011723.GA15242@zhanggen-UX430UQ>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/19 6:17 PM, Gen Zhang wrote:
> Hi Andrew,
> I am starting submitting patches these days and got some patches 
> "Reviewed-by" from maintainers. After checking the 
> submitting-patches.html, I figured out what "Reviewed-by" means. But I
> didn't get the guidance on what to do after getting "Reviewed-by".
> Am I supposed to send this patch to more maintainers? Or something else?
> Thanks
> Gen
> 

[Yes, I am not Andrew. ;]

Patches should be sent to a maintainer who is responsible for merging
changes for the driver or $arch or subsystem.
And they should also be Cc-ed to the appropriate mailing list(s) and
source code author(s), usually [unless they are no longer active].

Some source files have author email addresses in them.
Or in a kernel git tree, you can use "git log path/to/source/file.c" to see
who has been making & merging patches to that file.c.
Probably the easiest thing to do is run ./scripts/get_maintainer.pl and
it will try to tell you who to send the patch to.

HTH.
-- 
~Randy
