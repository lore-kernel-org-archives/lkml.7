Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8DAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67EA2213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LSyfaQGT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbfCSOOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:14:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54150 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfCSOOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 10:14:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ggpmEi/tz48S76kwN3kqs6AHjU/+w6TOvQ5t1vMmBu0=; b=LSyfaQGTQz6zC0t9R3T+kbTEm
        JbuDIO6wxLMB3f1i/92m7xKg32noIfu/gQSaQFVA/XV23qJB70+jUqoGRhZ1G8PAOPLQR/QhirKlI
        jaZqW0ijWQtBCpwjr7Wo1qcLFVzm7uECdL8NhaHGpsWHYKOExVTb7Gh/jCMCHgbyDqRvEEcSR4HPL
        RUxzyomyFQKKIxM1wH2QAxSVRQiSmusxUUSH4HuQVQDjr3XQcMgbmXIANpyjuXomHUt06AehLufHl
        C9YxKO5xu5qPWty7gKzBosb4LwS5lSimbQy+udSMy9YjCB1VlobzlJq4HTWJcM5qyMciMPFI0U9aG
        PBPknQwXQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h6FVD-0005oA-89; Tue, 19 Mar 2019 14:14:03 +0000
Subject: Re: linux-next: Tree for Mar 19 (sound/soc/codecs/nau8810.c)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Lin <ctlin0@nuvoton.com>,
        moderated for non-subscribers <alsa-devel@alsa-project.org>
References: <20190319161236.214675f6@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <00f5cef0-4024-caf2-7f98-52b1e92b13b2@infradead.org>
Date:   Tue, 19 Mar 2019 07:13:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190319161236.214675f6@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/19 10:12 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20190318:
> 

on i386:

ld: sound/soc/codecs/nau8810.o: in function `nau8810_set_pll':
nau8810.c:(.text+0x6e7): undefined reference to `__udivdi3'


-- 
~Randy
