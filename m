Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9467C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F6A8206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729443AbfDWRaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 13:30:14 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:41146 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727745AbfDWRaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 13:30:14 -0400
Received: from marcel-macpro.fritz.box (p4FF9FD9B.dip0.t-ipconnect.de [79.249.253.155])
        by mail.holtmann.org (Postfix) with ESMTPSA id 6354CCF2DA;
        Tue, 23 Apr 2019 19:38:23 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH v2] Bluetooth: hci_qca: Give enough time to ROME
 controller to bootup.
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190401094908.11460-1-bgodavar@codeaurora.org>
Date:   Tue, 23 Apr 2019 19:30:12 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        Rocky Liao <rjliao@codeaurora.org>,
        Claire Chang <tientzu@chromium.org>
Content-Transfer-Encoding: 7bit
Message-Id: <5CD7CD42-D86C-4C9D-BB06-40C5BC61AE4C@holtmann.org>
References: <20190401094908.11460-1-bgodavar@codeaurora.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Balakrishna,

> This patch enables enough time to ROME controller to bootup
> after we bring the enable pin out of reset.
> 
> Fixes: 05ba533c5c11 ("Bluetooth: hci_qca: Add serdev support").
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> Reviewed-by: Rocky Liao <rjliao@codeaurora.org>
> Tested-by: Rocky Liao <rjliao@codeaurora.org>
> Tested-by: Claire Chang <tientzu@chromium.org>
> ---
> Changes in v2:
>  * added fixes tag in the commit text.
> ---
> drivers/bluetooth/hci_qca.c | 2 ++
> 1 file changed, 2 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

