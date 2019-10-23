Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3932CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 842282173B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391661AbfJWMoB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 08:44:01 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:43425 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391648AbfJWMoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:44:01 -0400
Received: from marcel-macpro.fritz.box (p4FEFC197.dip0.t-ipconnect.de [79.239.193.151])
        by mail.holtmann.org (Postfix) with ESMTPSA id E87EBCECDF;
        Wed, 23 Oct 2019 14:52:59 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.19\))
Subject: Re: [PATCH] Revert "Bluetooth: hci_ll: set operational frequency
 earlier"
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHCN7xKAkYacV6qWuONVqRyJuODt2mNquTWAgEFb0NcjjqpnsA@mail.gmail.com>
Date:   Wed, 23 Oct 2019 14:43:59 +0200
Cc:     "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adam Ford <adam.ford@logicpd.com>,
        Sebastian Reichel <sre@kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <D50D569D-E0ED-4682-880F-396590BFE3A6@holtmann.org>
References: <20191002114626.12407-1-aford173@gmail.com>
 <1550E9D9-43ED-4345-A9AF-6D9F097FC64E@holtmann.org>
 <CAHCN7xKA9-K4uYU9oFW+A7ywc8TGixNa-yHJgL7uSTbyXnisTQ@mail.gmail.com>
 <CAHCN7xKAkYacV6qWuONVqRyJuODt2mNquTWAgEFb0NcjjqpnsA@mail.gmail.com>
To:     Adam Ford <aford173@gmail.com>
X-Mailer: Apple Mail (2.3594.4.19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

>>>> As nice as it would be to update firmware faster, that patch broke
>>>> at least two different boards, an OMAP4+WL1285 based Motorola Droid
>>>> 4, as reported by Sebasian Reichel and the Logic PD i.MX6Q +
>>>> WL1837MOD.
>>>> 
>>>> This reverts commit a2e02f38eff84f199c8e32359eb213f81f270047.
>>>> 
>>>> Signed-off-by: Adam Ford <aford173@gmail.com>
>>> 
>>> patch has been applied to bluetooth-next tree.
>> 
>> Any change this can get pushed upstream to stable?  (including 5.4?)
>> 
> 
> Marcel,  I have confirmed this revert also fixes a regression on my
> omap36xx based device using a wl1283 Bluetooth.  At this point, I
> believe we've identified at least 3 devices with regressions that this
> revert fixes.

as soon as we have done our pull request and this is in Linus’ tree, feel free to suggest it for -stable tree inclusion.

Regards

Marcel

