Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F82C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 357B020643
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbfDWQfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:35:23 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:53860 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbfDWQfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:35:21 -0400
Received: from marcel-macpro.fritz.box (p4FF9FD9B.dip0.t-ipconnect.de [79.249.253.155])
        by mail.holtmann.org (Postfix) with ESMTPSA id 7DBF4CF2DA;
        Tue, 23 Apr 2019 18:43:29 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [RFC v1] Bluetooth: hci_core: Don't stop BT if the BD address
 missing in dts
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190418132123.12816-1-bgodavar@codeaurora.org>
Date:   Tue, 23 Apr 2019 18:35:18 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <371A1719-7CDD-4940-9D6F-0F3339FA50E6@holtmann.org>
References: <20190418132123.12816-1-bgodavar@codeaurora.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Balakrishna,

> When flag HCI_QUIRK_USE_BDADDR_PROPERTY is set, we will read the
> bluetooth address from dts. If the bluetooth address node is missing
> from the dts we will enable it controller UNCONFIGURED state.
> This patch enables the normal flow even if the BD address is missing
> from the dts tree.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
> net/bluetooth/hci_core.c | 2 --
> 1 file changed, 2 deletions(-)

can I get an ACK for this one?

Regards

Marcel

