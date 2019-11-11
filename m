Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572C7C17441
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 04:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 380D12086A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 04:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfKKESn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 23:18:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:41768 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726754AbfKKESm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 23:18:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3DE98B32D;
        Mon, 11 Nov 2019 04:18:41 +0000 (UTC)
Subject: Re: [PATCH v2 0/2] Initial RTD1619 SoC and Realtek Mjolnir EVB
 support
To:     James Tai <james.tai@realtek.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        'DTML' <devicetree@vger.kernel.org>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <43B123F21A8CFE44A9641C099E4196FFCF91F9CB@RTITMBSVM04.realtek.com.tw>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <f2ce8745-e056-06a5-3d55-b00ab4d82414@suse.de>
Date:   Mon, 11 Nov 2019 05:18:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <43B123F21A8CFE44A9641C099E4196FFCF91F9CB@RTITMBSVM04.realtek.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Am 08.11.19 um 10:42 schrieb James Tai:
> This series adds Device Trees for the Realtek RTD1619 SoC and Realtek's
> Mjolnir EVB.
> 
> v1 -> v2:
> * Define compatible strings for Realtek RTD1619 SoC and Realtek Mjolnir
> * Add uart1 and uart2 device node into rtd16xx.dtsi
> * move cpus node and the interrupt-affinity into rtd16xx.dtsi
> * Specify the r-bus ranges

With the exception of r-bus this is getting pretty good already.
Two formal improvements:

1) The patches 1/2 and 2/2 are expected to be threaded to 0/2 (but not
2/2 to 1/2). Please check your git [sendemail] config or use --thread
--no-chain-reply-to. That helps keep the series together when people
start replying to individual patches. If your Git config seems correct,
it might also be an issue with your SMTP server.

2) Please also include a per-patch changelog like I do. I privately
shared a script how I do that in a reproducible way. This benefits
reviewers not getting CC'ed on the cover letter as well as users of the
Patchwork web interface.

Thanks,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
