Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8454C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 05:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7813D21925
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 05:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553231932;
	bh=1jBf8qsSVEzRA/E+kFeS8qozylZZOG3vwReMA/YDsbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EiDyeGwMQbxRhwrEjhoWYwlHjIAh/C5A8cSsNd8Huk8otKL+BFZpR3+7iVPUx000N
	 eia1a/xR+WZpAYbVNsKx2FqX4zzm34OPKir9cbnh3DLvqneDQLksmwFCRuueqUKeT1
	 GYgdP6HAwtWhWf6WRPWrteDGQkB1IgeOsOQcldN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbfCVFSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 01:18:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:39972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727632AbfCVFSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 01:18:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54A9821902;
        Fri, 22 Mar 2019 05:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553231926;
        bh=1jBf8qsSVEzRA/E+kFeS8qozylZZOG3vwReMA/YDsbw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v7byVg54am6TfCM2SjDaWC+6TmQUxdmqUlS2oToRH0ygdF6nwmdCqt1yDwtvOA6Zf
         iLimVi483Jsf7hXqDJiqQqa8d+/YrbdvyCKXKEXST7D4EtgKPU4XvdBZZCQ7IdM8Ep
         CHrN9ifwfbBWehZEtmj0FF7hf+5y/uM0oeRfyO8g=
Date:   Fri, 22 Mar 2019 06:18:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc:     wim@linux-watchdog.orgw, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: Re: [PATCH V1 1/1] watchdog: f71808e_wdt: fix F81866 bit operation
Message-ID: <20190322051844.GB17257@kroah.com>
References: <1553225816-24375-1-git-send-email-hpeter+linux_kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553225816-24375-1-git-send-email-hpeter+linux_kernel@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 11:36:56AM +0800, Ji-Ze Hong (Peter Hong) wrote:
> Fix error bit operation in watchdog_start()
> 
> Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
> ---
>  drivers/watchdog/f71808e_wdt.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
