Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CC3C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 03:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D64206E6
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 03:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfKODDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 22:03:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:49994 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726674AbfKODDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 22:03:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5F901AFCD;
        Fri, 15 Nov 2019 03:03:21 +0000 (UTC)
Subject: Re: [PATCH v3 0/2] arm64: dts: Initial RTD1619 SoC and Realtek
 Mjolnir EVB support
To:     James Tai <james.tai@realtek.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        'DTML' <devicetree@vger.kernel.org>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <540b62715e77486485365081e992af76@realtek.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <44a543b9-988f-b56c-ca70-7d1faa40bffb@suse.de>
Date:   Fri, 15 Nov 2019 04:03:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <540b62715e77486485365081e992af76@realtek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Am 12.11.19 um 16:45 schrieb James Tai:
> This series adds initial Device Trees for Realtek RTD1619 SoC and
> Realtek Mjolnir EVB.
> 
> v2 -> v3:
> * Adjust the address-cells and address-size property of root node
> * Adjust ranges property of r-bus node
> * Adjust uart node addressing
> * Add comments for uart node
> * Revert soc node
> 
> v1 -> v2:
> * Define compatible strings for Realtek RTD1619 SoC and Realtek Mjolnir
> * Add uart1 and uart2 device node into rtd16xx.dtsi
> * move cpus node and the interrupt-affinity into rtd16xx.dtsi
> * Specify the r-bus ranges

Some observations of what is not in this patchset:

* There is neither /memreserve/ nor /reserved-memory here. What about
Boot ROM, TEE and RPC?
* The reset controllers for the UARTs are missing. Can we take the same
shortcut as in my RTD1395 patch to add them now, i.e. are they
compatible with RTD1295?
* Is the watchdog incompatible, or is it just not enabled by the
bootloader and depends on future, e.g., clk patches?
* Is the RTC not enabled on boot, similar to the other SoCs?

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
