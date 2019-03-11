Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68748C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37C7B20643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbfCKSyv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:54:51 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:49254 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfCKSyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:54:51 -0400
Received: from marcel-macpro.fritz.box (p4FEFC449.dip0.t-ipconnect.de [79.239.196.73])
        by mail.holtmann.org (Postfix) with ESMTPSA id 47280CF2CA;
        Mon, 11 Mar 2019 20:02:47 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v2] Bluetooth: hci_qca: Add helper function to get the
 chip family
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190311183831.174391-1-mka@chromium.org>
Date:   Mon, 11 Mar 2019 19:54:48 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Hemantg <hemantg@codeaurora.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <A2E5F727-578B-42D6-94AC-152A510532A7@holtmann.org>
References: <20190311183831.174391-1-mka@chromium.org>
To:     Matthias Kaehlcke <mka@chromium.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

> Many functions obtain a 'struct qca_serdev' only to read the btsoc_type
> field. Add a helper function that encapsulates this.
> 
> This also fixes crashes observed on platforms with ROME controllers
> that are instantiated through ldisc and not as serdev clients. The
> crashes are caused by NULL pointer dereferentiations, which stem from
> the driver's assumption that a QCA HCI device is always associated with
> a serdev device.
> 
> Fixes: fa9ad876b8e0 ("Bluetooth: hci_qca: Add support for Qualcomm Bluetooth chip wcn3990")
> Reported-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v2:
> - make ROME the default type for non-serdev platforms
> ---
> drivers/bluetooth/hci_qca.c | 45 +++++++++++++++++++++----------------
> 1 file changed, 26 insertions(+), 19 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

