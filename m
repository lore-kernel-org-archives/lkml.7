Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D90CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55FDD2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552934954;
	bh=blCz3vWGwtyhauZQfAcLl0jKrQ1czPOfesFpVNCnfzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=m/s55hmJzx3esrzmki5pMgkABnWAhz/97J12JS7XmEf/TmrZC+AIQra5Wz6+2eUeK
	 02NdFwc2sIDSGuFRbdLbXOIwCD5KLGSSHsYJtH6htA6BtnNXx/EHMrjDI9ABnnVjv2
	 JPnHKQoI5zXUI6Ws5rNb1h48ddLFKApVm9Hm9shA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfCRStM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 14:49:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:32794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbfCRStM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 14:49:12 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78EB82077B;
        Mon, 18 Mar 2019 18:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552934952;
        bh=blCz3vWGwtyhauZQfAcLl0jKrQ1czPOfesFpVNCnfzY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CXhB9DX6n3xVK8eAvflGMze7aTL8RWK1audO219yMyetWo8iA69CvhHgaDv9Oohti
         Zu6FJflHWFxB++5cFX5HmTJseaz5BMpg8iRT34c9jIKA5l7LOICucEKtdVh68l8vP0
         nRhEMy4tZUwta0KwKOe1q8fCL4vezlusec8uxAd0=
Date:   Mon, 18 Mar 2019 19:49:09 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Emanuel Bennici <benniciemanuel78@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, NeilBrown <neil@brown.name>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>
Subject: Re: [PATCH] staging: mt7621-pci-phy: Add Spaces to Macro Definition
Message-ID: <20190318184909.GC11680@kroah.com>
References: <20190317002345.GA6938@p200300EEEE2F.fritz.box>
 <20190317113004.GK4614@kroah.com>
 <cf1ff260-564b-da2e-9543-539b249d2a47@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf1ff260-564b-da2e-9543-539b249d2a47@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 07:09:55PM +0100, Emanuel Bennici wrote:
> Am 17.03.19 um 12:30 schrieb Greg Kroah-Hartman:
> > On Sun, Mar 17, 2019 at 01:23:48AM +0100, Emanuel Bennici wrote: >> Improve Code readability by adding Spaces after #define > > You did not add "spaces", you added tabs. > > Please be specific :) > > thanks, > > greg k-h
> 
> Improve Code readability by adding Tabs and Spaces after #define

Why is my email quoted above?  That's not ok for a changelog text :(

Please fix up and send a properly versioned patch, as the documentation
says to do so.

thanks,

greg k-h
