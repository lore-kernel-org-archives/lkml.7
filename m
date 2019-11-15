Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6C1C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E3BA20692
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vDSU1ZK3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfKOQTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 11:19:54 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43654 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbfKOQTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 11:19:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MihLrs/7FogrHpnKneeCp+h+sbBa6r5+J8efbKThpOI=; b=vDSU1ZK3jFr3QP3fGfLx3qkbl
        WwMuqlIsGri1tAkLsVtK+irkl8NqY57I/N20jwPd70dl4IvCbvoNOyq1Qbfqa+gFdq5mR+MT5BHl/
        YND/BICyPvw9qkWWLoA6oj/FX9Rpe0Sa23XncCZmjZB1j9wP4aBIH3KB8b3PxqmrPPt1TTOTxvpzL
        /I1zB9kOH0Ij+gpP/JxCZ5Sx8B7m46pE9wqqXgLpgMvXbHuym536g+o+Z2PN6T9PMbTy7FoLoPmR/
        G+QOCHC9Vvyic9H9AiXT0tnqm0BPPPhOiSZj6acoryxqxAiwpBnIckuUpUb6p2sAoeF/AOTBIbNHM
        6tqUnnY8w==;
Received: from [2601:1c0:6280:3f0::5a22]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVeKA-0002p8-4s; Fri, 15 Nov 2019 16:19:54 +0000
Subject: Re: linux-next: Tree for Nov 15 (drivers/md/dm-integrity)
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
References: <20191115190525.77efdf6c@canb.auug.org.au>
 <f368f431-b741-d04f-440b-3d8c3c035537@infradead.org>
Message-ID: <d3a96436-0d9c-a13f-7524-33b203910367@infradead.org>
Date:   Fri, 15 Nov 2019 08:19:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <f368f431-b741-d04f-440b-3d8c3c035537@infradead.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/19 8:17 AM, Randy Dunlap wrote:
> On 11/15/19 12:05 AM, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20191114:
>>
> 
> on i386:
> 
> ld: drivers/md/dm-integrity.o: in function `calculate_device_limits':
> dm-integrity.c:(.text.unlikely+0x1e9): undefined reference to `__udivdi3'
> 
> 

BTW, dm-devel@redhat.com seems to be invalid or dead.

so adding Alasdair and Mike.

-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
