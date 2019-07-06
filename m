Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DFCC468AD
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 10:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8930D21670
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 10:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbfGFK4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 06:56:20 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:39515 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfGFK4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 06:56:20 -0400
Received: from [192.168.0.113] (CMPC-089-239-107-172.CNet.Gawex.PL [89.239.107.172])
        by mail.holtmann.org (Postfix) with ESMTPSA id 41E19CF163;
        Sat,  6 Jul 2019 13:04:49 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v6 2/2] dt-bindings: net: bluetooth: Add device property
 firmware-name for QCA6174
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1559814055-13872-1-git-send-email-rjliao@codeaurora.org>
Date:   Sat, 6 Jul 2019 12:56:17 +0200
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        Johan Hedberg <johan.hedberg@gmail.com>,
        thierry.escande@linaro.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bgodavar@codeaurora.org, c-hbandi@codeaurora.org
Content-Transfer-Encoding: 7bit
Message-Id: <9245C22A-E0B7-437E-BD73-8A25033660C2@holtmann.org>
References: <1557919203-11055-1-git-send-email-rjliao@codeaurora.org>
 <1559814055-13872-1-git-send-email-rjliao@codeaurora.org>
To:     Rocky Liao <rjliao@codeaurora.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rocky,

> This patch adds an optional device property "firmware-name" to allow the
> driver to load customized nvm firmware file based on this property.
> 
> Signed-off-by: Rocky Liao <rjliao@codeaurora.org>
> ---
> Changes in v6:
>  * Added read firmware-name property for both QCA6174 and WCN399X
> ---
> Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt | 4 ++++
> 1 file changed, 4 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

