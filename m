Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8367BC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 07:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64DAA2067C
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 07:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfLQHkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 02:40:51 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:53775 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfLQHkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 02:40:51 -0500
Received: from marcel-macbook.fritz.box (p4FF9F0D1.dip0.t-ipconnect.de [79.249.240.209])
        by mail.holtmann.org (Postfix) with ESMTPSA id 21291CED46;
        Tue, 17 Dec 2019 08:50:01 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH v1 2/2] dt-bindings: net: broadcom-bluetooth: Document
 BCM4329 support
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20191215185253.14024-2-digetx@gmail.com>
Date:   Tue, 17 Dec 2019 08:40:49 +0100
Cc:     Rob Herring <robh+dt@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <E971B7A3-B5F2-4F21-B0F4-B7D289080D9A@holtmann.org>
References: <20191215185253.14024-1-digetx@gmail.com>
 <20191215185253.14024-2-digetx@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

> The BCM4329 is a 802.11 a/b/g/n WiFi + Bluetooth 2.1 chip which is found
> in Azurewave AW-NH611 WiFi+BT module.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
> Documentation/devicetree/bindings/net/broadcom-bluetooth.txt | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

