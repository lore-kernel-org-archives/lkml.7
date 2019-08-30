Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E88DC3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE7F21721
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567146749;
	bh=D2EmTQTAa6YAb6Wp9h/sppcW/IyU77/K+uVFpI6i5SU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IW7mabueDUzILzf4QTYqiLXoGtUCSinXzdJhZFg1LM22V7UcFPEyx8syNl0umCQ09
	 6VSAWZ1Vuiden2/BZDZtX0xgy6efpIH9Y0pB4VZvczGWUFHP2HEhhHj8Wqlxz/L1HO
	 WU6z09rW8Qa9a4e0/LkLBpfmZzvadp3Vs9Um54aY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbfH3Gc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 02:32:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:34078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbfH3Gc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 02:32:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72E1720659;
        Fri, 30 Aug 2019 06:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567146747;
        bh=D2EmTQTAa6YAb6Wp9h/sppcW/IyU77/K+uVFpI6i5SU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v04SHRddU3hBfo3S2cm9riysudSFXb/CIC3edSvqOJdnRHZgKZosnAGwGzN1Ck6oz
         rj2w6dKRY6Y2/CDwnv44OMJbX7LL5I58y9mIGRcPVqu3oRMSOvuKcHiYzCtur/usM7
         LGV9EtvVhxqhwoeOBlXJ+o0NabJTBO3yHYawyauk=
Date:   Fri, 30 Aug 2019 08:32:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] software node: fixes for two smatch errors
Message-ID: <20190830063224.GD15257@kroah.com>
References: <20190829132116.76120-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829132116.76120-1-heikki.krogerus@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 04:21:14PM +0300, Heikki Krogerus wrote:
> Hi,
> 
> Both potentially unitialized variable errors.
> 
> Heikki Krogerus (2):
>   software node: Fix use of potentially uninitialized variable
>   software node: Fix use of potentially uninitialized variable

You can't send 2 different patches with identical subjects :(

Please make them unique as they should be doing different things.

thanks,

greg k-h
