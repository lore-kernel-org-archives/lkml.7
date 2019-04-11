Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E04C282DA
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E99652184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554972505;
	bh=eSLe9DK5obN8DuIVbQiQLS5NNGibWxOjuhhp0/GJYmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rBYeMhh4PD/CaAFXSsRiLUqvJsByvMX1rKfpyxjml/CNlui8ZCphJdSOS5a7uC3Jd
	 Z3CpfgwStE8ENWRkzOUiOniFQ1xGOTHuz4o1btstkX2UoyOdHVgDycI61mewwElc1M
	 7Ae2MlSP1/wvPXhbVOLJ38L3WbWpFLqUTKa4J7vY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfDKIsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 04:48:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:57118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726588AbfDKIsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 04:48:23 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 145F22083E;
        Thu, 11 Apr 2019 08:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554972502;
        bh=eSLe9DK5obN8DuIVbQiQLS5NNGibWxOjuhhp0/GJYmw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ry7ZG6QOK5acsVriTYrta2IE8OAtSIVoyrGt8pVHNF0YNLIev67SRU2IEhAQTd+dN
         +A7Ffp0NlK6vYsY8b3Rbdah9bsm8mNoVS5A/8Pt1VOsCshnsORyWo3aEVC/JNS0cv6
         vepZ41I7A32V3GheEFovIxoHYseVLHXB6QERy4yE=
Date:   Thu, 11 Apr 2019 16:48:07 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH 10/22] watchdog: imx_sc_wdt: Use 'dev' instead of
 dereferencing it repeatedly
Message-ID: <20190411084806.GF3050@dragon>
References: <1554913683-25454-1-git-send-email-linux@roeck-us.net>
 <1554913683-25454-11-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554913683-25454-11-git-send-email-linux@roeck-us.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 09:27:51AM -0700, Guenter Roeck wrote:
> Introduce local variable 'struct device *dev' and use it instead of
> dereferencing it repeatedly.
> 
> The conversion was done automatically with coccinelle using the
> following semantic patches. The semantic patches and the scripts
> used to generate this commit log are available at
> https://github.com/groeck/coccinelle-patches
> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Shawn Guo <shawnguo@kernel.org>
