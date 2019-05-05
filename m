Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAE7C004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 17:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 093DB20675
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 17:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbfEEReN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 13:34:13 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:36628 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbfEEReN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 13:34:13 -0400
Received: from marcel-macpro.fritz.box (p4FF9FD9B.dip0.t-ipconnect.de [79.249.253.155])
        by mail.holtmann.org (Postfix) with ESMTPSA id 3F8BBCEE02;
        Sun,  5 May 2019 19:42:26 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH v3 1/2] Bluetooth: hci_qca: Rename STATE_<flags> to
 QCA_<flags>
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190429232131.183049-1-mka@chromium.org>
Date:   Sun, 5 May 2019 19:34:12 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Harish Bandi <c-hbandi@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>
Content-Transfer-Encoding: 7bit
Message-Id: <A544D15F-0CBC-4E8D-A585-26F6B886C1FD@holtmann.org>
References: <20190429232131.183049-1-mka@chromium.org>
To:     Matthias Kaehlcke <mka@chromium.org>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

> Rename STATE_IN_BAND_SLEEP_ENABLED to QCA_IBS_ENABLED. The constant
> represents a flag (multiple flags can be set at once), not a unique
> state of the controller or driver.
> 
> Also make the flag an enum value instead of a pre-processor constant
> (more flags will be added to the enum group by another patch).
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v3:
> - rename STATE_IN_BAND_SLEEP_ENABLED to QCA_IBS_ENABLED
> 
> Changes in v2:
> - don't use BIT()
> - change to enum type
> - updated commit message
> ---
> drivers/bluetooth/hci_qca.c | 15 ++++++++-------
> 1 file changed, 8 insertions(+), 7 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

