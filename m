Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A78C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 07:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03337206D3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 07:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfLQHpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 02:45:11 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:59658 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfLQHpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 02:45:11 -0500
Received: from marcel-macbook.fritz.box (p4FF9F0D1.dip0.t-ipconnect.de [79.249.240.209])
        by mail.holtmann.org (Postfix) with ESMTPSA id DF255CED64;
        Tue, 17 Dec 2019 08:54:21 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH v1] Bluetooth: hci_qca: Replace of_device_get_match_data
 with device_get_match_data
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20191213085045.24637-1-rjliao@codeaurora.org>
Date:   Tue, 17 Dec 2019 08:45:09 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <DA8056C4-352C-4DF2-A5B9-AD9216B2C823@holtmann.org>
References: <20191213085045.24637-1-rjliao@codeaurora.org>
To:     Rocky Liao <rjliao@codeaurora.org>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rocky,

> Replace of_device_get_match_data with device_get_match_data to make driver
> work across platforms.
> 
> Signed-off-by: Rocky Liao <rjliao@codeaurora.org>
> ---
> drivers/bluetooth/hci_qca.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

