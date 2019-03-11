Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A9CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 03:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EAE2206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 03:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PO39Y+g/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfCKDwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 23:52:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37492 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbfCKDwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 23:52:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=R/JJY+Fzox0n6gWzJmHh8OwouUibGB3HPKZVPqj4BSs=; b=PO39Y+g/N/jDwcale0v9WuudH
        FLZYsm4Cw2GlhIJRu/YLUIPtUuvjmAPiKqxlFAV0X23XhdFAQInIVzXwIt6Hr13zsDckxsRQsCVD7
        gq+5wSdA9+eUmv+KZKV60TKGhWOH2qvMtr1naqLzmMca89/CN27HjhPDoYGgN/IQQYQdLBu6KPZUe
        hZt93qIcZlptWeoJwaptRBzZjGrG6jB68+2i0o3ghki1vAQCeeXto3c/d1TDB2t9Etq8em4ec/jmP
        ulfgkoY7PhvQozWU2Qwu7tNETE8e1gzkYquOXJ96gpfW5OGvGf0N3ec7XW1IS142gTaevbmFI5Ig3
        yws5/w//Q==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h3BzR-0004VI-3O; Mon, 11 Mar 2019 03:52:37 +0000
Subject: Re: [PATCH 3/4] Add header file,Kconfig and Makefile
To:     =?UTF-8?B?TW9ycmlzIEt1IOWPpOaWh+S/ig==?= <morris_ku@sunix.com>,
        Morris Ku <saumah@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>
References: <20190308123547.20578-1-saumah@gmail.com>
 <c23c156e-0493-96e2-f4eb-0171e8c8fc58@infradead.org>
 <HK2PR03MB45297EB467A0A7550CCBB94795480@HK2PR03MB4529.apcprd03.prod.outlook.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ae1cd94e-9c1c-e05c-ab82-73003fa1ab0e@infradead.org>
Date:   Sun, 10 Mar 2019 20:52:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <HK2PR03MB45297EB467A0A7550CCBB94795480@HK2PR03MB4529.apcprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/19 8:25 PM, Morris Ku 古文俊 wrote:
> Hi,
> 
>> This patch add header file, Kconfig and Makefile. 
>> 
>> Signed-off-by: Morris Ku <saumah@gmail.com>
>> ---
> ok , I'll delete Kconfig  in next version.

Hi,
Please just send plain text emails -- no html.

vger.kernel.org (the mailing list server) ignores emails
that contain html.

thanks.
-- 
~Randy
