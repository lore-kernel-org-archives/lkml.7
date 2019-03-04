Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB77C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EE712075B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="U682EVBf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbfCDMTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 07:19:39 -0500
Received: from tomli.me ([153.92.126.73]:43676 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfCDMTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 07:19:39 -0500
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id c1c34a91;
        Mon, 4 Mar 2019 12:19:37 +0000 (UTC)
X-HELO: localhost.localdomain
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.localdomain) (2402:f000:1:1501:200:5efe:3d30:3659)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Mon, 04 Mar 2019 12:19:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=1490979754; bh=af4/+GkaTVDKQNRen9CJRfzG+rNmnkfV09A8cVjuvXg=; b=U682EVBfbw3UWKQYFsmfgEzMLpk9inuFiGPF8/Fok2bwx2gIvtI2rTlFLAQHdxwmRrc+BgZq5rGVQp5NWEXSaPRPdgRlP0Jsi2a/KCCvy+aEuRvFxVMEPV7YpYk2OWdEhR4CyxZApjm1KXBFTdesEkH7chmUX6Znzbyq0PKzSNB5mxZIdQ2qtC10ORCaRgiXsXoNPmg75HGiJPAoBBKd0oO8qnDKbRO+Q0hBU/0BCBgauTEmCaniirbChhUp/jklrxtXMy5iISCld+NdlnsP9SdYe026YpUhR4YCYdRCCLxwAnQ8lddxTcWuJPRf8JJ4pSZ8wPTp+8BNLpV37vxa0g==
Date:   Mon, 4 Mar 2019 20:19:26 +0800
From:   Tom Li <tomli@tomli.me>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Yifeng Li <tomli@tomli.me>, kbuild-all@01.org,
        linux-mips@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] mfd: yeeloong_kb3310b: support KB3310B EC for Lemote
 Yeeloong laptops.
Message-ID: <20190304121925.GA9830@localhost.localdomain>
References: <20190302175334.5103-2-tomli@tomli.me>
 <201903040851.4ZDLoz8h%fengguang.wu@intel.com>
 <20190304101437.GN4118@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304101437.GN4118@dell>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 10:14:37AM +0000, Lee Jones wrote:
> This patch isn't in my Inbox.
> 
> Who was it sent to?

I sent the patch to you and linux-mips. This patch series is a MIPS platform
driver, and the first patch in this series creates a MFD driver which is
needed to be reviewed by you. Unfortunately, somehow you didn't receive
it, perhaps it was rejected by the mail server?

Hasn't the bot tested the patch, weeks of time will be wasted... Is there
a mailing list I can use to send MFD patches for you to review?

Thanks,
Tom Li
