Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA302C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B037B2072D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lq4gdsnU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfKOQfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 11:35:37 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56456 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbfKOQfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 11:35:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4UDa6Y6CRNUxOhJ/s+W6TLT2P8CBwqVBIipMhoU/5cQ=; b=lq4gdsnUXduAUiPQkKJ7IMx5K
        1hs4RgvrdfjtvQ6agg8CNhKt6+g16BNVIeHMZGpDzGwdJbJRX0Gq8O/rfOinS+PHzLbo0AAe3Wz9T
        RfHcyptwbBR7JtFBJsgA5iR84Cn3iopa3pLOKlsLGagQbn/ofWiBxSvsIsXc25LFCYtssD7VIFUMu
        Pwl0l5HQfjvvaDDcVC0EbvGOlDp3PFWtBvg1hPst7selTMthsk+msq2Fo8RlpZl/ymdRpuivitWjB
        U+KBskb9Sdz/gowx6NS1Qjf77n3fp3kvC4hQ4V9QE6Dq+9zMG4tF9AjOXGS1EHE8I6A1fOkHIhZOm
        wib/ITo/Q==;
Received: from [2601:1c0:6280:3f0::5a22]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVeZM-0004u6-Ve; Fri, 15 Nov 2019 16:35:37 +0000
Subject: Re: linux-next: Tree for Nov 15 (sound/soc/codecs/rt5677)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bard Liao <bardliao@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>
References: <20191115190525.77efdf6c@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c505aa5d-086e-cb7d-55c0-cd092f62e82a@infradead.org>
Date:   Fri, 15 Nov 2019 08:35:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191115190525.77efdf6c@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/19 12:05 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20191114:
> 

on i386:
when CONFIG_SPI is not set/enabled:


ld: sound/soc/codecs/rt5677.o: in function `rt5677_dsp_work':
rt5677.c:(.text+0x2cb7): undefined reference to `rt5677_spi_write'
ld: sound/soc/codecs/rt5677.o: in function `rt5677_check_hotword':
rt5677.c:(.text+0x3120): undefined reference to `rt5677_spi_hotword_detected'


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
