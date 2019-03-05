Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91512C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 646FA20684
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbfCEPqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 10:46:50 -0500
Received: from muru.com ([72.249.23.125]:41262 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726877AbfCEPqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 10:46:49 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id F24748116;
        Tue,  5 Mar 2019 15:47:00 +0000 (UTC)
Date:   Tue, 5 Mar 2019 07:46:46 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] phy: mapphone-mdm6600: add gpiolib dependency
Message-ID: <20190305154646.GH39872@atomide.com>
References: <20190304202406.1716350-1-arnd@arndb.de>
 <20190304202406.1716350-3-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304202406.1716350-3-arnd@arndb.de>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [190304 20:24]:
> gcc points out that when CONFIG_GPIOLIB is disabled,
> gpiod_get_array_value_cansleep() returns 0 but fails to set its output:
> 
> drivers/phy/motorola/phy-mapphone-mdm6600.c: In function 'phy_mdm6600_status':
> drivers/phy/motorola/phy-mapphone-mdm6600.c:220:24: error: 'values[0]' is used uninitialized in this function [-Werror=uninitialized]
> 
> This could be fixed more generally in gpiolib by returning a failure
> code, but for this specific case, the easier workaround is to add a
> gpiolib dependency.

Thanks for fixing it:

Acked-by: Tony Lindgren <tony@atomide.com>
