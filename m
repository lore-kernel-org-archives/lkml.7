Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07679C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C56B62077B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbfCSQ0l convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:26:41 -0400
Received: from unicorn.mansr.com ([81.2.72.234]:40196 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbfCSQ0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:26:41 -0400
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 6A1A114CEB; Tue, 19 Mar 2019 16:26:39 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc:     Dan Williams <dcbw@redhat.com>, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: set driver_info for SIM5218 and compatibles
References: <20190226170710.12709-1-mans@mansr.com>
        <20190227083342.GJ4747@localhost> <yw1xpnrdv3z7.fsf@mansr.com>
        <20190227131315.GO4747@localhost> <yw1xlg21uwrp.fsf@mansr.com>
        <20190319102840.GI6124@localhost> <yw1xd0mn16ev.fsf@mansr.com>
        <20190319110819.GB3178@localhost> <yw1x8sxb125q.fsf@mansr.com>
        <20190319122719.GC3178@localhost> <20190319124358.GK6124@localhost>
        <6c89938b00ad289e1802f675bd00e288b1458d73.camel@redhat.com>
        <yw1xr2b3ylsp.fsf@mansr.com> <878sxa9ag7.fsf@miraculix.mork.no>
Date:   Tue, 19 Mar 2019 16:26:39 +0000
In-Reply-To: <878sxa9ag7.fsf@miraculix.mork.no> (=?iso-8859-1?Q?=22Bj=F8rn?=
 Mork"'s message of
        "Tue, 19 Mar 2019 15:59:36 +0100")
Message-ID: <yw1xmulqzv7k.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bjørn Mork <bjorn@mork.no> writes:

> Måns Rullgård <mans@mansr.com> writes:
>> Dan Williams <dcbw@redhat.com> writes:
>>
>>> TLDR; some firmware uses the DTR signal as an indicator to come out of
>>> low-power mode. Without doing so you cannot talk to the modem over any
>>> of it's ports, QMI, net, or serial.
>>
>> I must be missing something, but how does a network interface have a DTR
>> signal?
>
> It does not.  But the network function is (ab)using the Comm class USB
> control message "SetControlLineState" to signal "wake up" from the host
> to the device.  Which is perfectly fine since the USB function in
> question is vendor specific.  The vendor can define any USB control
> message to mean anything they want. Reusing a Comm class message
> probably made sense to the firmware engineer designing this.  We can
> only note and adapt.
>
> It doesn't have anything to do with DTR.

Every time you think USB can't get any worse, it does.

-- 
Måns Rullgård
