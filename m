Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D739CA9EA3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 121F321897
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407572AbfJRH7M convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 03:59:12 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:35319 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405702AbfJRH7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 03:59:12 -0400
Received: from surfer-172-29-2-69-hotspot.internet-for-guests.com (p2E5701B0.dip0.t-ipconnect.de [46.87.1.176])
        by mail.holtmann.org (Postfix) with ESMTPSA id B47AACECF4;
        Fri, 18 Oct 2019 10:08:09 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.19\))
Subject: Re: [PATCH 0/4] Bluetooth: hci_qca: Regulator usage cleanup
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20191018052405.3693555-1-bjorn.andersson@linaro.org>
Date:   Fri, 18 Oct 2019 09:59:10 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        linux-arm-msm@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <739222E4-F173-42A9-8D67-1BD8FEE227EC@holtmann.org>
References: <20191018052405.3693555-1-bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
X-Mailer: Apple Mail (2.3594.4.19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

> Clean up the regulator usage in hci_qca and in particular don't
> regulator_set_voltage() for fixed voltages. It cleans up the driver, but more
> important it makes bluetooth work on my Lenovo Yoga C630, where the regulator
> for vddch0 is defined with a voltage range that doesn't overlap the values in
> the driver.
> 
> Bjorn Andersson (4):
>  Bluetooth: hci_qca: Update regulator_set_load() usage
>  Bluetooth: hci_qca: Don't vote for specific voltage
>  Bluetooth: hci_qca: Use regulator bulk enable/disable
>  Bluetooth: hci_qca: Split qca_power_setup()
> 
> drivers/bluetooth/hci_qca.c | 135 +++++++++++++++---------------------
> 1 file changed, 55 insertions(+), 80 deletions(-)

all 4 patches have been applied to bluetooth-next tree.

Regards

Marcel

