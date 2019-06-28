Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EA4C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 20:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B86DB2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 20:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aOZNcMIF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfF1Urr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 16:47:47 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47600 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfF1Urq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 16:47:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0AFB9+OcrWykWagjvEfuqPWjzrPw4TNE2Nz1Y05oeEo=; b=aOZNcMIF9nooQMIi5wldPRS0Hr
        90q3G/l8kE8yRYqCCuyYqBxrCrnseH3fTi9jvA0WkrrVXbg+ZLDAbQv6G0vqV0BLkQineCVKJjNF9
        roFoYHANiypJCzPIJH9TJnBJv2hqquyLciBWVdIpozeMcj2SXtTyUPdXBvBEogpo1ctwE0qp5YpTe
        j13GzY2qfwRF9zDAA6KLiJbIWHFuTyLRh3VKUy+OxOGCSUVsoqhpe6AunA3richyOZh60eiYWPCHx
        +29zMqCt1O/jRd00W/jr3PbQ5c+lzZeAmBFGw/Tz3PPwiAfwyhiuCp4DhwN6PQUtobMhsoQFj1u1O
        RX4ryOYA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgxmb-0003Te-12; Fri, 28 Jun 2019 20:47:45 +0000
Subject: Re: [PATCH] docs: format kernel-parameters -- as code
To:     Jonathan Corbet <corbet@lwn.net>, Stephen Kitt <steve@sk2.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190627135938.3722-1-steve@sk2.org>
 <20190628091021.457d0301@lwn.net> <20190628203841.723ccd9c@heffalump.sk2.org>
 <20190628124804.5ce44f04@lwn.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <88c37575-2bee-03ff-970e-f4f77635da6e@infradead.org>
Date:   Fri, 28 Jun 2019 13:47:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190628124804.5ce44f04@lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/19 11:48 AM, Jonathan Corbet wrote:
> On Fri, 28 Jun 2019 20:38:41 +0200
> Stephen Kitt <steve@sk2.org> wrote:
> 
>> Right, looking further shows a large number of places where -- is handled
>> incorrectly. The following patch disables this “smart” handling wholesale;
>> I’ll follow up (in the next few days) with patches to use real em- and
>> en-dashes where appropriate.
> 
> Thanks for figuring that out, it seems like the right thing to do.
> 
> Let's not worry about "real" dashes for now.  Not everybody welcomes
> non-ascii characters in the docs and, for dashes, it's something I deemed
> not worth fighting about.

Ack that.  Thanks.

-- 
~Randy
