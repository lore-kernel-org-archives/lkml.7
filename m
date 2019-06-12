Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2997C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 09:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96760207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 09:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437572AbfFLJjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 05:39:08 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:57087 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406059AbfFLJjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 05:39:07 -0400
X-Originating-IP: 83.155.44.161
Received: from classic (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
        (Authenticated sender: hadess@hadess.net)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id B12B42000B;
        Wed, 12 Jun 2019 09:38:58 +0000 (UTC)
Message-ID: <9ad95905975e09646f0f2aa967140881cbbe3477.camel@hadess.net>
Subject: Re: [PATCH] Revert "Bluetooth: Align minimum encryption key size
 for LE and BR/EDR connections"
From:   Bastien Nocera <hadess@hadess.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Date:   Wed, 12 Jun 2019 11:38:57 +0200
In-Reply-To: <20190612070701.GA13320@kroah.com>
References: <20190522052002.10411-1-anarsoul@gmail.com>
         <6BD1D3F7-E2F2-4B2D-9479-06E27049133C@holtmann.org>
         <7B7F362B-6C8B-4112-8772-FB6BC708ABF5@holtmann.org>
         <CA+E=qVfopSA90vG2Kkh+XzdYdNn=M-hJN_AptW=R+B5v3HB9eA@mail.gmail.com>
         <CA+E=qVdLOS9smt-nBxg9Lon0iTZr87kONSp-XPKj9tqB4bvnqw@mail.gmail.com>
         <723142BB-8217-4A01-A2B9-F527174FDC0F@holtmann.org>
         <20190612070701.GA13320@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-06-12 at 09:07 +0200, Greg Kroah-Hartman wrote:
> On Tue, Jun 11, 2019 at 11:36:26PM +0200, Marcel Holtmann wrote:
> > Hi Vasily,
> > 
> > > Can we get this revert merged into stable branches? Bluetooth HID
> > > has
> > > been broken for many devices for quite a while now and RFC patch
> > > that
> > > fixes the breakage hasn't seen any movement for almost a month.
> > 
> > lets send the RFC patch upstream since it got enough feedback that
> > it fixes the issue.
> 
> According to Hans, the workaround did not work.

Is it possible that those folks were running Fedora, and using a
version of bluetoothd without a fix for using dbus-broker as the D-Bus
daemon implementation?

I backported the fix in an update last week:
https://bugzilla.redhat.com/show_bug.cgi?id=1711594

> So can we just get this reverted so that people's machines go back to
> working?
> 
> thanks,
> 
> greg k-h

