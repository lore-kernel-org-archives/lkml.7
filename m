Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2ADC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3514620449
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560443776;
	bh=DNOPj2Yx04AnRxwW50GJD0lO1OKzC99KUz7kFws8Elg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WwIT0FPZTdGxpy6yTAfC8VdNNi++w5v3WVdpw3W2rJTm+7H+4w6K/01GMteXfVywm
	 7Qta3mEVPzHl9LHMlZSi4yp/fSc/jL6/52xZq4qAyQBrAeSKgJKLLWxfAmn04hrhJH
	 QB095/6DZi7k4rY4BHgQrIpfCgZzqtDhs0b7hakY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392595AbfFMQgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:36:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:53986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730693AbfFMHfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 03:35:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8159A20866;
        Thu, 13 Jun 2019 07:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560411350;
        bh=DNOPj2Yx04AnRxwW50GJD0lO1OKzC99KUz7kFws8Elg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=izsisZBJPQF0Ow37TFLvzUCps7FILRUBfislpzeHKcSh2hhVOGFiqSMjp4FBk+vju
         ldUg+bfSXVeMCRV+C0mBPVak5LTc6kSpsbIVMMXhB/LtDkC80UWFzRKENhUYz2z8P5
         f3u1IYdHXRXgpAjHbJn5NbkMKKKaHgjTpS2YpktM=
Date:   Thu, 13 Jun 2019 09:35:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH] Revert "Bluetooth: Align minimum encryption key size for
 LE and BR/EDR connections"
Message-ID: <20190613073547.GB16436@kroah.com>
References: <20190522052002.10411-1-anarsoul@gmail.com>
 <6BD1D3F7-E2F2-4B2D-9479-06E27049133C@holtmann.org>
 <7B7F362B-6C8B-4112-8772-FB6BC708ABF5@holtmann.org>
 <CA+E=qVfopSA90vG2Kkh+XzdYdNn=M-hJN_AptW=R+B5v3HB9eA@mail.gmail.com>
 <CA+E=qVdLOS9smt-nBxg9Lon0iTZr87kONSp-XPKj9tqB4bvnqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+E=qVdLOS9smt-nBxg9Lon0iTZr87kONSp-XPKj9tqB4bvnqw@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 12:56:02PM -0700, Vasily Khoruzhick wrote:
> Greg,
> 
> Can we get this revert merged into stable branches? Bluetooth HID has
> been broken for many devices for quite a while now and RFC patch that
> fixes the breakage hasn't seen any movement for almost a month.

Now reverted as the bluetooth developers seem to be moving pretty slowly
on this :(

greg k-h
