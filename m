Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2ED0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A311218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfCOXki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 19:40:38 -0400
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:34916 "EHLO
        emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfCOXkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 19:40:37 -0400
Received: from darkstar.musicnaut.iki.fi (85-76-21-58-nat.elisa-mobile.fi [85.76.21.58])
        by emh07.mail.saunalahti.fi (Postfix) with ESMTP id EBFD8B0037;
        Sat, 16 Mar 2019 01:40:34 +0200 (EET)
Date:   Sat, 16 Mar 2019 01:40:34 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Laura Lazzati <laura.lazzati.15@gmail.com>
Cc:     gregkh@linuxfoundation.org, tsotsos@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: octeon-usb octeon-hcd: Fix several typos.
Message-ID: <20190315234034.GA6260@darkstar.musicnaut.iki.fi>
References: <20190309181827.9301-1-laura.lazzati.15@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190309181827.9301-1-laura.lazzati.15@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Mar 09, 2019 at 03:18:27PM -0300, Laura Lazzati wrote:
> I found that the comments had several typos such as "aenable", "internaly" and some others.
> I fixed them all.
> 
> Signed-off-by: Laura Lazzati <laura.lazzati.15@gmail.com>

I spotted one more typo that could be fixed as well:

> @@ -1797,7 +1797,7 @@ union cvmx_usbnx_usbp_ctl_status {
>  	 *	This is a test signal. When the USB Core is
>  	 *	powered up (not in Susned Mode), an automatic
                                   ^^^^^^

Should be "Suspend".

A.
