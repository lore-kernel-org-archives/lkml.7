Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD543C2D0D1
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 02:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DF9220838
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 02:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfL2Cse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 21:48:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:56764 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbfL2Cse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 21:48:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 96E9FAC2C;
        Sun, 29 Dec 2019 02:48:32 +0000 (UTC)
Subject: Re: [PATCH v2 0/2] Initial RTD1319 SoC and Realtek PymParticle EVB
 support
To:     James Tai <james.tai@realtek.com>
Cc:     linux-realtek-soc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org
References: <20191228150553.6210-1-james.tai@realtek.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <9fbe4392-5028-3718-8c97-547a46efad2a@suse.de>
Date:   Sun, 29 Dec 2019 03:48:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191228150553.6210-1-james.tai@realtek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Am 28.12.19 um 16:05 schrieb James Tai:
> Cc: Andreas Färber <afaerber@suse.de>

This time you CC'ed me only on the cover letter, so that I didn't get 
notified of, e.g., Marc's review comments. I wonder why: realtek.yaml is 
in MAINTAINERS, and so is dts/realtek/, so get_maintainers.pl should've 
picked me up, even if you forgot to explicitly CC me? Please check what 
went wrong there and make sure it doesn't happen again for the next 
submission.

Thanks,
Andreas

>   .../devicetree/bindings/arm/realtek.yaml      |   6 +
>   arch/arm64/boot/dts/realtek/Makefile          |   2 +
>   .../boot/dts/realtek/rtd1319-pymparticle.dts  |  43 ++++
>   arch/arm64/boot/dts/realtek/rtd1319.dtsi      |  12 +
>   arch/arm64/boot/dts/realtek/rtd13xx.dtsi      | 212 ++++++++++++++++++
>   5 files changed, 275 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/realtek/rtd1319-pymparticle.dts
>   create mode 100644 arch/arm64/boot/dts/realtek/rtd1319.dtsi
>   create mode 100644 arch/arm64/boot/dts/realtek/rtd13xx.dtsi

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
