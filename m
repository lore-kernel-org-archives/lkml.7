Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B5ECA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 03:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB6A820679
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 03:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lqVwejqY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730668AbfJ1D2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 23:28:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39348 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbfJ1D2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 23:28:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pGhxkZI8OXt4Dcv5JMCcpWKbsOITOhSGDHxn01NkRKs=; b=lqVwejqYmQ40NJtL8805W13Gu
        9dGBFtITGO6W+HQm2bDplGabfhNuIfXkQplk9D41H5ZdHrenEClZ5AIMSd1Ouo/lteL5eJC/Bo8k0
        A0Ito7JK/G0SYyGnAJwLTRd9B9eZM+fjShyuA3wUvK60F3Xm/0msb5uWcIQ2yxzuWhtIvjOMhgsf4
        8Tg2kznFaT53594WV2aUhZAv4J/BX4RIUPim3P3hBUOV6U5hrP9t2et8khP8YqrNf356DJ/cqLeiU
        +DbHk6D4bWypsYAUd6koUSwwCOzV7ISOejpKI5ABJdXeFWF5QtgC9oxyFvTbhVvaemFcKAjamq18o
        4d947lKTQ==;
Received: from [2601:1c0:6280:3f0::9ef4]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iOvi3-00047S-IT; Mon, 28 Oct 2019 03:28:47 +0000
Subject: Re: [PATCH] scripts:prune-kernel:prune old kernels and modules dir
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        bfields@fieldses.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191025054703.16400-1-unixbhaskar@gmail.com>
 <4adba61c-9c1b-dee3-0a9b-9159dcce5a82@infradead.org>
 <20191028032203.GA28082@Gentoo>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <83f11555-8364-1e2d-f0df-c90e889710a3@infradead.org>
Date:   Sun, 27 Oct 2019 20:28:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191028032203.GA28082@Gentoo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/19 8:22 PM, Bhaskar Chowdhury wrote:
>>> +do 
>>
>> 'do' has a trailing space after it.  drop it.
>>
> Certain thing ..this space and tab killing me...how fix these damn thing
> Randy??

I dunno.  It depends on what editor you are using and what
options.  So what editor?

-- 
~Randy

