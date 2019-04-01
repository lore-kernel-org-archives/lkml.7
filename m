Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B8BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F2ED20830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554111555;
	bh=YFeAeQaOyOMKq5Z71RlOQlE/6P/rzNk+E5RXmVA/KTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qIfQsxCb+D3XQ2DVRZpqT8Y6B/zXY3lTl4/ybuOkrIp01gwZXUZH7afD/pclBx7eI
	 cxKLGX79bstrt/4LDlcQKySzbSujyL9VHQgxhFagREq8t6WIqBkF7VkQ6xMP6D4wiJ
	 gWCZ57WIGDObL8tDMkJECMvnoyjQFibA1m6EZI4E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfDAJjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 05:39:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:53858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbfDAJjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 05:39:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E14420830;
        Mon,  1 Apr 2019 09:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554111552;
        bh=YFeAeQaOyOMKq5Z71RlOQlE/6P/rzNk+E5RXmVA/KTg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JTBYc0Ah9L4pF7PBfYnZYEbA3z71TSfcicmRVttV64ALlzO6ISi5sm6LuQh3g6B8J
         dFOjubH8SyZ7QYqUQYZNdHEo8EqYdqAqLaXTH6EJ7ppdpX4PHgqYok5ErAA5s90+Fc
         GkkFgCk4/dMa2t4GX9+jy6ZXTC1K65WAtY7zKygI=
Date:   Mon, 1 Apr 2019 11:39:00 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     =?utf-8?B?5ZCz5piK5r6E?= Ricky <ricky_wu@realtek.com>
Cc:     "arnd@arndb.de" <arnd@arndb.de>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] misc: rtsx: Enable OCP for rts522a rts524a rts525a
 rts5260
Message-ID: <20190401093900.GA32682@kroah.com>
References: <20190307094415.4853-1-ricky_wu@realtek.com>
 <BDFC8C62036EBE41BBBC808595CAAECA030790E7@RTITMBSVM07.realtek.com.tw>
 <20190401070424.GA20095@kroah.com>
 <BDFC8C62036EBE41BBBC808595CAAECA0307912A@RTITMBSVM07.realtek.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BDFC8C62036EBE41BBBC808595CAAECA0307912A@RTITMBSVM07.realtek.com.tw>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 08:34:44AM +0000, 吳昊澄 Ricky wrote:
> Dear Greg k-h,
> 
> I saw the patch is already in Linus's tree
> But I found it is not my v3-patch
> Can you help me to check this status kindly?

I had already applied and submitted your patch when you sent the v3
patch.  I can not go back in time and change it.  If there is a
follow-on change that needs to be made, to bring it up to whatever your
v3 patch is, please send that so it can be applied.

thanks,

greg k-h
