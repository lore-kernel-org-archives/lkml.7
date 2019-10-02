Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6EBC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 22:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 565EA222C2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 22:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W3nKOVLw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbfJBWMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 18:12:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57608 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfJBWMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 18:12:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=73tVWQ3v84KxdNQPWmcNcSz97cSdJQxQxagmXQY35II=; b=W3nKOVLw3sKyL5/8swuVedHSw
        bruP9N66fD2/Bi37YaPtgFypZXVBkXc27NdPZ5qgMOzpTYN9WKP6wgVyYaup/r9/kIEVyWKZFpVrb
        7v37PCOfrit3YjDn5x1OljIrMhcYRsoCuzej5lOKrC7r/NfBI49x7KqAIFgXhSfsqoi+Pipvg3vTK
        nql0ZPiEsdTGXPh7HRYVb3HAGwQ506Uw7q/h306+QrKeMItkB1AJ4vujtdxlJmg0dHVJGVH2mNk9j
        HSMzzTdh4aacRJu5IYIdUfuNeww7lxMfuYvGAvJ5P3YwSbvoUaY5jRr1H4KBm/OVFW0zh9Wg36kPI
        UvppIbuWQ==;
Received: from [2601:1c0:6280:3f0::9a1f]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iFmr6-0002RX-1t; Wed, 02 Oct 2019 22:12:20 +0000
Subject: Re: linux-next: Signed-off-by missing for commit in the net-next tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "rd.dunlab@gmail.com" <rd.dunlab@gmail.com>
References: <20191003080633.0388a91d@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5d671b8e-1a3e-3a32-1163-d15754ddb8b2@infradead.org>
Date:   Wed, 2 Oct 2019 15:12:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191003080633.0388a91d@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/19 3:06 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Commits
> 
>   0f04f8ea62ce ("Minor fixes to the CAIF Transport drivers Kconfig file")
>   21d549769e79 ("Isolate CAIF transport drivers into their own menu")
>   0903102f5785 ("Clean up the net/caif/Kconfig menu")
> 
> are missing a Signed-off-by from their authors.
> 
> I guess <rd.dunlab@gmail.com> and <rdunlap@infradead.org> may be the
> same person?  Please be consistent.

  Yes.          Yes, will do that.

-- 
~Randy
