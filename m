Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD5CC3A5A3
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 01:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F8622CF5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 01:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kxL5f0dW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfH1BOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 21:14:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59134 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfH1BOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 21:14:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:Cc:From:References:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hfSx8v0zhIV+bXC+CodQztxjQ/b6g4dcxtBZrzRlWPs=; b=kxL5f0dWo7sB0WNPrB0IaSLY7
        MbNT2c+q6KEjvIRj65dBT3HQu0J0qW2J+yuxyG93K/X1w6GQYhWFiPDwTrlwGDIUhnpoXDKMhvKNh
        G7keMO2VEKiqAmLzL1v0r3lUDWwvnxe3F/H2LTPH7MCTOE0WGt0F4b+sHbwkaLfLcoPSaA5Uvs6Sx
        X/7vpKszkDmVggCa7+U58gqc2KS2enuH4tRmyaZjeVU0ObU1qsqmO0gl5TQf1edJhcqJ0MnvSTvK7
        MreUZ+Ucmf+3ez2qvttBxfq8782KE01IEy+gsHiBcoqkRGj+kkaeVulwpjNrFKxEhZuo04pzKqX0u
        w4QUJsD/g==;
Received: from [2601:1c0:6200:6e8::4f71]
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2mXh-0001yi-EV; Wed, 28 Aug 2019 01:14:33 +0000
Subject: Re: mmotm 2019-08-24-16-02 uploaded
 (drivers/tty/serial/fsl_linflexuart.c:)
To:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20190824230323.REILuVBbY%akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Cc:     Fugang Duan <fugang.duan@nxp.com>
Message-ID: <b082b200-7298-6cd5-6981-44439bc2d788@infradead.org>
Date:   Tue, 27 Aug 2019 18:14:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190824230323.REILuVBbY%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/19 4:03 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2019-08-24-16-02 has been uploaded to
> 
>    http://www.ozlabs.org/~akpm/mmotm/
> 
> mmotm-readme.txt says
> 
> README for mm-of-the-moment:
> 
> http://www.ozlabs.org/~akpm/mmotm/
> 
> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> more than once a week.
> 
> You will need quilt to apply these patches to the latest Linus release (5.x
> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> http://ozlabs.org/~akpm/mmotm/series
> 
> The file broken-out.tar.gz contains two datestamp files: .DATE and
> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> followed by the base kernel version against which this patch series is to
> be applied.
> 
> This tree is partially included in linux-next.  To see which patches are
> included in linux-next, consult the `series' file.  Only the patches
> within the #NEXT_PATCHES_START/#NEXT_PATCHES_END markers are included in
> linux-next.

on i386:
when CONFIG_PRINTK is not set/enabled:

../drivers/tty/serial/fsl_linflexuart.c: In function ‘linflex_earlycon_putchar’:
../drivers/tty/serial/fsl_linflexuart.c:608:31: error: ‘CONFIG_LOG_BUF_SHIFT’ undeclared (first use in this function); did you mean ‘CONFIG_DEBUG_SHIRQ’?
  if (earlycon_buf.len >= 1 << CONFIG_LOG_BUF_SHIFT)
                               ^~~~~~~~~~~~~~~~~~~~
                               CONFIG_DEBUG_SHIRQ


-- 
~Randy
