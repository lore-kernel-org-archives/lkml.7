Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610F0C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 13:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 316DC208C0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 13:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559826177;
	bh=ZMEpYSkZA0Q0/VcvnwOoovQKU7Ziw+6pF1UaPZVwQAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zNrelTI89939AMUvWJOPK8OnhNqAcxxZdabUv8VEeRycavSzI9Xpyrv9fROi3nKzG
	 L78FnHvkfyAGm3vmG4wRdA5kvyUqjQ2IbnT1mXsgP2mcHzzsBqZtC1SYFj1d4tnB3i
	 KwQwyceXNgkkGatM02D98/OfRgJ6r6LWmE09J9MA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbfFFNC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 09:02:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:38952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726922AbfFFNC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 09:02:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BD8020872;
        Thu,  6 Jun 2019 13:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559826175;
        bh=ZMEpYSkZA0Q0/VcvnwOoovQKU7Ziw+6pF1UaPZVwQAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q0JE+X1PLsBLOR56AmukxAbdTkEoMFaf3p8OY61fXd0Ep2nz2hDA6Qti6r9NxSncX
         Hms64YiJUI6Z/L8wXeKvidGPtIrqexWEetKYjTrLwmQadIYhe/5syePhmtoUANc3Jj
         xv7ezCUg+O30LYeMgYbAEIm3rKrk0zC62LrnuJac=
Date:   Thu, 6 Jun 2019 15:02:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Shobhit Kukreti <shobhitkukreti@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        hadess@hadess.net, hdegoede@redhat.com, Larry.Finger@lwfinger.net
Subject: Re: [PATCH] staging: rtl8723bs: CleanUp to remove the error reported
 by checkpatch
Message-ID: <20190606130253.GE1140@kroah.com>
References: <20190606015949.GA2275@t-1000>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606015949.GA2275@t-1000>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 06:59:52PM -0700, Shobhit Kukreti wrote:
> Cleaned up the code to remove the error "(foo*)" should be "(foo *)"
> reported by checkpatch from the file rtl8723bs/os_dep/ioctl_linux.c

Your subject line shoudl give a hint as to what the error you are fixing
is.

Also, no need for "CleanUp" in it, that's not a real word :)

thanks,

greg k-h
