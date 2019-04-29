Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94D1C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 09:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E0220673
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 09:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="oDWbMUPc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbfD2JlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 05:41:00 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:18913 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbfD2JlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 05:41:00 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cc6c6a70000>; Mon, 29 Apr 2019 02:40:55 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 29 Apr 2019 02:40:59 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 29 Apr 2019 02:40:59 -0700
Received: from [10.19.120.158] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 29 Apr
 2019 09:40:58 +0000
Subject: Re: [PATCH 0/6] usb: Add Clear_TT_Buffer support for XHCI
To:     Alan Stern <stern@rowland.harvard.edu>
References: <Pine.LNX.4.44L0.1904261128380.23806-100000@netrider.rowland.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Jim Lin <jilin@nvidia.com>
Message-ID: <00107302-c6e4-84a7-ebad-d3125c00c586@nvidia.com>
Date:   Mon, 29 Apr 2019 17:40:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1904261128380.23806-100000@netrider.rowland.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556530855; bh=ccGmS4A3lOHZoFUowckctKathxHgA41PTCfg4Lvjt2M=;
        h=X-PGP-Universal:Subject:To:References:CC:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding;
        b=oDWbMUPcyTr6ch+EfDqAmmLqIB81wnp71oVCxWtv3huDR5lSP1cyNfRxWAbTgsbq3
         LL3wqmb1l7bCPuOFdxkWxhjaCk3BLgN+pnxbLW2FaQlfcRc+vur/CgT62FXPQCRU2s
         f4i1qysYw3VM2Nfy6zmGA7aFLfz439bpPP9Ni0WNBJaxEiOSW7I6sXnzalWyzZdxet
         WolvK1jTNl8562byEsm8/aFglyo9skzBWQcfgx6MpV9wm2dnEDGvXvfkIB9iTQrDg8
         FBmYBMpkU3Xu5deML+IUbGjLDbm3zNjQBvDPYgfvpkPa0/M9K1eiHD50siy+nBvbvc
         e+FW//Vw+7h+Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for review.

Abandon this series of patches.

And will send out another minimized patch later.

Jim


On 2019=E5=B9=B404=E6=9C=8826=E6=97=A5 23:34, Alan Stern wrote:
> On Fri, 26 Apr 2019, Jim Lin wrote:
>
>> Jim Lin (6):
>>    usb: hub:Extend usb_hub_clear_tt_buffer parameter
>>    usb: isp1760:Adjusted for usb_hub_clear_tt_buffer
>>    usb: fotg210:Adjusted for usb_hub_clear_tt_buffer
>>    usb: ehci: Adjusted for usb_hub_clear_tt_buffer
>>    usb: dwc2: Adjusted for usb_hub_clear_tt_buffer
>>    usb: xhci: Add Clear_TT_Buffer
>>
>>   drivers/usb/core/hub.c            |  5 +++--
>>   drivers/usb/dwc2/hcd_intr.c       |  2 +-
>>   drivers/usb/host/ehci-q.c         |  2 +-
>>   drivers/usb/host/fotg210-hcd.c    |  2 +-
>>   drivers/usb/host/xhci-ring.c      | 25 +++++++++++++++++++++++++
>>   drivers/usb/host/xhci.c           |  7 +++++++
>>   drivers/usb/host/xhci.h           |  3 +++
>>   drivers/usb/isp1760/isp1760-hcd.c |  5 +++--
>>   include/linux/usb/hcd.h           |  2 +-
>>   9 files changed, 45 insertions(+), 8 deletions(-)
> This doesn't explain anything.  After reading the patches, I could see
> that patches 2-5 are needed in order to work with patch 1, but I don't
> know why patch 1 was needed in the first place.  It looks like patch 1
> forces callers to add an extra argument containing information that is
> already available, so why is the extra argument needed?
>
> In any case, this is the sort of the thing you should explain to people
> instead of forcing them to figure it out for themselves.
>
> Alan Stern
>
--nvpublic
