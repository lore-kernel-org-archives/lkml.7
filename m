Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7922AC41514
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4300B2173E
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mteAUakX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbfH3QwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 12:52:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53530 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbfH3QwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 12:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7a+XCsiuXXCRR1Y2/qK9IVAIAgqTUuDihw3bfaNlQgE=; b=mteAUakXTj9/LbVuXP+4pW3nT
        jBtwOjqFjNwLGwxgJ1uNHOFTM4deOUCfe+LBYq3uX9t1Rxp1z9KDX5CcrdgrsI5/WNmg4FMQ/8FsG
        E5Sw542kisDnh4B5EePaqh6vIIzjYCRpC/EH7vu+e13ND0Ds6bbFJ3AKrn0ynlAh/Yr3CLxHyEFLt
        VEE5MocBM4bGPCp49PijEuVeEKA2wf0YRNjViOG3F/HAs1wUhzFCKRW8mIV+BxlA/WANxD0QWhINJ
        oejEubgTPnjxFOXenn0dRH233xmjsgENr27xjoNcHW9HD3BxAzvJousVPoxEvQYBrerTk8TsVh/iE
        LA5gnXk1w==;
Received: from [2601:1c0:6200:6e8::4f71]
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i3k8G-0002Tr-KG; Fri, 30 Aug 2019 16:52:16 +0000
Subject: Re: linux-next: Tree for Aug 30 (exfat)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20190831003613.7540b2d7@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8ef40504-ba29-5325-9cb6-0c800a7b03ce@infradead.org>
Date:   Fri, 30 Aug 2019 09:52:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190831003613.7540b2d7@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/19 7:36 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20190829:
> 

on x86_64:
when CONFIG_VFAT_FS is not set/enabled:

../drivers/staging/exfat/exfat_super.c:46:41: error: ‘CONFIG_FAT_DEFAULT_IOCHARSET’ undeclared here (not in a function); did you mean ‘CONFIG_EXFAT_DEFAULT_IOCHARSET’?
 static char exfat_default_iocharset[] = CONFIG_FAT_DEFAULT_IOCHARSET;
                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
                                         CONFIG_EXFAT_DEFAULT_IOCHARSET



-- 
~Randy
