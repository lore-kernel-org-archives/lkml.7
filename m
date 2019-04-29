Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7333EC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A0D20673
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fbOBs4n+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbfD2OwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 10:52:06 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53780 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728339AbfD2OwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 10:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XWObNu9Ml1qqZhYpuzXFaJYSLMbGpHRtVg/+qSsyk7A=; b=fbOBs4n+O0FSpPNZiT9SIFm0GN
        eP7WrfkWbUH0ros5nKaEqn+4p5WRJAaXK7RK2vOyYWz1n55wltI3RexAFvTQZ/lO1+aCAKFo9oF+i
        sPJKZa8YIfBVB79Izp+3105hbKbPwvfQhHebiTGG+BePIlGlt+MfOPdhNtYh/4vD5yHn5KM6eHREC
        N9pB+ppuvDdjMOz22khgjLEwBlD9MWwXsDFBNR350F/YViOxVI8+wbmEqKSTOqQhLFBaiJMQDSjUa
        IO+i3lJ/157z1/e4Klivg1sZxg0QJFG5tuFse94DELxwJu0XwOebx84WwWrhzHf107PWFYG9W2C+8
        Z4BkmTZA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hL7dS-0000V6-RY; Mon, 29 Apr 2019 14:52:03 +0000
Subject: Re: linux-next: Tree for Apr 29 (drivers/md/dm-dust)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dm-devel <dm-devel@redhat.com>
References: <20190429190354.0d5e2e93@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <534f901f-c662-6216-c39a-addb545f614b@infradead.org>
Date:   Mon, 29 Apr 2019 07:52:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190429190354.0d5e2e93@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/19 2:03 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20190426:
> 

on i386:

ld: drivers/md/dm-dust.o: in function `dust_map':
dm-dust.c:(.text+0x28d): undefined reference to `__udivdi3'
ld: drivers/md/dm-dust.o: in function `dust_message':
dm-dust.c:(.text+0x9a4): undefined reference to `__udivdi3'



-- 
~Randy
