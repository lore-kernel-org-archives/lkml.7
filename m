Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225AEC06517
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 10:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D83C3218AD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 10:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfGDKbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 06:31:21 -0400
Received: from ns.iliad.fr ([212.27.33.1]:45016 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727303AbfGDKbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 06:31:20 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 052E7205C8;
        Thu,  4 Jul 2019 12:31:19 +0200 (CEST)
Received: from [192.168.108.49] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id E286A201B0;
        Thu,  4 Jul 2019 12:31:18 +0200 (CEST)
Subject: Re: [PATCH v2] media: si2168: Refactor command setup code
To:     =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>
Cc:     Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Brad Love <brad@nextdimension.cc>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <c28a0da0-7264-4d23-94f1-3bd614383843@free.fr>
 <20190704101401.GG22408@latitude>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <2dfb88d8-be2b-c6b6-fe39-6083dd418ccc@free.fr>
Date:   Thu, 4 Jul 2019 12:31:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190704101401.GG22408@latitude>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Thu Jul  4 12:31:19 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07/2019 12:14, Jonathan Neuschäfer wrote:

> On Thu, Jul 04, 2019 at 11:58:45AM +0200, Marc Gonzalez wrote:
>> >From ceb5f687f3f7dab2fb9d5b34408d9cf83a0be228 Mon Sep 17 00:00:00 2001
>> From: Marc Gonzalez <marc.w.gonzalez@free.fr>
>> Date: Mon, 1 Jul 2019 12:58:31 +0200
>> Subject: [PATCH v2] media: si2168: Refactor command setup code
>>
>> Refactor the command setup code, and let the compiler determine
>> the size of each command.
>>
>> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> 
> Reviewed-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Thanks for the review.

I see that I messed up the header, I'll respin a v3, and add your tag.

Regards.
