Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E5EC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 07:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2F7020663
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 07:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfLJHy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 02:54:28 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58017 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbfLJHy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 02:54:27 -0500
Received: from soja.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:13da])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <o.rempel@pengutronix.de>)
        id 1ieaLf-0006sK-B5; Tue, 10 Dec 2019 08:54:23 +0100
Subject: Re: [PATCH v1] ARM i.MX6q: make sure PHY fixup for KSZ9031 is applied
 only on one board
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Fabio Estevam <festevam@gmail.com>, netdev@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20191209084430.11107-1-o.rempel@pengutronix.de>
 <20191209171508.GD9099@lunn.ch>
 <20191209173952.qnkzfrbixjgi2jfy@pengutronix.de>
 <20191209175119.GK9099@lunn.ch>
From:   Oleksij Rempel <o.rempel@pengutronix.de>
Message-ID: <416bc3a5-a134-f78b-a0d4-bcf1c635acaa@pengutronix.de>
Date:   Tue, 10 Dec 2019 08:54:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191209175119.GK9099@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:13da
X-SA-Exim-Mail-From: o.rempel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09.12.19 18:51, Andrew Lunn wrote:
>> Yes. all of them are broken.
>> I just trying to not wake all wasp at one time. Most probably there are
>> board working by accident. So, it will be good to have at least separate
>> patches for each fixup.
> 
> I agree about a patch per fixup. Can you try to generate such patches?
> See if there is enough history in git to determine which boards
> actually need these fixups?

Ok,

then please ignore this patch. I'll prepare a series of patches related to imx phy fixups.

Kind regards,
Oleksij Rempel

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
