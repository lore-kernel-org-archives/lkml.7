Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687D2C2D0BE
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 17:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F02B217BA
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 17:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575740361;
	bh=T++ydQOV27cJbVsEb9mju7e2HDkTJb9/H8TvZE8Cq9s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=n1DiwUM+BiW55ucT2IELube5xdnLHt6XpkesEZsQtCOqm5On3C7nScklugkvd3PaY
	 BioM+VhMyWDdPos+SmoYnsfoNruQlmA2JFSyluxGpg7PfOkkDgwPjVASVIMRnRkZZo
	 mEmWEYrmxdHCAGXr+9Yx0W4VrJDY+P95U10MxhSw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfLGRjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 12:39:20 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:55248 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726455AbfLGRjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 12:39:19 -0500
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:AES256-GCM-SHA384:256)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1ide32-0008Ha-2c; Sat, 07 Dec 2019 18:39:16 +0100
Date:   Sat, 7 Dec 2019 17:39:14 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] Add iProc IDM device support
Message-ID: <20191207173914.353f768d@why>
In-Reply-To: <20191202233127.31160-1-ray.jui@broadcom.com>
References: <20191202233127.31160-1-ray.jui@broadcom.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: ray.jui@broadcom.com, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, rayagonda.kokatanur@broadcom.com, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  2 Dec 2019 15:31:25 -0800
Ray Jui <ray.jui@broadcom.com> wrote:

> The Broadcom iProc IDM device allows control and monitoring of ASIC internal
> bus transactions. Most importantly, it can be configured to detect bus
> transaction timeout. In such case, critical information such as transaction
> address that caused the error, bus master ID of the transaction that caused
> the error, and etc., are made available from the IDM device.

This seems to have many of the features of an EDAC device reporting
uncorrectable errors.

Is there any reason why it is not implemented as such?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
