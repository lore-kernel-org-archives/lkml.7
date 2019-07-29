Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFC0C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 10:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 933B3206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 10:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbfG2KNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 06:13:00 -0400
Received: from foss.arm.com ([217.140.110.172]:41390 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbfG2KNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 06:13:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DDDA344;
        Mon, 29 Jul 2019 03:12:59 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBF873F694;
        Mon, 29 Jul 2019 03:12:57 -0700 (PDT)
Date:   Mon, 29 Jul 2019 11:12:50 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ronen Krupnik <ronenk@amazon.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        barakw@amazon.com, dwmw@amazon.co.uk, benh@amazon.com,
        jonnyc@amazon.com, talel@amazon.com, hhhawa@amazon.com,
        hanochu@amazon.com, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 2/2] arm64: dts: amazon: add Amazon Annapurna Labs Alpine
 v3 support
Message-ID: <20190729101250.GA831@e107155-lin>
References: <20190728195135.12661-1-ronenk@amazon.com>
 <20190728195135.12661-3-ronenk@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190728195135.12661-3-ronenk@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 10:51:35PM +0300, Ronen Krupnik wrote:
> This patch adds the initial support for the Amazon Annapurna Labs Alpine v3
> Soc and Evaluation Platform (EVP).

[...]

> +
> +		pmu {
> +			compatible = "arm,armv8-pmuv3";

Please use "arm,cortex-a72-pmu" as we know it's Cortex-A72 cores

--
Regards,
Sudeep
