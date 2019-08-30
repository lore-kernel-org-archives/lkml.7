Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433C3C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 12:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EAB421670
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 12:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbfH3Mst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 08:48:49 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:36333 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbfH3Mss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 08:48:48 -0400
Received: from marcel-macbook.fritz.box (p4FEFC580.dip0.t-ipconnect.de [79.239.197.128])
        by mail.holtmann.org (Postfix) with ESMTPSA id 7669DCECDE;
        Fri, 30 Aug 2019 14:57:33 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 1/2] Bluetooth: btrtl: Set
 HCI_QUIRK_SIMULTANEOUS_DISCOVERY
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190830120109.GA3033@laptop-alex>
Date:   Fri, 30 Aug 2019 14:48:47 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Max Chou <max.chou@realtek.com>
Content-Transfer-Encoding: 7bit
Message-Id: <9C749271-2ECF-4C71-A285-A3AB09938946@holtmann.org>
References: <20190830120109.GA3033@laptop-alex>
To:     Alex Lu <alex_lu@realsil.com.cn>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

> Realtek Bluetooth controllers can do both LE scan and BR/EDR inquiry
> at once, need to set HCI_QUIRK_SIMULTANEOUS_DISCOVERY quirk.
> 
> Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
> ---
> drivers/bluetooth/btrtl.c | 5 +++++
> 1 file changed, 5 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

