Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DCFFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 566682067B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389785AbfKHTPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:15:14 -0500
Received: from jpvw.nl ([80.127.100.2]:33746 "EHLO jpvw.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389181AbfKHTPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:15:12 -0500
Received: from localhost ([127.0.0.1] helo=jpvw.nl)
        by jpvw.nl with esmtp (Exim 4.92)
        (envelope-from <jp@jpvw.nl>)
        id 1iT9iv-0001pW-6Z; Fri, 08 Nov 2019 20:15:09 +0100
Subject: Re: [PATCH 1/1] media: dvbsky: use a single mutex and state buffers
 for all R/W ops
To:     =?UTF-8?Q?Br=c3=bcns=2c_Stefan?= <Stefan.Bruens@rwth-aachen.de>,
        Andrei Koshkosh <andreykosh000@mail.ru>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        Sean Young <sean@mess.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1573236913-16642-1-git-send-email-andreykosh000@mail.ru>
 <3265129.arFHkKjftx@sbruens-linux.lcs.intern>
From:   JP <jp@jpvw.nl>
Message-ID: <aa7bbda2-27af-41e7-0b8c-9013b4781e57@jpvw.nl>
Date:   Fri, 8 Nov 2019 20:15:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <3265129.arFHkKjftx@sbruens-linux.lcs.intern>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/8/19 7:22 PM, Brüns, Stefan wrote:
> On Freitag, 8. November 2019 19:15:13 CET Andrei Koshkosh wrote:
>> Signed-off-by: Andrei Koshkosh <andreykosh000@mail.ru>
> Do not claim to be author of something you have not written.
>
> This is mostly commit 7d95fb746c4e "media: dvbsky: use just one mutex for
> serializing device R/W ops" originally from Mauro and later reverted.

See https://patchwork.linuxtv.org/patch/59590/
Apart from that,  this is allready in current linux_media tree.

Jan Pieter.

