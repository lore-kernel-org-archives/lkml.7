Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99304C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 11:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 636E62081C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 11:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=haabendal.dk header.i=@haabendal.dk header.b="y8KDhysU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbfEULLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 07:11:12 -0400
Received: from mailrelay3-1.pub.mailoutpod1-cph3.one.com ([46.30.210.184]:17804
        "EHLO mailrelay3-1.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726705AbfEULLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 07:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=haabendal.dk; s=20140924;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:from;
        bh=JIHGunsgaCgZeL/o7QkqGP7k7OB8Pmo0Z9kFuz+i2e0=;
        b=y8KDhysUj7jzWbtyVXzGyruait8OD0e0tLApY/HniiTs/VBe0JGvqIy+zsEb6wu5cKbssAnYafUpI
         nIpysd9lkI3sxy5OLvTHYbJ3h6RBYK9DuZ8d/clRqoiUHharD1sJ+RBkEWiNJx0/WHbIzAXC4DC5oV
         Bnx1AnbsklgSsjiI=
X-HalOne-Cookie: e9c62d4db971f1bf8e2808d0f1cb863824030696
X-HalOne-ID: 2213bfb0-7bb9-11e9-a0e1-d0431ea8bb03
Received: from localhost (unknown [193.163.1.7])
        by mailrelay3.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 2213bfb0-7bb9-11e9-a0e1-d0431ea8bb03;
        Tue, 21 May 2019 11:11:08 +0000 (UTC)
From:   Esben Haabendal <esben@haabendal.dk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-serial@vger.kernel.org,
        Jiri Slaby <jslaby@suse.com>, Nishanth Menon <nm@ti.com>,
        Vignesh R <vigneshr@ti.com>, Tony Lindgren <tony@atomide.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] serial: 8250: Add support for 8250/16550 as MFD function
References: <20190426084038.6377-1-esben@geanix.com>
        <20190426084038.6377-3-esben@geanix.com> <20190507114905.GB29524@dell>
        <87o94ejwrx.fsf@haabendal.dk> <20190507133844.GA6194@dell>
        <87bm05mpmx.fsf@haabendal.dk> <20190514104741.GO4319@dell>
        <20190514122618.GA18859@kroah.com> <87imudky2o.fsf@haabendal.dk>
        <20190521100904.GA13612@kroah.com>
Date:   Tue, 21 May 2019 13:11:08 +0200
In-Reply-To: <20190521100904.GA13612@kroah.com> (Greg Kroah-Hartman's message
        of "Tue, 21 May 2019 12:09:04 +0200")
Message-ID: <87pnocm59v.fsf@haabendal.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

>> I will try ad hold back with this thread until you get back to it.
>
> Ok, I have no idea what is going on here, sorry.  This is a really long
> and meandering thread, and I can't even find the original patches in my
> queue.
>
> So can you resend things and we can start over?  :)

Will do.

> But note, using a mfd for a uart seems VERY odd to me...

Ok.  In my case, I have a pcie card with an fpga which includes 5 uart
ports, 3 ethernet interfaces and a number of custom IP blocks.
I believe that an mfd driver for that pcie card in that case.

/Esben
