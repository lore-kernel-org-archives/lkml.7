Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F31C31E5E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 17:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E13205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 17:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=comcastmailservice.net header.i=@comcastmailservice.net header.b="oFFa7lGA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729826AbfFRRW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 13:22:58 -0400
Received: from resqmta-ch2-08v.sys.comcast.net ([69.252.207.40]:57314 "EHLO
        resqmta-ch2-08v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729435AbfFRRW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 13:22:57 -0400
Received: from resomta-ch2-14v.sys.comcast.net ([69.252.207.110])
        by resqmta-ch2-08v.sys.comcast.net with ESMTP
        id dGmihySmAmLM0dHovhPFfv; Tue, 18 Jun 2019 17:22:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20180828_2048; t=1560878577;
        bh=JHcgE4OMl2fKvXDVpOvk+kiciICu15GPHQ9+Epi74S4=;
        h=Received:Received:Reply-To:Subject:To:From:Message-ID:Date:
         MIME-Version:Content-Type;
        b=oFFa7lGA3ExymOoKaqlYZf9oGbx0l1+nGx9KFWaHmpw4UDgb88VInSPuGYj/S9znq
         KKUWf1BI2QiCRiAfTVzhxd7rsmRt0k8KZ6OcROoqC7KBErFUXvgQs80C2krfB30kNa
         KoA/67ICo9IIFUPCLrCtNTeLWQXP2PI+RLwZL9aYNKbAt1C02PF3Xe7qOEzeaawx1N
         spv1JKRlee9oK85OLH3sVnLi5a8y7JQbOA2xZzJBw/EusGdaA6/bMNp6bYtCOLks9U
         5NbR9QF1I6zjEyvmwQerzNA/oQDv3F8l0cYPbYEQ98bdTxbQ2dMnDE+TcG6I4zq6I2
         gCCZk8BOSEVog==
Received: from [IPv6:2001:558:6040:22:2171:426f:b27e:296d] ([IPv6:2001:558:6040:22:2171:426f:b27e:296d])
        by resomta-ch2-14v.sys.comcast.net with ESMTPSA
        id dHoth3IEIllmHdHouhC4Ms; Tue, 18 Jun 2019 17:22:56 +0000
X-Xfinity-VMeta: sc=-100;st=legit
Reply-To: james@nurealm.net
Subject: Re: [PATCH 5.1 003/115] HID: input: make sure the wheel high
 resolution multiplier is set
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
References: <20190617210759.929316339@linuxfoundation.org>
 <20190617210800.096317488@linuxfoundation.org>
From:   James Feeney <james@nurealm.net>
Message-ID: <a90f3536-8833-498d-c9d5-ef460ad153da@nurealm.net>
Date:   Tue, 18 Jun 2019 11:22:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190617210800.096317488@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uhm - could someone please "clue me in" here?

When I look into:

'move all the pending queues back to their "real" places'
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=c5da0df8985ac2f29ffdaba77bae201121bc0e10

I can find both the "d43c17ead879ba7c076dc2f5fd80cd76047c9ff4" patch, "HID: input: make sure the wheel high resolution multiplier is set" and the "39b3c3a5fbc5d744114e497d35bf0c12f798c134" patch, "HID: input: fix assignment of .value".

I take this to mean that these patches are "in the stable-queue".  But then, these patches are not "in the kernel".

So then, how do these patches go from being "in the stable-queue" to being "in the kernel"?

To the "uninitiated" and "naive", as I am, to outward appearances, the patches are "just sitting there".  How do the patches get selected for inclusion into the "next" kernel revision?

Thanks
James
