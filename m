Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62F4C742A8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 07:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F382084B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 07:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbfGLHPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 03:15:53 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:59381 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfGLHPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 03:15:52 -0400
Received: from [192.168.21.103] (unknown [157.25.100.178])
        by mail.holtmann.org (Postfix) with ESMTPSA id 5ABE1CF2C4;
        Fri, 12 Jul 2019 09:24:23 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v1] Bluetooth: hci_qca: Send VS pre shutdown command.
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1562908180-7468-1-git-send-email-c-hbandi@codeaurora.org>
Date:   Fri, 12 Jul 2019 09:15:49 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bgodavar@codeaurora.org, anubhavg@codeaurora.org
Content-Transfer-Encoding: 7bit
Message-Id: <4D1C3F9F-6E0D-4B94-8372-DA7EB624282F@holtmann.org>
References: <1562908180-7468-1-git-send-email-c-hbandi@codeaurora.org>
To:     Harish Bandi <c-hbandi@codeaurora.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Harish,

> WCN399x chips are coex chips, it needs a VS pre shutdown
> command while turning off the BT. So that chip can inform
> BT is OFF to other active clients.
> 
> Signed-off-by: Harish Bandi <c-hbandi@codeaurora.org>
> ---
> drivers/bluetooth/btqca.c   | 21 +++++++++++++++++++++
> drivers/bluetooth/btqca.h   |  7 +++++++
> drivers/bluetooth/hci_qca.c |  3 +++
> 3 files changed, 31 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

