Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEB9C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 15:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C4D72068F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 15:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fLtFRfU5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbfKSPdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 10:33:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38112 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727682AbfKSPdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 10:33:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7k98xFtkO3R8OY2GTrR+n6nxLnbfq1kjR6KlJVfIm+M=; b=fLtFRfU5eeKhmoEe0pKbpvvBb
        l3MY1BEVYKISFsskQDSLnZTbqlBl5NAwWVFE42zgiApxtamP25+7J7aWm0p37iX0AKjSSkEZ3N+I0
        9IamcDFOqg9O9LUZP8UFWkRUde2JBRIsDbE8qQ3xgsBubOlDqoOovIvonAyPf90Yj74kld27Tv82R
        s207u98tRCi1+5hTd9033FbkbbNzqsVe3FKlzINCebCxcJMW3v6B8EHip9kIc7/5jjX7lOUGlVwOn
        MrRki1XSPPK+/itwDbDp+36uxulpH0VJAK02JchWYDWOmiOu8CWOjbT88ha+54EvIGO5SiJ1295Qo
        t9NJ8Xpfw==;
Received: from [2601:1c0:6280:3f0::5a22]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iX5Vi-0002IW-Uf; Tue, 19 Nov 2019 15:33:46 +0000
Subject: Re: linux-next: Tree for Nov 19 (i915)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>
References: <20191119194658.39af50d0@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1d30acd4-9947-d228-967f-c4e76ebca832@infradead.org>
Date:   Tue, 19 Nov 2019 07:33:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191119194658.39af50d0@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/19 12:46 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20191118:


on x86_64:

ERROR: "pm_suspend_target_state" [drivers/gpu/drm/i915/i915.ko] undefined!

# CONFIG_SUSPEND is not set

-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
