Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262C5C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 01:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E921E206DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 01:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbfC1B35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 21:29:57 -0400
Received: from smtprelay0104.hostedemail.com ([216.40.44.104]:51732 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725601AbfC1B34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 21:29:56 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 77386100E86C3;
        Thu, 28 Mar 2019 01:29:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: beef67_56067dcc0ef43
X-Filterd-Recvd-Size: 2107
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Thu, 28 Mar 2019 01:29:51 +0000 (UTC)
Message-ID: <fc86715bcd4a6cc7a4765e5b2975842fc0df57ad.camel@perches.com>
Subject: Re: [PATCH v11 06/27] MAINTAINERS: Add myself as maintainer for
 Ingenic TCU drivers
From:   Joe Perches <joe@perches.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Mathieu Malaterre <malat@debian.org>, od@zcrc.me,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org
Date:   Wed, 27 Mar 2019 18:29:49 -0700
In-Reply-To: <20190327231631.15708-7-paul@crapouillou.net>
References: <20190327231631.15708-1-paul@crapouillou.net>
         <20190327231631.15708-7-paul@crapouillou.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-03-28 at 00:16 +0100, Paul Cercueil wrote:
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -7665,6 +7665,15 @@ L:	linux-mtd@lists.infradead.org
>  S:	Maintained
>  F:	drivers/mtd/nand/raw/jz4780_*
>  
> +INGENIC TCU driver

trivia:

Generally the section header is all upper case and not mixed case
$ git grep -i DRIVER -- MAINTAINERS | \
  grep -v 'drivers/' | grep -v 'MAINTAINERS:[A-Z]:' | \
  grep -P -i -o 'drivers?' | \
  sort | uniq -c | sort -rn
    980 DRIVER
    181 DRIVERS
     19 driver
     12 Driver
      8 drivers
      3 Drivers


