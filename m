Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C010C17443
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 05:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36FE220856
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 05:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573449969;
	bh=H+9NY5NoBtSDcrU2DUVT7MbY08MFMHKqvmh7Or5JfDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=t3XSKLOixCEAkl6hdgYdP6D1ZBdtSNOEY3HUOnKhgIAriuuPR92uoowYdo8cINvT2
	 hXzQvpfT3qADNy6wxU8S0eAcTUxpg0U+W3iyBKEuNS7duTOWUyjuDR29I+BM7Xaigf
	 x5FSey/1tlZjnIwWQvEZVBJxuDb5aWSTJlf+iAvw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfKKF0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 00:26:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:38552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbfKKF0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 00:26:07 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C77D820856;
        Mon, 11 Nov 2019 05:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573449967;
        bh=H+9NY5NoBtSDcrU2DUVT7MbY08MFMHKqvmh7Or5JfDY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I2z9H+P9QHWnDiLHkQ602ePx3T2AzdbGBjrjITJc+ua1aGvNv0XWhJeYVeA5W0Zs1
         cLxaLezk+WtYVQdE7I4AuwWRqeKHu/DVmcSNNBSJlR4/xTPakxwyfClrxPXJxfVdvo
         mJxd8AL37rzHnGIkFSlZxM1VGU5C5tTw4ooQ8xvo=
Date:   Mon, 11 Nov 2019 06:26:01 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] interconnect changes for 5.5
Message-ID: <20191111052601.GA3176397@kroah.com>
References: <5123bf54-5d62-fc5c-8838-17bc34487d83@linaro.org>
 <20191107142111.GB109902@kroah.com>
 <0cb5a6a6-399f-99e3-dc41-50114eea4025@linaro.org>
 <20191108103917.GB683302@kroah.com>
 <CAOCOHw4d0q3uGTAh_UrNWr+Wi6ObDKUFn7M_zkD8cFTkNFEUDA@mail.gmail.com>
 <20191109084820.GC1289838@kroah.com>
 <CAOCOHw4AFz2Rj3sLTrboA0pBOkL_5MbitJnFHgBYaVBbWyYATw@mail.gmail.com>
 <20191110101647.GA1441986@kroah.com>
 <20191111045423.rnhmv7uzhabgtebq@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111045423.rnhmv7uzhabgtebq@vireshk-i7>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 10:24:23AM +0530, Viresh Kumar wrote:
> On 10-11-19, 11:16, Greg Kroah-Hartman wrote:
> > Ah, now I get it.  Yeah, that sucks.  We need a "shortcut" in Kconfig to
> > express that type of dependancy.
> 
> So we are going to merge this patch for now ?

I did not, sorry.

greg k-h
