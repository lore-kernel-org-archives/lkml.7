Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9CAC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 14:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1A421902
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 14:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cQiAowwA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfCWOvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 10:51:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42456 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfCWOvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 10:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4TA8KdD4JBk6BJ7geLLOLe7UXvMlnv7R08Vja/v7G4g=; b=cQiAowwAF6j+Icx1pu7ZngoNj
        QbdphKQ77TLrA4WEl2R0FmF+koe8l0cFTwtynTSNbnpiNicdEjQG+pYQk4jQTt1i2upo2G/DFdddi
        McYMc1CQCTAqxtfjfuhsdrzxDrfcDE+u9eZXHJOUWRFZcOG6lH13A48PBNydZbO5WDXc+thnF5n4W
        44SbTB2ysvQfF/TTz5FZ9oD5BK1N67+pEr45solomfBML/fy0u8Pa6gE8pkT/Ieps0f4KJBSXviB5
        MCAKLpUhYE1kEkjh0jNdiy7iDLwu4/TtMxa7hVse+uVjwqcaWOUZ9wyuWyS1RqB6jDkKKtuDMnRpa
        6Amhr4FQA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h7hzA-0001hD-Dc; Sat, 23 Mar 2019 14:51:00 +0000
Subject: Re: [PATCH 1/3] auxdisplay: deconfuse configuration
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Mans Rullgard <mans@mansr.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        Willy Tarreau <w@1wt.eu>,
        Geert Uytterhoeven <geert.uytterhoeven@gmail.com>
References: <20190301184816.784-1-mans@mansr.com>
 <CANiq72=H1Gubbr+eoEKUR+m49fkcC7Sr_hsyP3azzpk=i-au+Q@mail.gmail.com>
 <CANiq72=fExsa6cxG=TpuQb3OxcFDdfQhfrE5=OU8vS0gn8KgZA@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c6800354-bd44-59b6-df03-3f2448e354a8@infradead.org>
Date:   Sat, 23 Mar 2019 07:50:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CANiq72=fExsa6cxG=TpuQb3OxcFDdfQhfrE5=OU8vS0gn8KgZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/19 7:28 AM, Miguel Ojeda wrote:
> On Wed, Mar 6, 2019 at 11:14 AM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
>>
>> Since you are touching the panel.c options, CC'ing the maintainers
>> (please do run get_maintainer.pl in that case!)
> 
> I was preparing the PR for -rc2 and I just noticed we didn't CC Randy
> which was the last one changing the Kconfig. CC'ing now in case he
> wants to take a look before I send the PR.
> 
> Cheers,
> Miguel

Hi,

I haven't seen any issues with this in linux-next, so go ahead, please.


cheers.
-- 
~Randy
