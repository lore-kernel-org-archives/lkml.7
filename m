Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742CEC3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 10:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51BB12071A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 10:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfLXKoO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 05:44:14 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:42003 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfLXKoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 05:44:14 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id D507A240007;
        Tue, 24 Dec 2019 10:44:11 +0000 (UTC)
Date:   Tue, 24 Dec 2019 11:44:10 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Rob Herring <robherring2@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the devicetree tree
Message-ID: <20191224114410.0d72c72f@xps13>
In-Reply-To: <20191221143211.47eea79d@canb.auug.org.au>
References: <20191221143211.47eea79d@canb.auug.org.au>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen, Rob,

Stephen Rothwell <sfr@canb.auug.org.au> wrote on Sat, 21 Dec 2019
14:32:11 +1100:

> Hi all,
> 
> n commit
> 
>   13670c493ab8 ("dt-bindings: phy: Fix the PX30 DSI PHY compatible in the example")
> 
> Fixes tag
> 
>   Fixes: 3200df7fa1d6 ("dt-bindings: phy: add yaml binding for rockchip,px30-dsi-dphy")
> 
> has these problem(s):
> 
>   - Target SHA1 does not exist
> 
> Maybe you meant
> 
> Fixes: 3817c7961179 ("dt-bindings: phy: add yaml binding for rockchip,px30-dsi-dphy")

Sorry for the mistake, I took the hash from Heiko's tree. This is
indeed the right one.

Thanks,
Miquèl
