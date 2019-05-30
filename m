Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0487C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 16:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F7225D5D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 16:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LBdgmbDm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfE3QKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 12:10:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58756 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfE3QKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 12:10:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CrDu0jNDhXvLN4tPiGa4OQrHQRQplcvYatA+4dyJNJs=; b=LBdgmbDmnRQFt8dUf3faOrVca
        ucEy2IUhF24KVguCRl7mUYGX1eZ5/oThD2LXwkEyMVjHqaD5BGBmQxJE4qyLTwounhCGwEU0EkzeE
        RG+w/GvIYMML70+Vq8lppAH+U+fHVK6VH4wQVszq8nmsBGdTgihjf9tHI306ysdWNCrgI32sLrSpc
        LUZ4nLIRI+lWTD4yE99IofjHZQbT1wbU1p/lBFbbpnjje+b3NHQtjwtga8khcyhK88ysbmGqX+Ao5
        SkAtBNEvd9puM2i4+lVzATCUznOgTX6Vs/xod2XEsuMVE+LLyr7SwZ2Xygfqv4+3I6jzNjnUtdNlH
        k2zkRAUGw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hWNd7-0007rn-NI; Thu, 30 May 2019 16:10:13 +0000
Subject: Re: linux-next: Tree for May 30 (firmware_loader)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20190530162132.6081d246@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <28716a14-772d-bc82-5111-34cd38cfda54@infradead.org>
Date:   Thu, 30 May 2019 09:10:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190530162132.6081d246@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/19 11:21 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20190529:
> 

on i386 or x86_64:
when CONFIG_PROC_SYSCTL is not set/enabled:

ld: drivers/base/firmware_loader/fallback_table.o:(.data+0x1c): undefined reference to `sysctl_vals'
ld: drivers/base/firmware_loader/fallback_table.o:(.data+0x20): undefined reference to `sysctl_vals'
ld: drivers/base/firmware_loader/fallback_table.o:(.data+0x40): undefined reference to `sysctl_vals'
ld: drivers/base/firmware_loader/fallback_table.o:(.data+0x44): undefined reference to `sysctl_vals'


-- 
~Randy
