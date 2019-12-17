Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9BCC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C8121835
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576589560;
	bh=mvCghyXyT3m3xPpZSVWQxeClciJdGR78AaD6vID+Tts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Kt83uqCjq8Jd/85MjNhg+PQeKFnBVNv8L+sFh75DFBIm9NtsbaLQL9m8/t3qinJ0b
	 zFsHLWJhcFrPz/NgM0ViFrsnrofzlyTJbCPlPkmrnJDEoG+AhQUk92I3XpGeqRsF6T
	 QucmGbaCkgRQjO2Q7Qj3zBXD/iYwuZhXdwYaqQNY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbfLQNcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 08:32:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:36588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728242AbfLQNch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 08:32:37 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50BAC21835;
        Tue, 17 Dec 2019 13:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576589556;
        bh=mvCghyXyT3m3xPpZSVWQxeClciJdGR78AaD6vID+Tts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZQ0YjU90nud327u6aB8jE146D/+Jk8jT9bx3SwCTJZpTwBKeebYauC4RlOP5DHK44
         wlca5fmMVgSz3FjFDcacqR2bF9iJ7idEJoto9C4fgyx4DL8BLCI/AX0FJd+6NepfZt
         RcE+pVXSal7VmL88qyU5MKlj5WHYDUC84I+WxvUc=
Date:   Tue, 17 Dec 2019 14:32:34 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dave Kim <david.kim@ncipher.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        Tim Magee <tim.magee@ncipher.com>
Subject: Re: [PATCH 1/1] drivers: misc: Add support for nCipher HSM devices
Message-ID: <20191217133234.GB3362771@kroah.com>
References: <20191217132244.14768-1-david.kim@ncipher.com>
 <20191217132244.14768-2-david.kim@ncipher.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191217132244.14768-2-david.kim@ncipher.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 01:22:44PM +0000, Dave Kim wrote:
> ﻿From: David Kim <david.kim@ncipher.com>
> 
> Introduce the driver for nCipher's Solo and Solo XC range of PCIe hardware
> security modules (HSM), which provide key creation/management and
> cryptography services.

A bit more description of exactly _what_ these devices do would be
helpful.

Also, how does userspace interact with the driver?  What api(s) are you
using/creating?  What userspace tools work with the device?

In short, we need more than just a one sentance description to be able
to properly review the code and provide text for a user to know what to
do with this driver.

Can you fix all that up and send a v2?

thanks,

greg k-h
