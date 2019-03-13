Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55759C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 07:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 264E12171F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 07:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfCMHyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 03:54:37 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:37328 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbfCMHyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 03:54:37 -0400
Received: from marcel-macpro.fritz.box (p4FEFC449.dip0.t-ipconnect.de [79.239.196.73])
        by mail.holtmann.org (Postfix) with ESMTPSA id 7AA1CCF358;
        Wed, 13 Mar 2019 09:02:34 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] Bluetooth: btqca: Fix misspelling of 'baudrate'
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAG5bF+TdR-A8x9L5vxA9qQFFa46coHXWdbgCKJNnmK-k3mr9dw@mail.gmail.com>
Date:   Wed, 13 Mar 2019 08:54:34 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Hemantg <hemantg@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>,
        Harish Bandi <c-hbandi@codeaurora.org>
Content-Transfer-Encoding: 7bit
Message-Id: <742E6566-3AAD-4685-89FA-0CE14309BB07@holtmann.org>
References: <CAG5bF+TdR-A8x9L5vxA9qQFFa46coHXWdbgCKJNnmK-k3mr9dw@mail.gmail.com>
To:     Matthias Kaehlcke <mka@chromium.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

> Rename the misspelled struct 'qca_bardrate' to 'qca_baudrate'
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> drivers/bluetooth/btqca.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

