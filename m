Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A222FC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 03:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A36E20840
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 03:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qNe+Dq6D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbfCHDmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 22:42:04 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52582 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfCHDmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 22:42:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oUCuY/K42dG5WQiNZHcixxhzJNLvlqs7Amh+8KSRX20=; b=qNe+Dq6D0YB8bD6Ra/4H0EB7q
        N7g3K5ytMqzBEi7333eEQfYKi2Jrhck5IfCGzKof1nGclPWEMn84UCTRzr/d6BFsZFO23OFmw+fu8
        Q82rS8GZlkZdGR0GWMD1d5JWTeQDPys0frPphX5wCZzOHV76hjXF2MXYW4FWpWv0itaH9XJ5zXYA6
        J8CeMH4jPY+oIBIc98OXr3F8dvgtFviPkN/JmaRM/FiYEHYll9lrMsN7vXlK29ePg8JDbP0xmVus+
        kVr3Dpt4gbgvw3P2uCeWSsQG9s+6H7vtOJyK/nMk0gG3ZjbVSrth+fHqVZaHocko5aVa2Ln2YbfVz
        vsMU8EiwQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h26OZ-0006iX-VW; Fri, 08 Mar 2019 03:42:04 +0000
Subject: Re: [PATCH 8/9] docs: Fix Title underline too short warning
To:     "Tobin C. Harding" <tobin@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190307211153.28400-1-tobin@kernel.org>
 <20190307211153.28400-9-tobin@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a195b380-4be4-512d-0a24-9f83082b9d83@infradead.org>
Date:   Thu, 7 Mar 2019 19:42:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190307211153.28400-9-tobin@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/19 1:11 PM, Tobin C. Harding wrote:
> Sphinx emits a bunch of 'Title underline too short' warnings.  We can
> fix these by using the correct length underlines.
> 
> Fix Title underline too short warning by amending heading underline.
> 
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> ---
>  Documentation/filesystems/path-lookup.rst | 24 +++++-----
>  Documentation/networking/snmp_counter.rst | 58 +++++++++++------------
>  2 files changed, 41 insertions(+), 41 deletions(-)

Hi,

These are already fixed.  Did you try the pending docs tree
(for which a pull request was sent a few hours ago)?

thanks,
-- 
~Randy
