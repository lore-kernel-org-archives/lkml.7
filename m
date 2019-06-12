Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67248C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 20:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35541206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 20:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PsNSMjSf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389052AbfFLUrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 16:47:10 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45722 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727321AbfFLUrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 16:47:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8WWENblypPDMsQ59pJNiVEtFrFCNg58U3zxKaLpaFTQ=; b=PsNSMjSfNbFfdWphzo5pEuc16P
        tYmuUhf5z7/LnJHcCERNlRHBS/3tz7afG43iyyTQActU1unUuEQ9u6P6OGfY0ST3gNSD7BvT59hOQ
        YyN3NRp5tKaouLgMGOd1wHIg2HvhKTWy4cF5SYJjGXbt8RqV74RcNHwMBKpKLaf66ZkLHenXOvm8+
        7mIRuZKI97lrkqNh6LO6OSpCfrundVQEPBGV45cmQStWX1C9t+W7v5YTC0CnqY38K9t4SOOePFxxG
        KOlmRIYFAbz6mQcRp4LXOfOqjaryv/Lk+RBVUwf1qXxxE9NiSA3qp5byYyY3hu5zLsv0Z24pOeYrU
        TDGPQ/FQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbA9C-000305-2J; Wed, 12 Jun 2019 20:47:06 +0000
Subject: Re: linux-next: Tree for Jun 12 (amdgpu: dcn10_hw_sequencer)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Oded Gabbay <oded.gabbay@gmail.com>
References: <20190612170027.13dbb84b@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9b4f8e15-8f9f-51d9-c355-9c2e453921e3@infradead.org>
Date:   Wed, 12 Jun 2019 13:47:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190612170027.13dbb84b@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/19 12:00 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20190611:
> 

on x86_64:

../drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c: In function ‘dcn10_apply_ctx_for_surface’:
../drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:2378:3: error: implicit declaration of function ‘udelay’ [-Werror=implicit-function-declaration]
   udelay(underflow_check_delay_us);
   ^



-- 
~Randy
