Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F85C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 16:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8EE520857
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 16:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfCBQj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 11:39:59 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:47704 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfCBQj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 11:39:58 -0500
Received: from marcel-macpro.fritz.box (p4FF9F361.dip0.t-ipconnect.de [79.249.243.97])
        by mail.holtmann.org (Postfix) with ESMTPSA id 3D16BCF352;
        Sat,  2 Mar 2019 17:47:53 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v2] hci_qca: Reduce delay after sending baudrate request
 for WCN3990
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190227235223.68668-1-mka@chromium.org>
Date:   Sat, 2 Mar 2019 17:39:56 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Hemantg <hemantg@codeaurora.org>
Content-Transfer-Encoding: 7bit
Message-Id: <5FC9D655-DEC2-4FC9-AB62-617FB08D694A@holtmann.org>
References: <20190227235223.68668-1-mka@chromium.org>
To:     Matthias Kaehlcke <mka@chromium.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

> The current 300ms delay after a baudrate change is extremely long.
> For WCN3990 it is sufficient to wait 10ms after the baudrate change
> request has been sent over the wire.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v2:
> - moved wait for the request to be sent into the common code path
> - s/WCM/WCN/ in commit message
> - rebased on latest bluetooth-next (5364a0b4f4be0 "arm64: dts:
>  rockchip: move QCA6174A wakeup pin into its USB node")
> ---
> drivers/bluetooth/hci_qca.c | 26 ++++++++++++++++++--------
> 1 file changed, 18 insertions(+), 8 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

