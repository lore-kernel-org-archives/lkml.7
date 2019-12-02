Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099F8C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 23:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1E102070A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 23:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfLBXJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 18:09:18 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:42336 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfLBXJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 18:09:17 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3F6A914DB02A2;
        Mon,  2 Dec 2019 15:09:17 -0800 (PST)
Date:   Mon, 02 Dec 2019 15:09:16 -0800 (PST)
Message-Id: <20191202.150916.2303395989063321734.davem@davemloft.net>
To:     leoyang.li@nxp.com
Cc:     linux@rasmusvillemoes.dk, timur@kernel.org, qiang.zhao@nxp.com,
        christophe.leroy@c-s.fr, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        oss@buserror.net
Subject: Re: [PATCH v6 00/49] QUICC Engine support on ARM, ARM64, PPC64
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CADRPPNSXS95DCpbnEG14tN7H4uxo7kFb8-azMU+MfPStyRcdpQ@mail.gmail.com>
References: <7beef282-1dd8-7c7a-4f6d-d0605d11eab5@kernel.org>
        <fb810251-f444-bd5d-54e3-774d2e1ccdb9@rasmusvillemoes.dk>
        <CADRPPNSXS95DCpbnEG14tN7H4uxo7kFb8-azMU+MfPStyRcdpQ@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 02 Dec 2019 15:09:17 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Yang <leoyang.li@nxp.com>
Date: Mon, 2 Dec 2019 16:56:39 -0600

> On Mon, Dec 2, 2019 at 2:14 AM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>>
>> On 01/12/2019 17.10, Timur Tabi wrote:
>> > On 11/28/19 8:55 AM, Rasmus Villemoes wrote:
>> >> There have been several attempts in the past few years to allow
>> >> building the QUICC engine drivers for platforms other than PPC32. This
>> >> is yet another attempt.
>> >>
>> >> v5 can be found
>> >> here:https://lore.kernel.org/lkml/20191118112324.22725-1-linux@rasmusvillemoes.dk/
>> >>
>> >
>> > If it helps:
>> >
>> > Entire series:
>> > Acked-by: Timur Tabi <timur@kernel.org>
>>
>> Thanks. I'll leave it to Li Yang whether to apply that - they already
>> all (except for the last-minute build fix) have your R-b.
>>
>> Li Yang, any chance you could pick up these patches so they have plenty
>> of time in -next until 5.6?
> 
> Sure.  I will.  I'm waiting for the Ack from David on the networking side.

Acked-by: David S. Miller <davem@davemloft.net>
