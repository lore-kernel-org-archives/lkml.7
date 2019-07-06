Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27781C0650E
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 10:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0780521670
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 10:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfGFKvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 06:51:20 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:59394 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfGFKvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 06:51:18 -0400
Received: from [192.168.0.113] (CMPC-089-239-107-172.CNet.Gawex.PL [89.239.107.172])
        by mail.holtmann.org (Postfix) with ESMTPSA id 891EBCEFAE;
        Sat,  6 Jul 2019 12:59:48 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v9] Bluetooth: btqca: inject command complete event during
 fw download
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190528214322.171922-1-mka@chromium.org>
Date:   Sat, 6 Jul 2019 12:51:16 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Harish Bandi <c-hbandi@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>
Content-Transfer-Encoding: 7bit
Message-Id: <AE7AB525-CFAC-411E-A615-54AF4E6B645E@holtmann.org>
References: <20190528214322.171922-1-mka@chromium.org>
To:     Matthias Kaehlcke <mka@chromium.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

> Latest qualcomm chips are not sending an command complete event for
> every firmware packet sent to chip. They only respond with a vendor
> specific event for the last firmware packet. This optimization will
> decrease the BT ON time. Due to this we are seeing a timeout error
> message logs on the console during firmware download. Now we are
> injecting a command complete event once we receive an vendor specific
> event for the last RAM firmware packet.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v9:
> - define QCA_HCI_CC_SUCCESS (again)
> - use QCA_HCI_CC_OPCODE instead of HCI_OP_NOP
> 
> Changes in v8:
> - renamed QCA_HCI_CC_SUCCESS to QCA_HCI_CC_OPCODE
> - use 0xFC00 as opcode of the injected event instead of 0
> - added Matthias' tags from the v7 review
> ---
> drivers/bluetooth/btqca.c | 39 ++++++++++++++++++++++++++++++++++++++-
> drivers/bluetooth/btqca.h |  4 ++++
> 2 files changed, 42 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

