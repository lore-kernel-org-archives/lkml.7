Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96FCC3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D252085A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfHSLy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 07:54:56 -0400
Received: from ns.iliad.fr ([212.27.33.1]:51136 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbfHSLy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 07:54:56 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 93E2020455;
        Mon, 19 Aug 2019 13:54:53 +0200 (CEST)
Received: from [192.168.108.37] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 7B9781FF27;
        Mon, 19 Aug 2019 13:54:53 +0200 (CEST)
Subject: Re: [PATCH v4] media: si2168: Refactor command setup code
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sean Young <sean@mess.org>, Brad Love <brad@nextdimension.cc>
Cc:     linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>
References: <06171488-7530-d4e4-1b94-f82905ed383d@free.fr>
Message-ID: <499bea86-f483-f776-4512-510c5df9d78f@free.fr>
Date:   Mon, 19 Aug 2019 13:54:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <06171488-7530-d4e4-1b94-f82905ed383d@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Mon Aug 19 13:54:53 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/07/2019 11:50, Marc Gonzalez wrote:

> Use cmd_init() to fill a struct si2168_cmd command.
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> ---
> Changes from v1:
> - Use a real function to populate struct si2168_cmd *cmd, and a trivial
> macro wrapping it (macro because sizeof).
> Changes from v2:
> - Fix header mess
> - Add Jonathan's tag
> Changes from v3:
> - Drop Jonathan's tag after rewrite
> - Completely drop macro, and explicitly provide 'wlen' argument
> ---
>  drivers/media/dvb-frontends/si2168.c | 152 ++++++++-------------------
>  1 file changed, 44 insertions(+), 108 deletions(-)

Brad, Sean, Antti,

I believe this patch is good to go. Is anything still wrong with it?

Regards.
