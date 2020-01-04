Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C792C2D0C2
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 09:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3C7A217F4
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 09:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgADJ64 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 04:58:56 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:43834 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgADJ6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 04:58:55 -0500
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id AB1DECED12;
        Sat,  4 Jan 2020 11:08:09 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH v4] bluetooth: hci_bcm: enable IRQ capability from node
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <08ae6108-0829-3bb4-f398-7e6a58719d29@baylibre.com>
Date:   Sat, 4 Jan 2020 10:58:53 +0100
Cc:     Johan Hovold <johan@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        BlueZ devel list <linux-bluetooth@vger.kernel.org>,
        nsaenzjulienne@suse.de, linux-kernel@vger.kernel.org,
        khilman@baylibre.com
Content-Transfer-Encoding: 8BIT
Message-Id: <8EBBCE1B-688D-4097-A2AF-6E099A0AD68B@holtmann.org>
References: <20191213105521.4290-1-glaroque@baylibre.com>
 <20191213111702.GX10631@localhost>
 <162e5588-a702-6042-6934-dd41b64fa1dc@baylibre.com>
 <20191213134404.GY10631@localhost>
 <08ae6108-0829-3bb4-f398-7e6a58719d29@baylibre.com>
To:     Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guillaume,

>>>>> @@ -1421,6 +1422,7 @@ static int bcm_serdev_probe(struct serdev_device *serdev)
>>>>> #endif
>>>>> 	bcmdev->serdev_hu.serdev = serdev;
>>>>> 	serdev_device_set_drvdata(serdev, bcmdev);
>>>>> +	bcmdev->irq = of_irq_get(bcmdev->dev->of_node, 0);
>>>> Shouldn't you be used using of_irq_get_byname()?
>>> i can use it if you prefer but no other interrupt need to be defined
>> Maybe not needed then. Was just thinking it may make it more clear that
>> you now have two ways to specify the "host-wakeup" interrupt (and in
>> your proposed implementation the interrupts-property happens to take
>> priority). Perhaps that can be sorted out when you submit the binding
>> update for review.
> 
> no problem i add a "host-wakeup" interrupt-name.
> you are right it will be more clear with name and we know why this interrupt is needed.

have I missed the v5 or are still sending it?

Regards

Marcel

