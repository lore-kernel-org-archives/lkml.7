Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03A2FA3735
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 15:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 792DE20872
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 15:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gtWpIetf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407052AbfJQPWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 11:22:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48806 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391285AbfJQPWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 11:22:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BhyZS7+sRv/JZoP4+6IBFbCyglVKgcF0rn92fjDmAO4=; b=gtWpIetf0FkX1pIJJ0IwoGVv1
        HsDLDA4LxEH/3ehgYeE2v/v4db7yQfFqttcJ3hZn40dmLYr7HcSeUIEDeiJ+SXdj6qWTsJDunTnJW
        UsVMf/lRaXRA6k+XOkmMYFfQ7ql2huqjvy76X4Ss6lAckL+3wwNBjXoTscIdmn7FZiz5en14jen27
        JMuybt8YtEWBjpZhLazYG0NlpASIKyzP0/YxdSi/9XBgUOIlAkuqw7PKFPdQJK0ouTyQSzShFMFkD
        9OvxDkSoKwSmw2Ygq9z9CN/k/9Icn8f2HccjIUmvMMzz9uZIagfqbuxRB3y3XfxsVL8Aq6+H9pp6x
        DFbYCt2dA==;
Received: from [2601:1c0:6280:3f0::9ef4]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iL7bW-0005jG-JK; Thu, 17 Oct 2019 15:22:19 +0000
Subject: Re: linux-next: Tree for Oct 17 (soundwire)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        moderated for non-subscribers <alsa-devel@alsa-project.org>,
        Vinod Koul <vkoul@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20191017152645.65892c78@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e8994e88-bdab-b3be-d62f-550ce9f2c76d@infradead.org>
Date:   Thu, 17 Oct 2019 08:22:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191017152645.65892c78@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/19 9:26 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20191016:
> 

on x86_64:

# CONFIG_BLOCK is not set

  CC [M]  drivers/soundwire/intel_init.o
In file included from ../drivers/soundwire/intel_init.c:12:0:
../include/linux/iomap.h: In function ‘iomap_sector’:
../include/linux/iomap.h:76:48: error: ‘SECTOR_SHIFT’ undeclared (first use in this function); did you mean ‘SECTIONS_SHIFT’?
  return (iomap->addr + pos - iomap->offset) >> SECTOR_SHIFT;
                                                ^~~~~~~~~~~~
                                                SECTIONS_SHIFT


-- 
~Randy
