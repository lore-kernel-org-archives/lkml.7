Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2375AC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 13:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00AAC206B8
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 13:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393772AbfIFN4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 09:56:32 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:35945 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388097AbfIFN4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 09:56:31 -0400
Received: from marcel-macbook.fritz.box (p4FEFC197.dip0.t-ipconnect.de [79.239.193.151])
        by mail.holtmann.org (Postfix) with ESMTPSA id 063F6CECDF;
        Fri,  6 Sep 2019 16:05:18 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] Bluetooth: hidp: Fix error checks in
 hidp_get/set_raw_report
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190906094158.8854-1-streetwalkermc@gmail.com>
Date:   Fri, 6 Sep 2019 15:56:29 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Fabian Henneke <fabian.henneke@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <440C3662-1870-44D8-B4E3-C290CE154F1E@holtmann.org>
References: <20190906094158.8854-1-streetwalkermc@gmail.com>
To:     Dan Elkouby <streetwalkermc@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

> Commit 48d9cc9d85dd ("Bluetooth: hidp: Let hidp_send_message return
> number of queued bytes") changed hidp_send_message to return non-zero
> values on success, which some other bits did not expect. This caused
> spurious errors to be propagated through the stack, breaking some (all?)
> drivers, such as hid-sony for the Dualshock 4 in Bluetooth mode.
> 
> Signed-off-by: Dan Elkouby <streetwalkermc@gmail.com>
> ---
> net/bluetooth/hidp/core.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

