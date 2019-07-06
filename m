Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFA1C0650E
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 10:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEEF321670
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 10:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfGFKvh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 06:51:37 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:42581 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfGFKva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 06:51:30 -0400
Received: from [192.168.0.113] (CMPC-089-239-107-172.CNet.Gawex.PL [89.239.107.172])
        by mail.holtmann.org (Postfix) with ESMTPSA id E30B4CF163;
        Sat,  6 Jul 2019 13:00:00 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] bluetooth: hci_ll: Refactor download_firmware
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190701205713.2833-1-fabian.schindlatz@fau.de>
Date:   Sat, 6 Jul 2019 12:51:28 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?Q?Thomas_R=C3=B6thenbacher?= <thomas.roethenbacher@fau.de>
Content-Transfer-Encoding: 8BIT
Message-Id: <25689519-DE1B-4BB6-9C36-4C73F2895E07@holtmann.org>
References: <20190701205713.2833-1-fabian.schindlatz@fau.de>
To:     Fabian Schindlatz <fabian.schindlatz@fau.de>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabian,

> Extract the new function send_command_from_firmware from
> download_firmware, which helps with the readability of the switch
> statement. This way the code is less deeply nested and also no longer
> exceeds the 80 character limit.
> 
> Co-developed-by: Thomas Röthenbacher <thomas.roethenbacher@fau.de>
> Signed-off-by: Thomas Röthenbacher <thomas.roethenbacher@fau.de>
> Signed-off-by: Fabian Schindlatz <fabian.schindlatz@fau.de>
> ---
> drivers/bluetooth/hci_ll.c | 45 ++++++++++++++++++++++++--------------
> 1 file changed, 28 insertions(+), 17 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

