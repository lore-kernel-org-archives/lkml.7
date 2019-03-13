Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1659EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 09:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C96232147C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 09:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfCMJIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 05:08:49 -0400
Received: from proxima.lasnet.de ([78.47.171.185]:38475 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbfCMJIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 05:08:49 -0400
Received: from localhost.localdomain (p200300E9D721079FBEBF6D7FF071FCD2.dip0.t-ipconnect.de [IPv6:2003:e9:d721:79f:bebf:6d7f:f071:fcd2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id B4304CA72E;
        Wed, 13 Mar 2019 10:08:46 +0100 (CET)
Subject: Re: [PATCH] net: ieee802154: fix a potential NULL pointer dereference
To:     "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Kangjie Lu <kjlu@umn.edu>
Cc:     "pakki001@umn.edu" <pakki001@umn.edu>,
        Alexander Aring <alex.aring@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190311072517.29740-1-kjlu@umn.edu>
 <BN3PR0301MB0897817BBE72CE6A33A1DE728E480@BN3PR0301MB0897.namprd03.prod.outlook.com>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <70435340-ecd3-2048-b1f2-b53e00a91d46@datenfreihafen.org>
Date:   Wed, 13 Mar 2019 10:08:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <BN3PR0301MB0897817BBE72CE6A33A1DE728E480@BN3PR0301MB0897.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On 11.03.19 08:30, Hennerich, Michael wrote:
> 
> 
>> -----Original Message-----
>> From: Kangjie Lu [mailto:kjlu@umn.edu]
>> Sent: Montag, 11. März 2019 08:25
>> To: kjlu@umn.edu
>> Cc: pakki001@umn.edu; Hennerich, Michael <Michael.Hennerich@analog.com>; Alexander Aring <alex.aring@gmail.com>; Stefan
>> Schmidt <stefan@datenfreihafen.org>; David S. Miller <davem@davemloft.net>; linux-wpan@vger.kernel.org;
>> netdev@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: [PATCH] net: ieee802154: fix a potential NULL pointer dereference
>>
>> In case alloc_ordered_workqueue fails, the fix releases
>> sources and returns -ENOMEM to avoid NULL pointer dereference.
>>
>> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> 
> Acked-by: Michael Hennerich <michael.hennerich@analog.com>

Strange enough patchwork did not pick up this acked by from you. I added
in manually to the patch. Just so you know.

regards
Stefan Schmidt
