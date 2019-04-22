Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B31C282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 04:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE57520859
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 04:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbfDVEsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 00:48:25 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:43298 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfDVEsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 00:48:25 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0B4F214DB85A6;
        Sun, 21 Apr 2019 21:48:24 -0700 (PDT)
Date:   Sun, 21 Apr 2019 21:48:23 -0700 (PDT)
Message-Id: <20190421.214823.1067084318038589092.davem@davemloft.net>
To:     crag0715@gmail.com
Cc:     netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, hayeswang@realtek.com,
        mario_limonciello@dell.com, crag.wang@dell.com, sjg@chromium.org,
        seanpaul@chromium.org, grundler@chromium.org, david.chen7@dell.com,
        f.fainelli@gmail.com, jslaby@suse.cz, gustavo@embeddedor.com,
        charles.hyde@dell.corp-partner.google.com, bigeasy@linutronix.de,
        zhongjiang@huawei.com
Subject: Re: [PATCH v2 1/1] r8152: sync sa_family with the media type of
 network device
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAP-8N0jiguFSdyeop3rxMoNdYJemCRSdohyOR4z8B3HDmdUmng@mail.gmail.com>
References: <20190422022307.19616-1-crag0715@gmail.com>
        <20190421.194453.2169045719820345607.davem@davemloft.net>
        <CAP-8N0jiguFSdyeop3rxMoNdYJemCRSdohyOR4z8B3HDmdUmng@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 21 Apr 2019 21:48:24 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Crag Wang <crag0715@gmail.com>
Date: Mon, 22 Apr 2019 11:17:49 +0800

> On Mon, Apr 22, 2019 at 10:44 AM David Miller <davem@davemloft.net> wrote:
>>
>>
>> Networking driver patches not sent to netdev@vger.kernel.org are very unlikely
>> to be integrated.
>>
>> Thank you.
> 
> Adding netdev@vger.kernel.org to this email, sorry about missing the
> recipient in the first place.

This does not get the patch queued up in patchwork, nor allow other readers of
netdev to see the patch so that it can be properly reviewed.

You must make a new, fresh, posting of your patch.
