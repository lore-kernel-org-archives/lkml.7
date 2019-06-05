Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B068FC282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 06:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 768A520866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 06:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559715003;
	bh=wTYwhYyVAwH/37258YCULY4b/DDUHUmOmKJEh2hkUE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GfhdvQSoe8EsijxLkoYJ7sYMlppprmx/PAaNUbU4XL/DFLO+fQLIus/7TnCqAtlT5
	 ZwPTCVJ8FXJyaUdW9PdKiUVJ0y2vFw0NCAOJ9/CwESnPHUEYV0rTOcTOYWx+7c1DWb
	 iHItHGoDlEqRkAqi+zXjEVIPh6YSnvE1+9Jjc0UY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfFEGKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 02:10:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:53696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbfFEGKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 02:10:02 -0400
Received: from dragon (li1264-180.members.linode.com [45.79.165.180])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9D3D2075C;
        Wed,  5 Jun 2019 06:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559715001;
        bh=wTYwhYyVAwH/37258YCULY4b/DDUHUmOmKJEh2hkUE4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=twASdHOlRFsxs4nkKKw8rd0OyYEdxLC4gTqsSzQ0mLPfAHk84ARn1oy0XSQwuw4H8
         Jq+QAgMrqoIaTG1d4aBHc2zX/R4SADoWn50kWf3ZapEh6vmoqqzAuDeXtEgOdiZsYq
         XLbgypHFHC7Bq+d9YTWOuGC+4tHDU3ZkfMquJAkY=
Date:   Wed, 5 Jun 2019 14:09:45 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson.Huang@nxp.com
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        leonard.crestez@nxp.com, abel.vesa@nxp.com,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hyc.nju@gmail.com, Linux-imx@nxp.com
Subject: Re: [PATCH RESEND 1/2] soc: imx: soc-imx8: Avoid unnecessary
 of_node_put() in error handling
Message-ID: <20190605060944.GB29853@dragon>
References: <20190524055101.3424-1-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524055101.3424-1-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 01:51:00PM +0800, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> of_node_put() is called after of_match_node() successfully called,
> then in the following error handling, of_node_put() is called again
> which is unnecessary, this patch adjusts the location of of_node_put()
> to avoid such scenario.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>

Applied both, thanks.
