Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D9EC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80DBA2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfDOOEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:04:23 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45474 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbfDOOEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 10:04:23 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 903A7281628
Subject: Re: [PATCH v4 2/2] platform/chrome: wilco_ec: Add h1_gpio status to
 debugfs
To:     Nick Crews <ncrews@chromium.org>, bleung@chromium.org
Cc:     linux-kernel@vger.kernel.org, dlaurie@chromium.org,
        derat@google.com, groeck@google.com, dtor@google.com,
        sjg@chromium.org, alevkoy@chromium.org, keithshort@chromium.org
References: <20190412181443.239166-1-ncrews@chromium.org>
 <20190412181443.239166-2-ncrews@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <b4d24cd0-b637-4616-1977-ec08bb119422@collabora.com>
Date:   Mon, 15 Apr 2019 16:04:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412181443.239166-2-ncrews@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/4/19 20:14, Nick Crews wrote:
> As part of Chrome OS's FAFT (Fully Automated Firmware Testing)
> tests, we need to ensure that the H1 chip is properly setting
> some GPIO lines. The h1_gpio attribute exposes the state
> of the lines:
> - ENTRY_TO_FACT_MODE in BIT(0)
> - SPI_CHROME_SEL in BIT(1)
> 
> There are two reasons that I am exposing this in debugfs,
> and not as a GPIO:
> 1. This is only useful for testing, so end users shouldn't ever
> care about this. In fact, if it passes the tests, then the value of
> h1_gpio will always be 2, so it would be really uninteresting for users.
> 2. This GPIO is not connected to, controlled by, or really even related
> to the AP. The GPIO runs between the EC and the H1 security chip.
> 
> Changes in v4:
> - Use "0x02x\n" instead of "02x\n" for format string
> - Use DEFINE_DEBUGFS_ATTRIBUTE()
> - Add documentation
> Changes in v3:
> - Fix documentation to correspond with formatting change in v2.
> Changes in v2:
> - Zero out the unused fields in the request.
> - Format result as "%02x\n" instead of as a decimal.
> 
> Signed-off-by: Nick Crews <ncrews@chromium.org>

Applied for 5.2

Thanks
