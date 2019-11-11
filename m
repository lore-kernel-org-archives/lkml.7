Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6E4C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 05:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 138D320856
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 05:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573450066;
	bh=23/dZyyNZJ5f/N9y6NkELPHEMcSatZdi+Z6beaSX7Xk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=b4E2MHRYadMqlTbjy4re0o4evVZ3e1etnb95m1uIBy7nHVDIorS5K2tBB1/pUVxlF
	 A+oPOG1jiNIAdxsGMfS+AayK1nkVYCVE6562bL8pUPZ9UJ1ViduQ59RsEZeJQnkU+8
	 dS+XlAmLpE0+IMG49q5yMmb1Qus1YxFXM64xJuBI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfKKF1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 00:27:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:39472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbfKKF1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 00:27:44 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DA5620656;
        Mon, 11 Nov 2019 05:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573450064;
        bh=23/dZyyNZJ5f/N9y6NkELPHEMcSatZdi+Z6beaSX7Xk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=trbF5BI8pXai20Z08vOQYuIeeFNCcVcSOFhO5RbUEz5l6Qv/zYBUWW3I4qPQhX3ve
         DBQaeMhs68y3UxY3oYUutNhjeNb8+GnOeA0rE24LcCHcUHkisLfr80W2YHE+vt7yKk
         kcjICYV4moz3RN7vKwg+qKwZ/pvGovXNFju7RYc0=
Date:   Mon, 11 Nov 2019 06:27:41 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     linux-realtek-soc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] base: soc: Export soc_device_to_device() helper
Message-ID: <20191111052741.GB3176397@kroah.com>
References: <20191103013645.9856-3-afaerber@suse.de>
 <20191111045609.7026-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191111045609.7026-1-afaerber@suse.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 05:56:09AM +0100, Andreas Färber wrote:
> Use of soc_device_to_device() in driver modules causes a build failure.
> Given that the helper is nicely documented in include/linux/sys_soc.h,
> let's export it as GPL symbol.

I thought we were fixing the soc drivers to not need this.  What
happened to that effort?  I thought I had patches in my tree (or
someone's tree) that did some of this work already, such that this
symbol isn't needed anymore.

thanks,

greg k-h
