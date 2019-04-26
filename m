Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11281C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD603206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfDZRAO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 13:00:14 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:60716 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfDZRAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 13:00:13 -0400
Received: from marcel-macpro.fritz.box (p4FF9FD9B.dip0.t-ipconnect.de [79.249.253.155])
        by mail.holtmann.org (Postfix) with ESMTPSA id 52EF3CEEB0;
        Fri, 26 Apr 2019 19:08:22 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH v8 0/2] Enable Bluetooth functionality for WCN3998.
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1556286962-3132-1-git-send-email-c-hbandi@codeaurora.org>
Date:   Fri, 26 Apr 2019 19:00:10 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bgodavar@codeaurora.org, anubhavg@codeaurora.org,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <548B5CB0-492C-4D64-B4A5-4D66F6016F46@holtmann.org>
References: <1556286962-3132-1-git-send-email-c-hbandi@codeaurora.org>
To:     Harish Bandi <c-hbandi@codeaurora.org>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Harish,

> This patch series we add support for WCN3998 BT chip set. This new chip set
> is based from the WCN3990 with minimal power numbers. So here in this patch
> The major difference between wcn3990 and WCN3998 is only power numbers.
> where as init process and fw download is same with wcn3990.
> So we add new compatible for WCN3998. 
> Removed the Reading of regulator values from dts.
> Added new compatible for WCN3998.
> Changes in V8:
> Removed export of qca_is_wcn399x() and added as inline function
> Added robh reviewed by tag in commit text
> Changes in V7:
> Initialized rom_ver to 0 to fix compiler warning 
> Changed Commit text for DT patch
> Changes in V6:
> changed return value to false in the qca_is_wcn399x()stub
> Changes in V5:
> changed is_qca_soc_type_wcn399x_family to
> qca_is_wcn399x helper function 
> Moved the qca_is_wcn399x function to btqca.c
> modified the DT document for wcn399x as per driver code
> Changes in V4:
> Added is_qca_soc_type_wcn399x_family helper function 
> to get the soc type is wcn399x or not.
> Changes in V3:
> updated to latest code base.
> 
> Harish Bandi (2):
>  Bluetooth: hci_qca: Added support for WCN3998
>  dt-bindings: net: bluetooth: Add device tree bindings for QTI chip
>    WCN3998
> 
> .../devicetree/bindings/net/qualcomm-bluetooth.txt |  5 +--
> drivers/bluetooth/btqca.c                          |  7 ++--
> drivers/bluetooth/btqca.h                          | 11 +++++-
> drivers/bluetooth/hci_qca.c                        | 40 ++++++++++++++--------
> 4 files changed, 43 insertions(+), 20 deletions(-)

both patches have been applied to bluetooth-next tree.

Regards

Marcel

