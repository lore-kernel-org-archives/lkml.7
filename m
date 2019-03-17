Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0708C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 12:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44432148D
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 12:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552824985;
	bh=icQqdIV+EvOlrG09RFY7s7dLZ2hZmpdk7Qb2nivd9Lo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DbCb79UMysh98RLf3W30SoLndUMA6B0Wux9BSKVxtFA8vJdfETaKT0q7FfX9wTv7N
	 TJZsIEWsgO3TxoLZnE6K59It3Cgg590FBMKuvMjrnxboDBQZjWtl9R4zJ/4Jv3knbc
	 g1F0dbki/1sRgpe3kn8o0x43mk2N+h1E81Tt0tjI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfCQMQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 08:16:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:47648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbfCQMQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 08:16:24 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DE5A2148D;
        Sun, 17 Mar 2019 12:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552824983;
        bh=icQqdIV+EvOlrG09RFY7s7dLZ2hZmpdk7Qb2nivd9Lo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sQ5YPE4IwhFBh7yqyYdY/cbf1nDL/Y4L6zQ9dFcREaYkjh0YOrrvL0Aiv89I3eQBn
         x3wXjT9s7QbRTFrQUu2mk/gZjG0PxENtpZ8XRRfnlFex4MQow/DFUZ0OAvzbtc0aCY
         NV3w1sdh34x8dgbbyu+blwSVpKA0HIOA3dsVn4rg=
Date:   Sun, 17 Mar 2019 13:16:21 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCHv2] staging: rtl8723bs: do not use __constant_cpu_to_le16
Message-ID: <20190317121621.GA7832@kroah.com>
References: <20190317114803.21670-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190317114803.21670-1-sergey.senozhatsky@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2019 at 08:48:03PM +0900, Sergey Senozhatsky wrote:
> From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>

Why ".work"?

> 
> cpu_to_le16() is capable enough to detect __builtin_constant_p()
> and to use an appropriate compile time ___constant_swahbXX()
> function.
> 
> So we can use cpu_to_le16() instead of __constant_cpu_to_le16().
> 
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

Email address does not match up to the From: line above :(

