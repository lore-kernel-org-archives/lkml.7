Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BB2C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174DF20726
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfLJET3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 23:19:29 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:39710 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbfLJET3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 23:19:29 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7D48C154F0608;
        Mon,  9 Dec 2019 20:19:26 -0800 (PST)
Date:   Mon, 09 Dec 2019 20:19:26 -0800 (PST)
Message-Id: <20191209.201926.728362288698200079.davem@davemloft.net>
To:     dmurphy@ti.com
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        bunk@kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        grygorii.strashko@ti.com
Subject: Re: [PATCH net-next v3 0/2] Fix Tx/Rx FIFO depth for DP83867
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191209201025.5757-1-dmurphy@ti.com>
References: <20191209201025.5757-1-dmurphy@ti.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 09 Dec 2019 20:19:26 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Murphy <dmurphy@ti.com>
Date: Mon, 9 Dec 2019 14:10:23 -0600

> The DP83867 supports both the RGMII and SGMII modes.  The Tx and Rx FIFO depths
> are configurable in these modes but may not applicable for both modes.
> 
> When the device is configured for RGMII mode the Tx FIFO depth is applicable
> and for SGMII mode both Tx and Rx FIFO depth settings are applicable.  When
> the driver was originally written only the RGMII device was available and there
> were no standard fifo-depth DT properties.
> 
> The patchset converts the special ti,fifo-depth property to the standard
> tx-fifo-depth property while still allowing the ti,fifo-depth property to be
> set as to maintain backward compatibility.
> 
> In addition to this change the rx-fifo-depth property support was added and only
> written when the device is configured for SGMII mode.

Series applied, thanks.
