Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9F5C3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 20:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C792146E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 20:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566679310;
	bh=HefwpWi/5mvxMqfzEVIQylA0rs9qcvEDqB4ppJLhKFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g+vnuHBbNutgpV9RLXDYBWgXVbcuN4+EComBwKcmghP3/K0IcmWfep0BUBEvDAcyB
	 xZfFUUyDbJK765D2M9Tg3hT1gL1dCCWl7rP2xBWmNJmnqH3ykb2oE+riywyCYrClXD
	 aESI882QRrB5C/fXVF/D0cIbLcEp5Oi/kxfaqIUg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfHXUlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 16:41:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:48982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727424AbfHXUls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 16:41:48 -0400
Received: from X250.getinternet.no (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E25120850;
        Sat, 24 Aug 2019 20:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566679308;
        bh=HefwpWi/5mvxMqfzEVIQylA0rs9qcvEDqB4ppJLhKFs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g8UbKxVgaYnfanghOV0kOlJGiP967SILqbwkIgTs6HCkQbE7sgc7oqU5lrz+A4ciG
         yraNYVmmpXbxnzVs8tuzNY9lhdyDlqrI9Ghy3LvpnZcYXgEdpApoj4W+EBTCrgcloU
         S9bnHIf0UrugrpmakSCF1+a5HPANygChz/JHODkk=
Date:   Sat, 24 Aug 2019 22:41:35 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: imx: gpcv2: Print the correct error code
Message-ID: <20190824204134.GK16308@X250.getinternet.no>
References: <ceab1bb4984d0a4f59a580cd9956c1fd6d6a78f3.1566405120.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ceab1bb4984d0a4f59a580cd9956c1fd6d6a78f3.1566405120.git.agx@sigxcpu.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 06:33:04PM +0200, Guido Günther wrote:
> The current code prints 'ret' (thus 0) while it should use 'err'.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>

Applied, thanks.
