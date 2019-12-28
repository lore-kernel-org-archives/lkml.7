Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DEAC3F68F
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 14:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3DB72173E
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 14:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfL1OIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 09:08:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:50362 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbfL1OIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 09:08:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 24853ACE3;
        Sat, 28 Dec 2019 14:08:51 +0000 (UTC)
Subject: Re: [PATCH v2 0/9] arm64: dts: realtek: Initial RTD1395 and BPi-M4 /
 Lion Skin support
To:     linux-realtek-soc@lists.infradead.org
Cc:     devicetree@vger.kernel.org, James Tai <james.tai@realtek.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20191202102910.26916-1-afaerber@suse.de>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <1c870687-1f2f-709f-2479-aeeae46dc7d7@suse.de>
Date:   Sat, 28 Dec 2019 15:08:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191202102910.26916-1-afaerber@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 02.12.19 um 11:29 schrieb Andreas Färber:
> Andreas Färber (9):
>    arm64: dts: realtek: rtd129x: Fix GIC CPU masks for RTD1293
>    arm64: dts: realtek: rtd129x: Use reserved-memory for RPC regions
>    arm64: dts: realtek: rtd129x: Introduce r-bus
>    arm64: dts: realtek: rtd129x: Carve out boot ROM from memory
>    arm64: dts: realtek: rtd16xx: Carve out boot ROM from memory
>    dt-bindings: arm: realtek: Add RTD1395 and Banana Pi BPI-M4
>    arm64: dts: realtek: Add RTD1395 and BPi-M4
>    dt-bindings: arm: realtek: Add Realtek Lion Skin EVB
>    arm64: dts: realtek: rtd1395: Add Realtek Lion Skin EVB

Applied to linux-realtek.git v5.6/dt:

https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-realtek.git/commit/?h=v5.6/dt

with RTD16xx rebased onto RTD1395.

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
