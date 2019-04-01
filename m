Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A976BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72FF62084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554102278;
	bh=ZKxeeB079ez9G8CDIMdrJQO8y9DkjvokTGhwsBLHoFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YEbJNd4zVVbfEivPpxHavJEaEvPSuOu14Y1mEkYOVlCP3lTzwYbPnpaqjZ2XNiN/u
	 QyY6y4leLN5v6MpsYVGXLhfNYrSJ3dvSDEhA5WUCsnt0NxueiNshuoBJZJF4zhkky+
	 ZF/Z37B0RJ05nKXBtDvuhPdGhWsoW7B97z9SJTjU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731742AbfDAHEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 03:04:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:42700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbfDAHEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 03:04:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9FAF20830;
        Mon,  1 Apr 2019 07:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554102276;
        bh=ZKxeeB079ez9G8CDIMdrJQO8y9DkjvokTGhwsBLHoFc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mzlhCsCQ2tEPEIYsjHKmgdv6yHMxOu/fDaeF1kp4pBRqDDVcPtcqmzExWA5Hbh5t1
         /B4PvcP9rkWU7E4W/oAMBOgfkQrwy3pJ5mapPoR8j+X2QV6r93PCm6ernq2BV2XZ6B
         aRwr1scOAkRiut6kKa0yDmJCOasPNOmVfX39Sld8=
Date:   Mon, 1 Apr 2019 09:04:24 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     =?utf-8?B?5ZCz5piK5r6E?= Ricky <ricky_wu@realtek.com>
Cc:     "arnd@arndb.de" <arnd@arndb.de>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] misc: rtsx: Enable OCP for rts522a rts524a rts525a
 rts5260
Message-ID: <20190401070424.GA20095@kroah.com>
References: <20190307094415.4853-1-ricky_wu@realtek.com>
 <BDFC8C62036EBE41BBBC808595CAAECA030790E7@RTITMBSVM07.realtek.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BDFC8C62036EBE41BBBC808595CAAECA030790E7@RTITMBSVM07.realtek.com.tw>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 06:40:19AM +0000, 吳昊澄 Ricky wrote:
> Dear all,
> 
> May I know how is this patch going on ? 
> Is it work well on your side?
> We have some guest want to know what stage is this patch going to

This patch is already in the 5.1-rc1 release, you can see it on
git.kernel.org in Linus's tree.  It will be in the final 5.1 release
which should happen in a few weeks.

thanks,

greg k-h
