Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2DCC352AA
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 10:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C97B2133F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 10:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570445645;
	bh=Z1MRzz422mluKa9Ij7u3C58q1TXNGxxIP/7fJgkKIpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mRi98+YpblvvxW0Hi7op5VHA0U7deAmK8omykyf10s4qiNiSJJsWx5uurj5Q+RBr0
	 Q4Y96oYd1ipNVgGrGtcd+tnnwuwY6m0wnyRY2kwh8hJ67TOXk3XBY0JG7WWoaooGsa
	 9YY55TX+Zy3T93pWc9d58eRDM63XjcKdIJDIKb94=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfJGKyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 06:54:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:42354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727402AbfJGKyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 06:54:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C98C20867;
        Mon,  7 Oct 2019 10:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570445643;
        bh=Z1MRzz422mluKa9Ij7u3C58q1TXNGxxIP/7fJgkKIpY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rThIEYgUEJNHh5O/4EKROFNcOWZjsEBA/BpVJO2DHtFpXbf/p7xkX66CN4anhTNec
         oPa48Zk4JXjSP46Ny3FErVccyo0aemdJsoz2TO+jCH3zjl4gCOG9PdvqyBHKPXFm7Z
         5bkz6p536OP+OLUX+mHND6bM0ZSJ13fpeGbOe15o=
Date:   Mon, 7 Oct 2019 12:54:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-usb@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Add platform_get_irq_byname_optional() and use it in
 the dwc3 driver
Message-ID: <20191007105401.GA550008@kroah.com>
References: <20191005210449.3926-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191005210449.3926-1-hdegoede@redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 05, 2019 at 11:04:46PM +0200, Hans de Goede wrote:
> Hi All,
> 
> Here is a fix for the false-positive dev_err in platform_get_irq_byname()
> discussed recently and reported here:
> https://bugzilla.kernel.org/show_bug.cgi?id=205037
> 
> Since patch 2 depends on patch 1, I think it might be best to merge
> all three patches through the same tree ...

Thanks for these, I'll take them through my USB tree to be merged to
Linus soon.

greg k-h
