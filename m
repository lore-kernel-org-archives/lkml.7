Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDE4C74A44
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 15:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46B1D20896
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 15:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o3bQwknb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbfGNPCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 11:02:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44482 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728146AbfGNPCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 11:02:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pCnrkDdFKCWXQWHpuictYANP6U7esLlG96OBuXYho7U=; b=o3bQwknbopwJuGSaXb6i7uOgt
        DIAM5ZLrid1AxheK7MJ3PN6vFqifcSrne8rm0aLnFLLP0+j/C6Oqr/ezqHHRsrWLeDU0niO4y33rC
        VtE++kgeLR41KeHxRD7gpeBDMWIwfY0zHlJzup8TYkiOSUkU3iyJjKxs+Pntcf9F4UTrhPxOs0ZJ8
        ZQAT3TV9TxU+TyS6VKdX5x4zPNP/RJWUIHVk24H1TBGo/3hvtUoxgcOTNKm9/MSCaglXgdqRN/GhS
        WvtTVoTtExOSshIJ/2tnipvLAWaTxkp2JphQsltU0n8/DN5F9bq2Y2lbulfoHcmBTxZOGDrhAe8EJ
        HhKzvMG/A==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=[192.168.1.17])
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hmg10-0001qD-HD; Sun, 14 Jul 2019 15:02:14 +0000
Subject: Re: linux-next: Fixes tag needs some work in the hyperv-fixes tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Sasha Levin <sashal@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190714225534.1dc093ad@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <44b7e61d-438d-e906-57fd-b1182bf6f6c6@infradead.org>
Date:   Sun, 14 Jul 2019 08:02:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190714225534.1dc093ad@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/19 5:55 AM, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   2e6d7851bdeb ("PCI: pci-hyperv: fix build errors on non-SYSFS config")
> 
> Fixes tag
> 
>   Fixes: a15f2c08c708 ("PCI: hv: support reporting serial number as slot

oops, copy-paste error.

> 
> has these problem(s):
> 
>   - Subject has leading but no trailing parentheses
>   - Subject has leading but no trailing quotes
> 
> Please do not split Fixes tags over more than one line.  Also do not
> include blank lines among the tag lines.

Hm, so you are saying that the Fixes: line should not be separated from the
other tag lines?  That's news to me...
Should Fixes: be before the other tag lines or does it matter?

thanks.
-- 
~Randy
