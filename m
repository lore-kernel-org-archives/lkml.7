Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D764C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB8B217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389821AbfDRRnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 13:43:45 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:43140 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388301AbfDRRnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 13:43:45 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 95E541477003E;
        Thu, 18 Apr 2019 10:43:44 -0700 (PDT)
Date:   Thu, 18 Apr 2019 10:43:44 -0700 (PDT)
Message-Id: <20190418.104344.957038152341042514.davem@davemloft.net>
To:     jan.kiszka@siemens.com
Cc:     peppe.cavallaro@st.com, alexandre.torgue@st.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        baocheng.su@siemens.com, andy.shevchenko@gmail.com
Subject: Re: [PATCH] stmmac: pci: Adjust IOT2000 matching
From:   David Miller <davem@davemloft.net>
In-Reply-To: <5a547510-2605-bae5-bd58-ab4aff28840d@siemens.com>
References: <5a547510-2605-bae5-bd58-ab4aff28840d@siemens.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 18 Apr 2019 10:43:44 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>
Date: Thu, 18 Apr 2019 11:14:56 +0200

> @@ -170,8 +176,6 @@ static const struct dmi_system_id quark_pci_dmi[] = {
>  	{
>  		.matches = {
>  			DMI_EXACT_MATCH(DMI_BOARD_NAME, "SIMATIC IOT2000"),
> -			DMI_EXACT_MATCH(DMI_BOARD_ASSET_TAG,
> -					"6ES7647-0AA00-1YA2"),
>  		},
>  		.driver_data = (void *)&iot2040_stmmac_dmi_data,

So really, every IOT2000 that doesn't have the IOT2020 asset tag will be
a 2040?  Forever?
