Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019B3C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 13:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D01EB2082C
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 13:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567948310;
	bh=eLdp0uQKPaA/H2khASulnTF5ispaOiwO0qb3kmUrZaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ome8Sx5Sn7XTmYDMjkaR4tEV5SKcbXZhsfYPI9IPeXfFyIpaswyuH00lZ+J9OvafB
	 j9qK5UxN1ZbFmOkFUQxs4JIQ+Ec7ipCHFETSH8WDkJYnRxQNbLlHzJOwS1pjm+bPK6
	 POH1Lk95RcuKBbksKUQ+ixkpkSVG7f5kxmsgkmo8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbfIHNLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 09:11:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:56026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbfIHNLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 09:11:49 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADC422081B;
        Sun,  8 Sep 2019 13:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567948309;
        bh=eLdp0uQKPaA/H2khASulnTF5ispaOiwO0qb3kmUrZaE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qo1sb8E0oylnjatDiCSWTPyITvKI17gvv5isFjaLQrGlKlmHTbV+ZvTLqlZX6mtpn
         Xl6f0Ph6OuVYy3KfIF/YRDO5ZGV/zgYmuv+55/VN73xyOXS7u6NJ7RtqnOtJhZ/mtn
         zxQlcuLBaAa7uGxDOe03LRKh6DI7x2JIyAlqnE5o=
Date:   Sun, 8 Sep 2019 14:11:46 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH 3/5] driver core: class: add function to create
 /sys/class/<class>/foo directory
Message-ID: <20190908131146.GE9466@kroah.com>
References: <1567946472-10075-1-git-send-email-akinobu.mita@gmail.com>
 <1567946472-10075-4-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567946472-10075-4-git-send-email-akinobu.mita@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 08, 2019 at 09:41:10PM +0900, Akinobu Mita wrote:
> This adds a new function class_kobject_create_and_add() that creates a
> directory in the /sys/class/<class>.
> 
> This function is required to create the /sys/class/leds/triggers directory
> that contains all available LED triggers.

I don't see a patch in this series that does that, is it 4/5?  I never
got that one...

thanks,

greg k-h
