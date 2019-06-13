Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF6BC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 20:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D98DD20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 20:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="moxFGE19"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbfFMUHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 16:07:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52548 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbfFMUHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 16:07:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZmPiORcOHqHhQtMeKPGW/zsji3FUaaCaqkpqz5XaKfM=; b=moxFGE191G2MhREBT+t4ixwAD
        zJWs1ILiWaY7S0TDVcWLPP9PhdnO0V5IQWaIx9ewrrWBtJ30ULz49pHNXB16ETkDUD6200s/1KeeK
        P5uDaz0z36I5UGT6k7oEFPGLyy+nVbDnVIQCQg30uVIgnvubZZFsfVAyvN3bPxnuaH8qap1DZ4Qw2
        BjvBk0zvuWF398KUsLJBSfpllemaUC7RaKhsHMGBq6s7WKt+D66eeHncon7RLKVtm+FxdIMqlhFVy
        9sNU4f6QOaVJGHJaX9Nm7jY5hbAJAO/tyEahbjeYz2oz5N5utTlr7Hj2zqiSX9C6oCsN4cFS0sbKI
        ekg3sh2CA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbW0i-0000R9-CE; Thu, 13 Jun 2019 20:07:48 +0000
Subject: Re: PC speaker
To:     Theodore Ts'o <tytso@mit.edu>, "R.F. Burns" <burnsrf@gmail.com>,
        linux-kernel@vger.kernel.org
References: <CABG1boNKq4Q49t2tFA863hi=jrFnJLarER5nyyGSpFPMbT1Qvg@mail.gmail.com>
 <20190613195705.GC9609@mit.edu>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f93838d9-2398-dd81-2eb7-ed31be27403c@infradead.org>
Date:   Thu, 13 Jun 2019 13:07:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190613195705.GC9609@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/19 12:57 PM, Theodore Ts'o wrote:
> On Thu, Jun 13, 2019 at 12:16:37PM -0400, R.F. Burns wrote:
>> Is it possible to write a kernel module which, when loaded, will blow
>> the PC speaker?
> 
> Yes; in fact, it's already been done.  See sound/drivers/pcsp/ in the
> Linux kernel sources.
> 
> 						- Ted
> 

Must be some kind of ritual by R.F. Burns:

Lots of repeated postings from them on June 12 of multiple years.

See https://lore.kernel.org/lkml/CABG1boNJirPD1bh5PyETz8jVSV6PyMwPYfhhVQWyztp8W-XjRg@mail.gmail.com/


-- 
~Randy
